<!--#include file="admFrame.asp"-->


<title><%=admProjectEdit%> | <%=admCompany%></title>


<!--  �Ƿ�����pjtId�����˳�ϵͳ -->

<%
pjtId = request("pjtId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 
rs.close
%>


<!--  ��ȡ������Ŀ���� -->

<%
dim arr_pjtName,rs
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId<>"&request("pjtId")&"",conn,3,3
Do while not rs.eof
	If arr_pjtName = "" then
		arr_pjtName = rs("pjtName")
	else
		arr_pjtName = arr_pjtName&","&rs("pjtName")
	end if
rs.Movenext
loop
rs.close
set rs = nothing 
%>


<script language="javascript">     
function CheckPost()
{		
	//��Ŀ���Ʋ���Ϊ���ж�
	if (addForm.pjtName.value == "")
      {
		  alert("��ܰ��ʾ����Ŀ���Ʋ���Ϊ��", function () {
            }, {type: 'warning', confirmButtonText: 'ȷ��'});
          addForm.pjtName.focus();
          return false;
      }

	// ��Ŀ����ȥ��
	var arr = addForm.arr_pjtName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.pjtName.value == arr[i]){
			alert("��ܰ��ʾ����Ŀ�����Ѵ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.pjtName.focus();
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


<!--  �༭��Ŀ	-->

<% if request("action")="save" then    
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_project where pjtId="&request("pjtId")&"",conn,3,3
	rs("pjtName") = request("pjtName")
	rs("pjtIntro") = request("pjtIntro")
	rs("pjtStatus") = request("pjtStatus")
	rs("pjtDBServer") = request("pjtDBServer")
	rs("pjtDBDatabase") = request("pjtDBDatabase")
	rs("pjtDBUser") = request("pjtDBUser")
	rs("pjtDBPassword") = request("pjtDBPassword")
	if request("checkbox1") = "on" then
		varObject = "web,"
	end if 
	if request("checkbox2") = "on" then
	   varObject = varObject + "iOS,"
	end if 
	if request("checkbox3") = "on" then
	   varObject = varObject + "android,"
	end if 
	if request("checkbox4") = "on" then
	   varObject = varObject + "CS,"
	end if 
	if request("checkbox5") = "on" then
	   varObject = varObject + "device,"
	end if 
	rs("pjtObject") = varObject
	rs.update
	rs.close
	set rs = nothing
	
	'��Ŀ�Ŀ���أ�ͬʱ���±���	
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_report where rpt_pjtId="&int(request("pjtId"))&"",conn,3,3
	do while not rs1.eof
		rs1("rpt_pjtStatus") = request("pjtStatus")
		rs1.update
	rs1.movenext
	loop
	
	rs1.close
	set rs1 = nothing
	'response.Redirect("admProjectInfo-"&request("pjtId")&".html")
end if 
%>


<%
pjtId = request("pjtId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3
%>



<form role="form" action="admProjectEditSave.html" method="post" name="addForm" onSubmit="return CheckPost()" >	


<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">table_chart</span> <%=admProjectPanel%> - <%=admProjectEdit%></h1>
			<p class="text-muted m-0 desc">Project Panel</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-12">
				<div class="card mb-4">
					<div class="card-body">	
						<div class="row">	
							<div class="col-md-6">
								<div class="form-group">
								<label>��Ŀ���� * (<12)</label>
								<input type="text" name="pjtName"   maxlength="12" class="form-control" value="<%=rs("pjtName")%>">
								</div>
							</div>
									
							<div class="col-md-6">
								<div class="form-group">
									<label>��Ŀ״̬ * </label>
									<% if rs("pjtStatus") = 1 then %>
										<div class="radio"><label><input type="radio" name="pjtStatus" value="1" checked>����</label></div>
										<div class="radio"><label><input type="radio" name="pjtStatus"  value="2">�ر�</label>	</div>
									<% elseif rs("pjtStatus") = 2 then %>
										<div class="radio"><label><input type="radio" name="pjtStatus" value="1" >����</label></div>
										<div class="radio"><label><input type="radio" name="pjtStatus"  value="2" checked>�ر�</label>	</div>
									<%end if %>
								</div>
							</div>
					
							<div class="col-md-6">
								<div class="form-group">
							
									<label>Ĭ�ϲ��Զ���</label>
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "web")>0 then%>
										<label><input type="checkbox" name="checkbox1" checked="checked"><i class="fa fa-windows"></i> B/S��webƽ̨��</label>
									<%else%>
										<label><input type="checkbox" name="checkbox1" ><i class="fa fa-windows"></i> B/S��webƽ̨��</label>
									<%end if %>
									</div>
								
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "iOS")>0 then%>
										<label><input type="checkbox" name="checkbox2" checked="checked"><i class="fa fa-apple"></i> iOS��APPƽ̨��</label>
									<%else%>
										<label><input type="checkbox" name="checkbox2" ><i class="fa fa-apple"></i> iOS��APPƽ̨��</label>
									<%end if %>
									</div>
								
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "android")>0 then%>
										<label><input type="checkbox" name="checkbox3" checked="checked"><i class="fa fa-android"></i> android��APPƽ̨��</label>
									<%else%>
										<label><input type="checkbox" name="checkbox3" ><i class="fa fa-android"></i> android��APPƽ̨��</label>
									<%end if %>
									</div>
							
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "CS")>0 then%>
										<label><input type="checkbox" name="checkbox4" checked="checked"><i class="fa fa-archive"></i> C/S��web�ͻ��˳�����.exe�ļ���</label>
									<%else%>
										<label><input type="checkbox" name="checkbox4" ><i class="fa fa-archive"></i> C/S��web�ͻ��˳�����.exe�ļ���</label>
									<%end if %>
									</div>
									
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "device")>0 then%>
										<label><input type="checkbox" name="checkbox5" checked="checked"><i class="fa fa-sitemap"></i> device�������豸�����ն˻��������ǵȣ�</label>
									<%else%>
										<label><input type="checkbox" name="checkbox5" ><i class="fa fa-sitemap"></i> device�������豸�����ն˻��������ǵȣ�</label>
									<%end if %>
									</div>
								</div>
							</div>
					
							<div class="col-md-12">
								<div class="form-group">
								<label>��Ŀ��Ϣ</label>
								<script type="text/plain" id="pjtIntro" style="width:100%; height:300px" name="pjtIntro"><%=rs("pjtIntro")%> </script>	
								<script>var editor_a = UE.getEditor('pjtIntro');</script>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>������IP</label>
								<input type="text" name="pjtDBServer" class="form-control" value="<%=rs("pjtDBServer")%>" >
								</div>
							</div>
					
							<div class="col-md-6">
								<div class="form-group">
								<label>���ݿ�</label>
								<input type="text" name="pjtDBDatabase" class="form-control" value="<%=rs("pjtDBDatabase")%>">
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>�û���</label>
								<input type="text" name="pjtDBUser" class="form-control" value="<%=rs("pjtDBUser")%>">
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>����</label>
								<input type="password" name="pjtDBPassword" class="form-control" value="<%=rs("pjtDBPassword")%>">
								</div>
							</div>
					
					
							<div class="col-md-12">
								<hr>  
								<input type="hidden" name="arr_pjtName" value="<%=arr_pjtName%>">
								<input name="pjtId" type="hidden" value="<%=rs("pjtId")%>" />	
								<div align="center"><button type="submit" class="btn btn-primary"  href="#">����</button></div>
							</div>
														
						</div><!-- /.row -->					
					</div>
				</div>	 
			</div> <!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.content -->
</div>

</form>
<%rs.close
set rs = nothing
%>
</body>
</html>


