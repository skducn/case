<!--#include file="frame.asp"-->

<title><%=cstCompany%> | 消息列表</title>
<link href="../bootstrap/css/custom.css" rel="stylesheet">


<div class="content-wrapper">
	<section class="content-header">
	<h1>
	消息管理
	<small>Message panel</small>
	</h1>
	<ol class="breadcrumb">
	<li><a href="main.asp"><i class="fa fa-align-justify"></i> Home</a></li>
	</ol>
	</section>


<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box  box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title">消息列表</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">

						<!-- /.box-header -->
						<div class="box-body">
							<table id="example2" class="table table-bordered table-hover">
							<thead>
							<tr>
					
							</tr>
							</thead>
							<tbody>
		
							<% 
							set rs = server.createobject("adodb.recordset")
							rs.open "select * from tbl_task where taskTo='all' or taskTo='"&session("userName")&"' order by taskId DESC" ,conn,3,3
							do while not rs.eof
							 
							 %>
								<tr>	
								<td>		
								<dl class="demo-methods">
									<dt1>
										<span class="self STYLE1">展开</span>&nbsp;<%=rs("taskId")%> , <%=rs("taskName")%>
									</dt1>
									<dd>
										<pre class="markup"><%=rs("taskContent")%></pre>
									</dd>
								</dl>		
								</td>								
						
								</tr>
							<% 
							  
							  rs.movenext
							  loop
							  rs.close
							  set rs = nothing
							  %>
								</tbody>
								<tfoot>
								</tfoot>
								</table>		
							</div>
				
					
				</div>
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
</section><!-- /.content -->
	

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
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="bootstrap/js/jquery.js"></script>  
<script src="bootstrap/js/custom.js?v=0.9.1"></script>
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
<!-- Morris.js charts -->
<script src="bootstrap/js/raphael-min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="bootstrap/js/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

</body>
</html>


