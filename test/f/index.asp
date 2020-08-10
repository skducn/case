<!--#include file="md5.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="Inc/config.asp"-->

<% 
if request("action")="exit" then
Session.Abandon()
response.Redirect("index.html")
end if 
%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>

	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Minimal and Clean Sign up / Login and Forgot Form by FreeHTML5.co</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FreeHTML5.co" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	

  

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/style.css">


	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	</head>
			<%if request("action") = "login" then
						userName = request("userName")
						userPass = md5(request("userPass")) 
						Set rs = Server.CreateObject("Adodb.Recordset")						
						rs.Open "select * from tbl_user where userName='"&userName&"' and userPass='"&userPass&"' and userStatus='1'",conn,3,3
						if not rs.eof then	   
							rs("latestLoginIp") = getUserIp()   'from function.asp
							rs("latestLoginDate") = now()
							rs.update
							session("userId") = rs("userId")
							session("userName") = rs("userName")
							session("userPower") = rs("userPower")
							if session("userPower") = 1 then   '管理员
								response.Redirect "admMain.html"
							elseif session("userPower") = 3 then  
								response.Redirect "tourist.html" ' 用例游客
							elseif session("userPower") = 4 then  
								response.Redirect "review.html"  ' 用例评审员
							else 
								response.Redirect "main.html"  '测试人员
							end if 
						end if    
						rs.close
						set rs = nothing
						conn.close
						set conn = nothing
					end if%>
			
	<body class="style-2">

		<div class="container">
			<div class="row">
				<div class="col-md-12 text-center">
					<ul class="menu">
					
					</ul>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					

					<!-- Start Sign In Form -->
					<form action="indexLogin.html" method="post" name="login" id="login"  class="fh5co-form animate-box" data-animate-effect="fadeInLeft">
						<h2>Sign In</h2>
						<div class="form-group">
							<label for="username" class="sr-only">Username</label>
							<input id="icon_prefix" type="text" class="form-control" name="userName" placeholder="Username" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="password" class="sr-only">Password</label>
							<input id="icon_password" type="password" class="form-control" name="userPass" placeholder="Password" autocomplete="off">
						</div>
						<div class="form-group">
							<label for="remember"><input type="checkbox" id="remember"> Remember Me</label>
						</div>
						<div class="form-group">
						<button class="btn waves-effect waves-light btn-large" type="submit" name="action" onClick="postFrom(this.form);">Sign in
						<i class="material-icons right">send</i>
   				    </button>
							<p>Not registered? <a href="sign-up2.html">Sign Up</a> | <a href="forgot2.html">Forgot Password?</a></p>
						</div>
						<div class="form-group">
							<input type="submit" value="Sign In" class="btn btn-primary">
						</div>
					</form>
					<!-- END Sign In Form -->

				</div>
			</div>
			<div class="row" style="padding-top: 60px; clear: both;">
				<div class="col-md-12 text-center"><p></p></div>
			</div>
		</div>
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Placeholder -->
	<script src="js/jquery.placeholder.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Main JS -->
	<script src="js/main.js"></script>

	</body>
</html>

