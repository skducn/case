<!--#include file="conn.asp"-->
<!--#include file="function.asp"-->
<!--#include file="constant.asp"-->
<%exitIndex()%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link rel="shortcut icon" href=" /favicon.ico" /> 
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="/favicon.ico" /> 
<link rel="stylesheet" type="text/css" href="731/dist/css/main2.css">
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<!-- https://fontawesome.dashgame.com/ ，确保 fonts不能删除 -->	
<link rel="stylesheet" type="text/css" href="css/1.css">

</head>


  <body class="sidebar-mini fixed">
    <div class="wrapper">
      <!-- Navbar-->
      <header class="main-header hidden-print"><a class="logo" href="main.html">CASE</a>
        <nav class="navbar navbar-static-top">
          <!-- Sidebar toggle button--><a class="sidebar-toggle" href="#" data-toggle="offcanvas"></a>
	
          <!-- Navbar Right Menu-->
          <div class="navbar-custom-menu">
            <ul class="top-nav">
				
				<li class="app-search">																	
					<!-- search -->           				
					<form method="POST"  action="sltSearchSearch.html" >
						<input name="searchName" class="form-search " type="text" placeholder=" 搜一搜"  size="30" maxlength="30">						
						<button class="app-search__button"><i class="fa fa-search"></i></button>	
					</form>	  
				</li>
								
           
              <!-- User Menu  sltUserEdit.html-->
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><i class="fa fa-cog fa-lg"></i> 设置</a>
                <ul class="dropdown-menu settings-menu">
                  <li><a href="admProfile.html"><i class="fa fa-user fa-lg"></i> 个人信息</a></li>                 				 
				  <li><a href="#" id="demoExit1"><i class="fa fa-sign-out fa-lg"></i>  <span>退出</span></a></li>			
                </ul>
              </li>
            </ul>
          </div>
        </nav>
      </header>
	  
      <!-- Side-Nav-->
      <aside class="main-sidebar hidden-print">
        <section class="sidebar">
          <div class="user-panel">		  								
			<%Set rs = Server.CreateObject("Adodb.Recordset")
			rs.Open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3 %>								
			<div class="pull-left image"><img class="img-circle " src="<%=rs("userImg")%>" alt="User Image"></div>
			<div class="pull-left info">
				<p><%=rs("userNickname")%></p>
				<p class="designation"><%=rs("userTitle")%></p>
			</div>
			<%rs.close%>
		</div>
			
	


		  
