<!--#include file="admFrame.asp"-->

<title>��̨-�༭��Ϣ | <%=cstCompany%></title>

<!--  �Ƿ�����taskId�����˳�ϵͳ -->

<%Set rs1 = Server.CreateObject("Adodb.Recordset")
rs1.Open "select * from tbl_task where taskId="&request("taskId")&" order by taskId DESC",conn,3,3 
if rs1.eof  then
	response.Redirect("../index.html")
end if 
rs1.close
%>
							
<!--  ��ȡ������Ϣ���� -->

<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_task where taskId<>"&request("taskId")&"",conn,3,3
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
	var gnl=confirm("ȷ��Ҫ����?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>

<div class="content-wrapper">
	<section class="content-header">
	<h1>��Ϣ����<small>message panel</small></h1>
	<ol class="breadcrumb"><li><a href="admMain.html"><i class="fa fa-align-justify"></i> Home</a></li></ol>
	</section>


<% if request("action")="del" then    
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_task where taskId="&request("taskId")&"",conn,3,3
	if not rs.eof then	
		rs.delete
	end if 
	rs.close
	set rs = nothing
	response.Redirect("admTaskList.html")

end if 
%>


<!--  �༭����	-->

<% if request("action")="save" then    
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_task where taskId="&request("taskId")&"",conn,3,3
	rs("taskName") = request("taskName")
	rs("taskContent") = request("taskContent")
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admTaskList.html")
	'response.Write("<script>;alert('����ɹ�');window.location.href='admTaskEdit-"&request("taskId")&".html';</script >")
end if 
%>

<%
taskId = request("taskId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_task where taskId="&taskId&"",conn,3,3
%>

<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title">�༭��Ϣ</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<form role="form" action="admTaskEditSave.html" method="post" name="addForm" onSubmit="return CheckPost()" >
					
					<div class="col-xs-6">
						<div class="form-group">
						<label>��Ϣ���� * (<16)</label>
						<input type="text" name="taskName"   maxlength="16" class="form-control" value="<%=rs("taskName")%>">
						</div>
					</div>
					
					<div class="col-xs-6">
						<div class="form-group">
						<label></label>
						<a href="admTaskEditDel-<%=rs("taskId")%>.html" onClick="return confirm('�Ƿ�ɾ������Ϣ��')" >ɾ����Ϣ</a>  
					</div>
					</div>
				
					
					<div class="col-xs-12">
						<div class="form-group">
						<label>��Ϣ����</label>
						<script type="text/plain" id="taskContent" style="width:100%; height:400px" name="taskContent"><%=rs("taskContent")%> </script>	
						<script>var editor_a = UE.getEditor('taskContent');</script>
						</div>
					</div>
					
					<input name="taskId" type="hidden" value="<%=rs("taskId")%>" />	
					<input type="hidden" name="arr_taskName" value="<%=arr_taskName%>">
					
					<div class="col-xs-12">
						<br>
						<div align="center"><button type="submit" class="btn bg-maroon" href="#">����</button></div>
						<br>
					</div>
					
					</form>
				</div>
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
</section><!-- /.content -->
<%rs.close
set rs = nothing
%>

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


