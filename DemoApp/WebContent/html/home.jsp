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
  <link href="css/Chart.min.css" rel="stylesheet">
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
              <i class="fa fa-user"></i> <%=(String)session.getAttribute("username") %>
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
              <li class="active"><a href="home.jsp"><i class="fas fa-home"></i> Home</a></li>
              <li><a href="request1.jsp"><i class="fas fa-file"></i> Request</a></li>
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
    <div class="container mainwrapper">
      <h3>Home</h3>
      <div class="row">
        <div class="col-md-6">
          <div class="box">
            <h4>HDFS to S3</h4>
            <div class="box-content">
              <canvas id="hdfstos3chart"></canvas>
            </div>
          </div>
        </div>

        <div class="col-md-6">
            <div class="box">
              <h4>Recon Status</h4>
              <div class="box-content">
                <canvas id="reconstatuschart"></canvas>
              </div>
            </div>
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
  <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  <script src="js/Chart.bundle.min.js"></script>
  <script src="js/Chart.min.js"></script>
  <script>
    $(document).ready(function () {
      $(function () {
        $('[data-toggle="tooltip"]').tooltip()
      })
    });
  </script>
  <script>
    //Hdfs to s3 status
    var ctx = document.getElementById('hdfstos3chart').getContext('2d');
    var chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'pie',

      // The data for our dataset
      data: {
        labels: ['Completed', 'Inprocess', 'Error', "Not yet Started"],
        datasets: [{
          label: 'My First dataset',
          backgroundColor: [
            "#61b50c",
            "#f6a002",
            "#de090c",
            "#36a2eb",],
            borderColor: "#fff",
          data: [8, 10, 5, 6]
        }]

      },

      // Configuration options go here
      options: {}
    });


    //recon Status

    var ctx = document.getElementById('reconstatuschart').getContext('2d');
    var chart = new Chart(ctx, {
      // The type of chart we want to create
      type: 'pie',

      // The data for our dataset
      data: {
        labels: ['Successfull', 'Inprocess', 'Failed', "Not Started"],
        datasets: [{
          label: 'My First dataset',
          backgroundColor: [
            "#61b50c",
            "#f6a002",
            "#de090c",
            "#36a2eb",],
            borderColor: "#fff",
          data: [4, 12, 4, 8]
        }]

      },

      // Configuration options go here
      options: {}
    });
  </script>
</body>

</html>