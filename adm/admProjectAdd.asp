<!--#include file="admFrame.asp"-->


<title><%=admProjectNew%> | <%=admCompany%></title>


<!--  ������Ŀ����	-->

<%
dim arr_pjtName,rs
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project",conn,3,3
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
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>



<!--  �½���Ŀ�ύ	-->

<% 
if request("action") = "submit" then    	
	dim varObject
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_project",conn,3,3	
	rs.addnew
	rs("pjtStatus") = "1"
	rs("pjtIsVer") = "off"
	rs("pjtIsPlan") = "off"
	rs("pjtIsReport") = "off"
	rs("pjtName") = request("pjtName")
	rs("pjtIntro") = request("pjtIntro")
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
	rs("pjtDBServer") = request("pjtDBServer")
	rs("pjtDBDatabase") = request("pjtDBDatabase")
	rs("pjtDBUser") = request("pjtDBUser")
	rs("pjtDBPassword") = request("pjtDBPassword")
	rs("pjtCreateDate") = now()
	rs.update	
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select top 1 * from tbl_project order by pjtId desc",conn,3,3	
	response.Write("<script>;alert('��Ŀ�½��ɹ������½��汾��');window.location.href='admPlatformAdd-"&rs1("pjtId")&".html';</script>")		
	rs1.close
	set rs1 = nothing	
	rs.close
	set rs = nothing 
end if 
%>

<form role="form" action="admProjectAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">table_chart</span> <%=admProjectPanel%> - <%=admProjectNew%></h1>
			<p class="text-muted m-0 desc">Project Panel</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-12 ">
				<div class="card mb-4">
				
					<div class="card-body">	
						<div class="row">	
							<div class="col-md-6">	
								<div class="form-group">				
									<label>��Ŀ���� *��<12��</label>
									<input type="text" name="pjtName"   maxlength="12" class="form-control" >					
								</div>
							</div>
			
							<div class="col-md-6">										
								<div class="form-group">
									<label><br> ��ѡ����Զ���</label>
									<div class="checkbox">
										<label><input type="checkbox" name="checkbox1" ><i class="fa fa-windows"></i> B/S��webƽ̨��</label>
									</div>				
									<div class="checkbox">
										<label><input type="checkbox" name="checkbox2"><i class="fa fa-apple"></i>  iOS��APPƽ̨��</label>
									</div>				
									<div class="checkbox">
										<label><input type="checkbox" name="checkbox3"><i class="fa fa-android"></i>  android��APPƽ̨��</label>
									</div>			
									<div class="checkbox">
										<label><input type="checkbox" name="checkbox4"><i class="fa fa-archive"></i> C/S��web�ͻ��˳�����.exe�ļ���</label>
									</div>					
									<div class="checkbox">
										<label><input type="checkbox" name="checkbox5"><i class="fa fa-sitemap"></i> device�������豸�����ն˻��������ǵȣ�</label>
									</div>					
								</div>	
							</div>
											
							<div class="col-md-12">
							<div class="form-group">
							<label>��Ŀ��Ϣ</label>
							<script type="text/plain" id="pjtIntro" style="width:100%; height:300px" name="pjtIntro"></script>	
							<script>var editor_a = UE.getEditor('pjtIntro');</script>
							</div>
							</div>
							
							<div class="col-md-6">
							<div class="form-group">
							<label>������IP</label>
							<input type="text" name="pjtDBServer"   maxlength="15" class="form-control" >
							</div>
							</div>
							
							<div class="col-md-6">
							<div class="form-group">
							<label>���ݿ�</label>
							<input type="text" name="pjtDBDatabase"   maxlength="30" class="form-control"  >
							</div>
							</div>
							
							<div class="col-md-6">
							<div class="form-group">
							<label>�˺�</label>
							<input type="text" name="pjtDBUser"   maxlength="30" class="form-control" >
							</div>
							</div>
							
							<div class="col-md-6">
							<div class="form-group">
							<label>����</label>
							<input type="text" name="pjtDBPassword"   maxlength="30" class="form-control" >
							</div>
							</div>
								
							
							<div class="col-md-12">		
								<hr>  
								<input type="hidden" name="arr_pjtName" value="<%=arr_pjtName%>">
								<div align="center"><button type="submit" class="btn btn-primary"  href="#">�ύ</button></div>
							</div>
						</div><!-- /.row -->					
					</div>
				</div>	 
			</div> <!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.content -->
</div>

</form>

</body>
</html>


