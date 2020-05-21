<!--#include file="conn.asp"-->
<!--#include file="frame1.asp"-->
<%=returnMain%>

<title>case | 首页</title>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        我的面板
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

<% if request("action") = "save" then
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
rs("userMemo") = request("userMemo")
rs.update
rs.close
set rs = nothing
end if %>


<form id="form1" name="form1" method="post" action="main.asp?action=save">

    <!-- Main content -->
    <section class="content">
      <!-- Small boxes (Stat box) -->
      <div class="row">
	  
	  
	  	<%
		varNoResult = 0 ' 没有执行过的用例数
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_project where pjtStatus='1' order by pjtId desc",conn,3,3
		do while not rs.eof
			set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where plat_pjtId="&rs("pjtId")&" and plat_rptStatus is null order by platformId desc",conn,3,3
			do while not rs1.eof
				set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseUser='"&session("userName")&"' order by caseId desc",conn,3,3
				varRecord = rs2.recordcount
				if varRecord <> 0 then
					do while not rs2.eof
						if rs2("caseResult") <> "ok" or rs2("caseResult") <> "error" then
							varNoResult = varNoResult + 1
						end if 
					rs2.movenext
					loop
				%>
					<div class="col-md-3">		
					 <!-- /.info-box -->
					 <% var1 = int(varNoResult/varRecord*100)%>
					 <% if var1 < 30 then %> 
						  <div class="info-box bg-red">
					 <% elseif  var1 < 80 then %> 
	 					  <div class="info-box bg-yellow">
 					 <% else %> 
	 					  <div class="info-box bg-green">
					 <%end if %>
						<span class="info-box-icon"><i class="ion ion-ios-pricetag-outline"></i></span>
			
						<div class="info-box-content">
						  <span class="info-box-text"><%=rs("pjtName")%> - <%=rs1("platformName")%></span>
						  <span class="info-box-number"><%=varNoResult%> / <%=varRecord%></span>
							
						  <div class="progress">
							<div class="progress-bar" style="width: <%=var1%>%"></div>
						  </div>
							  <span class="progress-description">
								 已完成 <%=var1%>%
							  </span>
						</div>
						<!-- /.info-box-content -->
					  </div>
					</div>
				<% end if 
				varNoResult = 0
			rs1.movenext
			loop
		rs.movenext
		loop%>
		
		</div>
		
<script type="text/javascript" charset="gbk" src="ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="ueditor/ueditor.all.min.js"> </script>	
<script type="text/javascript" charset="gbk" src="ueditor/lang/zh-cn/zh-cn.js"></script>
		<div class="row">
		<div class="col-xs-12">
		<%
		set rs8 = server.createobject("adodb.recordset")
		rs8.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
		userMemo = rs8("userMemo")		
		rs8.close
		set rs8 = nothing
		%>
		<label>我的备忘录</label>
		<script type="text/plain" id="userMemo" style="width:100%; height:400px" name="userMemo"><%=userMemo%></script>	
		<script>var editor_a = UE.getEditor('userMemo');</script>
		</div>
		</div>
	 <br>
	<button type="submit" class="btn btn-primary pull-right" style="margin-right: 5px;"  href="#"><i class="fa fa-angellist"></i> &nbsp;保存</button>
	
    </section>
    <!-- /.content -->
	
	</form>
	
  </div>

</div>
<!-- ./wrapper -->

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
