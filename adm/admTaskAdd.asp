<!--#include file="admFrame.asp"-->

<title>��̨-������Ϣ | <%=cstCompany%></title>

<!--  ��ȡ������Ϣ���� -->

<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_task",conn,3,3
Do while not rs.eof
	If arr_taskName = "" then
		arr_taskName = rs("taskName")
	else
		arr_taskName = arr_taskName&","&rs("taskName")
	end if
rs.Movenext
loop
rs.close
set rs = nothing 
%>

<script language="javascript">     
function CheckPost()
{		
	//��Ϣ���Ʋ���Ϊ���ж�
	if (addForm.taskName.value == "")
      {
		  alert("��ܰ��ʾ", "��Ϣ���Ʋ���Ϊ��", function () {
            }, {type: 'warning', confirmButtonText: 'ȷ��'});
          addForm.taskName.focus();
          return false;
      }
	 
	// ��Ϣ����ȥ��
	var arr = addForm.arr_taskName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.taskName.value == arr[i]){
			alert("��ܰ��ʾ","��Ϣ�����Ѵ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.taskName.focus();
			return false;}
	}
	
	
	//�ύǰ����ȷ��		
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>

<div class="content-wrapper">
	<section class="content-header">
	<h1>��Ϣ����<small>Message panel</small></h1>
	<ol class="breadcrumb"><li><a href="admMain.html"><i class="fa fa-align-justify"></i> Home</a></li></ol>
	</section>



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
	response.Redirect("admTaskList.html")

end if 
%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title ">�½���Ϣ</h3> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; >> &nbsp;&nbsp;&nbsp;&nbsp;<a href="admTaskList.html">��Ϣ�б�</a>
				</div>
				<!-- /.box-header -->
				<div class="box-body">

				<form role="form" action="admTaskAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
			
					
					<div class="col-xs-6">
						<div class="form-group">
						<label>��Ϣ���� * (<16)</label>
						<input type="text" name="taskName"  maxlength="16" class="form-control"  placeholder="�������Ŷ ...">
						</div>
					</div>
					
					<div class="col-xs-3">
							<!-- select -->
						<div class="form-group">
						  <label>���Ͷ��� *</label>
  						  <%set rs11 = server.CreateObject("ADODB.RecordSet")
							rs11.Open "select * from tbl_power where powerId=2",conn,3,3 %>

						  <select class="form-control" name="taskTo" >
						  <option value="all">������</option>
						  <%set rs1 = server.CreateObject("ADODB.RecordSet")
							rs1.Open "select * from tbl_user where userPower="&rs11("powerId")&" order by userId desc",conn,3,3
							do while not rs1.eof%>
							<option value="<%=rs1("userName")%>"><%=rs1("userName")%> (<%=rs1("userNickname")%>)</option>
							<%rs1.movenext
							loop
							rs1.close%>
						  </select>
						</div>
					</div>
					
					<div class="col-xs-12">
						<div class="form-group">
						<label>��Ϣ���� *</label>
						<script type="text/plain" id="taskContent" style="width:100%; height:400px" name="taskContent"></script>	
						<script>var editor_a = UE.getEditor('taskContent');</script>
						</div>
					</div>
					
					<input type="hidden" name="arr_taskName" value="<%=arr_taskName%>">

					<div class="col-xs-12">
					<br>
					<div align="center"><button type="submit" class="btn bg-maroon " href="#">�ύ</button></div>
					<br>
					</div>
					
					</form>
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


