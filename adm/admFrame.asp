<!--#include file="../conn.asp"-->
<!--#include file="../common/constant.asp"-->
<!--#include file="../common/function.asp"-->
<%=admMainExit(session("userPower"))%>

<!DOCTYPE html>
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link rel="shortcut icon" href=" /favicon.ico" /> 
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link href="../cosmo/assets/images/favicon.ico" rel="icon">
	<link href="../cosmo/assets/css/pages/messages.css" rel="stylesheet">
	<link href="../cosmo/assets/css/basestyle/style.css" rel="stylesheet">
	<link href="../cosmo/assets/css/daterangepicker/daterangepicker.css" rel="stylesheet">
	<link href="../cosmo/assets/css/fullcalendar/fullcalendar.css" rel="stylesheet">
	
	<!-- Material Icons -->
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	

    
	<script src="../ueditor/ueditor.config.js"></script>
	<script src="../ueditor/ueditor.all.min.js"></script>	
	<script src="../ueditor/lang/zh-cn/zh-cn.js"></script> 

	</head>


<body>
     <!-- Pre Loader-->
      <div class="loader-wrapper">
        <div class="spinner">
          <svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
            <circle class="length" fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
          </svg>
          <svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
            <circle fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
          </svg>
          <svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
            <circle fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
          </svg>
          <svg viewBox="0 0 66 66" xmlns="http://www.w3.org/2000/svg">
            <circle fill="none" stroke-width="6" stroke-linecap="round" cx="33" cy="33" r="28"></circle>
          </svg>
        </div>
      </div>
      <!-- Pre Loader-->
	  
