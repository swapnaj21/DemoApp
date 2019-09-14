
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%

Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
		"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23");  

//  
  
if (request.getParameter("action") != null && request.getParameter("action").equals("submit"))
{
	
		//Get the list of baskets from DB.
		//For each basket, insert 1 record in HISTORY_MAIN and corresponding HISTORY_DTL tables
	    String sqlSel = "SELECT DISTINCT LABEL_NAME FROM DMU_BASKET_TEMP WHERE USER_ID='Admin'";
		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery(sqlSel); 
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		ArrayList<String> lstBasket = new ArrayList();
		while (rs.next()) {
			
			lstBasket.add(rs.getString(1));
		}
		rs.close();
		stmt.close();
		
		for (String labelname : lstBasket)
		{
			java.util.Date date = new java.util.Date();
			java.sql.Date sDate = new java.sql.Date(date.getTime());
			 String sqlInsert = "INSERT INTO DMU_HISTORY_MAIN (REQUEST_NO,USER_ID,REQUESTED_TIME,STATUS,REQUEST_TYPE) values (?,?,now(),?,?)";
			 PreparedStatement pstmt = con.prepareStatement(sqlInsert);
			 pstmt.setString(1,labelname);
			 pstmt.setString(2,"Admin");
			// pstmt.setDate(3,now());
			 pstmt.setString(3,"Submitted");
			 pstmt.setString(4,request.getParameter("migtype"));
			
			 pstmt.executeUpdate();
			 pstmt.close();
			 
			 //insert into detail table from basket table
			 String strInsert = "INSERT INTO DMU_HISTORY_DTL(REQUEST_NO, SR_NO, SCHEMA_NAME, TABLE_NAME, FILTER_CONDITION, TARGET_S3_BUCKET, INCREMENTAL_FLAG, INCREMENTAL_CLMN, STATUS) SELECT LABEL_NAME, SR_NO, SCHEMA_NAME, TABLE_NAME, FILTER_CONDITION, TARGET_S3_BUCKET, INCREMENTAL_FLAG, INCREMENTAL_CLMN, 'SUBMITTED' FROM DMU.DMU_BASKET_TEMP WHERE USER_ID = 'Admin' AND LABEL_NAME = ? ";
			 pstmt = con.prepareStatement(strInsert);
			 pstmt.setString(1,labelname);
			 
			 pstmt.executeUpdate();
			 pstmt.close();
			 

			 //Delete from basket table
			 String sqlDelete = "DELETE FROM DMU_BASKET_TEMP WHERE USER_ID= 'Admin' AND LABEL_NAME = ? ";
			 
			 pstmt = con.prepareStatement(sqlDelete);
			 pstmt.setString(1,labelname);
			 pstmt.executeUpdate();
			 pstmt.close();			
		}

	 
	 


}
con.close();
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <title>Data Migration Utility</title>

  <!-- Bootstrap -->
  <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="font-awesome-5.0.8/css/fontawesome-all.min.css" rel="stylesheet">
  <link href="css/bootstrap-select.min.css" rel="stylesheet">
  <link href="css/style.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
  <!--Eof Migration scope Modal-->

  <section id="inner-header">
    <div class="container">
      <div class="row">
        <div class="col-md-7">
          <div class="inner-logo">
            <h2><span>DE</span>Data Migration Utility</h2>
          </div>
        </div>
        <div class="col-md-5 text-right">
          <a href="basketscreen1.jsp" class="topbasketbutton"><i
              class="fas fa-shopping-basket"></i> Basket</a>
          <div class="top-user-menu dropdown pull-right" dropdown="">
            <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
              aria-haspopup="true" aria-expanded="true">
              <i class="fa fa-user"></i>  <%=(String)session.getAttribute("username") %>
              <span class="caret"></span>
            </button>
            <ul aria-labelledby="dLabel" class="dropdown-menu">
              <li>
                <a href="settings.jsp">Settings</a>
              </li>
              <li>
                <a href="login.jsp">Signout</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!--Eof Header-->

  <section id="main-menu">
    <div class="container">
      <nav class="navbar">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
              data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
          </div>

          <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
              <li><a href="home.jsp"><i class="fas fa-home"></i> Home</a></li>
              <li><a href="request1.jsp"><i class="fas fa-file"></i> Request</a></li>
              <li class="active"><a href="history1.jsp"><i class="fas fa-history"></i> History</a></li>
              <li><a href="recon.html"><i class="fas fa-retweet"></i> Recon</a></li>
              <li><a href="help.html"><i class="fas fa-question"></i> Help</a></li>
            </ul>

          </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
      </nav>
    </div>
  </section>
  <!--Eof Menu-->

  <section id="main-content-wrapper">
    <div class="container mainwrapper">
      <div class="row">
        <div class="col-md-6">
          <h3>History</h3>
        </div>
        <div class="col-md-6 text-right mt-20"><i class="fas fa-sync-alt"></i>
            <a href="history1.jsp?action=ret" class="btn btn-sm btn-success">Refresh Status</a></div>
             
      </div>
      <!--Sof Filters-->
      <div class="filters-wrapper">
        <div class="row">
          <h4><i class="fas fa-filter"></i> Filters</h4>
          <div class="form-group col-md-3">
            <label>Request No</label>
            <input type="text" class="form-control">
          </div>
          <div class="form-group col-md-3">
            <label>Request by</label>
            <select class="form-control selectpicker">
              <option>--select--</option>
              <option>John Doe</option>
              <option>Admin</option>
            </select>
          </div>

          <div class="form-group col-md-3">
            <label>Request Type</label>
            <select class="form-control selectpicker">
              <option>--select--</option>
              <option>HDFS to S3</option>
              <option>Teradata to S3</option>
            </select>
          </div>

          <div class="form-group col-md-3">
            <label>Status</label>
            <select class="form-control selectpicker">
              <option>--select--</option>
              <option>Completed</option>
              <option>In Proccess</option>
              <option>Error</option>
            </select>
          </div>
        </div>
      </div>
      <!--Eof Filters-->
      <div class="table-responsive mt-20">
        <div class="table-wrapper">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>Request No</th>
                <th>Requested by</th>
                <th>Requested Time</th>
                <th>Status</th>
                <th>Request Type</th>
                <th>Script Generation Completed Time</th>
                <th>Execution Completed Time</th>
              </tr>
            </thead>
            <tbody>
            
                        <%
        	Class.forName("com.mysql.jdbc.Driver");  
            con=DriverManager.getConnection(  
        	"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23");  

            	//retrieve all baskets.
	//for the given user id
	 String sqlSel = "SELECT REQUEST_NO,USER_ID,REQUESTED_TIME,STATUS,REQUEST_TYPE,SCRIPT_GEN_CMPLT_TIME,EXCTN_CMPLT_TIME FROM DMU_HISTORY_MAIN where USER_ID='Admin' ORDER by REQUESTED_TIME DESC";
		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery(sqlSel); 
		java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		int count=0;
		String fmt = "";
		while (rs.next()) {
		count++;
		 %>   
			<tbody>
            <tr>
              <td><a href="requestnumber1.jsp?reqNum=<%=rs.getString("REQUEST_NO") %>"><%=rs.getString("REQUEST_NO") %>
              </td>
               <td><%=rs.getString("USER_ID") %></td>
               <%
              
               java.sql.Timestamp dbSqlTimestamp = rs.getTimestamp("REQUESTED_TIME");
               //fmt = format.format( new java.util.Date(dbSqlTimestamp));
               %>
                <td><%=dbSqlTimestamp.toString()%></td>
                 <%
                 if ("Completed".equals(rs.getString("STATUS")))
                 {
                	 %>
                	<td><span class="label label-success"><%=rs.getString("STATUS")%></span></td> 
                	 <%
                	 
                 }
                 
                 if ("Failed".equals(rs.getString("STATUS")))
                 {
                	 %>
                	 <td><span class="label label-danger"><%=rs.getString("STATUS")%></span></td> 
                	 <%
                 }
                 
                 if ("In Progress".equals(rs.getString("STATUS")) )
                 {
                	 %>
                	 <td><span class="label label-warning"><%=rs.getString("STATUS")%></span></td> 
                	 <%
                 }
                 if ("Submitted".equals(rs.getString("STATUS")))
                 {
                	 %>
                	 <td><span class="label label-info"><%=rs.getString("STATUS")%></span></td> 
                	 <%
                 }
                 %>                    

                  <td><%=rs.getString("REQUEST_TYPE") %></td>
                  <td><%=rs.getString("SCRIPT_GEN_CMPLT_TIME") == null ? "" : rs.getString("SCRIPT_GEN_CMPLT_TIME")%></td> 
                  <td><%=rs.getString("EXCTN_CMPLT_TIME") == null ? "" : rs.getString("EXCTN_CMPLT_TIME")%><a href='ftptool.jsp?reqNum=<%=rs.getString("REQUEST_NO") %>' target="_new">logs</td>
            </tr>

		  <%  
			
		}
		rs.close();
		stmt.close();
		con.close();
		if (count ==0)
		{
			%>
			<td colspan=7>History Empty. No migration history.</td>
			<% 
		}
		 %>
 

            </tbody>
          </table>
        </div>
      </div>
    </div>
    </div>

    </div>
  </section>
  <!-- Eof Mid Content-->

  <section id="login-footer">
    <div class="container">
      <div class="poweredby">
        <p>Powered by</p>
        <img src="images/data_economy_logo.png" alt="Data Economy" />
      </div>
    </div>
  </section>

  <!--Eof Footer-->


  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="js/bootstrap-select.min.js"></script>
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <script>
    $(document).ready(function () {
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
    });
  </script>
</body>

</html>