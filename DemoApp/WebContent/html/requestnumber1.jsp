<%@ page import="java.util.*,java.io.*,java.sql.*" %>
<%@page import="java.sql.*"%>
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
            <a href="basketscreen1.jsp" class="topbasketbutton"><i class="fas fa-shopping-basket"></i> Basket</a>       
          <div class="top-user-menu dropdown pull-right" dropdown="">
            <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
              aria-haspopup="true" aria-expanded="true">
              <i class="fa fa-user"></i> Admin
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
      <h3>Request #<%=request.getParameter("reqNum") %></h3>
      <div class="table-responsive mt-20">
        <div class="table-wrapper">
          <table class="table table-hover">
            <thead>
              <tr>
                <th style="width: 6%"> S.No</th>
                <th>Schema Name</th>
                <th>Table Name</th>
                <th>Filter Condition</th>
                <th>Target File Path</th>
                <th>Incremental Flag</th>
                <th>Incremental Column</th>
                <th style="width:12%;">Status</th>
              </tr>
            </thead>
            <tbody>
            <%
 			Class.forName("com.mysql.jdbc.Driver");  
            Connection con1=DriverManager.getConnection(  
        	"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23"); 
            String reqNum=request.getParameter("reqNum");
 			//for the given user id
			 String sqlSel = "SELECT REQUEST_NO,SR_NO,SCHEMA_NAME,TABLE_NAME,FILTER_CONDITION,TARGET_S3_BUCKET,INCREMENTAL_FLAG,INCREMENTAL_CLMN,STATUS FROM DMU.DMU_HISTORY_DTL where REQUEST_NO = '"+reqNum+"'";
				Statement stmt1=con1.createStatement();  
				ResultSet rs=stmt1.executeQuery(sqlSel); 
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
					
		            %>
		              <tr>
		                <td><%=sNo%></td>
		                <td><%=Schema%> </td>
		                <td><%=table%></td>
		                <td><%=filter %></td>
		                <td><%=bucket %></td>
		                <td class="text-center">
		                  <div class="checkbox checkbox-primary">
		                    <input id="checkbox2" type="checkbox" <%if("Y".equals(incrflag)){  %>checked=""<%} %> disabled>
		                    <label for="checkbox2">
		                    </label>
		                  </div>
		                </td>
		                <td><%=incrcol%></td>
		                <%if ("Success".equalsIgnoreCase(stat)) { %>
		                <td><a href="#"><span class="label label-success"><%=stat %></span></a></td>
		                <%} 
		                if ("Failed".equalsIgnoreCase(stat)) { %>
		                <td><a href="#"><span class="label label-danger"><%=stat %></span></a></td>
		                <%} if ("Submitted".equalsIgnoreCase(stat)) { %>
		                <td><a href="#"><span class="label label-info"><%=stat %></span></a></td>
		                
		                <%} if ("In Progress".equalsIgnoreCase(stat)) { %>
		                <td><a href="#"><span class="label label-warning"><%=stat %></span></a></td>
		                <%
		                } %>
		              </tr>					
					<%
					
				}
			rs.close();
			stmt1.close();
			con1.close();            
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
  <!-- Include all Completed plugins (below), or include individual files as needed -->
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