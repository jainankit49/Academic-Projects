package assignment;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.io.BufferedReader;
import java.io.InputStreamReader;
/**
 *
 * @author Deepak
 */
public class HW2 {

	static	DecimalFormat df = new DecimalFormat("#.##");
	static ArrayList<ArrayList<String>> finalrules = new ArrayList<ArrayList<String>>();
	static HashSet combine(Integer[] arr, int k, int startId, int[] branch, int numElem,HashSet arrSet){
		if (numElem == k){
			ArrayList<Integer> mySet = new ArrayList<Integer>();
			for(int i=0;i<branch.length;i++)
				mySet.add(branch[i]);

			arrSet.add(mySet);
			return arrSet;
		}

		for (int i = startId; i < arr.length; ++i){
			branch[numElem++]=arr[i];
			combine(arr, k, ++startId, branch, numElem, arrSet);
			--numElem;
		}
		return arrSet;
	}

	static ArrayList<Integer> bin(int k,int b){
		int number=k;
		int base=b;
		final boolean[] ret = new boolean[base];
		ArrayList<Integer> retlist= new ArrayList<Integer>();
		for (int i = 0; i < base; i++) {
			ret[base - 1 - i] = (1 << i & number) != 0;
			if((1 << i & number) != 0)
				retlist.add(1);
			else
				retlist.add(0);
		}
		return retlist;
	}

	static int fcount(HashMap<String,ArrayList<Integer>> db, String[] key){
		ArrayList<ArrayList<Integer>> temp=new ArrayList<ArrayList<Integer>>();
		for(int i=0;i<key.length;i++){
			temp.add(db.get(key[i]));
		}
		int sup=0;
		int flag=0;
		for (int k = 0; k < 100; k++) {
			for (int i = 0; i < temp.size(); i++)
				flag+=temp.get(i).get(k);
			if(flag==temp.size()){
				sup++;
				flag=0;
			}
			else
				flag=0;
		}
		return sup;
	}

	public static ArrayList<ArrayList<String>> templateParser(String rule){

		ArrayList<ArrayList<String>> tempres=new ArrayList<ArrayList<String>>();
		//************template 2 check************
		if(rule.startsWith("SIZEOF")){
			//System.out.println("template 2 found");
			String part = "";
			String symbol = "";
			String number = "";
			String inputRule = rule;
			inputRule = inputRule.replace("SIZEOF","");
			inputRule = inputRule.replace("("," ");
			inputRule = inputRule.replace(")"," ");
			if(inputRule.contains(">="))
				inputRule = inputRule.replace(">="," >= ");
			else if(inputRule.contains("<="))
				inputRule = inputRule.replace("<="," <= ");
			else if(inputRule.contains(">"))
				inputRule = inputRule.replace(">"," > ");
			else if(inputRule.contains("<"))
				inputRule = inputRule.replace("<"," < ");	
			else if(inputRule.contains("="))
				inputRule = inputRule.replace("="," = ");

			inputRule = inputRule.replaceAll("\\s+"," ");
			inputRule = inputRule.trim();
			//System.out.println(inputRule);
			String[] inArr = inputRule.split(" ");
			part   = inArr[0].trim();
			symbol = inArr[1].trim();
			number = inArr[2].trim();
			//System.out.println(symbol+" , "+number);
			ArrayList<ArrayList<String>> result=new ArrayList<ArrayList<String>>();
			tempres=template2(part, symbol, number);	
			
		}

		//************template 3 check*************
		else if(rule.contains("AND") || rule.contains("OR")){
			ArrayList<ArrayList<String>> res1=new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> res2=new ArrayList<ArrayList<String>>();
			if(rule.contains("AND")){
				String[] temps=rule.split("AND");
				res1=templateParser(temps[0]);
				res2=templateParser(temps[1].trim());
				for(int i=0;i<res1.size();i++){
					for(int j=0;j<res2.size();j++){
						if(res1.get(i).equals(res2.get(j))){
							tempres.add(res1.get(i));
						}
					}
				}
				//conOperator = "AND";
			}
			else{
				String[] temps=rule.split("OR");
				res1=templateParser(temps[0]);
				res2=templateParser(temps[1].trim());
				for(int i=0;i<res1.size();i++){
					tempres.add(res1.get(i));
				}
				for(int i=0;i<res2.size();i++){
					if(!tempres.contains(res2.get(i))){
						tempres.add(res2.get(i));
					}
				}
				//conOperator = "OR";
			}

		}

		//*************template 1 check*************
		else if(rule.contains("HAS") && rule.contains("OF")){
			//System.out.println("template 1 found");
			String partA = "";
			String partB = "";
			String partC = "";
			String inputRule = rule;
			String[] inAr1 = inputRule.split("HAS");
			partA = inAr1[0].trim();
			String inAr2[] = inAr1[1].split("OF");
			partB = inAr2[0].trim();
			partC = inAr2[1].trim();
			ArrayList<ArrayList<String>> result=new ArrayList<ArrayList<String>>();
			tempres=template1(partA, partB, partC);
		}
		return tempres;
	}

