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
                <a href="settings.html">Settings</a>
              </li>
              <li>
                <a href="login.html">Signout</a>
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
              <li class="active"><a href="request1.jsp">Request</a></li>
              <li><a href="history1.jsp">History</a></li>
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
    <div class="container mainwrapper">
      <h3>Database Tables</h3>
      <ol class="breadcrumb">
          <li><a href="request1.jsp">Request</a></li>
          <li><a href="request1.jsp">HDFS to S3</a></li>
          <li><a href="request1.jsp?action=db">Full Database</a></li>
          <li class="active"><%=request.getParameter("databasename") %></li>
        </ol>
<div class="table-filters">
  <div class="row">
    <div class="col-md-4 col-md-offset-5">
        <div class="form-group form-inline">
            <label>Search</label>
            <input id="myInput" type="text" class="form-control" style="width:80%" placeholder="Search" />
          </div>
    </div>
    <div class="col-md-3">
        <div class="checkbox checkbox-success">
            <input id="checkboxselectall" type="checkbox">
            <label for="checkboxselectall">Add all items to basket
            </label>
        </div>
      </div>
  </div>
    
</div>
      <div class="table-responsive">
        <div class="table-wrapper">
            <form role="form" name="datatableForm" action="basketscreen1.jsp" method="GET">

          <table id="tblData" class="table table-hover">
            <thead>
              <tr>
                <th style="width: 6%"> S.No</th>
                <th>Schema Name</th>
                <th>Table Name</th>
                <th>Filter Condition</th>
                <th>target File Path</th>
                <th>Incremental Flag</th>
                <th>Incremental Column</th>
                <th style="width: 5%;"> Add to Basket</th>
              </tr>
            </thead>
            <form role="form" name="datatableForm" action="basketscreen1.jsp" method="GET">
            <input type="hidden" name="schema" value='<%=request.getParameter("databasename")%>'>
            <tbody id="myTable">
              <%
				Class.forName("com.cloudera.hive.jdbc41.HS2Driver");
				//Added
				String connection="jdbc:hive2://18.216.202.239:10000/"+request.getParameter("databasename"); //+hostname+":"+port;
				java.sql.Connection con = java.sql.DriverManager.getConnection(connection,"", "");
				//java.sql.Connection con = java.sql.DriverManager.getConnection("jdbc:impala://18.216.202.239:10000", "", "");
				java.sql.Statement stmt = con.createStatement();
				
				String sql = ("show tables");
				//String sql = ("select count(*) from categories");
				//String sql = ("SHOW DATABASES");
				java.sql.ResultSet res = stmt.executeQuery(sql);
				int count=0;
				while (res.next()) {
					count++;
				    %>
				      <tr>
				       <td><input type="hidden" name="sno<%=count%>" value='<%=count%>'><%=count%></td>
				       <td><%=request.getParameter("databasename")%></td>
				       <td><input type="hidden" name="tablename<%=count%>" value='<%=res.getString(1)%>'><%=res.getString(1)%></td>
		                <td><input type="text" name="filter<%=count%>"  class="form-control"/></td>
        		        <td><input type="text" class="form-control" name="s3bucket<%=count%>" value='<%=request.getParameter("bucket")%>/<%=res.getString(1)%>' /></td>
               
	                <td class="text-center">
	                  <div class="checkbox checkbox-primary">
	                    <input name="incremental<%=count%>" id="checkbox<%=count%>" type="checkbox" value="Y">
	                 	 <label for="checkbox<%=count%>">
                          </label>
	                </div></td>
	                <td><input type="text" name="incrementcolumn<%=count%>" class="form-control"/></td>
	                <td id='' class="text-center">
	                    
	                        <input type="checkbox" id="basket<%=count%>" name="basket<%=count%>" ></input>
	                        
	                    
	                    </td>
	                     </tr>				     
				     <%
				 }
				res.close();
				stmt.close();
				con.close();
				%>
   				<input type="hidden" name="total" value=<%=count%>></input>
   				<input type="hidden" name="labelname" value='<%=request.getParameter("labelname")%>'></input>
   				<input type="hidden" name="migtype" value='<%=request.getParameter("migtype")%>'></input>
   				
   				
   				
            </tbody>
            
          </table>
         
        </div>
      </div>
      <div class="footerbuttons"> 
          <a href="home.jsp" class="btn btn-default-outline">Cancel</a>
         
           <button class="btn btn-success" onclick="document.datatableForm.action.value='save'";>Continue</button>
        </div>
        <input type="hidden" name="action" value=''></input>
         </form>
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
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <script>
    $(document).ready(function () {
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
      $("#myInput").on("keyup", function() {
    	    var value = $(this).val().toLowerCase();
    	   
    	    $("#myTable tr").filter(function() {
    	    	
    	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    	    });
    	  });
      

      $('#checkboxselectall').click(function() {
    	    var isChecked = $(this).prop("checked");
    	    $('#tblData tr:has(td)').find('input[type="checkbox"]').prop('checked', isChecked);
    	    
    	  });

    	  $('#tblData tr:has(td)').find('input[type="checkbox"]').click(function() {
    	    var isChecked = $(this).prop("checked");
    	    var isHeaderChecked = $("#chkParent").prop("checked");
    	    if (isChecked == false && isHeaderChecked)
    	      $("#chkParent").prop('checked', isChecked);
    	    else {
    	      $('#tblData tr:has(td)').find('input[type="checkbox"]').each(function() {
    	        if ($(this).prop("checked") == false)
    	          isChecked = false;
    	      });
    	      console.log(isChecked);
    	      $("#chkParent").prop('checked', isChecked);
    	    }
    	  });
    });
  </script>
</body>

</html>