<%@ page import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23");  
Statement stmt=con.createStatement();  
ResultSet rs=stmt.executeQuery("select user_id,Password from DMU_USERS");  
while (rs.next()) {

    
    String userid = rs.getString(1);
    String password = rs.getString(2);

	out.println(userid+"-"+password+":");


}
rs.close();

DatabaseMetaData metadata = con.getMetaData();
ResultSet resultSet = metadata.getColumns(null, null, "DMU_USERS", null);
while (resultSet.next()) {
  String name = resultSet.getString("COLUMN_NAME");
  String type = resultSet.getString("TYPE_NAME");
  int size = resultSet.getInt("COLUMN_SIZE");

  out.println("Column name: [" + name + "]; type: [" + type + "]; size: [" + size + "]");
}
stmt.close();
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
	 <link href="css/style.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body class="bg-white">
   <div class="container-fluid">
  <div class="row">
  <div class="col-md-6 pdl-0 desktop-only"><div class="loginpage-slide"></div></div>
   <div class="col-md-6">
 <section id="login-header">
 <div class="login-logo">
  <img src="images/data_economy_logo.png" alt="Data Economy"/>
 </div>
 </section>
 <!--Eof Login Header-->
 
 <section id="main-login-container">
<div class="login-wrapper">
    <form method="post">
        <div class="form-group">
            <input type="text" name="login" class="form-control" placeholder="Your Email *"  />
        </div>
        <div class="form-group">
            <input type="password" name="password" class="form-control" placeholder="Your Password *" />
        </div>
        <div class="form-group">
            <div class="login-btn"><a  href="home.html" class="btn btn-mainlogin">Login</a></div>
            <button class="btn btn-success">Login</button>
        </div>
        <div class="form-group">
            <a href="#" class="ForgetPwd">Forget Password?</a>
        </div>
    </form>
</div>
 </section>
 <!--Eof Main Login Container-->
   </div>
  </div>
  </div>
  
 
 <!--Eof Login Footer-->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </body>
</html>