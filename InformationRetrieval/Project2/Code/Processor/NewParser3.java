

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.xml.sax.Attributes;

import javax.xml.parsers.SAXParserFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.ParserConfigurationException;

import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;



public class NewParser3 extends DefaultHandler { 
	/* */

	private static StringBuilder text;
	private static int counter=1;
	private static int personcounter=1;
	private static int filmcounter=1;
	private static int orgcounter=1;

	private static final String TIMESTAMP_PATTERN = "[0-9]{4}\\|(0?[1-9]|1[012])\\|((0?[1-9])|[12][0-9]|3[01])";
	private static final String TIMESTAMP = "[0-9]{4}\\|(0?[1-9]|1[012])\\|((0?[1-9])|[12][0-9]|3[01])\\|[0-9]{4}\\|(0?[1-9]|1[012])\\|((0?[1-9])|[12][0-9]|3[01])";
	private static final String PATTERN = "[\\[]{2}[^\\]]{1,}[\\]]{2}";
	private static final String PATTERN1= "[\\[]{2}|[\\]]{2}";
	private static final String PATTERN2= "\\{\\{Unbulleted\\s{0,}list\\s{0,}\\|";
	private static final String PATTERN3= "\\{\\{[^\\}\\}]{1,}\\}\\}";
	private static final String PATTERN4= "[0-9]{0,4}\\|[0-9]{1,2}\\|[0-9]{1,2}";
	private static final String PATTERN5= "\\{\\{BirthDeathAge[^\\}\\}]{1,}\\}\\}";
	private static final String PATTERN6= "[0-9]{2,4}\\|[0-9]{1,2}\\|[0-9]{1,2}";
	private static final String PATTERN7= "[0-9]{4}\\|[0-9]{0,4}";

	public static String parseTagFormatting(String text) 
	{
		String s="";
		if (text!=null)
		{
			int count1=0;
			int i;
			char c;
			String b="";
			if (text!=null) {
				int length;
				//	if (!(text.contains("Infobox Single") || text.contains("Infobox planet") || text.contains("Infobox website") || text.contains("Infobox Settlement") || text.contains("Infobox Award") || text.contains("Infobox airport") || text.contains("Infobox television") || text.contains("Infobox book") || text.contains("Infobox organization")))
				if ((text.contains("Infobox person") || text.contains("Infobox organization") || text.contains("Infobox film")) && (personcounter<=4000 && orgcounter<200 && filmcounter<=2000))
				{
					if (text.contains("Infobox person"))
					{
						System.out.println("person count : "+personcounter++);
					}
					else if (text.contains("Infobox organization"))
					{
						System.out.println("organization count : "+orgcounter++);
					}
					else if (text.contains("Infobox film"))
					{
						System.out.println("film count : "+filmcounter++);
					}
					System.out.println(counter++);
					length=text.length();
					int ind=text.indexOf("{{Infobox");
					if (ind>-1)
					{
						if (length-9>=ind)
						{
							text=text.substring(ind, length);

							length=text.length();
							//{
							for (i=0;i<length-2;i++)
							{		

								if (text.charAt(i)=='{' && text.charAt(i+1)=='{')
								{
									count1++;
								}
								else if (text.charAt(i)=='}' && text.charAt(i+1)=='}')
								{
									count1--;
								}

								if (count1!=0)
								{
									if (i<length-1)
									{
										c=text.charAt(i);
										s=Character.toString(c);
										b=b.concat(s);
									}								
								}
								else
								{
									break;		
								}
							}
						}
					}
				}
				else
					return "";
			}	
			text= b.toString();
			int len=text.length();
			if (len>2)
				text=text.substring(2,len);
		}
		return text;
	}

