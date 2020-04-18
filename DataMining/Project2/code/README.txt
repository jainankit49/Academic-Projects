1. Create a table named HW2 in Oracle DB with input data provided.
2. In the connection string for jdbc, modify the username, password and SID.
3. Execute the HW2.java file. 
4. Enter the support value at the console.
5. Confidence value has been assumed to be 70.0
6. The console will display the number of frequent item sets and their values.
7. Number of rules generated for given support and confidence will be displayed.
8. Enter the template query at the console.
9. Please follow the below syntax for different template queries,
   (Full Query has to be entered in UpperCase)(Please enter "down" in lowercase i.e. G1-Down)
   (i) Template 1: 
       RULE HAS ANY|NUMBER|NONE OF (ITEM1,ITEM2.....)   
	   Eg. RULE HAS NONE OF G1-Down
  (ii) Template 2:     
       SIZEOF BODY|HEAD|RULE >= NUMBER
	   Eg. SIZEOF BODY >= 2
 (iii) Template 3:
       HEAD HAS (1) OF (Disease) AND BODY HAS (NONE) OF (Disease)
	   Eg. HEAD HAS 1 OF Breast Cancer AND BODY HAS NONE OF Colon Cancer
10. The template query outputs will be displayed accordingly. 	   
	   