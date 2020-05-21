<!DOCTYPE html>
<!--#include file="conn.asp"-->

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
  <link rel="shortcut icon" href=" /favicon.ico" /> 
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <link rel="shortcut icon" href="/favicon.ico" /> 
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.5 -->
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="dist/css/skins/_all-skins.min.css">
  <!-- iCheck -->
  <link rel="stylesheet" href="plugins/iCheck/flat/blue.css">
  <!-- Morris chart -->
  <link rel="stylesheet" href="plugins/morris/morris.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="plugins/jvectormap/jquery-jvectormap-1.2.2.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="plugins/datepicker/datepicker3.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="plugins/daterangepicker/daterangepicker-bs3.css">
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
  <!-- DataTables -->
  <link rel="stylesheet" href="plugins/datatables/dataTables.bootstrap.css">
  
	<script src="ueditor/ueditor.config.js"></script>
	<script src="ueditor/ueditor.all.min.js"> </script>	
	<script src="ueditor/lang/zh-cn/zh-cn.js"></script> 

</head>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="review.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>C</b>ETC</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><strong>Cetc</strong>testcase</span>    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

   
    </nav>
  </header>
  
  <aside class="main-sidebar">
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
		<div class="pull-left image">
		<%Set rs = Server.CreateObject("Adodb.Recordset")
		rs.Open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3 	%>
		<img src="<%=rs("userImg")%>" class="user-image" alt="User Image">
		</div>
		<div class="pull-left info">
		<p><i class="fa fa-circle text-success"></i> <%=rs("userNickname")%></p>
		</div>
		<%rs.close%>
	</div>

      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">评审用例</li>
      
		
		
		<!-- 查看用例 -->
        <li class="treeview">
         
            <%Set rs1 = Server.CreateObject("Adodb.Recordset")
			  rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
			  if rs1.eof then
			  	  response.write "no project"
			  else
			  	  do while not rs1.eof %>
						<!-- 项目名 -->
						<li>
						  <a href="#"><i class="fa fa-circle-o text-yellow"></i> <%=rs1("pjtName")%> <i class="fa fa-angle-left pull-right"></i></a>
						  <ul class="treeview-menu">
							  <%Set rs2 = Server.CreateObject("Adodb.Recordset")
							    rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
							    if rs2.eof then
								    response.write "no platform"
							    else
									
								    do while not rs2.eof 
									  Set rs7 = Server.CreateObject("Adodb.Recordset")
									  Set rs78 = Server.CreateObject("Adodb.Recordset")
									  Set rs79 = Server.CreateObject("Adodb.Recordset")
							           rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 
										
									   rs78.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&"  and caseStage=1 order by caseId asc",conn,3,3 
							           rs79.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&"  and caseStage=2 order by caseId asc",conn,3,3 
									   if rs78.recordcount > 0 then %>
										    <li><a href="../reviewtestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-1.html"><i class="fa fa-circle-o text-yellow"></i> <%=rs2("platformName")%> </a></li>
										<%elseif rs79.recordcount > 0 then%>
											<li><a href="../reviewtestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-2.html"><i class="fa fa-circle-o text-yellow"></i> <%=rs2("platformName")%> </a></li>												
								        <%else%>
											<li><a href="../reviewtestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-3.html"><i class="fa fa-circle-o text-yellow"></i> <%=rs2("platformName")%> </a></li>
										<% end if
	 rs7.close
								   rs79.close
								   rs78.close
								  rs2.movenext
								  loop
								  
							     end if
								 rs2.close %>
						  </ul>
				 		</li>
				 <%rs1.movenext
				 loop
			end if 
			rs1.close %>
        </li> <!-- 查看测试用例 over-->
	
		
      </ul>
	
	<BR>
	<li><a href="index.html"><i class="fa fa-mail-reply"></i>&nbsp; <span>退出</span></a></li>
	
	
    </section>
    <!-- /.sidebar -->
  </aside>


 

