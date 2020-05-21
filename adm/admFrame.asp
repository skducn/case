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
	<a class="navbar-brand m-0 py-2 brand-title" href="admMain.html">case ��̨</a>
	<a class="navbar-brand py-2 material-icons toggle-sidebar" href="#">menu</a>
	</nav>
	<nav class="navigation" >
		<ul>
			<li class="active"><a href="admMain.html" title="Dashboard"><span class="nav-icon material-icons">dashboard</span> ��Ŀ�嵥</a></li>
			<li title="Theme Settings"><a href="theme-setting.html"><span class="nav-icon material-icons ">color_lens</span>���ⱳ��</a></li>				  				                 
		</ul>


		<!-- ��Ϣ���� -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">message</span>��Ϣ���� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<li><a href="admTaskAdd.html"><span class="nav-icon material-icons">add</span>������Ϣ</a></li>
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>�༭��Ϣ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">			
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_task order by taskId DESC",conn,3,3 
							if rs1.eof then
							response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-maroon'>������</i>"
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
					<li><a href="admTaskList.html"><span class="nav-icon material-icons ">list</span>��Ϣ�б�</a></li>
				</ul>			
			</li>
		</ul>
	  
		
		<!-- ��Ŀ���� -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span>��Ŀ���� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<li><a href="admProjectAdd.html"><span class="nav-icon material-icons">add</span>�½���Ŀ</a></li>
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>�༭��Ŀ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">			
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ</i></a><%
							else
								do while not rs1.eof %>
									<!-- ������Ŀ�� -->
									<li>
										<a href="admProjectEdit-<%=rs1("pjtId")%>.html"><i class="fa fa-circle-o text-red"></i> <%=rs1("pjtName")%> 
										<% if rs1("pjtStatus") = 2 then
											response.write "<span class='label pull-right bg-red'>���رգ�</span>"			
										end if %></a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li>
					
					<!-- ��Ŀ�б� -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">list</span>��Ŀ�б� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">	
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ</i></a><%
							else
								do while not rs1.eof %>
									<!-- ������Ŀ�� -->
									<li>
									<a href="admProjectInfo-<%=rs1("pjtId")%>.html"><%=rs1("pjtName")%> </a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- �鿴��Ŀ over-->										
				</ul>			
			</li>
		</ul>
		
		
		<!-- �汾���� -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">filter_1</span>�汾���� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<!-- �½��汾 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">add</span>�½��汾 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">	
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ</i></a><%
							else
								do while not rs1.eof %>
									<!-- ������Ŀ�� -->
									<li>
									<a href="admPlatformAdd-<%=rs1("pjtId")%>.html"><i class="fa fa-circle-o text-green"></i> <%=rs1("pjtName")%></a>
									</li>
								<%rs1.movenext
								loop
							end if 
							rs1.close
							set rs1 = nothing %>
						</ul>
					</li> <!-- �½��汾 over-->
					
					<!-- �༭�汾 -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>�༭�汾 <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">	
							<%Set rs1 = Server.CreateObject("Adodb.Recordset")
							rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
							if rs1.eof then
								%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ</i></a><%
							else
								do while not rs1.eof %>
									<!-- ��Ŀ�� -->								
									<li class="Form Stuff">
										<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span> <%=rs1("pjtName")%>  <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
										<ul class="sub-nav">											
											<!-- ƽ̨�� -->
											<%Set rs2 = Server.CreateObject("Adodb.Recordset")
											rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
											if rs2.eof then%>
												<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>���½��汾</i></a>
											<%else
												do while not rs2.eof 	%>		
													<!-- ������Ŀ�� -->
													<li>
														<a href="admPlatformEdit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><i class="fa fa-circle-o text-green"></i> <%=rs2("platformName")%> 
														<% if rs2("platformStatus") = 2 then
															response.write "<span class='label pull-right bg-red'>"			
															response.write "���رգ�"
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
					</li> <!-- �༭�汾 over-->
			</ul>
		</li> <!-- �汾���� over-->
		
		
		
		<!-- ��ǩ���� -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">notes</span>��ǩ���� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<!-- �½���ǩ -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">add</span>�½���ǩ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
						if rs1.eof then
							%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ</i></a><%
						else						
							do while not rs1.eof %>
								<!-- ��Ŀ�� -->							
								<li class="Form Stuff">
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
									<ul class="sub-nav">
										<!-- ƽ̨�� -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
										if rs2.eof then%>
											<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>���½��汾</i></a>
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
				</li> <!-- ������ǩ over-->
				
				<!-- �༭��ǩ -->
				<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>�༭��ǩ <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' order by pjtId DESC",conn,3,3 
						if rs1.eof then
							%><a href="admProjectAdd.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ</i></a><%
						else
							do while not rs1.eof %>
								<!-- ��Ŀ�� -->
								<li class="Form Stuff">
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
									<ul class="sub-nav">
										<!-- ƽ̨�� -->
										<%Set rs2 = Server.CreateObject("Adodb.Recordset")
										rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
										if rs2.eof then%>
											<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>���½��汾</i></a>											
										<%else
											do while not rs2.eof  %>												
												<li class="Form Stuff">
									<a href="#" title=""><span class="nav-icon material-icons ">filter_1</span><%=rs2("platformName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
									<ul class="sub-nav">
									
													<%								
													Set rs3 = Server.CreateObject("Adodb.Recordset")
													rs3.Open "select * from tbl_label where lbl_pjtId="&rs1("pjtId")&" and lbl_platformId="&rs2("platformId")&" order by lblId DESC",conn,3,3 
													if rs3.eof then%>
														<a href="admLabelAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-yellow'>������ǩ</i></a>
													<%else
														do while not rs3.eof 
														' ������ǩ%>
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
				</li> <!-- �༭��ǩ over-->
			</ul>
		</li>
		<!-- ��ǩ���� over-->

		
		<!-- �ƻ����� -->
		
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">date_range</span>�ƻ����� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<!-- �½���ǩ -->
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">add</span>�½��ƻ� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
				<%Set rs1 = Server.CreateObject("Adodb.Recordset")
				rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' and pjtIsPlan='off'  order by pjtId DESC",conn,3,3 
				if rs1.eof then
					%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ���汾</i><%
				else
					do while not rs1.eof %> <!-- ������Ŀ�� -->								
							<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and platformStatus='1' order by platformId DESC",conn,3,3 
							if rs2.eof then%>								
								<a href="admPlatformAdd-<%=rs1("pjtId")%>.html">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-green'>���½��汾</i></a>
							<%else
								do while not rs2.eof%>	<!-- �����汾 -->																						
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
				<!-- �½��ƻ� over-->
				
				<!-- �༭�ƻ� -->
				<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">edit</span>�༭�ƻ� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
				<%Set rs1 = Server.CreateObject("Adodb.Recordset")
				rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on' order by pjtId DESC",conn,3,3 
				if not rs1.eof then
					
					do while not rs1.eof %>	<!-- ������Ŀ -->																																				
						
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" order by planId DESC",conn,3,3 
							if rs2.recordcount <>0 then%>							
								
								
								<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
									<%Set rs3 = Server.CreateObject("Adodb.Recordset")
									rs3.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and verIsPlan='on' and platformStatus='1' order by platformId DESC",conn,3,3 
									if rs3.eof then
										response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>�ް汾</i>"
									else
										do while not rs3.eof%>	<!-- �����汾 -->																						
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
				<!-- �༭�ƻ� over-->

				<!-- �ƻ��б� -->
			
				<li class="Form Stuff">
					<a href="#" title=""><span class="nav-icon material-icons ">list</span>�ƻ��б� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_project where pjtStatus='1' and pjtIsVer='on'  order by pjtId DESC",conn,3,3 
						if not rs1.eof then
					
					do while not rs1.eof %>	<!-- ������Ŀ -->																																				
					
							<%Set rs2 = Server.CreateObject("Adodb.Recordset")
							rs2.Open "select * from tbl_plan where plan_pjtId="&rs1("pjtId")&" order by planId DESC",conn,3,3 
							if rs2.recordcount <>0 then%>							
								
								
									<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
						<ul class="sub-nav">
									<%Set rs3 = Server.CreateObject("Adodb.Recordset")
									rs3.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" and verIsPlan='on' and platformStatus='1' order by platformId DESC",conn,3,3 
									if rs3.eof then
										response.write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-aqua'>�ް汾</i>"
									else
										do while not rs3.eof%>	<!-- �����汾 -->																						
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
				<!-- �鿴�ƻ� over-->
			</ul>
		</li> 
		<!-- �ƻ����� over-->
		
		
		<!-- ���Ա������ -->
		<ul class="sub-nav">		
			<li >
				<a href="#" title=""><span class="nav-icon material-icons ">book</span>������� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
				<ul class="sub-nav">	
					<li class="Form Stuff">
						<a href="#" title=""><span class="nav-icon material-icons ">bookmarks</span>��˱��� 
					<!-- ��ʾ����˵ı������� -->
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
							%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa text-red'>���½���Ŀ���汾</i><%
						else
							do while not rs1.eof %>
							<!-- ��Ŀ�� -->
							<li class="Form Stuff">
								<%  ' ��ʾ����˵ı������� , δ��˵İ汾����Ŀ��Ϊ��ɫ
								Set rs5 = Server.CreateObject("Adodb.Recordset")
								rs5.Open "select * from tbl_report where rptStatus='undone' and rpt_pjtId="&rs1("pjtId")&" order by rptId DESC",conn,3,3 
								noAudit = rs5.recordcount 
								rs5.close 
								if noAudit > 0 then%>
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
								<%else%>
									<a href="#" title=""><span class="nav-icon material-icons ">table_chart</span><%=rs1("pjtName")%> <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
								<%end if %>
							
								<!-- ƽ̨�� -->
								<ul class="sub-nav">	
									<%Set rs2 = Server.CreateObject("Adodb.Recordset")
									rs2.Open "select * from tbl_platform where plat_pjtId="&rs1("pjtId")&" order by platformId DESC",conn,3,3 
									if rs2.eof then
										response.write "�ް汾"
									else
										do while not rs2.eof 						
											Set rs5 = Server.CreateObject("Adodb.Recordset")
											rs5.Open "select * from tbl_report where rpt_pjtId="&rs1("pjtId")&" and rpt_platformId="&rs2("platformId")&" order by rptId DESC",conn,3,3 
											if not rs5.eof then
												if rs5("rptStatus") = "done" then %>
													<li><a href="admReportAudit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%> &nbsp;&nbsp;(����ɣ�</a></li>      				
												<%elseif rs5("rptStatus") = "reject" then %>
													<li><a href="admReportAudit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%> &nbsp;&nbsp;<font color="white">(�Ѿܾ���</font></a></li>    
												<%else %>
													<li><a href="admReportAudit-<%=rs1("pjtId")%>-<%=rs2("platformId")%>.html"><%=rs2("platformName")%>&nbsp;&nbsp;<font color="white">������ˣ�</font> </a></li    
												><%end if 
											end if
											rs5.close			
										rs2.movenext
										loop						
									end if 
									rs2.close
									set rs2 = nothing%>
								</ul><!-- .ƽ̨�� over-->
							</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul><!-- .treeview-menu2 over-->
				</li> <!-- ��˱��� over-->
				
			</ul>
		</li> 
		<!-- ���Ա������ over-->

		
		
		<!-- �û����� -->
		
		<li >
			<a href="#" title=""><span class="nav-icon material-icons ">perm_identity</span>�û����� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
			<ul class="sub-nav">	
				<li><a href="admUserAdd.html"><span class="nav-icon material-icons">add</span>�����û�</a></li>
				<li class="Form Stuff">
					<a href="#" title=""><span class="nav-icon material-icons ">edit</span>�༭�û� <span class="toogle-sub-nav material-icons">keyboard_arrow_right</span></a>
					<ul class="sub-nav">
						<%Set rs1 = Server.CreateObject("Adodb.Recordset")
						rs1.Open "select * from tbl_user order by userId DESC",conn,3,3 
						if rs1.eof then
							response.write "���û�"
						else
							do while not rs1.eof %>
								<!-- �����û��� -->
								<li>
								<a href="admUserEdit-<%=rs1("userId")%>.html"><i class="fa fa-circle-o text-aqua"></i> <%=rs1("userNickname")%>
								<% if rs1("userStatus") = 2 then
										response.write "<span class='label pull-right bg-red'>"			
										response.write "���رգ�"
										response.write "</span>"
									end if %></a>
								</li>
							<%rs1.movenext
							loop
						end if 
						rs1.close
						set rs1 = nothing %>
					</ul>
				</li> <!-- .treeview�༭�� over-->
			</ul>
		</li> <!-- �û����� over-->
		
			 <ul>
                 <li><a href="admMainExit.html" onClick="return confirm('�Ƿ������˳�ϵͳ��')"><span class="nav-icon material-icons">exit_to_app</span> �˳�</a></li>           
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
							<a class="dropdown-item" href="admProfile.html">�����˺�</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item" href="admMainExit.html" onClick="return confirm('�Ƿ������˳�ϵͳ��')">�˳�</a>
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