	public static void main(String args []) throws IOException, ParseException{

		FileWriter fw = new FileWriter ("InfoBox5.txt",true);
		BufferedWriter bw = new BufferedWriter (fw);
		final PrintWriter fileOut = new PrintWriter (bw); 

		try {

			SAXParserFactory factory = SAXParserFactory.newInstance();
			SAXParser saxParser = factory.newSAXParser();
			DefaultHandler handler = new DefaultHandler() {

				boolean isText=false;
				String txt;

				public void startElement(String uri, String localName,String qName, Attributes attributes) throws SAXException {

					if(qName.equalsIgnoreCase("text")){
						isText = true;
						text = new StringBuilder("");
					}
				}

				public void characters(char ch[], int start, int length) throws SAXException {

					if(isText){
						text = text.append(ch, start, length);
					}
				}

				public void endElement(String uri, String localName,
						String qName) throws SAXException {

					if(qName.equalsIgnoreCase("page"))	
					{   

						try {
							txt = text.toString();
							txt = parseTagFormatting(txt);        
							if ((txt.contains("| name") || txt.contains("|name") || txt.contains(" | name") || txt.contains(" |name")) && counter<=5800)
							{
								fileOut.println (txt); 
								fileOut.flush();
							}
							else if (counter>5800)
							{
								SAXParserFactory factory=null;
								SAXParser saxParser = null;
							}

						}

						catch (Exception e) {
							e.printStackTrace();
						}
					}			
				}
			};
			saxParser.parse( "C:\\Users\\Ankit\\Downloads\\IR_Project_3\\1.xml", handler);
		}

		catch (Exception e) {
			e.printStackTrace();
		}

		finally {
			System.out.println("Started Final_Infobox");
			String st;
			InputStreamReader inputFile = new InputStreamReader(new FileInputStream("InfoBox5.txt"));

			BufferedReader bufferReader = new BufferedReader(inputFile);

			//Charset charset = Charset.forName("UTF-8");
			FileWriter fw1 = new FileWriter ("Final_InfoBox5.xml", true);
			//BufferedWriter writer = Files.newBufferedWriter(fw1, charset);
			BufferedWriter bw1 = new BufferedWriter (fw1);
			PrintWriter fileOut1 = new PrintWriter ("Final_InfoBox5.xml","UTF-8"); 
			int c=0;
			StringBuffer sb=new StringBuffer();
			while ((st = bufferReader.readLine()) != null)
			{
				st=st.replaceAll("\"","");
				if (st.length()>0)
				{
					if (st.startsWith("Infobox") && c==0)
					{
						c=1;
						st="<add>\n"+"<doc>";
					}


					else if (st.startsWith("Infobox"))
					{
						/*fileOut1.println (sb); 
						fileOut1.flush();
						sb.delete(0,sb.length());*/
						st="</doc>\n"+"<doc>";
					}

					else if (st.startsWith("|") || st.startsWith(" |"))
					{
						if (st.endsWith("|"))
						{
							st=st.substring(0, st.lastIndexOf("|"));
						}

						int leng=st.length();
						if (st.startsWith("| ") && leng>2)
						{
							st="<"+st.substring(2,leng);
						}
						else if (st.startsWith(" |") && leng>2)
						{
							st="<"+st.substring(2,leng);
						}
						else if (st.startsWith("|") && leng>1)
						{
							st="<"+st.substring(1,leng);
						}
						int len=st.length();
						int space_index=st.indexOf(' ');
						int assignment_index=st.indexOf('=');
						//System.out.println(st);
						//int i=space_index;
						//int first=0;
						/*while (i<len && st.charAt(i)!=' ')
						{
							if (i<len-1)
								i++;
							first=i;
						}	
						int j=i;
						int last=i;*/

						/*if (first<assignment_index)
						{\
							if(j<len)
							{
								while (j<len && st.charAt(j)!='=')
								{
									if (j<len-1)
										j++;	 
									last=j;
								}
							}
						}
						else
						{
							last=first;
						}
						last--;*/
						if (assignment_index>-1 && len>1)
						{

							if ((space_index==-1) && (st.indexOf("=")==st.length()-1))
							{
								//len=st.length();
								//assignment_index=st.indexOf("=");
								//space_index=st.indexOf(" ");
								st=st.substring(0,1)+"field name=\""+st.substring(1,assignment_index)+"\"><![CDATA[]]>";
								String st1="</field>";
								st=st+st1;
								//st=st.substring(0,1)+" !@#$% "+st.substring(1,assignment_index);
							}
							else if ((space_index>1) && (st.indexOf("=")==st.length()-1))
							{
								//len=st.length();
								//assignment_index=st.indexOf("=");
								//space_index=st.indexOf(" ");
								st=st.substring(0,1)+"field name=\""+st.substring(1,space_index)+"\"><![CDATA[]]>";
								String st1="</field>";
								st=st+st1;
								//st=st.substring(0,1)+" !@#$% "+st.substring(1,assignment_index);
							}
							else if (assignment_index>space_index)
							{
								//int leng=st.length();
								try
								{

									if (assignment_index<len && space_index>1 && space_index<len-1)
									{
										//len=st.length();
										//assignment_index=st.indexOf("=");
										//space_index=st.indexOf(" ");
										String st1=st.substring(0,1)+"field name=\"";
										String st2=st.substring(1,space_index)+"\"><![CDATA[";
										String st3=st.substring(assignment_index+1, len)+"]]>";
										st=st1+st2+st3;

									}
								}

								catch (Exception e)
								{
									e.printStackTrace();
									//System.out.println(leng+" "+len);
								}
								//	st=st;
								//st=st.replace(" =", "\">");

								//st=st.replace(" =", "");
								//st=st.replace("=", "");

								finally
								{
									String st1="</field>";
									st=st+st1;
									System.out.println(st);
								}
							}  // ||

							else if (space_index>=assignment_index)
							{
								//len=st.length();
								//assignment_index=st.indexOf("=");
								//space_index=st.indexOf(" ");
								st=st.substring(0,1)+"field name=\""+st.substring(1,assignment_index)+"\"><![CDATA["+st.substring(assignment_index+1, len)+"]]>";
								String st1="</field>";
								st=st+st1;
							}
						}
						else if (len>1)
						{
							//len=st.length();
							//assignment_index=st.indexOf("=");
							//space_index=st.indexOf(" ");
							st=st.substring(0,1)+"field name=\""+st.substring(1,len)+"\"><![CDATA[]]>";
							String st1="</field>";
							st=st+st1;
						}
						//sb=sb.append(st);

					}								
					else
					{
						continue;
					}

					st=st.replaceAll("\\{\\{#tag:ref[^\\}\\}]{1,}\\}\\}","");
					st=st.replaceAll("<ref>.{0,}</ref>","");
					st=st.replaceAll("<ref.{0,}>.{0,}</ref>","");
					st=st.replaceAll("<!--.{0,}-->","");
					st=st.replaceAll("<ref.{0,}/>","");
					st=st.replaceAll("<small>","");
					st=st.replaceAll("</small>","");

					String pattern = PATTERN;
					Pattern r = Pattern.compile(pattern);
					Matcher m = r.matcher(st);
					while (m.find())
					{
						String st2=m.group();
						st2=st2.replaceAll(PATTERN1, "");
						if (st2.contains("|"))
						{
							String []s4=st2.split("\\|");
							st2=s4[1];
						}
						st=st.replace(m.group(), st2);
					}

					pattern = PATTERN2;
					r = Pattern.compile(pattern);
					m = r.matcher(st);
					//st=st.replaceAll("{{Unbulleted\\s{0,}list\\s{0,}\\|", "");
					if (m.find())
					{
						st=st.replaceAll(PATTERN2, "");
						st=st.replaceAll("}}","");
						st=st.replaceAll("\\|","\n");
					}

					pattern=PATTERN3;
					Pattern r5 = Pattern.compile(pattern);
					Matcher m5 = r5.matcher(st);
					//System.out.println("ASWEDT :"+st);
					while (m5.find())
					{

						pattern=PATTERN5;
						Pattern r3 = Pattern.compile(pattern);
						Matcher m3 = r3.matcher(st);
						if (m3.find())
						{		
							String st3=m3.group();
							//System.out.println("!@#$% : " +st3);
							pattern=PATTERN6;
							r3 = Pattern.compile(pattern);
							m3 = r3.matcher(st3);
							if (m3.find())
							{
								String st4=m3.group();
								//System.out.println(st4);
								st4=st4.replace("|","-");
								SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
								Date time = sdf1.parse(st4);
								SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd yyyy");
								st4 = dateFormat.format(time);
								st=st.replace(st3, st4);

								break;
							}
						}

						String q=m5.group();	
						//System.out.println(q);
						String []q1=q.split("\\|",2);
						int l=q1.length;
						st=st.replace(q,q1[l-1]);
						//System.out.println("aaa: "+st);
						if (st.contains("||"))
						{
							String []q2=q1[l-1].split("\\|",2);
							st=st.replace(q1[l-1],q2[0]);
							//System.out.println("qwwdd "+st);
						}


						else
						{
							String pattern4 = PATTERN4;
							Pattern r1 = Pattern.compile(pattern4);
							Matcher m1 = r1.matcher(st);
							if (m1.find())
							{
								String st2=m1.group();
								String st3=st2;
								//System.out.println(st3);
								st3=st3.replace("|","-");
								//System.out.println(st3);
								SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
								Date time = sdf1.parse(st3);
								SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd yyyy");
								st3 = dateFormat.format(time);
								//System.out.println(q);
								//System.out.println(st3);
								st=st.replace(q1[l-1], st3);
								//st="<![CDATA["+st3+"]]";
								//System.out.println(st);
							}

							pattern4 = PATTERN7;
							r1 = Pattern.compile(pattern4);
							m1 = r1.matcher(st);

							if (m1.find())
							{
								String st2=m1.group();
								String st3=st2;
								System.out.println("RVYN :"+st3);
								st3=st3.replace("|","-");
								st=st.replace(st2, st3);

							}

							//System.out.println("QWERT   "+st);
						}
					}

					/*System.out.println(st);

					System.out.println(st);*/


					st=st.replace("<br>","\n");
					st=st.replace("<br />","\n");
					st=st.replace("<br/>","\n");
					st=st.replace("#","");
					System.out.println(st);


					String pattern8 = "CDATA[^\\[]";
					Pattern r1 = Pattern.compile(pattern8);
					Matcher m1 = r1.matcher(st);
					
					if (st.contains("field name=\"birth_date\"") || st.contains("field name=\"death_date\"") || st.contains("field name=\"birth_place\"") || st.contains("field name=\"name\"") || st.contains("field name=\"death_place\"") || st.contains("field name=\"death_cause\"") || st.contains("field name=\"disappeared_place\"") || st.contains("field name=\"disappeared_date\"") || 
							st.contains("field name=\"monument\"") || st.contains("field name=\"body_discovered\"") || st.contains("field name=\"resting_place\"") || st.contains("field name=\"residence\"") ||
							st.contains("field name=\"nationality\"") || st.contains("field name=\"other_names\"") || st.contains("field name=\"ethnicity\"") || st.contains("field name=\"citizenship\"") || st.contains("field name=\"education\"") ||
							st.contains("field name=\"occupation\"") || st.contains("field name=\"alma_mater\"") || st.contains("field name=\"years_active\"") || st.contains("field name=\"employer\"") || 
							st.contains("field name=\"organization\"") || st.contains("field name=\"known_for\"") || st.contains("field name=\"notable_works\"") || st.contains("field name=\"style\"") || 
							st.contains("field name=\"home_town\"") || st.contains("field name=\"salary\"") || st.contains("field name=\"net_worth\"") || st.contains("field name=\"height\"") || 
							st.contains("field name=\"television\"") || st.contains("field name=\"title\"") || st.contains("field name=\"term\"") || 
							st.contains("field name=\"predecessor\"") || st.contains("field name=\"successor\"") || st.contains("field name=\"party\"") || st.contains("field name=\"movement\"") ||
							st.contains("field name=\"opponents\"") || st.contains("field name=\"boardse\"") || st.contains("field name=\"religion\"") || st.contains("field name=\"criminal_charge\"") || st.contains("field name=\"criminal_penalty\"") ||
							st.contains("field name=\"criminal_status\"") || st.contains("field name=\"spouse\"") || st.contains("field name=\"partner\"") || st.contains("field name=\"children\"") || 
							st.contains("field name=\"parents\"") || st.contains("field name=\"relatives\"") || st.contains("field name=\"awards\"") || st.contains("field name=\"signature\"") || 
							st.contains("field name=\"native_name\"") || st.contains("field name=\"former_name\"") || st.contains("field name=\"caption\"") || st.contains("field name=\"map\"") || 
							st.contains("field name=\"malt\"") || st.contains("field name=\"mcaption\"") || st.contains("field name=\"abbreviation\"") || st.contains("field name=\"motto\"") || 
							st.contains("field name=\"formation\"") || st.contains("field name=\"foundation\"") || st.contains("field name=\"extinction\"") || st.contains("field name=\"merger\"")|| st.contains("field name=\"type\"") ||st.contains("field name=\"status\"") ||st.contains("field name=\"purpose\"") ||st.contains("field name=\"professional_title\"") ||st.contains("field name=\"headquarters\"") ||st.contains("field name=\"location\"") ||st.contains("field name=\"region_served\"") ||st.contains("field name=\"services\"") ||st.contains("field name=\"membership\"") ||st.contains("field name=\"language\"") ||st.contains("field name=\"general\"") ||st.contains("field name=\"leader_title\"") ||st.contains("field name=\"leader_name\"") ||st.contains("field name=\"key_people\"") ||st.contains("field name=\"main_organ\"") ||st.contains("field name=\"parent_organization\"") ||st.contains("field name=\"subsidiaries\"") ||st.contains("field name=\"affiliations\"") || st.contains("field name=\"budget\"") || st.contains("field name=\"num_staff\"") || 
							st.contains("field name=\"num_staff\"") || st.contains("field name=\"num_staff\"") || st.contains("field name=\"num_staff\"") || st.contains("field name=\"num_volunteers\"") || st.contains("field name=\"slogan\"") || st.contains("field name=\"director\"") || st.contains("field name=\"producer\"") || st.contains("field name=\"writer\"") || st.contains("field name=\"screenplay\"") || st.contains("field name=\"story\"") || 
							st.contains("<doc>") || st.contains("<add>") || st.contains("</add>") || st.contains("</doc>") || st.contains("field name=\"based_on\"") || st.contains("field name=\"narrator\"") || st.contains("field name=\"starring\"") || st.contains("field name=\"music\"") || st.contains("field name=\"cinematography\"") || st.contains("field name=\"editing\"") || st.contains("field name=\"studio\"") || st.contains("field name=\"distributor\"") || st.contains("field name=\"released\"") || st.contains("field name=\"runtime\"") || st.contains("field name=\"country\"") || st.contains("field name=\"language\"") || st.contains("field name=\"gross\"")) 

					{
						

						if (m1.find())
						{
							st=st.replace("CDATA", "CDATA[");

						}
							fileOut1.println (st); 
							fileOut1.flush(); 
					}

				}
			}

			if (bufferReader.readLine() == null)
			{
				fileOut1.println ("</doc>\n"+"</add>"); 
				fileOut1.flush();
			}



		}

	}

}
