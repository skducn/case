<!--#include file="frame.asp"-->

<title>执行用例 | <%=cstCompany%></title>
<link href="bootstrap/css/custom.css" rel="stylesheet">

<%
pjtId = request("pjtId")
platformId = request("platformId")
lblId = request("lblId")
%>



<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit text-primary">&nbsp;<%=cstExcCase%></i></h1><p>execute testcase</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#"><%=cstExcCase%></a></li></ul></div>
	</div>
	
	<div class="box box-danger box-solid box-default">
		<div class="box-header with-border">
							</div>
							
<div class="card">
	<div class="row">
		<div class="col-md-12">
			<div class="nav-tabs-custom">
				<ul class="nav nav-tabs pull-right">
				
			
				

			
			<!-- 遍历标签名，默认active第一个标签 -->
			  <%
			  counts = 0
			  Set rs3 = Server.CreateObject("Adodb.Recordset")
			  rs3.Open "select * from tbl_label where lbl_pjtId="&request("pjtId")&" and lbl_platformId="&request("platformId")&" order by lblId asc",conn,3,3
			  varLebelTotal = rs3.recordcount
			  reDim lblId_array(varLebelTotal)  
				
			  ' 多个标签
			  if varLebelTotal > 1 then  
				do while not rs3.eof 		
					lblId_array(counts) = rs3("lblId")
					' rs66.recordcount 获取当前标签 当前环境下的用例数。
					set rs66 = server.createobject("adodb.recordset")
					rs66.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(counts)&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
					
					if rs3("lblId") = int(lblId) then  %>
						<li class="active"><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs3("lblName")%>
						<% if rs66.recordcount >0 then %>
						<span class="label label-success"><%=rs66.recordcount%></span>
						<%end if %>
						</a></li>
					<%else%>
						<li><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs3("lblName")%>
						<% if rs66.recordcount >0 then %>
						<span class="label label-success"><%=rs66.recordcount%></span>
						<%end if %>
						</a></li>
					<%end if 
					counts = counts + 1 
				rs3.movenext
				loop  
			  '1个标签	 
			  elseif varLebelTotal = 1 then
			 	 set rs77 = server.createobject("adodb.recordset")
				 rs77.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
					
			  		lblId_array(counts) = rs3("lblId") %> 
			        <li class="active"><a href="#tab_1-1" data-toggle="tab"><%=rs3("lblName")%>
				    <% if rs77.recordcount >0 then %>
						<span class="label label-success"><%=rs77.recordcount%></span>
					<%end if %>
					</a></li>
				   <%rs77.close%>
			 <%else
			     response.write "no label"
			  end if  %>  
            </ul>
			
		
     <div class="tab-content">
	
	
<% 
varcount = 0
do while varcount < varLebelTotal 
	if lblId_array(varcount) = int(lblId) then %>
		<div class="tab-pane active" id="tab_1-<%=varcount%>">
	<%else%>
		<div class="tab-pane" id="tab_1-<%=varcount%>">
	<%end if %>
	

	<!-- 执行 我的测试用例  绿色色分割线 -->
	<div class="box box-success">
		<div class="box-header with-border">	
			<h3 class="box-title" style="white-space: nowrap;">			
			<!-- 显示项目名 - 平台名 -->
		    <%Set rs4 = Server.CreateObject("Adodb.Recordset")
			rs4.Open "select * from tbl_project where pjtId="&request("pjtId")&" ",conn,3,3
			Set rs5 = Server.CreateObject("Adodb.Recordset")
			rs5.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&"",conn,3,3
			Set rs6 = Server.CreateObject("Adodb.Recordset")
			rs6.Open "select * from tbl_case where case_pjtId="&request("pjtId")&" and case_platformId="&request("platformId")&" and caseCreateUser='"&session("userName")&"' ",conn,3,3%>
			
			<%=rs4("pjtName")%> - <%=rs5("platformName")%> <span class="label label-success"><%=rs6.recordcount%></span>
			<hr>
			<%rs6.close
			rs5.close
			rs4.close%>
			</h3>			
			
			<div class="row">						
				<h4>			
				<% if request("caseStage") = 1 then
					response.write "&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-fire'></i>&nbsp;冒烟测试 "
					elseif request("caseStage") = 2 then
					response.write "&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-ellipsis-h'></i>&nbsp;正式测试"
					else
					response.write "&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-chrome'></i>&nbsp;回归测试"
				end if 
				%>
				</h4>	
				
			<!-- 切换环境 -->	

			<div class="col-md-10">
				<div class="bs-component">
					<ul class="nav nav-pills ">  					
						<li class="active"><a class="dropdown-toggle" data-toggle="dropdown" href="#">切换环境<span class="caret"></span></a>
						<ul class="dropdown-menu">
						<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcase-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-1.html">冒烟测试</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcase-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-2.html">正式测试</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcase-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-3.html">回归测试</a></li>
						</ul>
						</li>
					</ul>
				</div>																							
			</div>
			
			<!-- 执行Ta的用例 -->	

			<div class="col-md-2" align="right">
				<div class="bs-component">
					<ul class="nav nav-pills ">    
						<li class="active"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> 执行Ta的用例<span class="caret"></span></a>
						<ul class="dropdown-menu">
						<%Set rs14 = Server.CreateObject("Adodb.Recordset")
						rs14.Open "select * from tbl_user where userPower=2 and userStatus<>'2' and userName<>'"&session("userName")&"'",conn,3,3
						do while not rs14.eof %>							
							<li role="presentation"><a href="excTestcaseTa-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-<%=request("caseStage")%>-<%=rs14("userName")%>.html"><%=rs14("userNickName")%></a></li>					
						<%rs14.movenext
						loop%>	
						</ul>
						</li>
					</ul>
				</div>
			</div>
						
		</div>
	</div>

	<div class="box-body">
	
	<br />
