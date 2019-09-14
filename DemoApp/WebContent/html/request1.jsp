<!DOCTYPE html>
<%@page import="java.text.SimpleDateFormat"%>
<html lang="en">

<head>
<script>
function validate()
{
	
	 if (document.forms[0].migdbtype.value == '--Select Migration Type--')
	 {
	 	alert('Migration type has to be selected.')
	 	return false;
	 }
 if (document.forms[0].databasename.value == '--Select Database--')
 {
 	alert('Database has to be selected.')
 	return false;
 }
 if (document.forms[0].bucket.value == '')
 {
 alert('Bucket details cannot be empty.')
 return false;
 }
 return true;
}
</script>
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
              <li><a href="home.jsp">Home</a></li>
              <li class="active"><a href="request1.jsp"><i class="fas fa-file"></i> Request</a></li>
              <li><a href="history1.jsp"><i class="fas fa-history"></i> History</a></li>
              <li><a href="recon.html">Recon</a></li>
              <li><a href="help.html">Help</a></li>
            </ul>

          </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
      </nav>
    </div>
  </section>
  <!--Eof Menu-->

  <section id="main-content-wrapper">
    <div class="container mainwrapper request-wrapper">
      <h3>Migration Options</h3>
      <form role="form" name="schemaForm" action="datatables1.jsp" method="POST" onsubmit="return validate()">
      <div class="row flex">
        <div class="col-md-4 pdr-0 rightborder">
          <div class="radio radio-primary radio-block active">
            <input type="radio" name="migtype" id="radio1" value="HDFS to S3" checked="">
            <label for="radio1">HDFS to S3</label>
          </div>
          <div class="radio radio-primary radio-block">
            <input type="radio" name="migtype" id="radio2" value="option2" disabled>
            <label for="radio2">Teradata to S3</label>
          </div>

          <div class="radio radio-primary radio-block">
            <input type="radio" name="migtype" id="radio4" value="option3" disabled>
            <label for="radio4">HDFS to RedShift</label>
          </div>
          
          <div class="radio radio-primary radio-block">
            <input type="radio" name="migtype" id="radio3" value="option4" disabled>
            <label for="radio3">Teradata to RedShift</label>
          </div>

          <div class="radio radio-primary radio-block">
            <input type="radio" name="migtype" id="radio4" value="option5" disabled>
            <label for="radio4">Teradata to Snowflake</label>
          </div>

          <div class="radio radio-primary radio-block">
            <input type="radio" name="migtype" id="radio4" value="option6" disabled>
            <label for="radio4">HDFS to Snowflake</label>
          </div>

        </div>
        <div class="col-md-8">
          <!--Sof Hdfs to s3 content-->
          <div class="tabs-content-wrapper" id="hdfstos3wrapper">
            <h4>HDFS to S3</h4>
                
                  <div id="databasetypes">
                      <div class="form-group">
                        <label>Create Label</label>
                        <%
                        java.text.SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                        java.util.Date date = new java.util.Date();
                       
                        %>
                        <input type="text" name="labelname" class="form-control" placeholder="Label" maxlength="50" value="Admin-<%=format.format(date)%>" />
                      </div>

                      <div class="form-group">
                        <label>Migration Type</label>
                        <select class="form-control selectpicker" id="migrationtype_select" name="migdbtype">
                          <option>--Select Migration Type--</option>
                          <option value="fulldatabase_form">Full Database</option>
                          <option value="listoftables_form">List of tables from spreadsheet (csv file)</option>
                        </select>
                      </div>

                      <div class="fulldatabase-content" id="fulldatabases">
                        <div class="form-group">
                          <label>Database Name</label>
                          <select name="databasename" class="form-control">
                            <option>--Select Database--</option>
                            <%
								Class.forName("com.cloudera.hive.jdbc41.HS2Driver");
								//Added
								String connection="jdbc:hive2://18.216.202.239:10000/retaildb"; //+hostname+":"+port;
								java.sql.Connection con = java.sql.DriverManager.getConnection(connection,"", "");
								//java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:impala://18.216.202.239:10000", "", "");
								java.sql.Statement stmt = con.createStatement();
								
								//String sql = ("show tables");
								//String sql = ("select count(*) from categories");
								String sql = ("SHOW DATABASES");
								java.sql.ResultSet res = stmt.executeQuery(sql);
								while (res.next()) {
								    %>
								     <option value='<%=res.getString(1)%>'><%=res.getString(1)%> </option>
								     <%
								 }
								res.close();
								stmt.close();
								con.close();
				
								%>

                          </select>
                        </div>
                        <div class="form-group">
                          <label>Target S3 Bucket</label>
                          <input type="text" class="form-control" placeholder="S3 Bucket" name="bucket" value=''/>
                        </div>
                      </div>

                    <div class="listoftables-content">
                      <div class="form-group">
                        <label>File Path</label>
                        <input type="text" class="form-control" placeholder="File Path" />
                      </div>
                    </div>
                </div>
              
            </div>
            <!--Eof Hdfs to s3 content-->
        </div>
      </div>
    <div class="footerbuttons">
      <a href="home.jsp" class="btn btn-default-outline">Cancel</a>
      <button class="btn btn-success" >Continue</button>
    </div>
    </div>
    </div>
  </div>
    </div>
    </form>
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
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <script src="js/bootstrap-select.min.js"></script>
  <script>
    $(document).ready(function () {
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
      //select items
      $(function () {
  $("#migrationtype_select").change(function() {
    var val = $(this).val();
    if(val === "fulldatabase_form") {
        $(".fulldatabase-content").show();
        $(".listoftables-content").hide();
    }
    else if(val === "listoftables_form") {
      $(".listoftables-content").show();
      $(".fulldatabase-content").hide();
    }
    else{
      $(".listoftables-content").hide();
      $(".fulldatabase-content").hide();
    }
  });
});
    });
  </script>
</body>

</html>