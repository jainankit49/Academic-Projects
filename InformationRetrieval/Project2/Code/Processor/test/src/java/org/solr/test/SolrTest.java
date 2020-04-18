/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.solr.test;
import javax.jws.WebService;
import javax.jws.WebMethod;
import javax.jws.WebParam;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrRequest;
import org.apache.solr.common.SolrDocumentList;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.apache.solr.client.solrj.response.SpellCheckResponse;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.response.TermsResponse;
import org.apache.solr.client.solrj.response.SpellCheckResponse.Suggestion;
import org.apache.solr.common.params.CommonParams;
import org.apache.solr.client.solrj.SolrServerException;
import java.util.HashMap;
import java.util.List;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.Map;
import java.util.regex.Pattern;
import opennlp.tools.tokenize.SimpleTokenizer;
import opennlp.tools.tokenize.Tokenizer;

/**
 *
 * @author PavanKumar
 */
@WebService(serviceName = "SolrTest")
public class SolrTest {

    private static final Pattern queryWordPattern = Pattern.compile("([lL]ist|[wW]ho|[wW]hat|[wW]hen|[Ww]here|[Ww]hy|[Hh]ow|[Ww]hom|[Ww]hich|[Nn]ame)");
    
    /**
     * Web service operation
     */
    @WebMethod(operationName = "solrq")
    public String solrq(@WebParam(name = "q1") String q,@WebParam(name = "q2") String field) {
        //TODO write your implementation code here:
        String ret="abc";
        
        DefaultHttpClient httpclient = new DefaultHttpClient();
        try{
        HttpSolrServer solr = new HttpSolrServer("http://localhost:8983/solr/",httpclient);
        //solr=URLConnection("http://localhost:8983/solr/");
        SolrQuery query = new SolrQuery();
        query.setQuery(q);
        // query.addFilterQuery("cat:electronics","store:amazon.com");
        query.setFields(field);
        query.setStart(0);    
        //query.set("defType", "edismax");
        QueryResponse response;
        
        response = solr.query(query);
        
        SolrDocumentList results = response.getResults();
        
        for (int i = 0; i < results.size(); ++i) {
          //System.out.println(results.get(i));
            ret=(results.get(i).toString());
        }
        }
        catch(Exception e)
        {
            ret=e.getLocalizedMessage();
        }
        return ret;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "NounVerb")
    public String[] NounVerb(@WebParam(name = "query") String query) {
        String[] retval={"",""};
        Pattern falseHeadsPattern = Pattern.compile("^(name|type|kind|sort|form|one|breed|names|variety)$");
        Pattern copulaPattern = Pattern.compile("^(is|are|'s|were|was|will)$");
        Pattern queryWordPattern = Pattern.compile("^(who|what|when|where|why|how|whom|which|name)$");
        Pattern useFocusNounPattern = Pattern.compile("^(who|what|which|name)$");
        Pattern howModifierTagPattern = Pattern.compile("^(JJ|RB)");
        String solrQuery=query;
        
        String [][] infobox={{"born","birth","birthday","birth place","birth date","","",""},{"died","die","death","expire","expired","dead","",""},
				{"disappeared","disappear","lost","","","","",""},{"body_discovered","discovered","discover","found","find","body discovered","",""},
				{"resting_place","buried","bury","rest","resting","creamate","cremated",""},{"monument","building","structure",
					"","","","",""},{"residence","resident","house","home","live","reside","",""},{"nationality","nation","country","","","","",""},
					{"other_names","alias","nickname","nick name","other name","other names","pet name","nicknames"},{"ethnicity","ethnic","",
						"","","","",""},{"citizenship","citizen","citizenship","country","","","",""},{"education","educated","educate","study","studied","","",""},
						{"alma_mater","college","school","university","institution","graduate","graduated","schooling"},{"occupation","work","job","profession","","","",""},
						{"years_active","years active","active","","","","",""},{"employer","company","","","","","",""},{"organization","","","","","","",""},
						{"agent","","","","","","",""},{"known_for","known for","famous for","famous","popular","known","",""},{"notable_works",
							"notable work","renowned works","renowned work","notable works","","","",""},{"style","","","","","","",""},
							{"home_town","home town","","","","","",""},{"salary","income","earning","","","","",""},
							{"networth","net worth","","","","","",""},{"height","","","","","","",""},{"weight","","","","","","",""},
							{"television","","","","","","",""},{"title","titles","","","","","",""},{"term","","","","","","",""},
							{"predecessor","","","","","","",""},{"successor","","","","","","",""},{"party","","","","","","",""},
							{"movement","","","","","","",""},{"opponents","opponent","","","","","",""},{"boards","board","","","","","",""},
							{"religion","","","","","","",""},{"denomination","","","","","","",""},{"criminal_charge","","","","","","",""}, 
							{"criminal_penalty","criminal penalty","","","","","",""},{"criminal_status","criminal status","","","","","",""},
							{"spouse","wife","husband","","","","",""},{"partner","","","","","","",""},{"children","","","","","","",""},{"parents","","","","","","",""},
							{"relatives","relative","","","","","",""},{"awards","","","","","","",""},{"signature","sign","","","","","",""},
							{"native_name","native name","native names","","","","",""},
							{"former_name","previous","formerly","old","ancient","past","former name",""},       
							{"abbreviation","abbreviate","abbreviated","short form","","","",""},
							{"motto","goal","objective","","","","",""},        
							{"predecessor","previous","ancestor","","","","",""},  
							{"successor","descendant","replacement","","","","",""},     
							{"formation","form","formed","developed","","","",""},     
							{"founder","foundation","found","founded","","","",""}, 
							{"extinction","extinct","disappear","vanish","","","",""},   
							{"merger","merge","join","union","tie-up","alliance","merged","merging"},
							{"type","types","","","","","",""},  
							{"status","","","","","","",""},        
							{"purpose","goal","objective","reason","","","",""},       
							{"professional_title","professional title","","","","","",""}, 
							{"headquarters","office","","","","","",""},  
							{"location","located","situate","situated","","","",""},           
							{"region_served","territory","area","region served","served region","","",""}, 
							{"services","service","serve","","","","",""},      
							{"membership","member","","","","","",""},    
							{"language","","","","","","",""},      
							{"general","","","","","","",""},       
							{"leader_title","leader title","","","","","",""},  
							{"leader_name","leader_name","","","","","",""},   
							{"key_people","key people","","","","","",""},    
							{"main_organ","main organ","","","","","",""},    
							{"parent_organization","parent organization","","","","","",""},  
							{"subsidiaries","subsidiary","","","","","",""},   
							{"affiliations","affiliate","association","association","affiliated","","",""},   
							{"budget","plan","cost","expense","amount","money","",""},        
							{"num_staff","number staff","number ","","","","",""},      
							{"num_volunteers","number volunteers","","","","","",""}, 
							{"slogan","slogans","","","","","",""},
                                                        {"caption","","","","","","",""},
							{"director","direct","directed","directing","","","",""},   
							{"producer","produce","produced","producing","","","",""},       
							{"writer","writing","written","write","wrote","","",""},         
							{"screenplay","","","","","","",""}, 
							{"story"," story writer","storywriter","","","","",""},          
							{"based_on","based on","","","","","",""},      
							{"narrator","narrated","narration","narrate","","","",""},      
							{"starring","starred","star cast","starcast","","","",""},      
							{"music","song","songs","musician","sing","sang","sung",""},         
							{"cinematography","","","","","","",""},  
							{"editing","edit","editted","editor","","","",""},         
							{"studio","","","","","","",""},          
							{"distributor","distribute","distributed","dictributing","distribution","","",""},    
							{"released","release","releasing","release date","released date","","",""},       
							{"runtime","time","length","run time","","","",""},        
							{"country","place","location","","","","",""}, 
							{"language","","","","","","",""},                    
							{"gross","earning","earned","earn","total","amount","profit","revenue"}};
        
	try {
	
			String  q=query;
                        q=q.replaceAll("\\s{2,}"," ");
                        if(q.contains(" of "))
                        {
                            q=q.replace(" of ", " ");
                        }
                        if(q.contains(" in "))
                        {
                            q=q.replace(" in ", " ");
                        }
			String verb="";
			String ques="";
			String noun="";
			boolean ngram=false;

			Tokenizer tokenizer=new SimpleTokenizer();
			String []tokens=tokenizer.tokenize(q);
			
			String[] n_gram=ngrams(q,2);
			System.out.println(q);

			b:	for (int i=0;i<infobox.length;i++)
			{
				for (int j=0;j<8;j++)
				{
					for (int k=0;k<n_gram.length;k++)
					{				
						if (n_gram[k].equalsIgnoreCase(infobox[i][j]))
						{
							q=q.replace(n_gram[k],"");
							verb=infobox[i][0];
							verb=verb.substring(0,1).toLowerCase()+verb.substring(1).toLowerCase();
							ngram=true;
							break b;								
						}
					}
				}
			}

			if (ngram==false)
			{
				a:	for (int i=0;i<infobox.length;i++)
				{
					for (int j=0;j<8;j++)
					{								
						for (int k=0;k<tokens.length;k++)
						{				
							if (tokens[k].equalsIgnoreCase(infobox[i][j]))
							{
								q=q.replace(tokens[k],"");
								verb=infobox[i][0];
								verb=verb.substring(0,1).toLowerCase()+verb.substring(1).toLowerCase();
								break a;								
							}
						}
					}
				}
			}


			for (int i=0;i<tokens.length;i++)
			{
				if (isQueryWord(tokens[i]))
				{
					ques=tokens[i];
                                        
					q=q.replace(ques,"");
					ques=ques.substring(0,1).toLowerCase()+ques.substring(1).toLowerCase();
					break;
				}
			}
                        
                        q=q.toLowerCase();
                        q=q.replaceAll(" took ", " ");
                        q=q.replaceAll(" much ", " ");
                        q=q.replaceAll(" many ", " ");
			q=q.replaceAll(" did "," ");
			q=q.replaceAll(" were "," ");
			q=q.replaceAll(" is "," ");
			q=q.replaceAll(" are "," ");
			q=q.replaceAll(" was "," ");
			q=q.replaceAll(" have "," ");
			q=q.replaceAll(" had "," ");
			q=q.replaceAll(" of "," ");
			q=q.replaceAll(" for "," ");
			q=q.replaceAll(" from "," ");
			q=q.replaceAll(" the "," ");
			q=q.replaceAll(" do "," ");
			q=q.replaceAll("'s "," ");
                        q=q.replaceAll(" do "," ");
                        q=q.replaceAll(" does "," ");
                        q=q.replaceAll(" all "," ");
                        q=q.replaceAll(" took "," ");
			
			noun=q;
			//System.out.println("verb "+verb);
			//System.out.println("ques "+ques);
			//System.out.println("noun "+noun);

			Map<String,String> s=new HashMap<String,String>();
			s.put("born+when","birth_date");
			s.put("born+where","birth_place");
                        s.put("born+which","birth_date");
                        s.put("born+what","birth_place");
			//s.put("born+who","name");
			s.put("died+when","death_date");
			s.put("died+where","death_place");
			s.put("died+how","death_cause");
			s.put("died+who","name");
			s.put("disappeared+where","disappered_place");
			s.put("disappeared+when","disappered_date");
			s.put("body_discovered+where","body_discovered");
			s.put("resting_place+where", "resting_place");  // place of burial
			s.put("resting_place+what", "resting_place");
			s.put("monument+what","monument");
			s.put("monument+which","monument");
			s.put("monument+list","monument");
			s.put("residence+where","residence");
			s.put("nationality+what","nationality");
			s.put("nationality+which","nationality");
			s.put("other_names+what","other_names");
			s.put("other_names+which","other_names");
			s.put("other_names+list","other_names");
			s.put("ethnicity+what","ethnicity");
			s.put("ethnicity+which","ethnicity");
			s.put("citizenship+what","citizenship");
			s.put("citizenship+which","citizenship");
			s.put("education+what","education");
			s.put("education+when","education");
			s.put("education+which","education");
			s.put("education+where","education");
			s.put("alma mater+where","alma_mater");
			s.put("occupation+what","occupation");
			s.put("occupation+list","occupation");
			s.put("years_active+when","years_active");
			s.put("employer+who","employer");   
			s.put("employer+where","employer");
			s.put("organization+which","organization");    
			s.put("organization+what","organization");  
			s.put("known_for+what","known_for");   
			s.put("known_for+why","known_for");
			s.put("notable_works+what","notable_works");   
			s.put("notable_works+list","notable_works"); 
			s.put("style+what","style");           
			s.put("home_town+where","home_town");       
			s.put("salary+what","salary"); 
			s.put("salary+how","salary");     
			s.put("networth+what","networth");    
			s.put("height+what","height");      
			s.put("weight+what","weight");        
			s.put("television+where","television");
			s.put("television+which","television");
			s.put("television+what","television");
			s.put("title+what","title");           
			s.put("term+when","term");      
			s.put("term+how","term"); //tenure of holding title
			s.put("predecessor+who","predecessor");     
			s.put("successor+who","successor");       
			s.put("party+which","party");           
			s.put("movement+which","movement"); 
			s.put("movement+what","movement");  
			s.put("opponents+who","opponents"); 
			s.put("opponents+whom","opponents");     
			s.put("boards+which","boards");  //board of director 
			s.put("boards+where","boards");
			s.put("boards+what","boards");
			s.put("religion+what","religion"); 
			s.put("religion+which","religion");   
			s.put("denomination+which","denomination");  
			s.put("denomination+what","denomination");   
			s.put("criminal_charge+which","criminal_charge");
			s.put("criminal_charge+what","criminal_charge");
			s.put("criminal_penalty+which","criminal_penalty");
			s.put("criminal_penalty+what","criminal_penalty");
			s.put("criminal_status+what","criminal_status"); 
			s.put("spouse+who","spouse");
			s.put("spouse+whom","spouse");
			s.put("partner+who","partner");   
			s.put("partner+whom","partner");   
			s.put("children+who","children"); 
			s.put("children+whom","children"); 
			s.put("parents+who","parents"); 
			s.put("parents+whom","parents"); 
			s.put("relatives+who","relatives");
			s.put("relatives+whom","relatives");   
			s.put("awards+what","awards");   
			s.put("awards+which","awards");   
			s.put("awards+list","awards");   
			s.put("signature+what","signature"); 

			s.put("native_name+what","native_name");
			s.put("native_name+which","native_name");
			s.put("former_name+what","former_name"); 
			s.put("former_name+which","former_name"); 
			s.put("caption+what","caption");
			//s.put("caption+which","caption");
			//s.put("caption+where","caption");
			s.put("map+what","map");
			s.put("map+which","map");
			s.put("malt+what","malt");
			s.put("malt+which","malt");
			s.put("mcaption+which","mcaption");
			s.put("mcaption+where","mcaption");
			s.put("abbreviation+what","abbreviation");
			s.put("abbreviation+which","abbreviation");
			s.put("motto+what","motto");
			s.put("motto+which","motto");
			s.put("predecessor+what","predecessor");
			s.put("predecessor+which","predecessor"); 
			s.put("successor+what","successor");
			s.put("successor+which","successor");
			s.put("formation+what","formation");
			s.put("formation+when","formation");
			s.put("founder+who","founder");
			s.put("extinction+when","extinction");
			s.put("extinction+where","extinction");
			s.put("merger+what","merger");
			s.put("merger+which","merger");
			s.put("merged+when","merger");
			s.put("type+what","type");
			s.put("type+which","type");
			s.put("status+what","status");
			s.put("status+which","status");
			s.put("status+when","status");
			s.put("purpose+what","purpose");
			s.put("professional_title+what","professional_title"); 
			s.put("professional_title+which","professional_title"); 
			s.put("headquarters+what","headquarters");
			s.put("headquarters+which","headquarters");
			s.put("headquarters+where","headquarters");
			s.put("location+which","location");
			s.put("location+where","location");
			s.put("location+what","location");
			s.put("region_served+where","region_served"); 
			s.put("region_served+which","region_served");
			s.put("region_served+what","region_served"); 
			s.put("services+what","services");
			s.put("services+which","services");
			s.put("membership+what","membership"); 
			s.put("membership+who","membership"); 
			s.put("membership+which","membership"); 
			s.put("language+what","language"); 
			s.put("language+which","language"); 
			s.put("general+what","general");
			s.put("general+which","general");
			s.put("leader_title+what","leader_title"); 
			s.put("leader_title+which","leader_title"); 
			s.put("leader_name+what","leader_name"); 
			s.put("leader_name+which","leader_name");
			s.put("leader_name+who","leader_name");
			s.put("key_people+who","key_people"); 
			s.put("key_people+what","key_people"); 
			s.put("key_people+which","key_people"); 
			s.put("main_organ+what","main_organ");
			s.put("main_organ+which","main_organ");
			s.put("parent_organization+what","parent_organization");
			s.put("parent_organization+which","parent_organization");
			s.put("parent_organization+where","parent_organization");
			s.put("subsidiaries+what","subsidiaries");
			s.put("subsidiaries+which","subsidiaries");
			s.put("affiliations+what","affiliations");
			s.put("affiliations+which","affiliations");
			s.put("budget+what","budget");
			s.put("num_staff+what","num_staff");
			s.put("num_staff+how","num_staff");
			s.put("num_volunteers+what","num_volunteers");  
			s.put("num_volunteers+how","num_volunteers");  
			s.put("slogan+what","slogan"); 
			s.put("slogan+which","slogan"); 

			s.put("director+who","director");
			s.put("director+which","director");
			s.put("director+what","director");
			s.put("producer+who","producer");
			s.put("producer+which","producer");
			s.put("producer+what","producer");
			s.put("writer+who","writer");
			s.put("writer+which","writer");
			s.put("writer+what","writer");
			s.put("screenplay+who","screenplay");
			s.put("screenplay+which","screenplay");
			s.put("screenplay+what","screenplay");
			s.put("story+who","story");
			s.put("story+which","story");
			s.put("story+what","story");
			s.put("based on+who","based_on");
			s.put("based on+which","based_on");
			s.put("based on+what","based_on");
			s.put("narrator+who","narrator");
			//s.put("narrator+which","narrator");
			//s.put("narrator+what","narrator");
			s.put("starring+who","starring");
			s.put("starring+which","starring");
			s.put("starring+what","starring");
			s.put("music+who","music");
			s.put("music+which","music");
			s.put("music+what","music");
			s.put("cinematography+who","cinematography");
			s.put("cinematography+which","cinematography");
			s.put("cinematography+what","cinematography");
			s.put("editing+who","editing");
			s.put("editing+which","editing");
			s.put("editing+what","editing");
			s.put("studio+which","studio");
			s.put("studio+what","studio");
			s.put("studio+where","studio");
			s.put("distributor+who","distributor");
			s.put("distributor+which","distributor");
			s.put("distributor+what","distributor");
			s.put("released+when","released");
			s.put("runtime+what","runtime");
			s.put("country+which","country");
			s.put("country+what","country");
			s.put("country+where","country");
			s.put("language+what","language");
			s.put("language+which","language");
			s.put("gross+what","gross");

			String value = s.get(verb+"+"+ques);
			//System.out.println(value);
                        retval[0]=noun;
                        if(value==null)
                        {
                            retval[1]="";
                        }
                        else
                        {
                            retval[1]=value;
                        }
                        return retval;

		}
		catch (Exception e) {
			// Model loading failed, handle the error
			retval[0]="-1";
                        retval[1]=e.getMessage();
                        return retval;
		}
		finally {
			
		}
        //return null;
    }

