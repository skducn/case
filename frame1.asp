<!DOCTYPE html>

<!--#include file="conn.asp"-->
<%=returnMain%>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
  <link rel="shortcut icon" href=" /favicon.ico" /> 
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.5 -->
  <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
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
  




  
  
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]--></head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>C</b>ETC</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><strong>Cetc</strong>tEsTCase</span>    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="dropdown messages-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-envelope-o"></i>
              <span class="label label-success">4</span>            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 4 messages</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li><!-- start message -->
                    <a href="#">
                      <div class="pull-left">
                        <img src="dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Support Team
                        <small><i class="fa fa-clock-o"></i> 5 mins</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <!-- end message -->
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="dist/img/user3-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        AdminLTE Design Team
                        <small><i class="fa fa-clock-o"></i> 2 hours</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="dist/img/user4-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Developers
                        <small><i class="fa fa-clock-o"></i> Today</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="dist/img/user3-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Sales Department
                        <small><i class="fa fa-clock-o"></i> Yesterday</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <div class="pull-left">
                        <img src="dist/img/user4-128x128.jpg" class="img-circle" alt="User Image">
                      </div>
                      <h4>
                        Reviewers
                        <small><i class="fa fa-clock-o"></i> 2 days</small>
                      </h4>
                      <p>Why not buy a new awesome theme?</p>
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">See All Messages</a></li>
            </ul>
          </li>
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">10</span>            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 10 notifications</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-warning text-yellow"></i> Very long description here that may not fit into the
                      page and may cause design problems
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-red"></i> 5 new members joined
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-shopping-cart text-green"></i> 25 sales made
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-user text-red"></i> You changed your username
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
          </li>
          <!-- Tasks: style can be found in dropdown.less -->
          <li class="dropdown tasks-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-flag-o"></i>
              <span class="label label-danger">9</span>            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 9 tasks</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Design some buttons
                        <small class="pull-right">20%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">20% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Create a nice theme
                        <small class="pull-right">40%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-green" style="width: 40%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">40% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Some task I need to do
                        <small class="pull-right">60%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-red" style="width: 60%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">60% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                  <li><!-- Task item -->
                    <a href="#">
                      <h3>
                        Make beautiful transitions
                        <small class="pull-right">80%</small>
                      </h3>
                      <div class="progress xs">
                        <div class="progress-bar progress-bar-yellow" style="width: 80%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                          <span class="sr-only">80% Complete</span>
                        </div>
                      </div>
                    </a>
                  </li>
                  <!-- end task item -->
                </ul>
              </li>
              <li class="footer">
                <a href="#">View all tasks</a>
              </li>
            </ul>
          </li>
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
		  <%Set rs = Server.CreateObject("Adodb.Recordset")
			  rs.Open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3 
			 %>
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="dist/img/<%=rs("userImg")%>" class="user-image" alt="User Image">
              <span class="hidden-xs"><%=session("userNickname")%></span>
            </a>
			
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
			
                <img src="dist/img/<%=rs("userImg")%>" class="img-circle" alt="User Image">

                <p> <%=rs("userTitle")%>
             
                  <small><%=rs("userEmail")%></small>
                </p>
              </li>
            
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left">
                  <a href="#" class="btn btn-default btn-flat">个人设置</a>
                </div>
                <div class="pull-right">
                  <a href="mainExit.html" class="btn btn-default btn-flat">退出</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="dist/img/<%=rs("userImg")%>" class="user-image" alt="User Image">
        </div>
        <div class="pull-left info">
          <p><%=session("userNickname")%></p>
		    
           
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- search form -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
              <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu">
        <li class="header">MAIN NAVIGATION</li>
        <li class="active treeview">
          <a href="#">
            <i class="fa fa-dashboard"></i> <span>Dashboard</span> <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li class="active"><a href="index.html"><i class="fa fa-circle-o"></i> Dashboard v1</a></li>
            <li><a href="index2.html"><i class="fa fa-circle-o"></i> Dashboard v2</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-files-o"></i>
            <span>Layout Options</span>
            <span class="label label-primary pull-right">4</span>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/layout/top-nav.html"><i class="fa fa-circle-o"></i> Top Navigation</a></li>
            <li><a href="pages/layout/boxed.html"><i class="fa fa-circle-o"></i> Boxed</a></li>
            <li><a href="pages/layout/fixed.html"><i class="fa fa-circle-o"></i> Fixed</a></li>
            <li><a href="pages/layout/collapsed-sidebar.html"><i class="fa fa-circle-o"></i> Collapsed Sidebar</a></li>
          </ul>
        </li>
        <li>
          <a href="pages/widgets.html">
            <i class="fa fa-th"></i> <span>Widgets</span>
            <small class="label pull-right bg-green">new</small>
          </a>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-pie-chart"></i>
            <span>Charts</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/charts/chartjs.html"><i class="fa fa-circle-o"></i> ChartJS</a></li>
            <li><a href="pages/charts/morris.html"><i class="fa fa-circle-o"></i> Morris</a></li>
            <li><a href="pages/charts/flot.html"><i class="fa fa-circle-o"></i> Flot</a></li>
            <li><a href="pages/charts/inline.html"><i class="fa fa-circle-o"></i> Inline charts</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-laptop"></i>
            <span>UI Elements</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/UI/general.html"><i class="fa fa-circle-o"></i> General</a></li>
            <li><a href="pages/UI/icons.html"><i class="fa fa-circle-o"></i> Icons</a></li>
            <li><a href="pages/UI/buttons.html"><i class="fa fa-circle-o"></i> Buttons</a></li>
            <li><a href="pages/UI/sliders.html"><i class="fa fa-circle-o"></i> Sliders</a></li>
            <li><a href="pages/UI/timeline.html"><i class="fa fa-circle-o"></i> Timeline</a></li>
            <li><a href="pages/UI/modals.html"><i class="fa fa-circle-o"></i> Modals</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-edit"></i> <span>Forms</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/forms/general.html"><i class="fa fa-circle-o"></i> General Elements</a></li>
            <li><a href="pages/forms/advanced.html"><i class="fa fa-circle-o"></i> Advanced Elements</a></li>
            <li><a href="pages/forms/editors.html"><i class="fa fa-circle-o"></i> Editors</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-table"></i> <span>Tables</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/tables/simple.html"><i class="fa fa-circle-o"></i> Simple tables</a></li>
            <li><a href="pages/tables/data.html"><i class="fa fa-circle-o"></i> Data tables</a></li>
          </ul>
        </li>
        <li>
          <a href="pages/calendar.html">
            <i class="fa fa-calendar"></i> <span>Calendar</span>
            <small class="label pull-right bg-red">3</small>
          </a>
        </li>
        <li>
          <a href="pages/mailbox/mailbox.html">
            <i class="fa fa-envelope"></i> <span>Mailbox</span>
            <small class="label pull-right bg-yellow">12</small>
          </a>
        </li>
        <li class="treeview">
          <a href="#">
            <i class="fa fa-folder"></i> <span>Examples</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <li><a href="pages/examples/invoice.html"><i class="fa fa-circle-o"></i> Invoice</a></li>
            <li><a href="pages/examples/profile.html"><i class="fa fa-circle-o"></i> Profile</a></li>
            <li><a href="pages/examples/login.html"><i class="fa fa-circle-o"></i> Login</a></li>
            <li><a href="pages/examples/register.html"><i class="fa fa-circle-o"></i> Register</a></li>
            <li><a href="pages/examples/lockscreen.html"><i class="fa fa-circle-o"></i> Lockscreen</a></li>
            <li><a href="pages/examples/404.html"><i class="fa fa-circle-o"></i> 404 Error</a></li>
            <li><a href="pages/examples/500.html"><i class="fa fa-circle-o"></i> 500 Error</a></li>
            <li><a href="pages/examples/blank.html"><i class="fa fa-circle-o"></i> Blank Page</a></li>
            <li><a href="pages/examples/pace.html"><i class="fa fa-circle-o"></i> Pace Page</a></li>
          </ul>
        </li>
		
		<!-- 新建测试用例 -->
        <li class="treeview">
          <a href="#">
            <i class="fa fa-edit text-red"></i> <span>新建用例</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <%Set rs1 = Server.CreateObject("Adodb.Recordset")
			  rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
			  if rs1.eof then
			  	  response.write "no project"
			  else
			  	  do while not rs1.eof %>
						<!-- 项目名 -->
						<li>
						  <a href="#"><i class="fa fa-circle-o text-red"></i> <%=rs1("pjtName")%> <i class="fa fa-angle-left pull-right"></i></a>
						  <ul class="treeview-menu">
							  <%Set rs2 = Server.CreateObject("Adodb.Recordset")
							  rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
							  if rs2.eof then
								 response.write "no platform"
							  else
								  do while not rs2.eof 
								     Set rs7 = Server.CreateObject("Adodb.Recordset")
							         rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 %>
										<!-- 平台名 -->
										<% if rs2("plat_rptStatus") = "done" then %>
										
											<li> 
											<a href="#">
											<i class="fa fa-circle-o text-red"></i>
											<span><%=rs2("platformName")%></span>								
											<span class="label pull-right bg-aqua">done</span>								
											</a>
											</li>
												
										<%else%>
										
											<li><a href="sltTestcase.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>&lblId=<%=rs7("lblId")%>"><i class="fa fa-circle-o text-red"></i> <%=rs2("platformName")%> </a></li>
								        
										<%end if 
								  rs7.close
								  rs2.movenext
								  loop
							  end if 
							  rs2.close%>
						  </ul>
				 		</li>
				 <%rs1.movenext
				 loop
			end if 
			rs1.close%>
          </ul>
        </li> <!-- 测试用例 over-->
		
		<!-- 执行用例 -->
        <li class="treeview">
			<a href="#">
			 <i class="fa fa-edit text-green"></i> <span>执行用例</span>
			<i class="fa fa-angle-left pull-right"></i>
			</a>
			<ul class="treeview-menu">
              <%Set rs1 = Server.CreateObject("Adodb.Recordset")
			    rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
				if rs1.eof then
					response.write "no project"
				else
			  	    do while not rs1.eof %>
						<!-- 项目名 -->
						<li>
						  <a href="#"><i class="fa fa-circle-o text-green"></i> <%=rs1("pjtName")%> <i class="fa fa-angle-left pull-right"></i></a>
						  <ul class="treeview-menu">
						  	   <!-- 平台名 -->
							  <%Set rs2 = Server.CreateObject("Adodb.Recordset")
							  rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
							  if rs2.eof then
								 response.write "no platform"
							  else
								  do while not rs2.eof 									
										 Set rs7 = Server.CreateObject("Adodb.Recordset")
							             rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 %>
										 <!-- 平台名 -->
										 <% if rs2("plat_rptStatus") = "done" then %>
										
											<li> 
											<a href="#">
											<i class="fa fa-circle-o text-green"></i>
											<span><%=rs2("platformName")%></span>								
											<span class="label pull-right bg-aqua">done</span>								
											</a>
											</li>
												
										<%else%>
										
											<li><a href="excTestcase.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>&lblId=<%=rs7("lblId")%>&caseStage=1"><i class="fa fa-circle-o text-green"></i> <%=rs2("platformName")%> </a></li>
								        
										<%end if 
									
								  rs2.movenext
								  loop
								  rs7.close
							  end if 
							  rs2.close%>
						  </ul>
				 		</li>
					<%rs1.movenext
				 	loop
				end if 
				rs1.close%>
			</ul>
        </li> <!-- 执行测试用例 over-->
		
	
		
		
		<!-- 查看编辑测试用例 -->
        <li class="treeview">
          <a href="#">
            <i class="fa fa-eye text-aqua"></i> <span>查看&编辑用例</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <%Set rs1 = Server.CreateObject("Adodb.Recordset")
			  rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
			  if rs1.eof then
			  	  response.write "no project"
			  else
			  	  do while not rs1.eof %>
						<!-- 项目名 -->
						<li>
						  <a href="#"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("pjtName")%> <i class="fa fa-angle-left pull-right"></i></a>
						  <ul class="treeview-menu">
							  <%Set rs2 = Server.CreateObject("Adodb.Recordset")
							    rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
							    if rs2.eof then
								    response.write "no platform"
							    else
								    do while not rs2.eof 
								       Set rs7 = Server.CreateObject("Adodb.Recordset")
							           rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 %>
										<!-- 平台名 -->
										<li><a href="sltTestcaseList.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>&lblId=<%=rs7("lblId")%>&caseStage=1"><i class="fa fa-circle-o text-aqua"></i> <%=rs2("platformName")%> </a></li>
								   <%  rs7.close
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
          </ul>
        </li> <!-- 查看测试用例 over-->
		
		
		<!-- 测试报告1 -->
        <li class="treeview">
          <a href="#">
            <i class="fa fa-book"></i> <span>测试报告</span>
            <i class="fa fa-angle-left pull-right"></i>
          </a>
          <ul class="treeview-menu">
            <%Set rs1 = Server.CreateObject("Adodb.Recordset")
			  rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
			  if rs1.eof then
			  	  response.write "no project"
			  else
			  	  do while not rs1.eof %>
						<!-- 项目名 -->
						<li>
						  <a href="#"><i class="fa fa-book "></i> <%=rs1("pjtName")%> <i class="fa fa-angle-left pull-right"></i></a>
						  <ul class="treeview-menu">
							  <%Set rs2 = Server.CreateObject("Adodb.Recordset")
							    rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
							    if rs2.eof then
								    response.write "no platform"
							    else
								    do while not rs2.eof 
										set rs3 = server.CreateObject("ADODB.RecordSet")
										rs3.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and isnull(caseResult) ",conn,3,3
										if rs3.recordcount = 0 then
											set rs4 = server.CreateObject("ADODB.RecordSet")
											rs4.Open "select * from tbl_report where rpt_pjtId="&rs1("pjtId")&" and rpt_platformId="&rs2("platformId")&" order by rptId DESC",conn,3,3
											if rs4.recordcount = 0 then%>
											
												<li> 
												 <a href="sltReportCreate.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>">
												<i class="fa fa-book text-green"></i>
												<span><%=rs2("platformName")%></span>								
													<span class="label pull-right bg-green">创建</span>								
												  </a>
												</li>
										    <%elseif rs4("rptStatus") = "undone" then%>	
												<li> 
												 <a href="sltReportShow.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>">
												<i class="fa fa-book text-aqua"></i>
												<span><%=rs2("platformName")%></span>								
													<span class="label pull-right bg-aqua">未审核</span>								
												  </a>
												</li>
											 <%elseif rs4("rptStatus") = "done" then%>	
												<li> 
												 <a href="sltReportShow.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>">
												<i class="fa fa-book text-aqua"></i>
												<span><%=rs2("platformName")%></span>								
													<span class="label pull-right bg-aqua">已完成</span>								
												  </a>
												</li>	
											<%end if%>
										<%else%>
										
											<li> 
											
											<% 
										 ' 标签名
										 Set rs5 = Server.CreateObject("Adodb.Recordset")
							             rs5.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 %>										
								
								  
											 <a href="excTestcase.asp?pjtId=<%=rs1("pjtId")%>&platformId=<%=rs2("platformId")%>&lblId=<%=rs5("lblId")%>&caseStage=1">
												<i class="fa fa-book"></i>
												<span><%=rs2("platformName")%></span>
												<span class="label pull-right bg-red"><%=rs3.recordcount%></span>
											  </a>
											</li>
										
										<% rs5.close
										
										end if
										rs3.close			
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
          </ul>
        </li> <!-- 测试报告1 over-->
		
		
		
        <li class="header">LABELS</li>
		<li><a href="documentation/index.html"><i class="fa fa-book"></i> <span>SRS使用说明书</span></a></li>

        <li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
        <li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
        <li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>


 

