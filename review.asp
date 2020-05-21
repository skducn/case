<!--#include file="reviewframe.asp"-->

<title><%=cstCompany%> | 评审用例</title>
<link href="bootstrap/css/custom.css" rel="stylesheet">

<!--  提交评审用例	-->

<% if request("action")="submit" then 
	platformId = split(request("platformId"),",")
	platformReview = split(request("platformReview"),",")
	x = ubound(split(request("x"),",")) + 1
	for a=1 to x
		set rs = server.CreateObject("ADODB.RecordSet")
		rs.Open "select * from tbl_platform where platformId="&platformId(a-1)&" order by platformId desc",conn,3,3	
		rs("platformReview") = ltrim(platformReview(a-1))
		rs("platformReviewStatus") = request("platformReviewStatus" + cstr(a))
		rs.update
		rs.close
		set rs = nothing 
	next 
	response.Redirect("review.html")
end if 
%>



<div class="content-wrapper">
	<section class="content-header">
		<h1> 评审用例<small>Review Testcase</small></h1>
		<ol class="breadcrumb">
			<li><a href="review.html"><i class="fa fa-align-justify"></i> Home</a></li>
		</ol>
	</section>
	
	<form id="form1" name="form1" method="post" action="review.asp?action=submit">
	
	<!-- Main content -->
	<section class="content">
		<button type="submit" class="btn btn-primary " style="margin-left: 5px;"  href="#">提交</button> 
		<br><br>
		
		<div class="row">
		
			<%
			varNoResult = 0 
			x = 0
			set rs = server.createobject("adodb.recordset")
			rs.open "select * from tbl_project where pjtStatus='1' order by pjtId desc",conn,3,3
			do while not rs.eof
				set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tbl_platform where plat_pjtId="&rs("pjtId")&" and platformStatus='1' and plat_rptStatus is null order by platformId desc",conn,3,3
				do while not rs1.eof
					x = x + 1
					set rs2 = server.createobject("adodb.recordset")
					rs2.open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&"  order by caseId desc",conn,3,3
					varRecord = rs2.recordcount
					if varRecord <> 0 then
						do while not rs2.eof
							if rs2("caseResult") <> "empty" or rs2("caseStatus") <> "1" then
							varNoResult = varNoResult + 1
							end if 
						rs2.movenext
						loop %>
		
						<div class="col-xs-6">	
							<% if rs1("platformReviewStatus") = "1" then %>	<div class="info-box bg-green">
							<%else%><div class="info-box bg-red">
							<%end if %>			
								<div class="col-xs-6">
									<div class="form-group">
									<span class="info-box-number"><%=rs("pjtName")%><%=rs1("platformName")%>  (<%=varNoResult%> / <%=varRecord%>)</span>
									</div>
								</div>
								<div class="col-xs-6">
									<div class="form-group">
										<% if rs1("platformReviewStatus") = "1" then %>
											<div class="radio"><label><input type="radio" name="platformReviewStatus<%=x%>" value="1" checked>评审通过</label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="platformReviewStatus<%=x%>" value="2">未通过</label>	
											</div>																								
										<% elseif rs1("platformReviewStatus") = "2" then %>
											<div class="radio"><label><input type="radio" name="platformReviewStatus<%=x%>" value="1" >评审通过</label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="platformReviewStatus<%=x%>" value="2" checked>未通过</label>
											</div>
										<%else%>
											<div class="radio"><label><input type="radio" name="platformReviewStatus<%=x%>" value="1" >评审通过</label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="platformReviewStatus<%=x%>"  value="2" checked>未通过</label>
											</div>
										<%end if%>
									</div>
								</div>
								<textarea  name="platformReview" class="form-control" rows="15" placeholder="Enter ..."><%=rs1("platformReview")%></textarea>
								<input name="x" type="hidden" value="<%=x%>" />
								<input name="platformId" type="hidden" value="<%=rs1("platformId")%>" />
							</div>
						</div><!-- /.col-xs-6 -->

					<% end if 
					varNoResult = 0
				rs1.movenext
				loop
			rs.movenext
			loop%>		
		</div><!-- /.row -->
		
		<button type="submit" class="btn btn-primary " style="margin-left: 5px;"  href="#">提交</button>
		
	</section>	
	</form>
	
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