    public static boolean isQueryWord(String word) {
		return(queryWordPattern.matcher(word).matches());
	}
    
    public static String[] ngrams(String s, int len) {
		String[] parts = s.split(" ");
		String[] result = new String[parts.length - len + 1];
		for(int i = 0; i < parts.length - len + 1; i++) {
			StringBuilder sb = new StringBuilder();
			for(int k = 0; k < len; k++) {
				if(k > 0) sb.append(' ');
				sb.append(parts[i+k]);
			}
			result[i] = sb.toString();
		}
		return result;
	}
    /**
     * Web service operation
     */
    @WebMethod(operationName = "QueryRet")
    public String[] QueryRet(@WebParam(name = "key") String key, @WebParam(name = "field") String field) {
        //TODO write your implementation code here:
        
        
        DefaultHttpClient httpclient = new DefaultHttpClient();
        
        try{
            HttpSolrServer solr = new HttpSolrServer("http://localhost:8983/solr/",httpclient);
            SolrQuery query = new SolrQuery();
            query.setQuery(key);
            if(field!=null)
            {
                query.setFields(field);
            }
            else
            {
                query.setFields("");
            }
            query.setStart(0);  
            QueryResponse response = solr.query(query);
            SolrDocumentList results = response.getResults();
            String[] ret= new String[results.size()+1];
            if(field==null)
            {
                
                return ret;
            }
            
            for (int i = 0; i < results.size(); ++i) {
              //System.out.println(results.get(i));

                ret[i]=(results.get(i).toString());
            }
            ret[results.size()]=String.valueOf(results.getNumFound());
            return ret;
        }
        
        catch(Exception e)
        {
            String[] ret={e.getMessage()};
            return ret;
        }
        
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "spellcheck")
    public String spellcheck(@WebParam(name = "key") String key) {
        Map<String, List<String>> suggestionsMap = new HashMap<String, List<String>>();
        String ret="1";
	if (key != null &&  !key.isEmpty()) {	
            DefaultHttpClient httpclient = new DefaultHttpClient();				
            try {
                HttpSolrServer solr = new HttpSolrServer("http://localhost:8983/solr/",httpclient);
		ModifiableSolrParams params = new ModifiableSolrParams();
		params.set("qt", "/select");
		params.set("q", key);
		params.set("spellcheck", "true");
		params.set("spellcheck.collate", "true");
                QueryResponse response = solr.query(params);
		if(response != null){
		SpellCheckResponse scr = response.getSpellCheckResponse();
		if(scr != null){
			List<Suggestion> suggLst = scr.getSuggestions();
			for(Suggestion sugg : suggLst){
			    	suggestionsMap.put(sugg.getToken(), sugg.getAlternatives());
			}
	    	}
                ret=scr.getCollatedResult();
                
                }
	}
	catch(Exception e){
            e.printStackTrace();
	}
	}
	return ret;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "AutoComplete")
    public String[] AutoComplete(@WebParam(name = "q") String q, @WebParam(name = "limit") int limit) {
         
         DefaultHttpClient httpclient = new DefaultHttpClient();
         //CommonsHttpSolrServer server = null;
         Map<String, List<String>> suggestionsMap = new HashMap<String, List<String>>();
        try{
            HttpSolrServer server = new HttpSolrServer("http://localhost:8983/solr/",httpclient);
            ModifiableSolrParams params = new ModifiableSolrParams();
            params.set("qt", "/suggest");
            params.set("q", q);
            params.set("spellcheck", "true");
            params.set("spellcheck.build", "true");
            params.set("spellcheck.reload", "true");
            params.set("spellcheck.count", "10");
            params.set("spellcheck.accuracy", "0.7");
            QueryResponse response= server.query(params);
            if(response != null){
		SpellCheckResponse scr = response.getSpellCheckResponse();
		if(scr != null){
			List<Suggestion> suggLst = scr.getSuggestions();
			for(Suggestion sugg : suggLst){
			    	suggestionsMap.put(sugg.getToken(), sugg.getAlternatives());
			}
	    	}
                List<Suggestion> temp=scr.getSuggestions();
                String[] items= new String[temp.size()];
                temp.toArray(items);
                return items;
            }
         } catch (SolrServerException ex) {
            String[] items={ex.getMessage(),"2"};
            return items;
        }
        //String[] ret=null;
        return null;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "AutoSug")
    public String[] AutoSug(@WebParam(name = "q") String q) {
        Map<String, List<String>> suggestionsMap = new HashMap<String, List<String>>();
        String ret[]={"1"};
	if (q != null &&  !q.isEmpty()) {	
            DefaultHttpClient httpclient = new DefaultHttpClient();				
            try {
                HttpSolrServer solr = new HttpSolrServer("http://localhost:8983/solr/",httpclient);
		ModifiableSolrParams params = new ModifiableSolrParams();
		params.set("qt", "/suggest");
		params.set("q", q);
		params.set("spellcheck", "true");
                params.set("spellcheck.build", "true");
                params.set("spellcheck.reload", "true");
                params.set("spellcheck.count", "10");
                params.set("spellcheck.accuracy", "0.7");
		//params.set("spellcheck.collate", "true");
                QueryResponse response = solr.query(params);
		if(response != null){
		SpellCheckResponse scr = response.getSpellCheckResponse();
                Suggestion sug=scr.getSuggestion(q);
		if(scr != null){
			List<Suggestion> suggLst = scr.getSuggestions();
			for(Suggestion sugg : suggLst){
			    	suggestionsMap.put(sugg.getToken(), sugg.getAlternatives());
			}
	    	}
                
                List<String> temp=sug.getSuggestions();
                ret[0]=String.valueOf(temp.size());
                String[] resul=new String[temp.size()];
                temp.toArray(resul);
                return resul;
                }
	}
	catch(Exception e){
            e.printStackTrace();
	}
	}
	return ret;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "splitter")
    public String[] splitter(@WebParam(name = "info") String info) {
        //TODO write your implementation code here:
        Pattern p=Pattern.compile("\\[[^\\]]{1,}\\]");
        Matcher m=p.matcher(info);
        //String ret="";
        while(m.find())
        {
            String t=m.group();
            t=t.replace(',', ';');
            //ret=m.group();
            info=info.replace(m.group(), t);
        }
        String[] temp=info.split(",");
        for(int i=0;i<temp.length;i++)
        {
            //temp[i]=temp[i].replaceFirst(" ", " : ");
        }
        return temp;
    }

    /**
     * Web service operation
     */
    @WebMethod(operationName = "splitrow")
    public String[] splitrow(@WebParam(name = "q") String q) {
        //TODO write your implementation code here:
        String[] temp=q.replaceFirst(" ", "$").split("$");
        return temp;
    }
    
    
    

    
}