	public static ArrayList<ArrayList<String>> template1(String partA, String partB, String partC){
		String cols[]=partC.split(",");
		ArrayList<ArrayList<String>> tempres=new ArrayList<ArrayList<String>>();
		if(partA.equalsIgnoreCase("RULE")){
			if(partB.equalsIgnoreCase("ANY")){
				//int number = Integer.parseInt(partB);
				for(int number=1;number<=cols.length;number++){
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] t1=finalrules.get(k).get(0).split(";");
					String[] t2=finalrules.get(k).get(1).split(";");
					String[] body=new String[t1.length+t2.length];
					for(int g=0;g<t1.length;g++){
						body[g]=t1[g];
					}
					for(int g=0;g<t2.length;g++){
						body[g+t1.length]=t2[g];
					}
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			tempres.add(finalrules.get(k));
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
					}

				}
			}
			}

			else if(partB.equalsIgnoreCase("NONE")){
				//int number = Integer.parseInt(partB);
				for(int number=1;number<=1;number++){
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] t1=finalrules.get(k).get(0).split(";");
					String[] t2=finalrules.get(k).get(1).split(";");
					String[] body=new String[t1.length+t2.length];
					for(int g=0;g<t1.length;g++){
						body[g]=t1[g];
					}
					for(int g=0;g<t2.length;g++){
						body[g+t1.length]=t2[g];
					}
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
			        if(found==0){
			        	tempres.add(finalrules.get(k));
			        }
					}

				}
			}
			}
			else{
				int number = Integer.parseInt(partB);
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] t1=finalrules.get(k).get(0).split(";");
					String[] t2=finalrules.get(k).get(1).split(";");
					String[] body=new String[t1.length+t2.length];
					for(int g=0;g<t1.length;g++){
						body[g]=t1[g];
					}
					for(int g=0;g<t2.length;g++){
						body[g+t1.length]=t2[g];
					}
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			tempres.add(finalrules.get(k));
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
					}

				}
			}
		}

		else if(partA.equalsIgnoreCase("BODY")){
			if(partB.equalsIgnoreCase("ANY")){
				//int number = Integer.parseInt(partB);
				for(int number=1;number<=cols.length;number++){
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] body=finalrules.get(k).get(0).split(";");
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			tempres.add(finalrules.get(k));
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
					}

				}
			}
			}
			else if(partB.equalsIgnoreCase("NONE")){
				//int number = Integer.parseInt(partB);
				for(int number=1;number<=1;number++){
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] body=finalrules.get(k).get(0).split(";");
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
			        if(found==0){
			        	tempres.add(finalrules.get(k));
			        }
					}

				}
			}
			}
			else{
				int number = Integer.parseInt(partB);
				for(int k=0;k<finalrules.size();k++){
					String[] body=finalrules.get(k).get(0).split(";");
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			tempres.add(finalrules.get(k));
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
					}

				}
			}
		}

		else if(partA.equalsIgnoreCase("HEAD")){

			if(partB.equalsIgnoreCase("ANY")){
				//int number = Integer.parseInt(partB);
				for(int number=1;number<=cols.length;number++){
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] body=finalrules.get(k).get(1).split(";");
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			tempres.add(finalrules.get(k));
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
					}

				}
			}
			}
			else if(partB.equalsIgnoreCase("NONE")){
				//int number = Integer.parseInt(partB);
				for(int number=1;number<=1;number++){
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] body=finalrules.get(k).get(1).split(";");
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
			        if(found==0){
			        	tempres.add(finalrules.get(k));
			        }
					}

				}
			}
			}
			else{
				int number = Integer.parseInt(partB);
				for(int k=0;k<finalrules.size();k++){
					int count1=0;
					
					String[] body=finalrules.get(k).get(1).split(";");
					if(body.length>=number){
						
					
					Integer[] inp=new Integer[cols.length];
			        for(int x=0;x<cols.length;x++){
			            inp[x]=x;
			        }
			        int[] branch = new int[number];
			        HashSet arrSet=new HashSet();
			        arrSet=combine(inp, number, 0, branch, 0, arrSet);
			        Iterator itc=arrSet.iterator();
			        //ArrayList<String> testcomb=new ArrayList<String>();
			        int matchcount=0;
			        ArrayList<String> str=new ArrayList<String>();
			        while(itc.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itc.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=cols[myint.get(p)]+";";
			            }
			            str.add(tmp);
			            //System.out.println(myint.size());
			        }
			        
			        Integer[] inpb=new Integer[body.length];
			        for(int x=0;x<body.length;x++){
			            inpb[x]=x;
			        }
			        int[] branchb = new int[number];
			        HashSet arrSetb=new HashSet();
			        arrSetb=combine(inpb, number, 0, branchb, 0, arrSetb);
			        Iterator itcb=arrSetb.iterator();
			        ArrayList<String> strbody=new ArrayList<String>();
			        while(itcb.hasNext())
			        {
			            String tmp="";
			            ArrayList<Integer> myint =(ArrayList<Integer>)itcb.next();
			            for(int p=0;p<myint.size();p++){
			            	tmp+=body[myint.get(p)]+";";
			            }
			            strbody.add(tmp);
			            //System.out.println(myint.size());
			        }
			        int found=0;
			        for(int i=0;i<str.size();i++){
			        	for(int j=0;j<strbody.size();j++){
			        		if(str.get(i).equalsIgnoreCase(strbody.get(j))){
			        			tempres.add(finalrules.get(k));
			        			found=1;
			        			break;
			        		}
			        		
			        	}
			        	if(found==1){
		        			break;
		        		}
			        }
					}

				}
			}
		}
		return tempres;
	}

	public static ArrayList<ArrayList<String>> template2(String part, String symbol, String number){

		// BODY CASE:
		ArrayList<ArrayList<String>> tempres=new ArrayList<ArrayList<String>>();
		if(part.equalsIgnoreCase("BODY")){
			for(int k=0;k<finalrules.size();k++){
				String[] body=finalrules.get(k).get(0).split(";");
				int bodySize = body.length;
				int num = Integer.parseInt(number);
				if(symbol.equals(">")){
					if(bodySize > num ){
						tempres.add(finalrules.get(k));
					}
				}

				else if(symbol.equals("=")){
					if(bodySize == num ){
						tempres.add(finalrules.get(k));
					}
						
				}

				else if(symbol.equals("<")){
					if(bodySize < num )
					{
						tempres.add(finalrules.get(k));
					}
						
				}

				else if(symbol.equals(">=")){
					if(bodySize >= num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("<=")){
					if(bodySize <= num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}
			}
			return tempres;
		}

		// HEAD CASE:
		if(part.equalsIgnoreCase("HEAD")){
			for(int k=0;k<finalrules.size();k++){
				String[] head=finalrules.get(k).get(1).split(";");
				int headSize = head.length;
				int num = Integer.parseInt(number);
				if(symbol.equals(">")){
					if(headSize > num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("=")){
					if(headSize == num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("<")){
					if(headSize < num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals(">=")){
					if(headSize >= num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("<=")){
					if(headSize <= num )
					{
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}
			}
			return tempres;
		}

		// RULE CASE
		if(part.equalsIgnoreCase("RULE")){
			for(int k=0;k<finalrules.size();k++){
				String[] body=finalrules.get(k).get(0).split(";");
				String[] head=finalrules.get(k).get(1).split(";");
				int headSize = head.length;
				int bodySize = body.length;
				int ruleSize = headSize+bodySize;

				int num = Integer.parseInt(number);
				if(symbol.equals(">")){
					if(ruleSize > num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("=")){
					if(ruleSize == num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("<")){
					if(ruleSize < num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"]  ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals(">=")){
					if(ruleSize >= num) {
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}

				else if(symbol.equals("<=")){
					if(ruleSize <= num ){
						tempres.add(finalrules.get(k));
					}
						//System.out.println("["+finalrules.get(k).get(0)+"] ==> ["+finalrules.get(k).get(1)+"] ; Support: "+finalrules.get(k).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalrules.get(k).get(3))));
				}
			}
			return tempres;
		}
		return tempres;
	}
//	public static void template3(String headDisease, String headCount,String bodyDisease, String bodyCount, String conOperator){
//		String[] body = {};
//		String[] head = {};
//		String[] arg = {};
//		for(int k=0;k<finalrules.size();k++){
//			body=finalrules.get(k).get(0).split(";");
//			head=finalrules.get(k).get(1).split(";");
//
//			if(conOperator.equalsIgnoreCase("AND")){
//				arg = args.split("AND");
//			}
//			else if(conOperator.equalsIgnoreCase("OR")){
//				
//			}
//		}
//	}

	/**
	 * @param args the command line arguments
	 */
	public static void main(String[] args) throws SQLException, IOException{
		// TODO code application logic here
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		Connection connection = null;

		//InputStreamReader supinput = new InputStreamReader(System.in);
		// double confidence=70.0;
		Scanner sc = new Scanner(System.in); 
		System.out.println("Enter the support value:"); 
		double n = sc.nextDouble();
		double min_support=n; double confidence=70.0;
		int nfreqs=0;
		connection =DriverManager.getConnection ("jdbc:oracle:thin:@localhost:1521:xe","System","password");
		Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		String tabnum="1";
		HashMap<String,Integer> freq1=new HashMap<String,Integer>();
		String qsel;
		qsel="SELECT * FROM HW2 ORDER BY SAMPLE";
		ResultSet rs=stmt.executeQuery(qsel);
		rs.next();
		HashMap<String,ArrayList<Integer>> db=new HashMap<String,ArrayList<Integer>>();
		for(int i=1;i<=100;i++){
			ArrayList<Integer> temp=new ArrayList<Integer>();
			for(int j=1;j<=100;j++){
				if(rs.getString(i+1).equalsIgnoreCase("UP")){
					temp.add(1);

				}else{
					temp.add(0);

				}

				rs.next();
			}
			rs.first();
			db.put("G"+i+"-UP", temp);
		}
		rs.first();
		for(int i=1;i<=100;i++){
			ArrayList<Integer> temp=new ArrayList<Integer>();
			for(int j=1;j<=100;j++){
				if(rs.getString(i+1).equalsIgnoreCase("Down")){
					temp.add(1);
				}else{
					temp.add(0);
				}
				rs.next();
			}
			rs.first();
			db.put("G"+i+"-Down", temp);
		}
		rs.first();
		ArrayList<Integer> dtemp=new ArrayList<Integer>();

		for (int j = 1; j <= 100; j++) {
			if (rs.getString(102).equalsIgnoreCase("AML")) {
				dtemp.add(1);

			} else {
				dtemp.add(0);
			}
			rs.next();
		}
		db.put("AML", dtemp);
		ArrayList<Integer> dtemp1=new ArrayList<Integer>();
		rs.first();
		for(int j=1;j<=100;j++){
			if(rs.getString(102).equalsIgnoreCase("ALL")){
				dtemp1.add(1);

			}else{
				dtemp1.add(0);
			}
			rs.next();
		}
		db.put("ALL", dtemp1);
		ArrayList<Integer> dtemp2=new ArrayList<Integer>();
		rs.first();
		for(int j=1;j<=100;j++){
			if(rs.getString(102).equalsIgnoreCase("Breast Cancer")){
				dtemp2.add(1);
			}else{
				dtemp2.add(0);
			}
			rs.next();
		}
		db.put("Breast Cancer", dtemp2);
		rs.first();
		ArrayList<Integer> dtemp3=new ArrayList<Integer>();
		for(int j=1;j<=100;j++){
			if(rs.getString(102).equalsIgnoreCase("Colon Cancer")){
				dtemp3.add(1);
			}else{
				dtemp3.add(0);
			}
			rs.next();
		}
		db.put("Colon Cancer", dtemp3);
		for(int i=1;i<=100;i++){
			ArrayList<Integer> ftemp=new ArrayList<Integer>();
			ftemp=db.get("G"+i+"-UP");
			int fc=0;
			for(int j=0;j<ftemp.size();j++){
				if(ftemp.get(j)==1){
					fc++;
				}
			}
			if(fc>=min_support){
				freq1.put("G"+i+"-UP", fc);
			}
		}
		for(int i=1;i<=100;i++){
			ArrayList<Integer> ftemp=new ArrayList<Integer>();
			ftemp=db.get("G"+i+"-Down");
			int fc=0;
			for(int j=0;j<ftemp.size();j++){
				if(ftemp.get(j)==1){
					fc++;
				}
			}
			if(fc>=min_support){
				freq1.put("G"+i+"-Down", fc);
			}
		}
		ArrayList<Integer> fd1 = new ArrayList<Integer>();
		fd1 = db.get("ALL");
		int fc = 0;
		for (int j = 0; j < fd1.size(); j++) {
			if (fd1.get(j) == 1) {
				fc++;
			}
		}
		if(fc>=min_support){
			freq1.put("ALL", fc);
		}
		fc=0;
		ArrayList<Integer> fd2 = new ArrayList<Integer>();
		fd2 = db.get("AML");
		for (int j = 0; j < fd1.size(); j++) {
			if (fd2.get(j) == 1) {
				fc++;
			}
		}
		if(fc>=min_support){
			freq1.put("AML", fc);
		}
		fc=0;
		ArrayList<Integer> fd3 = new ArrayList<Integer>();
		fd3 = db.get("Breast Cancer");
		for (int j = 0; j < fd1.size(); j++) {
			if (fd3.get(j) == 1) {
				fc++;
			}
		}
		if(fc>=min_support){
			freq1.put("Breast Cancer", fc);
		}
		fc=0;
		ArrayList<Integer> fd4 = new ArrayList<Integer>();
		fd4 = db.get("Colon Cancer");
		for (int j = 0; j < fd1.size(); j++) {
			if (fd4.get(j) == 1) {
				fc++;
			}
		}
		if(fc>=min_support){
			freq1.put("Colon Cancer", fc);
		}

		//freq1 generation completed

		ArrayList<HashMap<String,Integer>> freqs=new ArrayList<HashMap<String,Integer>>();
		freqs.add(freq1);
		HashMap<String,Integer> freq2=new HashMap<String,Integer>();
		String[] freq1list=new String[freq1.size()];
		freq1.keySet().toArray(freq1list);
		for (int i = 0; i < freq1list.length; i++) {
			for (int j = i + 1; j < freq1list.length; j++) {
				ArrayList<Integer> f1=db.get(freq1list[i]);
				ArrayList<Integer> f2=db.get(freq1list[j]);
				int supp=0;
				for(int k=0;k<100;k++){
					if(f1.get(k)==1 && f2.get(k)==1){
						supp++;
					}
				}
				if(supp>=min_support){
					freq2.put(freq1list[i]+";"+freq1list[j], supp);
				}

			}
		}
		System.out.print(freq2.size());
		freqs.add(freq2);
		int k=3;

		for(;;){
			ArrayList<ArrayList<String>> entries=new ArrayList<ArrayList<String>>();
			HashMap<ArrayList<String>,Integer> lastfreq=new HashMap<ArrayList<String>,Integer>();
			HashMap<String,Integer> tempfreq=new HashMap<String,Integer>();
			String[] keyent=new String[freqs.get(k-2).size()];
			System.out.println("Previous freq size : "+freqs.get(k-2).size());
			freqs.get(k-2).keySet().toArray(keyent);            
			for(int h=0;h<keyent.length;h++){
				ArrayList<String> temp=new ArrayList<String>();
				String[] cc=keyent[h].split(";");
				for(int x=0;x<cc.length;x++){
					temp.add(cc[x]);
				}
				entries.add(temp);
				lastfreq.put(temp, 1);
			}
			System.out.println(entries.size());
			for(int i=0;i<entries.size();i++){
				for(int j=i+1;j<entries.size();j++){
					ArrayList<String> comp=new ArrayList<String>();
					ArrayList<String> comp2=new ArrayList<String>();
					comp=(ArrayList<String>)entries.get(i).clone();
					comp2=(ArrayList<String>)entries.get(j).clone();
					int pat=1;
					for(int g=0;g<k-2;g++){
						if(comp.get(g).equalsIgnoreCase(comp2.get(g))){
							pat=1;
						}
						else{
							pat=0;
							break;
						}
					}
					//comp.retainAll(comp2);
					if(pat==1){
						ArrayList<String> comb=new ArrayList<String>();
						comb=(ArrayList<String>)entries.get(i).clone();
						ArrayList<String> comb1=new ArrayList<String>();
						comb1=(ArrayList<String>)entries.get(j).clone();
						for (String x : comb1) {
							if (!comb.contains(x)) {
								comb.add(x);
							}
						}
						int flag=0;
						int mfound=0;
						for(int h=0;h<comb.size();h++){
							ArrayList<String> myt=new ArrayList<String>();
							myt=(ArrayList<String>)comb.clone();
							myt.remove(h);

							for(int l=0;l<entries.size();l++){
								if(entries.get(l).equals(myt)){
									mfound=1;
								}
							}

						}
						if(mfound==1){
							String[] cols=new String[comb.toArray().length];
							comb.toArray(cols);
							int sp = fcount(db, cols);
							if (sp >= min_support) {
								String key = "";
								for (int zz = 0; zz < k; zz++) {
									if (zz == k - 1) {
										key += cols[zz];
									} else {
										key += cols[zz] + ";";
									}
								}
								tempfreq.put(key, sp);
							}
						}
					}
				}
			}

			if(tempfreq.size()>0){
				freqs.add(tempfreq);
				k++;
			}
			else{
				System.out.println("Frequent ItemSet Generation Complete for Minimum Support ="+min_support);
				int totalcount = 0;
				for(int ff=0;ff<freqs.size();ff++){
					System.out.println("Freq "+(ff+1)+" : "+freqs.get(ff).size());
					totalcount+=freqs.get(ff).size();
				}
				System.out.println("Total : "+totalcount);
				break;
			}



		}
		System.out.println(k);
		//Association rules
		ArrayList<ArrayList<String>> candrule = new ArrayList<ArrayList<String>>();
		for (int an = 2; an < k; an++) {
			HashMap<String,Integer> tmp=new HashMap<String,Integer>();
			tmp=(HashMap<String,Integer>)freqs.get(an-1).clone();
			String[] cols=new String[tmp.size()];
			tmp.keySet().toArray(cols);
			for(int mm=0;mm<cols.length;mm++){
				ArrayList temp1=new ArrayList<String>();
				String[] gs=cols[mm].split(";");
				for(int zz=0;zz<gs.length;zz++){
					temp1.add(gs[zz]);
				}
				temp1.add(tmp.get(cols[mm]).toString());
				candrule.add(temp1);
			}

		}

		ArrayList<ArrayList<String>> assrule = new ArrayList<ArrayList<String>>();
		for (int i = 0; i < candrule.size(); i++) {
			ArrayList<String> candrow = new ArrayList<String>();
			candrow = candrule.get(i);
			int numsize = candrow.size() - 1;
			int base = numsize;
			double ddd = candrow.size() - 1;
			ArrayList<ArrayList<Integer>> binary = new ArrayList<ArrayList<Integer>>();
			int x = (int) Math.pow(2.0, ddd) - 2;
			for (int j = x; j > 0; j--) {
				ArrayList<Integer> tbin = new ArrayList<Integer>();
				tbin = bin(j, base);
				binary.add(tbin);
			}
			for (int j = 0; j < binary.size(); j++) {
				ArrayList<Integer> btemp = new ArrayList<Integer>();
				btemp = binary.get(j);
				ArrayList<String> asctemp = new ArrayList<String>();
				String body = "";
				String head = "";
				for (int h = 0; h < btemp.size(); h++) {
					if (btemp.get(h) == 0) {
						body += candrow.get(h) + ";";
					} else {
						head += candrow.get(h) + ";";
					}
				}
				asctemp.add(body);
				asctemp.add(head);
				asctemp.add(candrow.get(candrow.size() - 1));
				assrule.add(asctemp);
			}
		}
		Iterator itl = assrule.iterator();

		for(int jj=0;jj<assrule.size();jj++){
			ArrayList<String> rtemp=new ArrayList<String>(assrule.get(jj));
			//rtemp=(ArrayList<String>)assrule.get(jj).clone();
			String body = rtemp.get(0);
			Integer xxx=Integer.parseInt(rtemp.get(2));
			String rsup = rtemp.get(2);
			String[] gs = body.split(";");
			int sp=fcount(db,gs);
			Double confid = (double)sp;
			Double cd = (Double.parseDouble(rsup) / confid) * 100;
			int ind = assrule.indexOf(rtemp);
			assrule.get(ind).add(cd.toString());
		}


		for (int g = 0; g < assrule.size(); g++) {
			Double cdd = Double.parseDouble(assrule.get(g).get(3));
			if (cdd >= 70.0) {
				finalrules.add(assrule.get(g));

			}
		}
		System.out.println("Number of rule generated :"+finalrules.size());
		InputStreamReader input1 = new InputStreamReader(System.in);
		BufferedReader reader1 = new BufferedReader(input1);
		System.out.println("Enter query :");
		String queryrules = reader1.readLine().trim();
		//System.out.println(queryrules);
		ArrayList<ArrayList<String>> finalres=new ArrayList<ArrayList<String>>();
		finalres=templateParser(queryrules);
		System.out.println("Numbers of rules retrieved : "+finalres.size());
		for(int i=0;i<finalres.size();i++){
			System.out.println("["+finalres.get(i).get(0).replaceAll(";"," ").trim()+"] ==> ["+finalres.get(i).get(1).replaceAll(";"," ").trim()+"] ; Support: "+finalres.get(i).get(2)+" ; Confidence : "+df.format(Double.parseDouble(finalres.get(i).get(3))));
		}


	}

}
