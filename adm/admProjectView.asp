<!--#include file="admFrame.asp"-->

<title>查看项目 | <%=admProject%></title>

<div class="content-wrapper">
	<section class="content-header">
	<h1>
	系统面板
	<small>System panel</small>
	</h1>
	<ol class="breadcrumb">
	<li><a href="admMain.html"><i class="fa fa-dashboard"></i> Home</a></li>
	</ol>
	</section>
	
<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId="&request("pjtId")&"",conn,3,3
%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-danger box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title">查看项目</h3> <a href="admProjectEdit-<%=request("pjtId")%>.html">(编辑)</a>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					
					<!-- text input -->
					
					<div class="col-xs-3">
						<div class="form-group">
						<label>项目名称 *</label>
						<input type="text" name="pjtName"   maxlength="16" class="form-control"  placeholder="<%=rs("pjtName")%>" disabled>
						</div>
					</div>
					
						<!-- radio -->
					<div class="col-xs-3">
						<div class="form-group">
							<label>项目状态</label>
							<% if rs("pjtStatus") = 1 then %>
								<div class="radio"><label><input type="radio" name="pjtStatus" value="1" checked>开启</label></div>
							<% elseif rs("pjtStatus") = 2 then %>
								<div class="radio"><label><input type="radio" name="pjtStatus"  value="2" checked>关闭</label>	</div>
							<%end if %>
						</div>
					</div>
					
					
					<div class="col-xs-6">
						<!-- 测试对象 -->
						<div class="form-group">
					
						<% '获取测试对象数量
						'rc=len(rs("pjtObject"))-len(replace(rs("pjtObject"),",",""))
		%>
							<label>默认测试对象</label>
							<div class="checkbox">
							<%if Instr(rs("pjtObject"), "web")>0 then%>
								<label><input type="checkbox" name="checkbox1" checked="checked"><i class="fa fa-windows"></i> B/S（web平台）</label>
							<%else%>
								<label><input type="checkbox" name="checkbox1" ><i class="fa fa-windows"></i> B/S（web平台）</label>
							<%end if %>
							</div>
						
							<div class="checkbox">
							<%if Instr(rs("pjtObject"), "iOS")>0 then%>
								<label><input type="checkbox" name="checkbox2" checked="checked"><i class="fa fa-apple"></i> iOS（APP平台）</label>
							<%else%>
								<label><input type="checkbox" name="checkbox2" ><i class="fa fa-apple"></i> iOS（APP平台）</label>
							<%end if %>
							</div>
						
							<div class="checkbox">
							<%if Instr(rs("pjtObject"), "android")>0 then%>
								<label><input type="checkbox" name="checkbox3" checked="checked"><i class="fa fa-android"></i> android（APP平台）</label>
							<%else%>
								<label><input type="checkbox" name="checkbox3" ><i class="fa fa-android"></i> android（APP平台）</label>
							<%end if %>
							</div>
					
							<div class="checkbox">
							<%if Instr(rs("pjtObject"), "CS")>0 then%>
								<label><input type="checkbox" name="checkbox4" checked="checked"><i class="fa fa-archive"></i> C/S（web客户端程序，如.exe文件）</label>
							<%else%>
								<label><input type="checkbox" name="checkbox4" ><i class="fa fa-archive"></i> C/S（web客户端程序，如.exe文件）</label>
							<%end if %>
							</div>
							
							<div class="checkbox">
							<%if Instr(rs("pjtObject"), "device")>0 then%>
								<label><input type="checkbox" name="checkbox5" checked="checked"><i class="fa fa-sitemap"></i> device（外置设备，如终端机、高拍仪等）</label>
							<%else%>
								<label><input type="checkbox" name="checkbox5" ><i class="fa fa-sitemap"></i> device（外置设备，如终端机、高拍仪等）</label>
							<%end if %>
							</div>
						</div>
					</div>
					
					
					
					
					<div class="col-xs-12">
						<div class="form-group">
						<label>项目信息</label>
						<script type="text/plain" id="pjtIntro" style="width:100%; height:200px" name="pjtIntro"><%=rs("pjtIntro")%></script>	
						<script>var editor_a = UE.getEditor('pjtIntro');</script>
						</div>
					</div>
					
					<div class="col-xs-3">
						<div class="form-group">
						<label>服务器IP</label>
						<input type="text" name="pjtDBServer"   maxlength="15" class="form-control"  placeholder="<%=rs("pjtDBServer")%>" disabled>
						</div>
					</div>
					
					<div class="col-xs-3">
						<div class="form-group">
						<label>数据库</label>
						<input type="text" name="pjtDBDatabase"   maxlength="15" class="form-control"  placeholder="<%=rs("pjtDBDatabase")%>" disabled>
						</div>
					</div>
					
					<div class="col-xs-3">
						<div class="form-group">
						<label>用户名</label>
						<input type="text" name="pjtDBUser"   maxlength="15" class="form-control"  placeholder="<%=rs("pjtDBUser")%>" disabled>
						</div>
					</div>
					
					<div class="col-xs-3">
						<div class="form-group">
						<label>密码</label>
						<input type="text" name="pjtDBPassword"   maxlength="15" class="form-control"  placeholder="<%=rs("pjtDBPassword")%>" disabled>
						</div>
					</div>

					<div class="col-xs-12">
					<a href="admProjectEdit-<%=request("pjtId")%>.html"><button type="button" class="btn btn-danger pull-right" href="#"><i class="fa fa-angellist"></i> &nbsp;编辑</button></a>
					<br><br>
					</div>
			
				</div>
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
</section><!-- /.content -->
	

</div>
<!-- ./wrapper -->

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

</body>
</html>


