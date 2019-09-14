<%@ page import="java.sql.*"%>
<%!String SR_NO=""; %>
<%!String CONNECTION_TYPE=""; %>
<%!String HIVE_HOST_NAME=""; %>
<%!String HIVE_PORT_NMBR=""; %>
<%!String IMPALA_HOST_NAME=""; %>
<%!String IMPALA_PORT_NMBR=""; %>
<%!String AWS_ACCESS_ID=""; %>
<%!String AWS_SECRET_KEY=""; %>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection con=DriverManager.getConnection(  
	"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23");  
	//Save connection
	if (request.getParameter("submitted")!=null && request.getParameter("submitted").equals("save"))
	{
		String sqlUpdate = "";
		if (request.getParameter("hdfs")!= null && request.getParameter("hdfs").equals("hive"))
		{
			 sqlUpdate = "UPDATE DMU_HDFS "
		                + "SET CONNECTION_TYPE = ? ,HIVE_HOST_NAME = ? , HIVE_PORT_NMBR = ?, IMPALA_HOST_NAME = NULL, IMPALA_PORT_NMBR = NULL"
		                + " WHERE SR_NO = 1";
			 PreparedStatement pstmt = con.prepareStatement(sqlUpdate);
			 pstmt.setString(1,"HIVE");
			 pstmt.setString(2,request.getParameter("hivehostname"));
			 pstmt.setString(3,request.getParameter("hiveport"));
			 pstmt.executeUpdate();
			 pstmt.close();
			 
		}
		else if (request.getParameter("hdfs")!= null && request.getParameter("hdfs").equals("impala"))
		{
			 sqlUpdate = "UPDATE DMU_HDFS "
		                + "SET CONNECTION_TYPE = ? ,IMPALA_HOST_NAME = ? , IMPALA_PORT_NMBR = ?,HIVE_HOST_NAME = NULL , HIVE_PORT_NMBR = NULL"
		                + " WHERE SR_NO = 1";
			 PreparedStatement pstmt = con.prepareStatement(sqlUpdate);
			 pstmt.setString(1,"IMPALA");
			 pstmt.setString(2,request.getParameter("impalahostname"));
			 pstmt.setString(3,request.getParameter("impalaport"));
			 pstmt.executeUpdate();
			 pstmt.close();
		}
		if (request.getParameter("aws")!= null && request.getParameter("aws").equals("provide"))
		{
			 sqlUpdate = "UPDATE DMU_S3 "
		                + "SET AWS_ACCESS_ID = ? ,AWS_SECRET_KEY = ? "
		                + " WHERE SR_NO = 1";
			 PreparedStatement pstmt1 = con.prepareStatement(sqlUpdate);
			 pstmt1.setString(1,request.getParameter("awskey"));
			 pstmt1.setString(2,request.getParameter("awssecret"));
			 pstmt1.executeUpdate();
			 pstmt1.close();
		}
		
		  
	} //save condition	


		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery("select CONNECTION_TYPE,HIVE_HOST_NAME,HIVE_PORT_NMBR,IMPALA_HOST_NAME,IMPALA_PORT_NMBR from DMU_HDFS");  
		while (rs.next()) {
		
		    CONNECTION_TYPE = rs.getString("CONNECTION_TYPE");
		    HIVE_HOST_NAME = rs.getString("HIVE_HOST_NAME");
		    HIVE_PORT_NMBR = rs.getString("HIVE_PORT_NMBR");
		    IMPALA_HOST_NAME = rs.getString("IMPALA_HOST_NAME");
		    IMPALA_PORT_NMBR = rs.getString("IMPALA_PORT_NMBR");
		    
			
		}
		rs.close();
		stmt.close();
		
	 	stmt=con.createStatement();  
		rs=stmt.executeQuery("select AWS_ACCESS_ID ,AWS_SECRET_KEY from DMU_S3 ");  
		while (rs.next()) {
		
			AWS_ACCESS_ID = rs.getString("AWS_ACCESS_ID");
			AWS_SECRET_KEY = rs.getString("AWS_SECRET_KEY");
			
		}
		rs.close();
		stmt.close();
		
		con.close();	
}
catch (Exception e)
{
	out.println(e.getMessage());
}


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
  <link href="css/style.css" rel="stylesheet">

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
  <section id="inner-header">
    <div class="container">
      <div class="row">
        <div class="col-md-7">
          <div class="inner-logo">
            <h2><span>DE</span>Data Migration Utility Functional</h2>
          </div>
        </div>
        <div class="col-md-5 text-right">
          <a href="basketscreen1.jsp" class="topbasketbutton"><i
              class="fas fa-shopping-basket"></i> Basket</a>
          <div class="top-user-menu dropdown pull-right" dropdown="">
            <button class="btn dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
              aria-haspopup="true" aria-expanded="true">
              <i class="fa fa-user"></i> Admin
              <span class="caret"></span>
            </button>f
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


  <section id="main-content-wrapper">
    <div class="container settings-page-wrapper">
      <!-- Nav tabs -->
      <ul class="nav nav-tabs settings-tabs" role="tablist">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="settings.jsp">Users</a></li>
        <li class="active"><a href="connection1.jsp">Connection</a>
        </li>
      </ul>
      <!-- Tab panes -->
      <div class="tab-content">
        <!-- Sof Connection Content-->
          <div class="connection-wrapper">
            <div class="row">
              <div class="col-md-12">
                 <h3>Connection</h3>
              </div>
            </div>
            <form name="testcon" method="POST">
            <div class="row">
              <div class="col-md-6">
                <!--Sof AWS-->
                <div class="box">
                <h4>AWS S3</h4>
                <div class="box-content">
                <div class="radio radio-primary radio-block">
                    <input type="radio" name="aws" id="radio1" value="hdfs">
                    <label for="radio1">AWS Access Credentials included in HDFS Site</label>
                  </div>
                  <div class="radio radio-primary radio-block">
                      <input type="radio" name="aws" id="provide" value="provide" checked="">
                      <label for="radio2">AWS Access details to be provided</label>
                    </div>
                    <div class="form-horizontal setting-form" id="aws_form">
                      <div class="form-group">
                        <label class="col-md-5">AWS Access Key</label>
                        <div class="col-md-7"><input type="text" class="form-control" name="awskey" value=<%=AWS_ACCESS_ID%>></div>
                      </div>
                      <div class="form-group">
                          <label class="col-md-5">AWS Secret Key</label>
                          <div class="col-md-7"><input type="password" class="form-control" name="awssecret" value=<%=AWS_SECRET_KEY%>></div>
                        </div>
                    </div>
                  </div>
                  </div>
                  <!--Eof AWS-->

                  <!--Sof HDFS-->
                <div class="box">
                    <h4>HDFS
                    <%
                String submitted=request.getParameter("submitted");
                
				String hostname=request.getParameter("hivehostname");
                String port=request.getParameter("hiveport");
				if(submitted!=null && submitted.equals("test"))
				{
					
					try
					{
						Class.forName("com.cloudera.hive.jdbc41.HS2Driver");
						//Added
						String connection="jdbc:hive2://"+hostname+":"+port;
						java.sql.Connection con = java.sql.DriverManager.getConnection(connection,"", "");
						//java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:impala://18.216.202.239:10000", "", "");
						java.sql.Statement stmt = con.createStatement();
						
						%> <span class="label label-success">Connection Successful</span>
						<%
						//String sql = ("show tables");
						//String sql = ("SHOW DATABASES");
						//java.sql.ResultSet res = stmt.executeQuery(sql);
						//while (res.next()) {
						 //   out.println( res.getString(1));
						  //}
						//res.close();
						stmt.close();
						con.close();					
					}
					catch (Exception e)
					{
						%>
						 <span class="label label-danger">Connection Failure</span>
						<%
					}
				}
				
				%>
				</h4>
                    <div class="box-content">
                    <div class="radio radio-primary radio-block">
                        <input type="radio" name="hdfs" id="hdfs1" value="hive" <%if (CONNECTION_TYPE.equals("HIVE")) { %> checked <% }%>>
                        <label for="hdfs1">Hive Direct Connection</label>
                      </div>
                      <div class="form-horizontal setting-form" id="hivedirect_form">
                          <div class="form-group">
                            <label class="col-md-5">Hive Host Name</label>
                            <div class="col-md-7"><input type="text" class="form-control" name="hivehostname" value=<%=HIVE_HOST_NAME%> ></div>
                          </div>
                          <div class="form-group">
                              <label class="col-md-5">Hive Port Name</label>
                              <div class="col-md-7"><input type="text" class="form-control" name="hiveport" value=<%=HIVE_PORT_NMBR%> ></div>
                            </div>
                        </div>

                      <div class="radio radio-primary radio-block">
                          <input type="radio" name="hdfs" id="hdfs2" value="impala" <%if (CONNECTION_TYPE.equals("IMPALA")) { %> checked <% }%>>
                          <label for="hdfs2">Hive Using Impala Connection</label>
                        </div>

                        <div class="form-horizontal setting-form" id="impala_form">
                            <div class="form-group">
                              <label class="col-md-5">Impala Host Name</label>
                              <div class="col-md-7"><input type="text" class="form-control" name="impalahostname" value=<%=IMPALA_HOST_NAME%>></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-5">Impala Port Name</label>
                                <div class="col-md-7"><input type="text" class="form-control" name="impalaport" value=<%=IMPALA_PORT_NMBR%>></div>
                              </div>
                          </div>

                        <div class="radio radio-primary radio-block">
                            <input type="radio" name="hdfs" id="hdfs3" value="option3" >
                            <label for="hdfs3">Spark on Hive Connection</label>
                          </div>

                          <div class="form-horizontal setting-form" id="spark_form">
                              <div class="form-group">
                                <label class="col-md-5">SQL Warehouse Dir</label>
                                <div class="col-md-7"><input type="text" class="form-control"></div>
                              </div>
                              <div class="form-group">
                                  <label class="col-md-5">Hive Metastore URI</label>
                                  <div class="col-md-7"><input type="text" class="form-control"></div>
                                </div>
                            </div>
                      </div>
                      </div>
                      <!--Eof HDFS-->
              </div>
              <div class="col-md-6">
                 <!--Sof Auth-->
                 <div class="box">
                    <h4>Authentication Type</h4>
                    <div class="box-content">
                    <div class="radio radio-primary radio-block">
                      <input type="radio" name="auth" id="auth1" value="option1" checked>
                      <label for="auth1">Unsecured Connection</label>
                    </div>
                    <div class="radio radio-primary radio-block">
                        <input type="radio" name="auth" id="auth2" value="option1">
                        <label for="auth2">LDAP Connection</label>
                      </div>
                      <div class="form-horizontal setting-form" id="ldap_form">
                          <div class="form-group">
                            <label class="col-md-5">Username</label>
                            <div class="col-md-7"><input type="text" class="form-control"></div>
                          </div>
                          <div class="form-group">
                              <label class="col-md-5">Password</label>
                              <div class="col-md-7"><input type="text" class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-5">Domain</label>
                                <div class="col-md-7"><input type="text" class="form-control"></div>
                              </div>
                        </div>
                      <div class="radio radio-primary radio-block">
                          <input type="radio" name="auth" id="auth3" value="option1">
                          <label for="auth3">Kerberos</label>
                        </div>

                        <div class="form-horizontal setting-form" id="kerberos_form">
                            <div class="form-group">
                              <label class="col-md-5">Host Realm</label>
                              <div class="col-md-7"><input type="text" class="form-control"></div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-5">Host FQDN</label>
                                <div class="col-md-7"><input type="text" class="form-control"></div>
                              </div>
                              <div class="form-group">
                                  <label class="col-md-5">Service Name</label>
                                  <div class="col-md-7"><input type="text" class="form-control"></div>
                                </div>
                          </div>

                        <div class="radio radio-primary radio-block">
                            <input type="radio" name="auth" id="auth4" value="option1">
                            <label for="auth4">SSL</label>
                          </div>

                          <div class="form-horizontal setting-form" id="ssl_form">
                              <div class="form-group">
                                <label class="col-md-5">SSL key path</label>
                                <div class="col-md-7"><input type="text" class="form-control"></div>
                              </div>
                            </div>
                      </div>
                      </div>
                      <!--Eof Auth-->
                </div>
            </div>
            <div class="footerbuttons">
                <button class="btn btn-success" onclick="document.forms[0].submitted.value='test';">Test Connection</button>
                
				<button class="btn btn-success" onclick="document.forms[0].submitted.value='save';">Save</button>
              </div>
        </div>
        <!-- Eof Connection Content-->
      </div>
    </div>
  </section>
  <!-- Eof Mid Content-->
  <input type="hidden" name="submitted" value=""/>
</form>
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

