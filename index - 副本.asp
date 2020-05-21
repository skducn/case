<!--#include file="md5.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="common/function.asp"-->
<!--#include file="Inc/config.asp"-->

<% 

if request("action")="exit" then
Session.Abandon()
response.Redirect("index.html")
end if 
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSS-->
    <link rel="stylesheet" type="text/css" href="731/dist/css/main.css">
    <!-- Font-icon css-->
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <title>Testcase | 登录</title>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries-->
    <!--if lt IE 9
    script(src='https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js')
    script(src='https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js')
    -->
  </head>
  
<!-- Javascripts-->
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>

<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script>
  
<script language="javascript">  
function CheckPost()
{	  
     if (addForm.userName.value == "" || addForm.userPass.value == "") 
	 {
		$.notify({
			title: "&nbsp;&nbsp;",
			message: "账号或密码不能为空！",
			icon: 'fa fa-check' 
		},{
			type: "danger"
		});
	  addForm.userName.focus();
	  return false;
  }
}
</script>

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
			session("latestLoginIp") = getUserIp()
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
	
	  <%if request("action") = "clear" then
		userName = request("userName")
		Set rs = Server.CreateObject("Adodb.Recordset")						
		rs.Open "select * from tbl_user where userName='"&userName&"'",conn,3,3
		if not rs.eof then	   
			rs("latestLoginIp") = ""
			rs.update
		end if    
		rs.close
		set rs = nothing
		conn.close
		set conn = nothing
		response.Redirect("index.html")
	end if%>

<body >

	<%
		Set rs = Server.CreateObject("Adodb.Recordset")						
		rs.Open "select * from tbl_user where latestLoginIp='"&getUserIp()&"' and userStatus='1'",conn,3,3
		if not rs.eof then	   
			response.Redirect("lock.html")		
		end if
		rs.close
	%>

    <section class="material-half-bg">
      <div class="cover"></div>
    </section>
    <section class="login-content">

   <div align="left">
	   <%
		ip=request.ServerVariables("REMOTE_ADDR")
		%>
        <a href="http://<%=ip%>"><font color="#99FF00"><i class="fa fa-angle-left fa-fw"></i>CMS</font></a>
   </div>
		  
      <div class="logo">
	 
        <h1 align="center">测试用例集</h1>
		 	<h2>Hello there! Welcome Back</h2>
	
      </div>
	 
			
      <div class="login-box">
		<form action="indexLogin.html" method="post" name="addForm"  class="login-form" onSubmit="return CheckPost()" >
          <h3 class="login-head">
		    <img class="img-circle user-image" width="100" src="/images/excel.png"></h3>
          <div class="form-group">           
            <input class="form-control" name="userName" type="text" placeholder="账号" autofocus>
          </div>
          <div class="form-group">
            <input class="form-control" name="userPass" type="password" placeholder="密码">
          </div>
          <div class="form-group">
            <div class="utility">
              <div class="animated-checkbox">
              </div>
              <p class="semibold-text mb-0"><a data-toggle="flip">忘记密码？</a></p>
            </div>
          </div>
          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block"><i class="fa fa-sign-in fa-lg fa-fw"></i>进入</button>
          </div>
        </form>
		
        <form class="forget-form" action="index.html">
          <h3 class="login-head"><i class="fa fa-lg fa-fw fa-lock"></i>忘记密码了吗？</h3>
          <div class="form-group">
            <label class="control-label">EMAIL</label>
            <input class="form-control" type="text" placeholder="Email">
          </div>
          <div class="form-group btn-container">
            <button class="btn btn-primary btn-block"><i class="fa fa-unlock fa-lg fa-fw"></i>重置</button>
          </div>
          <div class="form-group mt-20">
            <p class="semibold-text mb-0"><a data-toggle="flip"><i class="fa fa-angle-left fa-fw"></i> 返回登录</a></p>
          </div>
        </form>
      </div>
    </section>
  </body>

</html>