<!-- Sidebar Menu-->
	<ul class="sidebar-menu">
		<li class="active"><a href="main.html"><i class="fa fa-dashboard"></i><span> 我的面板</span></a></li>
		
			<!-- 新增用例 -->					
			<li class="treeview"><a href="#"><i class="fa fa-edit text-danger"></i><span><%=cstNewCase%> </span><i class="fa fa-angle-right text-danger"></i></a>
				<ul class="treeview-menu">
					<%Set rs1 = Server.CreateObject("Adodb.Recordset")
					rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtName",conn,3,3 
					if rs1.eof then
						response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>无项目</i>"
					else
						do while not rs1.eof %> <!-- 遍历项目名 -->
						<li class="treeview"><a href="#"><span><%=rs1("pjtName")%></span><i class="fa fa-angle-right"></i></a>
							<ul class="treeview-menu">
								<%Set rs2 = Server.CreateObject("Adodb.Recordset")
								rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
								if rs2.eof then
									response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>无版本</i>"
								else
									do while not rs2.eof 
										Set rs7 = Server.CreateObject("Adodb.Recordset")
										rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 %>
										<!-- 遍历版本，已完成测试报告的则不能再新增用例 -->
										<% if rs2("plat_rptStatus") = "done" then %>
											<li><span><a href="#"  target="BoardList"><%=rs2("platformName")%></span><span class="label pull-right bg-aqua">done</span></a></li>
										<%else%>
											<li><span><a href="sltTestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>.html"><%=rs2("platformName")%></a></span></li>

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
					rs1.close
					set rs1 = nothing%>
				</ul>
			</li> 
			<!-- 新建用例 over-->
					  
			
			<!-- 执行用例 -->
				<li class="treeview"><a href="#"><i class="fa fa-edit text-primary"></i><span><%=cstExcCase%></span><i class="fa fa-angle-right text-primary"></i></a>
				<ul class="treeview-menu">
					<%Set rs1 = Server.CreateObject("Adodb.Recordset")
					rs1.Open "select * from tbl_project where pjtStatus='1'  order by pjtName",conn,3,3 
					if rs1.eof then
						response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>无项目</i>"
					else
						do while not rs1.eof %><!-- 遍历项目名 -->
							<li class="treeview"><a href="#"><span><%=rs1("pjtName")%></span><i class="fa fa-angle-right"></i></a>
							<ul class="treeview-menu">
						
								<%Set rs2 = Server.CreateObject("Adodb.Recordset")
								rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
								if rs2.eof then
									response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>无版本</i>"
								else
									do while not rs2.eof 									
										Set rs7 = Server.CreateObject("Adodb.Recordset")
										rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 %>
										<!-- 遍历版本，已完成测试报告的则不能再执行用例 -->
										<%if rs2("plat_rptStatus") = "done" then %>
											<li><a href="#"><i class="fa fa-circle"></i><span><%=rs2("platformName")%></span><span class="label pull-right bg-aqua">done</span></a></li>
								
										<%else
											Set rs78 = Server.CreateObject("Adodb.Recordset")
											Set rs79 = Server.CreateObject("Adodb.Recordset")
											rs78.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and caseCreateUser='"&session("userName")&"' and caseStage=1 order by caseId asc",conn,3,3 
											rs79.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and caseCreateUser='"&session("userName")&"' and caseStage=2 order by caseId asc",conn,3,3 
											if rs78.recordcount > 0 then %>
												<li><span><a href="excTestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-1.html"><%=rs2("platformName")%></a></span></li>
											<%elseif rs79.recordcount > 0 then%>
												<li><span><a href="excTestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-2.html"><%=rs2("platformName")%></a></span></li>												
											<%else%>
												<li><span><a href="excTestcase-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-3.html"><%=rs2("platformName")%></a></span> </li>
											<% end if
											rs79.close
											rs78.close
											set rs78 = nothing
											set rs79 = nothing
										end if 
										rs7.close
										set rs7 = nothing
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
					set rs1 = nothing%>
				</ul>
			</li> 
			<!-- 执行用例 over-->
			
			
			<!-- 变更用例 -->
			<li class="treeview"><a href="#"><i class="fa fa-edit text-warning"></i><span><%=cstChangeCase%></span><i class="fa fa-angle-right text-warning"></i></a>
				<ul class="treeview-menu">
					<%Set rs1 = Server.CreateObject("Adodb.Recordset")
					rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtName",conn,3,3 
					if rs1.eof then
						response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-yellow'>无项目</i>"
					else
						do while not rs1.eof %><!-- 遍历项目名 -->
							<li class="treeview"><a href="#"><span><%=rs1("pjtName")%></span><i class="fa fa-angle-right"></i></a>
							<ul class="treeview-menu">
						
								<%Set rs2 = Server.CreateObject("Adodb.Recordset")
								rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
								if rs2.eof then
									response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-yellow'>无版本</i>"
								else
									do while not rs2.eof 
										Set rs7 = Server.CreateObject("Adodb.Recordset")
										Set rs78 = Server.CreateObject("Adodb.Recordset")
										Set rs79 = Server.CreateObject("Adodb.Recordset")
										rs7.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3 
										rs78.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and caseCreateUser='"&session("userName")&"' and caseStage=1 order by caseId asc",conn,3,3 
										rs79.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and caseCreateUser='"&session("userName")&"' and caseStage=2 order by caseId asc",conn,3,3 
										if rs78.recordcount > 0 then %>
											<li><span><a href="sltTestcaseList-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-1.html"><%=rs2("platformName")%></a></span></li>
										<%elseif rs79.recordcount > 0 then%>
											<li><span><a href="sltTestcaseList-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-2.html"><%=rs2("platformName")%></a></span></li>												
										<%else%>
											<li><span><a href="sltTestcaseList-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs7("lblId")%>-3.html"><%=rs2("platformName")%></a></span></li>
										<% end if
										rs7.close
										rs79.close
										rs78.close
										set rs7 = nothing
										set rs79 = nothing
										set rs78 = nothing
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
					set rs1 = nothing%>
				</ul>
			</li> 
			<!-- 变更用例 over-->
		
		
			<!-- 计划管理 -->
		
			<li class="treeview"><a href="#"><i class="fa fa-briefcase "></i> <span><%=cstPlanManage%></span><i class="fa fa-angle-right"></i></a>
				<ul class="treeview-menu">
					<!-- 新建计划 -->
					
						<li class="treeview"><a href="#"><i class="fa fa-edit"></i><span><%=cstNewPlan%></span><i class="fa fa-angle-right"></i></a>
						<ul class="treeview-menu">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' and pjtIsPlan='off' order by pjtName ",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>请新建项目及版本</i>"
						else
							do while not rs1.eof %> <!-- 遍历项目名 -->							
								<li class="treeview"><a href="#"><span><%=rs1("pjtName")%></span><i class="fa fa-angle-right"></i></a>
								<ul class="treeview-menu">						
							
								<%Set rs2 = Server.CreateObject("Adodb.Recordset")
								rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
								if rs2.eof then%>								
									<a href="sltPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>请新建版本</i></a>
								<%else
									do while not rs2.eof%>	<!-- 遍历版本 -->																						
										<%Set rs6 = Server.CreateObject("Adodb.Recordset")
										rs6.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" and plan_platformId="&rs2("platformId")&" order by planId DESC",conn,3,3 
										if rs6.eof then%>						
											<li><span><a href="sltPlanAdd-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-0.html"><%=rs2("platformName")%></a></span></li>		
										<%																														
										end if 
										rs6.close
										set rs6 = nothing
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
					
						<li class="treeview"><a href="#"><i class="fa fa-edit"></i><span><%=cstEditPlan%></span><i class="fa fa-angle-right"></i></a>
						<ul class="treeview-menu">	
						
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' order by pjtName",conn,3,3 
						if not rs1.eof then
							do while not rs1.eof %>	<!-- 遍历项目 -->																																				
						
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" order by planId DESC",conn,3,3 
							if rs2.recordcount <>0 then%>	
								<li class="treeview"><a href="#"><span><%=rs1("pjtName")%></span><i class="fa fa-angle-right"></i></a>
								<ul class="treeview-menu">							
						
									<%Set rs3 = Server.CreateObject("Adodb.Recordset")
									rs3.Open "select * from tbl_platform where plat_pjtId="&rs2("plan_pjtId")&"  and verIsPlan='on'  and platformStatus='1' order by platformId DESC",conn,3,3 
										do while not rs3.eof%>	<!-- 遍历版本 -->	
										
											<%Set rs4 = Server.CreateObject("Adodb.Recordset")
											rs4.Open "select * from tbl_plan where plan_platformId="&rs3("platformId")&" order by planId DESC",conn,3,3 	
											if not rs4.eof then%>																				
											
											<li><span><a href="sltPlanEdit-<%=rs1("pjtId")%>-<%=rs4("plan_platformId")%>.html"><%=rs3("platformName")%></a></span></li>																										
											
										<%  end if 
											rs4.close
										rs3.movenext
										loop						
										rs3.close
										set rs3 = nothing%>
								</ul>
								</li>
							<%end if 
							rs2.close	
							set rs2 = nothing						
							%>
							</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
						</ul>
					</li> 
					<!-- 编辑计划 over-->


					<!-- 计划列表 -->
			
						<li class="treeview"><a href="#"><i class="fa fa-list"></i><span><%=cstPlanList%> </span><i class="fa fa-angle-right"></i></a>
								<ul class="treeview-menu">	
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' order by pjtName",conn,3,3 
						if not rs1.eof then
							do while not rs1.eof %>	<!-- 遍历项目 -->																																			
								<li class="treeview" ><a href="#"><span><%=rs1("pjtName")%></span><i class="fa fa-angle-right"></i></a>
								<ul class="treeview-menu">	
									<%Set rs3 = Server.CreateObject("Adodb.Recordset")
									rs3.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and verIsPlan='on' and  platformStatus='1' order by platformId DESC",conn,3,3 
									if rs3.eof then
										response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无版本</i>"
									else
										do while not rs3.eof%>	<!-- 遍历版本 -->																					
											<%Set rs2 = Server.CreateObject("Adodb.Recordset")
											rs2.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" and plan_platformId="&rs3("platformId")&" order by planId DESC",conn,3,3 
												if not rs2.eof then%>																																		
													<li><span><a href="sltTestPlanList-<%=rs2("planId")%>.html"><%=rs3("platformName")%></a></span></li>																										
												<%
												end if 
										rs3.movenext
										loop						
									
									rs3.close
									set rs3 = nothing%>
								</ul>
								</li>
								<%
							end if 
							rs2.close							
							set rs2 = nothing%>
							</li>
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
			
			
			<!-- 测试报告 -->
			
			<li class="treeview"><a href="#"><i class="fa fa-book" ></i><span> <%=cstReport%> </span><i class="fa fa-angle-right"></i></a>
					<ul class="treeview-menu text-purpl">	
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtName",conn,3,3 											
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='white'>无项目</font>"
						else
							do while not rs1.eof 
 							    ' <!-- 遍历项目 -->
								
								' 有报告未完成
								Set rs52 = Server.CreateObject("Adodb.Recordset")								
								rs52.Open "select * from tbl_report where rpt_pjtId="&rs1("pjtId")&" and rptStatus='undone' order by rptId DESC",conn,3,3 								
								Set rs53 = Server.CreateObject("Adodb.Recordset")
								rs53.Open "select * from tbl_report where rpt_pjtId="&rs1("pjtId")&" order by rptId DESC",conn,3,3 %>							
								<!-- 项目名 (
								红色：新建报告，
								绿色：还有未执行的用例，
								黄色：可编辑，未审核报告
								蓝色：已完成报告）
								-->
								<li class="treeview">				
									<%if rs52.recordcount > 0 then%>
										<!-- 报告未审核 -->
										<a href="#"><%=rs1("pjtName")%> <i class="fa fa-angle-right"></i></a>						  						
									<%elseif rs53.eof then
										count1 = 0
										Set rs55 = Server.CreateObject("Adodb.Recordset")
										rs55.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
										do while not rs55.eof 											
											set rs56 = server.CreateObject("ADODB.RecordSet")
											rs56.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs55("platformId")&" and caseResult='empty' and caseStatus='1' ",conn,3,3
											count1 = rs56.recordcount + count1
										rs55.movenext
										loop
										if count1 > 0 then%>
										<!-- 未执行完用例的项目名 -->
											<a href="#"><%=rs1("pjtName")%> <i class="fa fa-angle-right"></i></a>								
										<%else%>
										<!-- 新建报告的项目名 -->
											<a href="#"><%=rs1("pjtName")%><i class="fa fa-angle-right"></i></a>																							
										<%end if %>									
									<%else%>
										<!-- 已完成报告的项目名 -->
										<a href="#"><%=rs1("pjtName")%><i class="fa fa-angle-right"></i></a>
									<%end if%>	
								
									<ul class="treeview-menu">
			
			
									<%Set rs2 = Server.CreateObject("Adodb.Recordset")
									rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformstatus='1' order by platformId DESC",conn,3,3 
									if rs2.eof then
										response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color='white'>无版本</font>"
									else								
										do while not rs2.eof 
											' 用例全部执行完了
											set rs3 = server.CreateObject("ADODB.RecordSet")
											rs3.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and caseResult='empty' and caseStatus='1' ",conn,3,3
											if rs3.recordcount = 0 then
												' 判断是否有记录 
												set rs33 = server.CreateObject("ADODB.RecordSet")
												rs33.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&"",conn,3,3
												if rs33.recordcount > 0 then
													set rs4 = server.CreateObject("ADODB.RecordSet")
													rs4.Open "select * from tbl_report where rpt_pjtId="&rs1("pjtId")&" and rpt_platformId="&rs2("platformId")&" order by rptId DESC",conn,3,3
													if rs4.recordcount = 0 then%>
														<li><a href="sltReportCreate-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-0.html">
														<i class="fa fa-edit text-primary"> <%=rs2("platformName")%></i><span class="label pull-right bg-purple">可新建</span></a></li>							
													<%elseif rs4("rptStatus") = "undone" then%>	
														<li><a href="sltReportShow-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html">
														<i class="fa fa-edit text-primary"> <%=rs2("platformName")%></i><span class="label pull-right bg-yellow">待审核</span></a></li>							
													<%elseif rs4("rptStatus") = "reject" then%>	
														<li> <a href="sltReportShow-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html">
														<i class="fa fa-edit text-primary"> <%=rs2("platformName")%></i><span class="label pull-right bg-red">未通过</span></a></li>
													<%elseif rs4("rptStatus") = "done" then%>
														<li><a href="sltReportShow-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%><span class="label pull-right">已完成</span></a></li>	
													<%end if
												end if 
												rs33.close
											else%>
												<li> 
													<% countCaseState = 0
													Set rs5 = Server.CreateObject("Adodb.Recordset")
													rs5.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId asc",conn,3,3
													set rs6 = server.CreateObject("ADODB.RecordSet")
													rs6.Open "select * from tbl_case where case_pjtId="&rs1("pjtId")&" and case_platformId="&rs2("platformId")&" and caseResult='empty' and caseStatus='1' and caseCreateUser='"&session("userName")&"'",conn,3,3 				
													
													if rs6.recordcount = 0 then 																																						
														do while not rs6.eof 
															if rs6("caseStage") = "1" then
																countCaseState = 1
															elseif rs6("caseStage") = "2" then
  																countCaseState = 2															
															else
																countCaseState = 3
															end if 
														rs6.movenext
														loop
														if countCaseState = 1 then %>
															<a href="excTestcaseReport-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs5("lblId")%>-1.html">
														<%elseif countCaseState = 2 then %>
															<a href="excTestcaseReport-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs5("lblId")%>-2.html">
														<%else%>
															<a href="excTestcaseReport-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs5("lblId")%>-3.html">
														<%end if%> 
															<i class="fa fa-edit text-primary"> <%=rs2("platformName")%></i>
															<span class="label pull-right"><%=rs3.recordcount%></span>
															</a>
													<%else
														do while not rs6.eof 
															if rs6("caseStage") = "1" then
																countCaseState = 1
															elseif rs6("caseStage") = "2" then
  																countCaseState = 2															
															else
																countCaseState = 3
															end if 
														rs6.movenext
														loop
														if countCaseState = 1 then %>
															<a href="excTestcaseReport-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs5("lblId")%>-1.html">
														<%elseif countCaseState = 2 then %>
															<a href="excTestcaseReport-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs5("lblId")%>-2.html">
														<%else%>
															<a href="excTestcaseReport-<%=rs1("pjtId")%>-<%=rs2("platformId")%>-<%=rs5("lblId")%>-3.html">
														<%end if%> 
															<i class="fa fa-edit text-primary"> <%=rs2("platformName")%></i>
															<span class="label pull-right"><%=rs3.recordcount%></span>
															</a>
													<% end if 
													
													rs6.close%>
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
				</li> 
				<!-- 测试报告 over-->
		
			
				<!-- 项目信息 -->
				<li class="treeview"><a href="#"><i class="fa fa-wrench"></i> <span><%=cstProjectInfo%> </span><i class="fa fa-angle-right"></i></a>							
					<ul class="treeview-menu">

						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtName",conn,3,3 
						if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>无项目</i>"
						else
							do while not rs1.eof %>
								<li><span><a href="sltProjectInfo-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs1("pjtName")%></a></span></li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> 
				<!-- 项目信息 over-->
	
				
			
				
				<!-- .备份用例 over-->
		
  				<li><a href="#" id="demoExit"><i class="fa fa-sign-out fa-lg"></i>  <span>退出</span></a></li>
				
		</ul>
	</ul>
</section>
</aside>		  



	
<!-- 百度编辑器--> 
<script src="ueditor/ueditor.config.js"></script>
<script src="ueditor/ueditor.all.min.js"> </script>	
<script src="ueditor/lang/zh-cn/zh-cn.js"></script> 

<!-- 退出弹框效果 -->
<script src="js/exit/jquery-2.1.4.min.js"></script>	
<script type="text/javascript" src="js/exit/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="js/exit/sweetalert.min.js"></script>
<script type="text/javascript" src="js/exit/custom.js"></script>

<!-- top按钮 cd-top-arrow.svg箭头-->
<link href="js/topButton/zzsc.css" rel="stylesheet" type="text/css" />
<script src="js/topButton/jquery.min.js"></script>
<script src="js/topButton/zzsc.js"></script> 

<!-- 快捷鍵列表 -->
<link href="js/shortcutKey/custom.css" rel="stylesheet" type="text/css" />


<!-- 表单提交校验 -->
<script src="js/check.js"></script>

<!-- 表格 -->
<script  src="js/table/jquery.dataTables.min.js"></script>
<script  src="js/table/dataTables.bootstrap.min.js"></script>

