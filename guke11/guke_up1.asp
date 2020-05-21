<!--#include file="guke_up.asp"-->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link rel="shortcut icon" href=" /favicon.ico" /> 
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link rel="shortcut icon" href="/favicon.ico" /> 
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	
	<title><%=cstCompany%> | 登录</title>
	
	<link href="../css/sideNav/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection">
	<link href="../css/sideNav/ghpages-materialize123.css" type="text/css" rel="stylesheet" media="screen,projection">

    <link href="https://fonts.googleapis.com/css?family=Inconsolata" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">


<SCRIPT language=javascript>
function check() 
{
	var strFileName=document.form1.FileName.value;
	if (strFileName=="")
	{
    	alert("请选择要上传的文件");
		document.form1.FileName.focus();
    	return false;
  	}
}
</SCRIPT>
</head>
<body leftmargin="0" topmargin="0" style="background-color: #D6DFF7">

<form action="guke_up2.asp" method="post" name="form1" onSubmit="return check()" enctype="multipart/form-data">
    <div class="file-field input-field">
      <div class="btn">
        <span>File</span>
  			<input name="FileName" type="FILE"  size="23" >
      </div>
      <div class="file-path-wrapper">
        <input class="file-path validate" type="text">
      </div>
    </div>
	  <input type="submit" name="Submit" value="上传" style="border:1px double rgb(88,88,88);font:9pt">

  </form>	


<script src="../css/sideNav/jquery-3.2.1.min.js"></script>
<script src="../css/sideNav/materialize.js"></script>


</body>
</html>