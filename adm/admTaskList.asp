<!--#include file="admFrame.asp"-->

<title>��̨-��Ϣ�б� | <%=cstCompany%></title>

<div class="content-wrapper">
	<section class="content-header">
	<h1>��Ϣ����<small>Message panel</small></h1>
	<ol class="breadcrumb"><li><a href="admMain.html"><i class="fa fa-align-justify"></i> Home</a></li></ol>
	</section>


<!-- ��� չ�� -->
<link href="../bootstrap/css/custom.css" rel="stylesheet">


<!--  �½�����	-->

<% 
if request("action") = "submit" then    
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_task",conn,3,3
	rs.addnew
	rs("taskName") = request("taskName")
	rs("taskContent") = request("taskContent")
	rs("taskTo") = request("taskTo")
	rs("taskFrom") = session("userName")
	rs("taskCreatedDate") = now
	rs.update
	rs.close
	set rs = nothing 
	response.Write("<script>;alert('�����ɹ�');window.location.href='admTaskList.html';</script>")
end if 
%>



<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box  box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title">��Ϣ�б�</h3> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; >> &nbsp;&nbsp;&nbsp;&nbsp;<a href="admTaskAdd.html">�½��б�</a>
				</div>
				<!-- /.box-header -->
				<div class="box-body">

						<div class="box-body">
							<table id="example2" class="table table-bordered table-hover">
							<thead>
							<tr>
							</tr>
							</thead>
							<tbody>
		
							<% 
							set rs = server.createobject("adodb.recordset")
							rs.open "select * from tbl_task order by taskId DESC" ,conn,3,3
							do while not rs.eof
							 
							 %>
								<tr>	
								<td>		
								<dl class="demo-methods">
									<dt1>
										<% if rs("taskTo") = "all" then%>
											<span class="self STYLE1">չ��</span>&nbsp;<%=rs("taskId")%> , <%=rs("taskName")%> <font color="red">(to <%=rs("taskTo")%>)</font>
											 

										<%else%>
											<span class="self STYLE1">չ��</span>&nbsp;<%=rs("taskId")%> , <%=rs("taskName")%> <font color="blue">(to <%=rs("taskTo")%>)</font>
										<%end if %>
										<a href="admTaskEditDel-<%=rs("taskId")%>.html" onClick="return confirm('�Ƿ�ɾ������Ϣ��')" >ɾ��</a> 
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
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>

<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>



<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- ��� չ�� ������� Bootstrap 3.3.5���� -->
<script src="../bootstrap/js/jquery.js"></script>  
<script src="../bootstrap/js/custom.js?v=0.9.1"></script>
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
<script src="../bootstrap/js/raphael-min.js"></script>
<script src="../plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="../plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="../plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="..bootstrap/js/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="../plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>

</body>
</html>


