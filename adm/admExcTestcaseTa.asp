<!--#include file="admFrame.asp"-->

<title><%=cstCompany%> | 执行Ta的用例</title>
<link href="../bootstrap/css/custom.css" rel="stylesheet">


<%
pjtId = request("pjtId")
platformId = request("platformId")
lblId = request("lblId")
user = request("user")
caseStage = request("caseStage")
%>



<div class="content-wrapper">
<section class="content-header">
	<h1>
		<!-- 执行XXX用例 -->
		<% 
		Set rs = Server.CreateObject("Adodb.Recordset")
		rs.Open "select * from tbl_user where userName='"&user&"'",conn,3,3
		response.write "执行<" &rs("userNickname")& ">的测试用例"
		rs.close
		%>
		
		<small>
		<!-- 项目名-版本 -->
		<%
		Set rs1 = Server.CreateObject("Adodb.Recordset")
		rs1.Open "select * from tbl_project where pjtId="&pjtId&" ",conn,3,3%>
		<%Set rs2 = Server.CreateObject("Adodb.Recordset")
		rs2.Open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" ",conn,3,3
		
		' 统计XXX用例个数
		Set rs3 = Server.CreateObject("Adodb.Recordset")				
		rs3.Open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" and caseCreateUser='"&user&"'",conn,3,3 %>
		<i class="fa fa-edit text-green"></i> <%=rs1("pjtName")%>&nbsp;<%=rs2("platformName")%>&nbsp;&nbsp;<span class="label label-success"><%=rs3.recordcount%></span>
		<%rs3.close
		rs2.close
		rs1.close%>
		</small>
	</h1>
	<ol class="breadcrumb">
		<li><a href="admMain.html"><i class="fa fa-align-justify"></i> Home</a></li>
	</ol>
</section>