<section>
<aside class="sidebar">
	<nav class="navbar navbar-dark bg-primary">
	<a class="navbar-brand m-0 py-2 brand-title" href="admMain.html">case 后台</a>
	<a class="navbar-brand py-2 material-icons toggle-sidebar" href="#">menu</a>
	</nav>
	<nav class="navigation" >
		<ul>
			<li class="active"><a href="admMain.html" title="Dashboard"><span class="nav-icon material-icons">dashboard</span> 项目清单</a></li>
			<li title="Theme Settings"><a href="theme-setting.html"><span class="nav-icon material-icons ">color_lens</span>主题背景</a></li>				  				                 
		</ul>


		<!-- 消息管理 -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">message</span>消息管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<li><a href="admTaskAdd.html"><span class="nav-icon material-icons">add</span>新增消息</a></li>
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>编辑消息 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">			
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_task order by taskId DESC",conn,3,3 
							if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-maroon'>无任务</i>"
							else
							do while not rs1.eof %>
								<li>
								<a href="admTaskEdit-<%=rs1("taskId")%>.html"><i class="fa fa-circle-o"></i> <%=rs1("taskName")%></a>
								</li>
							<%rs1.movenext
							loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li>
					<li><a href="admTaskList.html"><span class="nav-icon material-icons ">list</span>消息列表</a></li>
				</ul>			
			</li>
		</ul>
	  
		
		<!-- 项目管理 -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span>项目管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<li><a href="admProjectAdd.html"><span class="nav-icon material-icons">add</span>新建项目</a></li>
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>编辑项目 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">			
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目</i></a><%
							else
								do while not rs1.eof %>
									<!-- 遍历项目名 -->
									<li>
										<a href="admProjectEdit-<%=rs1("pjtId")%>.html"><i class="fa fa-circle-o text-red"></i> <%=rs1("pjtName")%> 
										<% if rs1("pjtStatus") = 2 then
											response.write "<span class='label pull-right bg-red'>（关闭）</span>"			
										end if %></a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li>
					
					<!-- 项目列表 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">list</span>项目列表 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">	
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目</i></a><%
							else
								do while not rs1.eof %>
									<!-- 遍历项目名 -->
									<li>
									<a href="admProjectInfo-<%=rs1("pjtId")%>.html"><%=rs1("pjtName")%> </a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- 查看项目 over-->										
				</ul>			
			</li>
		</ul>
		
		
		<!-- 版本管理 -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">filter_1</span>版本管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<!-- 新建版本 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">add</span>新建版本 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">	
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目</i></a><%
							else
								do while not rs1.eof %>
									<!-- 遍历项目名 -->
									<li>
									<a href="admPlatformAdd-<%=rs1("pjtId")%>.html"><i class="fa fa-circle-o text-green"></i> <%=rs1("pjtName")%></a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- 新建版本 over-->
					
					<!-- 编辑版本 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>编辑版本 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">	
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目</i></a><%
							else
								do while not rs1.eof %>
									<!-- 项目名 -->								
									<li class="Form Stuff">
										<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span> <%=rs1("pjtName")%>  <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
										<ul class="sub-nav">											
											<!-- 平台名 -->
											<%Set rs2 = Server.CreateObject("Adodb.Recordset")
											rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
											if rs2.eof then%>
												<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>请新建版本</i></a>
											<%else
												do while not rs2.eof 	%>		
													<!-- 遍历项目名 -->
													<li>
														<a href="admPlatformEdit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><i class="fa fa-circle-o text-green"></i> <%=rs2("platformName")%> 
														<% if rs2("platformStatus") = 2 then
															response.write "<span class='label pull-right bg-red'>"			
															response.write "（关闭）"
															response.write "</span>"
														end if %></a>
													</li>																										
												<%rs2.movenext
												loop						
											end if 
											rs2.close
											set rs2 = nothing%>
										</ul>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- 编辑版本 over-->
			</ul>
		</li> <!-- 版本管理 over-->
		
		
		
		<!-- 标签管理 -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">notes</span>标签管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<!-- 新建标签 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">add</span>新建标签 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
						if rs1.eof then
							%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目</i></a><%
						else						
							do while not rs1.eof %>
								<!-- 项目名 -->							
								<li class="Form Stuff">
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
									<ul class="sub-nav">
										<!-- 平台名 -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
										if rs2.eof then%>
											<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>请新建版本</i></a>
										<%else
											do while not rs2.eof %>								
											<li><a href="admLabelAdd-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><i class="fa fa-circle-o text-yellow"></i> <%=rs2("platformName")%> </a></li>
											<% rs2.movenext
											loop	
										end if 
										rs2.close
										set rs2 = nothing%>
									</ul>
								</li>
							<%rs1.movenext
							loop		
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- 新增标签 over-->
				
				<!-- 编辑标签 -->
				<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>编辑标签 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
						if rs1.eof then
							%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目</i></a><%
						else
							do while not rs1.eof %>
								<!-- 项目名 -->
								<li class="Form Stuff">
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
									<ul class="sub-nav">
										<!-- 平台名 -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
										if rs2.eof then%>
											<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>请新建版本</i></a>											
										<%else
											do while not rs2.eof  %>												
												<li class="Form Stuff">
									<a href="#" title=""><span class="nav-icon material-icons ">filter_1</span><%=rs2("platformName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
									<ul class="sub-nav">
									
													<%								
													Set rs3 = Server.CreateObject("Adodb.Recordset")
													rs3.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId DESC",conn,3,3 
													if rs3.eof then%>
														<a href="admLabelAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-yellow'>创建标签</i></a>
													<%else
														do while not rs3.eof 
														' 遍历标签%>
														<li><a href="admLabelEdit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs3("lblId")%>.html"><i class="fa fa-circle-o text-yellow"></i> <%=rs3("lblName")%> </a></li>
														<%rs3.movenext
														loop		
													end if 
													rs3.close
													set rs3 = nothing%> 
												</ul>
											</li>
											<%rs2.movenext
											loop
										end if 
										rs2.close
										set rs2 = nothing%>
									</ul>
								</li>
							<%rs1.movenext
							loop 
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- 编辑标签 over-->
			</ul>
		</li>
		<!-- 标签管理 over-->

		
		<!-- 计划管理 -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">date_range</span>计划管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<!-- 新建标签 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">add</span>新建计划 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
				<%Set rs1 = Server.CreateObject("Adodb.Recordset")
				rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' and pjtIsPlan='off'  order by pjtId DESC",conn,3,3 
				if rs1.eof then
					%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目及版本</i><%
				else
					do while not rs1.eof %> <!-- 遍历项目名 -->								
							<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
							if rs2.eof then%>								
								<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>请新建版本</i></a>
							<%else
								do while not rs2.eof%>	<!-- 遍历版本 -->																						
									<%Set rs6 = Server.CreateObject("Adodb.Recordset")
									rs6.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" and plan_platformId="&rs2("platformId")&" order by planId DESC",conn,3,3 
									if rs6.eof then%>						
										<li><a href="admPlanAdd-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><i class="fa fa-circle-o text-maroon"></i> <%=rs2("platformName")%></a></li>																																			
								<%  end if 
								rs2.movenext
								loop						
							end if 
							rs2.close
							set rs2 = nothing%>
							</ul>
						</li>
					<%rs1.movenext
					loop
				end if 
				rs1.close
				set rs1 = nothing %>
				</ul>
				</li> 
				<!-- 新建计划 over-->
				
				<!-- 编辑计划 -->
				<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>编辑计划 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
				<%Set rs1 = Server.CreateObject("Adodb.Recordset")
				rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' order by pjtId DESC",conn,3,3 
				if not rs1.eof then
					
					do while not rs1.eof %>	<!-- 遍历项目 -->																																				
						
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" order by planId DESC",conn,3,3 
							if rs2.recordcount <>0 then%>							
								
								
								<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
									<%Set rs3 = Server.CreateObject("Adodb.Recordset")
									rs3.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and verIsPlan='on' and platformStatus='1' order by platformId DESC",conn,3,3 
									if rs3.eof then
										response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无版本</i>"
									else
										do while not rs3.eof%>	<!-- 遍历版本 -->																						
											<li><a href="admPlanEdit-<%=rs1("pjtId")%>-<%=rs3("platformId")%>.html"><i class="fa fa-circle-o text-maroon"></i> <%=rs3("platformName")%></a></li>																										
										<%rs3.movenext
										loop						
									end if 
									rs3.close
									set rs3 = nothing%>
								</ul>
								</li>
								<%
							
							end if 
							rs2.close							
							%>
						
					<%rs1.movenext
					loop
				end if 
				rs1.close
				set rs1 = nothing %>
				</ul>
				</li> 
				<!-- 编辑计划 over-->

				<!-- 计划列表 -->
			
				<li class="Form Stuff">
					<a href="#" title=""><span class="nav-icon material-icons ">list</span>计划列表 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on'  order by pjtId DESC",conn,3,3 
						if not rs1.eof then
					
					do while not rs1.eof %>	<!-- 遍历项目 -->																																				
					
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" order by planId DESC",conn,3,3 
							if rs2.recordcount <>0 then%>							
								
								
									<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
									<%Set rs3 = Server.CreateObject("Adodb.Recordset")
									rs3.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and verIsPlan='on' and platformStatus='1' order by platformId DESC",conn,3,3 
									if rs3.eof then
										response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无版本</i>"
									else
										do while not rs3.eof%>	<!-- 遍历版本 -->																						
											<li><a href="admTestPlanList-<%=rs1("pjtId")%>-<%=rs3("platformId")%>.html"><i class="fa fa-circle-o text-maroon"></i> <%=rs3("platformName")%></a></li>																										
										<%rs3.movenext
										loop						
									end if 
									rs3.close
									set rs3 = nothing%>
								</ul></li>
								<%
							
							end if 
							rs2.close							
							%>
						
					<%rs1.movenext
					loop
				end if 
				rs1.close
				set rs1 = nothing %>
				</ul>
				</li> 
				<!-- 查看计划 over-->
			</ul>
		</li> 
		<!-- 计划管理 over-->
		
		
		<!-- 测试报告管理 -->
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">book</span>报告管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">bookmarks</span>审核报告 
					<!-- 显示待审核的报告数量 -->
					<% Set rs5 = Server.CreateObject("Adodb.Recordset")
					rs5.Open "select * from tbl_report where rptStatus='undone' and rpt_pjtStatus='1' order by rptId DESC",conn,3,3 
					if rs5.recordcount > 0 then
						response.write "(" + cstr(rs5.recordcount) + ")"
					end if 
					rs5.close %>
					<span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					
				
					<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsReport='on' order by pjtId DESC",conn,3,3 
						if rs1.eof then
							%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目及版本</i><%
						else
							do while not rs1.eof %>
							<!-- 项目名 -->
							<li class="Form Stuff">
								<%  ' 显示待审核的报告数量 , 未审核的版本，项目名为红色
								Set rs5 = Server.CreateObject("Adodb.Recordset")
								rs5.Open "select * from tbl_report where rptStatus='undone' and rpt_pjtId="&rs1("pjtId")&" order by rptId DESC",conn,3,3 
								noAudit = rs5.recordcount 
								rs5.close 
								if noAudit > 0 then%>
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
								<%else%>
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
								<%end if %>
							
								<!-- 平台名 -->
								<ul class="sub-nav">	
									<%Set rs2 = Server.CreateObject("Adodb.Recordset")
									rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
									if rs2.eof then
										response.write "无版本"
									else
										do while not rs2.eof 						
											Set rs5 = Server.CreateObject("Adodb.Recordset")
											rs5.Open "select * from tbl_report where rpt_pjtId="&rs1("pjtId")&" and rpt_platformId="&rs2("platformId")&" order by rptId DESC",conn,3,3 
											if not rs5.eof then
												if rs5("rptStatus") = "done" then %>
													<li><a href="admReportAudit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%> &nbsp;&nbsp;(已完成）</a></li>      				
												<%elseif rs5("rptStatus") = "reject" then %>
													<li><a href="admReportAudit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%> &nbsp;&nbsp;<font color="white">(已拒绝）</font></a></li>    
												<%else %>
													<li><a href="admReportAudit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%>&nbsp;&nbsp;<font color="white">（待审核）</font> </a></li    
												><%end if 
											end if
											rs5.close			
										rs2.movenext
										loop						
									end if 
									rs2.close
									set rs2 = nothing%>
								</ul><!-- .平台名 over-->
							</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul><!-- .treeview-menu2 over-->
				</li> <!-- 审核报告 over-->
				
			</ul>
		</li> 
		<!-- 测试报告管理 over-->

		
		
		<!-- 用户管理 -->
		
		<li >
			<a href="#" title=""><span class="nav-icon material-icons ">perm_identity</span>用户管理 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
			<ul class="sub-nav">	
				<li><a href="admUserAdd.html"><span class="nav-icon material-icons">add</span>新增用户</a></li>
				<li class="Form Stuff">
					<a href="#" title=""><span class="nav-icon material-icons ">edit</span>编辑用户 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_user order by userId DESC",conn,3,3 
						if rs1.eof then
							response.write "无用户"
						else
							do while not rs1.eof %>
								<!-- 遍历用户名 -->
								<li>
								<a href="admUserEdit-<%=rs1("userId")%>.html"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("userNickname")%>
								<% if rs1("userStatus") = 2 then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "（关闭）"
										response.write "</span>"
									end if %></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- .treeview编辑用 over-->
			</ul>
		</li> <!-- 用户管理 over-->
		
			 <ul>
                 <li><a href="admMainExit.html" onClick="return confirm('是否立即退出系统？')"><span class="nav-icon material-icons">exit_to_app</span> 退出</a></li>           
             </ul>


	</nav>
</aside>


		<!--RIGHT CONTENT AREA-->
	<div class="content-area">	
		<header class="header sticky-top">
			<nav class="navbar navbar-light bg-white px-sm-4 ">
				<a class="navbar-brand py-2 d-md-none  m-0 material-icons toggle-sidebar" href="#">menu</a>
				<ul class="navbar-nav flex-row ml-auto">		
					<li class="nav-item ml-sm-3 user-logedin dropdown">
						<%	
						set rs = server.CreateObject("ADODB.RecordSet")
						rs.Open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3 %>						
						<a href="#" id="userLogedinDropdown" data-toggle="dropdown" class="nav-link weight-400 dropdown-toggle"><img src="<%=rs("userImg")%>" class="mr-2 rounded-circle" width="30"> 
						<%=rs("userNickname")%></a>
						<div class="dropdown-menu dropdown-menu-right" aria-labelledby="userLogedinDropdown">
							<a class="dropdown-item" href="admProfile.html">个人账号</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="admMainExit.html" onClick="return confirm('是否立即退出系统？')">退出</a>
						</div>
					</li>
				
				</ul>
			</nav>
		</header>
		<%rs.close
		set rs = nothing%>
		
		

		

<script src="../cosmo/assets/js/lib/moment.min.js"></script>
<script src="../cosmo/assets/js/lib/jquery.min.js"></script>
<script src="../cosmo/assets/js/lib/popper.min.js"></script>
<script src="../cosmo/assets/js/bootstrap/bootstrap.min.js"></script>
<script src="../cosmo/assets/js/chosen-js/chosen.jquery.js"></script>
<script src="../cosmo/assets/js/custom.js"></script>
<script src="../cosmo/assets/js/fullcalendar/fullcalendar.js"></script>
<script src="../cosmo/assets/js/daterangepicker/daterangepicker.min.js"></script>