<% 
set rs6 = server.createobject("adodb.recordset")
rs6.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(varcount)&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
if not rs6.eof then 					
	do while not rs6.eof %>
		<div class="layout clear">
		<dl class="demo-methods">
		<dt1> 
		<span class="code"><span class="self">展开</span>&nbsp;</span>	
		<%=rs6("caseId")%>&nbsp;,
		<%			
		if rs6("caseWebResult") = "ng" then 
			response.write "<font color='red'><i class='fa fa-windows'></i></font> "
		elseif rs6("caseWebResult") = "pass" then 
			response.write "<i class='fa fa-windows'></i> "
		end if 
		
		if rs6("caseIosResult") = "ng" then 
			response.write "<font color='red'><i class='fa fa-apple'></i></font> "
		elseif rs6("caseIosResult") = "pass" then 
			response.write "<i class='fa fa-apple'></i> "
		end if 
		
		if rs6("caseAndroidResult") = "ng" then
			response.write "<font color='red'><i class='fa fa-android'></i></font> "
		elseif rs6("caseAndroidResult") = "pass" then 
		  response.write "<i class='fa fa-android'></i>"
		end if
		
		if rs6("caseCSResult") = "ng" then 
			response.write "<font color='red'><i class='fa fa-archive'></i></font> "
		elseif rs6("caseCSResult") = "pass" then 
			response.write "<i class='fa fa-archive'></i> "
		end if
		
		if rs6("caseDeviceResult") = "ng" then 
			response.write "<font color='red'><i class='fa fa-sitemap'></i></font> "
		elseif rs6("caseDeviceResult") = "pass" then 
			response.write "<i class='fa fa-sitemap'></i> "
		end if
		%>	
			
		&nbsp;<a href="excTestcaseEdit-<%=rs6("caseId")%>.html"><%=rs6("caseTitle")%></a>
	
		<% set rs8 = server.createobject("adodb.recordset")
		rs8.open "select * from tbl_user where userName='"&rs6("caseExcUser")&"' order by userId desc",conn,3,3

		if rs6("caseExcUser") <> rs6("caseExcDate") then 
			if rs6("caseExcUser") <> rs6("caseCreateUser") then %> 
				<font color=blue>（<%=rs8("userNickname")%> 于 <%=rs6("caseExcDate")%> 已执行)</font>
			<%else%>
				（<%=rs6("caseExcDate")%> 已执行）
			<%end if 
		end if 
		rs8.close%>
							
		<%if rs6("caseStatus")=2 then
			response.write "<font color=red><i class='fa fa-hourglass-half'></i></font> "
		elseif rs6("caseStatus")=3 then
			response.write "<font color=red><i class='fa fa-remove'></i></font> "
		end if 	
		
		if rs6("caseExcUser") = "" then
		elseif rs6("caseExcUser") <> rs6("caseCreateUser") then
			set rs17 = server.createobject("adodb.recordset")
			rs17.open "select * from tbl_user where userName='"&rs6("caseExcUser")&"' order by userId desc",conn,3,3
		end if %>
		 
		<br />
		</dt1><dd><pre class="markup"><%=rs6("caseStep")%></pre></dd>
		</dl>
		</div>
	<%rs6.movenext
	loop
end if 
rs6.close
set rs6 = nothing%>



</div>
</div>
</div>  



<% 
varcount = varcount + 1
loop
%> 



	
				</div>
					<div class="col-md-12" align="right">	
					<hr>
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>			
					</div>
			</div>
		</div>
	</div>
</div>





<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="bootstrap/js/jquery.js"></script>  
<script src="bootstrap/js/custom.js?v=0.9.1"></script>

<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>



</body>
</html>
