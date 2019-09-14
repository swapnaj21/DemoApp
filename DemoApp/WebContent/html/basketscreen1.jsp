<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%
Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection(  
		"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23");  

if (request.getParameter("action") != null && request.getParameter("action").equals("del"))
{
	// String sqlDelete = "DELETE FROM DMU_BASKET_TEMP WHERE USER_ID= 'Admin'";
	 String sqlDelete = "DELETE FROM DMU_BASKET_TEMP";
	 PreparedStatement pstmt = con.prepareStatement(sqlDelete);
	 pstmt.executeUpdate();
	 pstmt.close();
	 
	 
}
else if (request.getParameter("action") != null && request.getParameter("action").equals("save")) //insert
{
	int total = Integer.parseInt(request.getParameter("total"));

	for (int loop = 1; loop <=total;loop++)
	{
		
		String basketflag = request.getParameter("basket"+loop);
		if (basketflag != null && basketflag.equals("on"))
		{
			String sno= request.getParameter("sno"+loop);
			String schema = request.getParameter("schema");
			String table= request.getParameter("tablename"+loop);
			String bucket = request.getParameter("s3bucket"+loop);
			String filter = request.getParameter("filter"+loop);
			String inccol= request.getParameter("incrementcolumn"+loop);
			String incremental= request.getParameter("incremental"+loop);
			if (incremental==null) incremental = "N";
			//out.println(sno+"-"+schema+"-"+table+"-"+bucket+"-"+filter+"-"+inccol+"-"+incremental);

			
				 String sqlInsert = "INSERT INTO DMU_BASKET_TEMP (USER_ID,SR_NO,SCHEMA_NAME,TABLE_NAME,FILTER_CONDITION,TARGET_S3_BUCKET,INCREMENTAL_FLAG,INCREMENTAL_CLMN,LABEL_NAME) values (?,?,?,?,?,?,?,?,?) ";
			                
				 PreparedStatement pstmt = con.prepareStatement(sqlInsert);
				 pstmt.setString(1,"Admin");
				 pstmt.setString(2,sno);
				 pstmt.setString(3,schema);
				 pstmt.setString(4,table);
				 pstmt.setString(5,filter);
				 pstmt.setString(6,bucket);
				 pstmt.setString(7,incremental);
				 pstmt.setString(8,inccol);
				 pstmt.setString(9,request.getParameter("labelname"));
				 pstmt.executeUpdate();
				 pstmt.close();
				 //out.println("data inserted" + sno+"-"+schema+"-"+table+"-"+bucket+"-"+filter+"-"+inccol+"-"+incremental);
					
		}
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
              <li class="active"><a href="request1.jsp"><i class="fas fa-file"></i> Request</a></li>
              <li><a href="history1.jsp"><i class="fas fa-history"></i> History</a></li>
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
  <form name="basketform" action="history1.jsp">
    <div class="container mainwrapper">
        <div class="row">
            <div class="col-md-6"><h3>Basket</h3></div>
            <div class="col-md-6 text-right mt-20"> <a href="basketscreen1.jsp?action=del" class="btn btn-sm btn-danger-outline"><i
              class="fas fa-times"></i>Clear All</i></a></div>
             
          </div>
      <div class="table-responsive mt-20">
        <div class="table-wrapper">
          <table class="table table-hover">
            <thead>
              <tr>
                <th style="width: 6%"> S.No</th>
                <th>Schema Name</th>
                <th>Table Name</th>
                <th>Filter Condition</th>
                <th>Target S3 Bucket</th>
                <th>Incremental Flag</th>
                <th>Incremental Column</th>
              </tr>
            </thead>
            <%
        	Class.forName("com.mysql.jdbc.Driver");  
            con=DriverManager.getConnection(  
        	"jdbc:mysql://mysql-instance1.c9z9oimycomq.us-east-2.rds.amazonaws.com:3306/DMU","DMU","DeDMU!23");  

            	//retrieve all baskets.
	//for the given user id
	 String sqlSel = "SELECT SR_NO,SCHEMA_NAME,TABLE_NAME,FILTER_CONDITION,TARGET_S3_BUCKET,INCREMENTAL_FLAG,INCREMENTAL_CLMN,LABEL_NAME FROM DMU_BASKET_TEMP where USER_ID='Admin' ORDER by SR_NO, LABEL_NAME";
		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery(sqlSel); 
		int count=0;
		while (rs.next()) {
		count++;
		 %>   
			<tbody>
            <tr>
              <td><%=rs.getString("SR_NO") %></td>
               <td><%=rs.getString("SCHEMA_NAME") %></td>
                <td><%=rs.getString("TABLE_NAME") %></td>
                 <td><%=rs.getString("FILTER_CONDITION") %></td>
                  <td><%=rs.getString("TARGET_S3_BUCKET") %></td>
                   
                   <td class="text-center">
		                  <div class="checkbox checkbox-primary">
		                    <input id="checkbox2" type="checkbox" <%if("Y".equals(rs.getString("INCREMENTAL_FLAG"))){  %>checked=""<%} %> disabled>
		                    <label for="checkbox2">
		                    </label>
		                  </div>
		                </td>
                  <td><%=rs.getString("INCREMENTAL_CLMN") %></td>
            </tr>

		  <%  
			
		}
		rs.close();
		stmt.close();
		con.close();
		if (count ==0)
		{
			%>
			<td colspan=7>Basket Empty. No tables selected into the basket.</td>
			<% 
		}
		 %>

            

   
            </tbody>
          </table>
        </div>
      </div>
      <div class="footerbuttons"> 
          <a href="datatables1.jsp" class="btn btn-default-outline">Back</a>
          <button class="btn btn-success">Submit</button>
        </div>
    </div>
    </div>

    </div>
  </section>
  <input type="hidden" name="migtype" value='<%=request.getParameter("migtype")%>'></input>
  <input type="hidden" name="labelname" value='<%=request.getParameter("labelname")%>'></input>
  <input type="hidden" name="action" value='submit'></input>
  </form>
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
  <script>
    $(document).ready(function () {
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
    });
  </script>
</body>

</html>