<section class="content">
	<div class="row">
	    <div class="col-md-12">
    	    <div class="nav-tabs-custom">
        	    <ul class="nav nav-tabs pull-right">			
					<!-- 遍历标签名，默认active第一个标签 -->
					<%
					counts = 0
					Set rs4 = Server.CreateObject("Adodb.Recordset")
					rs4.Open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3
					varLebelTotal = rs4.recordcount
					reDim lblId_array(varLebelTotal)  
					
					' 多个标签
					if varLebelTotal > 1 then  
						do while not rs4.eof 		
							lblId_array(counts) = rs4("lblId")
							' 获取当前标签 当前环境下的用例数。
							set rs5 = server.createobject("adodb.recordset")
							rs5.open "select * from tbl_case where caseStage="&caseStage&" and case_lblId="&lblId_array(counts)&" and caseCreateUser='"&user&"' order by caseId desc",conn,3,3
							
							if rs4("lblId") = int(lblId) then  %>
								<li class="active"><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs4("lblName")%>
								<% if rs5.recordcount >0 then %>
								<span class="label label-success"><%=rs5.recordcount%></span>
								<%end if %>
								</a></li>
							<%else%>
								<li><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs4("lblName")%>
								<% if rs5.recordcount >0 then %>
								<span class="label label-success"><%=rs5.recordcount%></span>
								<%end if %>
								</a></li>
							<%end if 
							counts = counts + 1 
							rs5.close
						rs4.movenext
						loop  
					'1个标签	 
					elseif varLebelTotal = 1 then
						set rs6 = server.createobject("adodb.recordset")
						rs6.open "select * from tbl_case where caseStage="&caseStage&" and case_lblId="&lblId&" and caseCreateUser='"&user&"' order by caseId desc",conn,3,3
						lblId_array(counts) = rs4("lblId")%> 
						<li class="active">
							<a href="#tab_1-1" data-toggle="tab"><%=rs4("lblName")%>
							<%if rs6.recordcount >0 then %>
								<span class="label label-success"><%=rs6.recordcount%></span>
							<%end if %>
							</a>
						</li>
						<%rs6.close%>
					<%else
					 	response.write "无标签"
					end if  
					rs4.close%>          
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
	

			
			<div class="box">
				<div class="box-header with-border">
					<div class="row">
						<div class="col-lg-2">
							<h3 class="box-title" style="white-space: nowrap;">
							<% if caseStage = "1" then
								response.write "<i class='fa fa-fire'></i>&nbsp;冒烟测试 "
							elseif caseStage = "2" then
								response.write "<i class='fa fa-ellipsis-h'></i>&nbsp;正式测试"
							else
								response.write ("<i class='fa fa-chrome'></i>&nbsp;回归测试")
							end if  
							%>
							</h3>
						</div><!-- /.col-lg-2 -->
					
						<div class="col-lg-2" style="white-space: nowrap;">		
							<div class="dropdown">
								<a class="dropdown-toggle" data-toggle="dropdown" href="#" nowrap="nowrap">
								切换环境 <span class="caret"></span>
								</a>
								<ul class="dropdown-menu" style="white-space: nowrap;">
								<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcaseTa-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-1-<%=request("user")%>.html">冒烟测试</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcaseTa-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-2-<%=request("user")%>.html">正式测试</a></li>
								<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcaseTa-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-3-<%=request("user")%>.html">回归测试</a></li>
								</ul>
							</div>
						</div><!-- /.col-lg-2 -->		
					</div><!-- /.row -->
				</div><!-- /.box-header with-border -->
				
				<div class="box-body">	
				<br />
	
				<% '显示XX组员的测试用例，已执行的用例不显示
				set rs7 = server.createobject("adodb.recordset")
				rs7.open "select * from tbl_case where caseStage="&caseStage&" and case_lblId="&lblId_array(varcount)&" and caseCreateUser='"&user&"' and caseResult='empty' order by caseId desc",conn,3,3
				if not rs7.eof then 					
					do while not rs7.eof%>
						<div class="layout clear">
							<dl class="demo-methods">
							<dt1> 
							<span class="code"><span class="self">展开</span>&nbsp;</span>	
							<%=rs7("caseId")%> ,&nbsp;  			
							<%if rs7("caseStatus")=2 then
								response.write "<i class='fa fa-hourglass-half text-red'></i>"
							elseif rs7("caseStatus")=3 then
								response.write "<i class='fa fa-remove text-red'></i>"
							end if 		
							if rs7("caseWebResult") = "ng" then 
								response.write "<i class='fa fa-windows text-red'></i>"
							elseif rs7("caseWebResult") = "pass" then 
								response.write "<i class='fa fa-windows text-green'></i> "
							end if 
							if rs7("caseIosResult") = "ng" then 
								response.write "<i class='fa fa-apple text-red'></i>"
							elseif rs7("caseIosResult") = "pass" then 
								response.write "<i class='fa fa-apple text-green'></i> "
							end if 
							if rs7("caseAndroidResult") = "ng" then
								response.write "<i class='fa fa-android text-red'></i>"
							elseif rs7("caseAndroidResult") = "pass" then 
								response.write "<i class='fa fa-android text-green'></i> "
							end if
							if rs7("caseCSResult") = "ng" then 
								response.write "<i class='fa fa-archive text-red'></i>"
							elseif rs7("caseCSResult") = "pass" then 
								response.write "<i class='fa fa-archive text-green'></i> "
							end if
							if rs7("caseDeviceResult") = "ng" then 
								response.write "<i class='fa fa-sitemap text-red'></i>"
							elseif rs7("caseDeviceResult") = "pass" then 
								response.write "<i class='fa fa-sitemap text-green'></i> "
							end if%>	
							
							&nbsp;<a href="excTestcaseEditTa-<%=rs7("caseId")%>-<%=rs7("caseCreateUser")%>.html"><%=rs7("caseTitle")%></a>
							<%set rs8 = server.createobject("adodb.recordset")			
							rs8.open "select * from tbl_user where userName='"&rs7("caseCreateUser")&"' order by userId desc",conn,3,3
							if rs7("caseExcUser") = "" then
								response.write "（"&rs8("userNickName")&"）"
							elseif rs7("caseExcUser") <> rs7("caseCreateUser") then
								set rs9 = server.createobject("adodb.recordset")
								rs9.open "select * from tbl_user where userName='"&rs7("caseExcUser")&"' order by userId desc",conn,3,3
								response.write "（"&rs9("userNickName")&" 代）"
								rs9.close
							else
								response.write "（"&rs8("userNickName")&"）"
							end if 
							rs8.close%>
							<br />
							</dt1><dd><pre class="markup"><%=rs7("caseStep")%></pre></dd>
							</dl>
						</div>
					<%rs7.movenext
					loop
				end if 	
				rs7.close
				set rs7 = nothing%>
			
			</div>
		</div>
	</div>  

<% 
varcount = varcount + 1
loop
%> 


提示：组员已执行完的用例将不作显示。
</div>
</div>
</div>


</div>
</section>

</div>


<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="../bootstrap/js/jquery.js"></script>  
<script src="../bootstrap/js/custom.js?v=0.9.1"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="../plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="../plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="../plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="../plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>



</body>
</html>
