<!--#include file="frame.asp"-->

<title><%=cstCompany%> | 执行Ta的用例</title>
<link href="bootstrap/css/custom.css" rel="stylesheet">


<div class="content-wrapper">
    <section class="content-header">
      <h1>
        执行 Ta的测试用例
		<small>冒烟、正式、回归测试</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="main.asp"><i class="fa fa-align-justify"></i> Home</a></li>
       
      </ol>
    </section>


<section class="content">
	<div class="row">
    <div class="col-md-12">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs pull-right">
			
			<!-- 遍历标签名，默认active第一个标签 -->
			  <%
			  pjtId = request("pjtId")
			  platformId = request("platformId")
			  lblId = request("lblId")
			  counts = 0
			  Set rs3 = Server.CreateObject("Adodb.Recordset")
			  rs3.Open "select * from tbl_label where lbl_pjtId="&request("pjtId")&" and lbl_platformId="&request("platformId")&" order by lblId asc",conn,3,3
			  
			 ' response.write rs3("lblId")
			 ' response.write lblId
			 ' response.End()
			  varLebelTotal = rs3.recordcount
			  reDim lblId_array(varLebelTotal)  
				
			  ' 多个标签
			  if varLebelTotal > 1 then  
				do while not rs3.eof 		
					lblId_array(counts) = rs3("lblId")
					' rs66.recordcount 获取当前标签 当前环境下的用例数。
					set rs66 = server.createobject("adodb.recordset")
					rs66.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(counts)&" and caseUser<>'"&session("userName")&"' order by caseId desc",conn,3,3
					
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
				   rs77.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId&" and caseUser<>'"&session("userName")&"' order by caseId desc",conn,3,3
			  	   lblId_array(counts) = rs3("lblId")%> 
			       <li class="active"><a href="#tab_1-1" data-toggle="tab"><%=rs3("lblName")%>
				   <% if rs77.recordcount >0 then %>
					<span class="label label-success"><%=rs77.recordcount%></span>
					<%end if %>
					</a></li>
			 <%else
			     response.write "no label"
			  end if  %>
			  
			  <!-- 显示项目名 - 平台名 -->
			  <%Set rs4 = Server.CreateObject("Adodb.Recordset")
				rs4.Open "select * from tbl_project where pjtId="&request("pjtId")&" ",conn,3,3%>
			  <%Set rs5 = Server.CreateObject("Adodb.Recordset")
				rs5.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&" ",conn,3,3
				Set rs6 = Server.CreateObject("Adodb.Recordset")
   			    rs6.Open "select * from tbl_case where case_pjtId="&request("pjtId")&" and case_platformId="&request("platformId")&" and caseResult='empty' and caseStatus='1' ",conn,3,3%>
          		<li class="pull-left header"><i class="fa fa-th"></i><%=rs4("pjtName")%> - <%=rs5("platformName")%> <span class="label label-info">未处理：<%=rs6.recordcount%></span></li>
				<%rs6.close
				rs5.close
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
	



	<!-- 执行 我的测试用例  橘黄色分割线 -->
	<div class="box">
		<div class="box-header with-border">
			<div class="row">
				<div class="col-lg-1">
					<h3 class="box-title" style="white-space: nowrap;">
					<% if request("caseStage") = 1 then
						response.write "<i class='fa fa-fire'></i>&nbsp;冒烟测试 "
					elseif request("caseStage") = 2 then
						response.write "<i class='fa fa-ellipsis-h'></i>&nbsp;正式测试"
					else
						response.write ("<i class='fa fa-chrome'></i>&nbsp;回归测试")
					end if  
					%>
					</h3>
				</div>
			
				<div class="col-lg-10">
				<!-- 切换环境 -->
					<div class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#" nowrap="nowrap">
						切换环境 <span class="caret"></span>
						</a>
						<ul class="dropdown-menu" style="white-space: nowrap;">
						<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcaseTaReport.asp?pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId_array(varcount)%>&caseStage=1">冒烟测试</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcaseTaReport.asp?pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId_array(varcount)%>&caseStage=2">正式测试</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="excTestcaseTaReport.asp?pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId_array(varcount)%>&caseStage=3">回归测试</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-1" style="white-space: nowrap;">
				<a href="excTestcase.asp?pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId_array(varcount)%>&caseStage=<%=request("caseStage")%>"> 我的用例</a>
				</div>
			</div>
		</div>
	<!-- /.box-header -->
	<div class="box-body">
	
	<br />
<% 
set rs6 = server.createobject("adodb.recordset")
rs6.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(varcount)&" and caseUser<>'"&session("userName")&"' order by caseId desc",conn,3,3
if not rs6.eof then 					
	do while not rs6.eof%>
		<div class="layout clear">
			<dl class="demo-methods">
			<dt1> 
			<span class="code"><span class="self">展开</span>&nbsp;</span>	
			<%=rs6("caseId")%> ,&nbsp;  
			
			  <%if rs6("caseStatus")=2 then
	response.write "(<i class='fa fa-hourglass-half text-red'></i>)"
	elseif rs6("caseStatus")=3 then
	response.write "(<i class='fa fa-remove text-red'></i>)"
	end if 	

   if rs6("caseWebResult") = "ng" then 
   response.write "<i class='fa fa-windows text-red'></i>"
   elseif rs6("caseWebResult") = "pass" then 
   response.write "<i class='fa fa-windows text-green'></i> "
   end if 
   
   if rs6("caseIosResult") = "ng" then 
   response.write "<i class='fa fa-apple text-red'></i>"
   elseif rs6("caseIosResult") = "pass" then 
   response.write "<i class='fa fa-apple text-green'></i> "
   end if 
   
   if rs6("caseAndroidResult") = "ng" then
   response.write "<i class='fa fa-android text-red'></i>"
   elseif rs6("caseAndroidResult") = "pass" then 
   response.write "<i class='fa fa-android text-green'></i> "
   end if
   
   if rs6("caseCSResult") = "ng" then 
   response.write "<i class='fa fa-archive text-red'></i>"
   elseif rs6("caseCSResult") = "pass" then 
   response.write "<i class='fa fa-archive text-green'></i> "
   end if
   
   if rs6("caseDeviceResult") = "ng" then 
   response.write "<i class='fa fa-sitemap text-red'></i>"
   elseif rs6("caseDeviceResult") = "pass" then 
   response.write "<i class='fa fa-sitemap text-green'></i> "
   end if
%>	
			
			&nbsp;<a href="excTestcaseEditTa.asp?caseId=<%=rs6("caseId")%>"><%=rs6("caseTitle")%></a>
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
</div>
</div>


</div>
</section>
</div>


<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="bootstrap/js/jquery.js"></script>  
<script src="bootstrap/js/custom.js?v=0.9.1"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>



</body>
</html>
