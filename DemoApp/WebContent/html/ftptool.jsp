<%@ page import="java.util.*,java.io.*,java.sql.*" %>
<%@page import="java.sql.*"%>
<%
 		try
		{
 			
 			String reqNum = request.getParameter("reqNum");
 			String schemaString = "";
 			//reqNum= "http://localhost:8080/DemoApp/html/requestnumber1.jsp?reqNum=Admin-2019-09-10%2004:46:35";
 			Class.forName("com.mysql.jdbc.Driver");  
            Connection con1=DriverManager.getConnection(  
        	"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23"); 
 
        	Statement stmt1=con1.createStatement();  
        	ResultSet rs = null;
			if (reqNum == null || "".equals(reqNum.trim()))
			{
				stmt1=con1.createStatement();  
	 			
	 			rs=stmt1.executeQuery("select REQUEST_NO FROM DMU_HISTORY_MAIN WHERE STATUS = 'Submitted' ");  
	 			while (rs.next()) {
	 				reqNum = rs.getString(1);		
	 			}
	 			rs.close();
	 			stmt1.close();   		
			}
			
			if (reqNum == null || "".equals(reqNum.trim()))
			{
				out.println("No Requests in Pending Status");
				
			}
			else
			{
				
            String sqlUpdate = "UPDATE DMU_HISTORY_MAIN SET STATUS = 'In Progress' WHERE REQUEST_NO = ?";
           
	       	 PreparedStatement pstmt = con1.prepareStatement(sqlUpdate);
	       	 pstmt.setString(1,reqNum);  	 
	       	 pstmt.executeUpdate();
	       	 pstmt.close();

	       	sqlUpdate = "UPDATE DMU_HISTORY_DTL SET STATUS = 'In Progress' WHERE REQUEST_NO = ?";
	           
	       	 pstmt = con1.prepareStatement(sqlUpdate);
	       	 pstmt.setString(1,reqNum);  	 
	       	 pstmt.executeUpdate();
	       	 pstmt.close();
	       	 
	       	
	 			stmt1=con1.createStatement();  
	 			rs = null;
	 			String AWS_ACCESS_ID="";
	 			String AWS_SECRET_KEY="";
	 			rs=stmt1.executeQuery("select AWS_ACCESS_ID ,AWS_SECRET_KEY from DMU_S3 ");  
	 			while (rs.next()) {
	 				AWS_ACCESS_ID = rs.getString("AWS_ACCESS_ID");
	 				AWS_SECRET_KEY = rs.getString("AWS_SECRET_KEY");				
	 			}
	 			rs.close();
	 			stmt1.close();            
 			//for the given user id
 			 String sqlSel = "SELECT REQUEST_NO,SR_NO,SCHEMA_NAME,TABLE_NAME,FILTER_CONDITION,TARGET_S3_BUCKET,INCREMENTAL_FLAG,INCREMENTAL_CLMN,STATUS FROM DMU.DMU_HISTORY_DTL where REQUEST_NO = '"+reqNum+"'";
 				stmt1=con1.createStatement();  
 				rs=stmt1.executeQuery(sqlSel); 
 				ArrayList<String> listSchema=new ArrayList();
 				ArrayList<String> listLocation=new ArrayList();
 				ArrayList<String> listBucket=new ArrayList();
 				String ftpString="";
 				String sNo="";
 				String Schema="";
 				String table="";
 				String filter="";
 				String bucket="";
 				String incrflag="";
 				String incrcol="";
 				String stat="";
 				
 				while (rs.next()) {
 					
 					sNo=rs.getString("SR_NO");
 					Schema=rs.getString("SCHEMA_NAME");
 					table=rs.getString("TABLE_NAME");
 					filter=rs.getString("FILTER_CONDITION");
 					bucket=rs.getString("TARGET_S3_BUCKET");
 					incrflag=rs.getString("INCREMENTAL_FLAG");
 					incrcol=rs.getString("INCREMENTAL_CLMN");
 					stat=rs.getString("STATUS");
 					
 					ftpString=sNo+"-"+Schema+"-"+table+"-"+filter+"-"+bucket+"-"+incrflag+"-"+incrcol+"-"+stat;
 					schemaString=Schema+"."+table;
 					
 					out.println(schemaString);
 					listSchema.add(schemaString);
 					listBucket.add(bucket);
 					out.println("<BR>");
 					
 				}
 			rs.close();
 			stmt1.close();
 			

 			
			Class.forName("com.cloudera.hive.jdbc41.HS2Driver");
				//Added
				String connection="jdbc:hive2://18.216.202.239:10000"; //+hostname+":"+port;
				java.sql.Connection con = java.sql.DriverManager.getConnection(connection,"", "");
 			for (String schema :listSchema)
 			{
 
 				//java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:impala://18.216.202.239:10000", "", "");
 				java.sql.Statement stmt = con.createStatement();
 				String showtable = null;
 				String hivelocation = null;
 				boolean ftpstring=false;
 				//String sql = ("show tables");
 				//String sql = ("select count(*) from categories");
 				String sql = ("SHOW CREATE TABLE "+schema);
 				java.sql.ResultSet res = stmt.executeQuery(sql);
 				 
 				
 				
 			//	sql = ("SHOW CREATE TABLE customers");
 			//	res = stmt.executeQuery(sql);
 				
 				while (res.next()) {
 				    showtable = res.getString(1);
 				   
 				    if (showtable!=null && showtable.equals("LOCATION")) 
 				    {
 				    	ftpstring= true;
 				    	
 				    	continue;
 				    }
 				    if (ftpstring)
 				    {
 				    	
 				    	hivelocation =  showtable.substring(3, showtable.length()-1).trim();
 				    	listLocation.add(hivelocation);
 				    	out.println(hivelocation+"-"+schema);
 				    	out.println("<BR>");
 				    	break;
 				    }
 				    
 				 }
 				res.close();
 				stmt.close();			
 			}  // End for schema array
 				
 			

			con.close();
 			int index = 0;	
 			String sftpcmd = "";		
 			for (String loc : listLocation)
 			{
 				
 				String bucketVal = listBucket.get(index);
 				index++;
 				if (AWS_ACCESS_ID == null ||  "".equals(AWS_ACCESS_ID.trim()) )
 				{
 	 				sftpcmd = "ssh -i /Users/chaturvedula/Downloads/dmu-user.pem dmu-user@18.216.202.239 /opt/cloudera/parcels/CDH-5.16.2-1.cdh5.16.2.p0.8/lib/hadoop/bin/hadoop distcp "+ loc+"/*  s3a://@"+bucketVal;
 					
 				}
 				else
 				{
 	 				sftpcmd = "ssh -i /Users/chaturvedula/Downloads/dmu-user.pem dmu-user@18.216.202.239 /opt/cloudera/parcels/CDH-5.16.2-1.cdh5.16.2.p0.8/lib/hadoop/bin/hadoop distcp "+ loc+"/*  s3a://"+AWS_ACCESS_ID+":"+AWS_SECRET_KEY+"@"+bucketVal;
 					
 				}
 				out.println(sftpcmd);
 				out.println("<BR>");
 				
 				Process p = Runtime.getRuntime().exec(sftpcmd);
 				
 	            try {
 					InputStreamReader ise = new InputStreamReader(p.getErrorStream());
 					BufferedReader bre = new BufferedReader(ise);
 					InputStreamReader iso = new InputStreamReader(p.getInputStream());
 					BufferedReader bro = new BufferedReader(iso);

 					String line=null;
 					while ( (line = bre.readLine()) != null ) {
 					    out.println( "ERR>" + line );
 					    out.println( "<BR>");
 					}
 					while ( (line = bro.readLine()) != null ) {
 					    out.println( "OUT>" + line );
 					    out.println( "<BR>");
 					}

 	            } catch (IOException ioe)
 	            {
 	                    ioe.printStackTrace();  
 	            }

 	            int exitVal = p.waitFor();

 	            out.println( exitVal );
 	            if (exitVal== 0)
 	    		{
 	    			out.println("Script success");
 	    			
 	    			//Update the table with success
 	    			con1=DriverManager.getConnection(  
 	    					"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23"); 

 	    				  sqlUpdate = "UPDATE DMU_HISTORY_DTL SET STATUS = 'Success' WHERE REQUEST_NO = ? AND TARGET_S3_BUCKET = ?";

 	    					  pstmt = con1.prepareStatement(sqlUpdate);
 	    					 pstmt.setString(1,reqNum); 
 	    					 pstmt.setString(2,bucketVal);
 	    					 pstmt.executeUpdate();
 	    					 pstmt.close();
 	    					 con1.close();
 	    		} 
 	            else 
 	    		{
 	    			out.println("Script failure");
 	    			
 	    			//Update the table with success
 	    			con1=DriverManager.getConnection(  
 	    					"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23"); 

 	    				  sqlUpdate = "UPDATE DMU_HISTORY_DTL SET STATUS = 'Failed' WHERE REQUEST_NO = ? AND TARGET_S3_BUCKET = ?";

 	    					  pstmt = con1.prepareStatement(sqlUpdate);
 	    					 pstmt.setString(1,reqNum); 
 	    					 pstmt.setString(2,bucketVal);
 	    					 pstmt.executeUpdate();
 	    					 pstmt.close();
 	    					 con1.close();
 	    		} 	           
 			}

 		  			con1=DriverManager.getConnection(  
 					"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23"); 

 				  sqlUpdate = "UPDATE DMU_HISTORY_MAIN SET STATUS = 'Completed' WHERE REQUEST_NO = ? ";

 					  pstmt = con1.prepareStatement(sqlUpdate);
 					 pstmt.setString(1,reqNum);
 					 
 					 pstmt.executeUpdate();
 					 pstmt.close();
 					 con1.close();
    }
		}
    catch (Throwable t) {
            t.printStackTrace();
    }
	
		

		
		 %>	
		