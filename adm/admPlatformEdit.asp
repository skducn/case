<!--#include file="admFrame.asp"-->

<title>��̨-�༭�汾 | <%=cstCompany%></title>

<!--  �Ƿ�����pjtId�����˳�ϵͳ -->

<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 
%>

<!--  ��ȡ���а汾�� -->

<%
dim arr_platformName,rs
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId<>"&request("platformId")&"",conn,3,3
Do while not rs.eof
	If arr_platformName = "" then
		arr_platformName = rs("platformName")
	else
		arr_platformName = arr_platformName&","&rs("platformName")
	end if
rs.Movenext
loop
rs.close
set rs = nothing 
%>


<script language="javascript">     
function CheckPost()
{		
	if (addForm.platformName.value == "")
      {
		  alert("��ܰ��ʾ���汾�Ų���Ϊ��", function () {
            }, {type: 'warning', confirmButtonText: 'ȷ��'});
          addForm.platformName.focus();
          return false;
      }

	// �汾��ȥ��
	var arr = addForm.arr_platformName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.platformName.value == arr[i]){
			alert("��ܰ��ʾ���汾���Ѵ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.platformName.focus();
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


<% 
if request("action")="save" then   
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&"",conn,3,3
	rs("platformName") = request("platformName")
	rs("platformRedmine") = request("platformRedmine")
	rs("platformStatus") = request("platformStatus")
	rs.update
	rs.close	
	set rs = nothing  				

	'����رհ汾�Ļ���ͬʱ����Ҫ���²��Լƻ�plan���е�planStatus
	 'if request("platformStatus") = "2" then
		'set rs1 = server.CreateObject("ADODB.RecordSet")
		'rs1.Open "select * from tbl_plan where plan_pjtId="&request("pjtId")&" and plan_platformId="&request("platformId")&"",conn,3,3
		'rs1("planStatus") = "2"
		'rs1.update
		'rs1.close
		'set rs1 = nothing
	'end if 

end if 
%>

<!--  ɾ���½��İ汾�ţ���������ҵ�񳡾���ǩ��δ������������ǩ��	-->

<% 
if request("action")="del" then   
set rs1 = server.CreateObject("ADODB.RecordSet")
rs1.Open "select * from tbl_label where lbl_pjtId="&request("pjtId")&" and lbl_platformId="&request("platformId")&" order by lblId",conn,3,3
if rs1.recordcount > 1 then
	response.Write("<script>;alert('������ʾ���޷�ɾ���˰汾������ɾ���˰汾�����еı�ǩ��');</script>")
	response.end 
else
rs1.delete
rs1.update
end if 
rs1.close
set rs1 = nothing 
set rs2 = server.CreateObject("ADODB.RecordSet")
rs2.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&" order by platformId",conn,3,3
rs2.delete
rs2.update    
rs2.close
set rs2 = nothing
response.Redirect("admMain.html")
end if 
%>


<%
pjtId = request("pjtId") 
platformId = request("platformId") 
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&"",conn,3,3
%>


<form role="form" action="admPlatformEditSave.html" method="post" name="addForm" onSubmit="return CheckPost()" >	


<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">filter_1</span>�汾����</h1>
			<p class="text-muted m-0 desc">Version management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-6 ">
				<div class="card mb-4">
					<div class="card-header"><b>�༭�汾</b></div>
					<div class="card-body">	
						<div class="row">	
						
							<div class="col-md-6">
								<div class="form-group">
									<label>��Ŀ����</label>
									 <%
									  set rs12 = server.CreateObject("ADODB.RecordSet")
									  rs12.Open "select * from tbl_project where pjtId="&request("pjtId")&" order by pjtId DESC",conn,3,3							 
									  %>
									<input type="text" name="pjtName"   maxlength="10" class="form-control"  value="<%=rs12("pjtName")%>" disabled="disabled">
								<% rs12.close%>
								</div>
							</div>
					
					
							<div class="col-md-6">
								<div class="form-group">
								<label>�汾�� * (<10)</label>
								<% 'ɾ���汾�Ź��ܣ�Ĭ������������汾�Ż��Զ�����һ��ҵ�񳡾���ǩ�������ж����ĳ���汾ֻ��һ����ǩʱ����ʾɾ�����ӡ�
								   '���鲻Ҫɾ���������������ڲ���
									set rs11 = server.CreateObject("ADODB.RecordSet")
									rs11.Open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId",conn,3,3
									if rs11.recordcount = 1 and rs11("lblName")="ҵ�񳡾�" then %>
										&nbsp;&nbsp;<a href="admPlatformEditDel-<%=pjtId%>-<%=platformId%>.html" onClick="return confirm('�Ƿ�ɾ�� <%=rs("platformName")%> �汾�ţ�')" >ɾ��</a>	
								<%end if %>		
								<input type="text" name="platformName"  class="form-control" value="<%=rs("platformName")%>" >
								</div>
							</div>			

							<div class="col-md-6">
								<div class="form-group">
								<label>ȱ��ƽ̨URL </label>
								<input type="text" name="platformRedmine"   maxlength="80" class="form-control"  value="<%=rs("platformRedmine")%>">
								</div>
							</div>
					
			
							<div class="col-md-6">
								<div class="form-group">
									<label>�汾״̬ ���رպ��ڲ˵�����ʾ��</label>
									<% if rs("platformStatus") = 2 then %>
										<div class="radio"><label><input type="radio" name="platformStatus" value="1" >����</label></div>
										<div class="radio"><label><input type="radio" name="platformStatus" value="2" checked>�ر�</label>	</div>
									<% else %>
										<div class="radio"><label><input type="radio" name="platformStatus" value="1" checked>����</label></div>
										<div class="radio"><label><input type="radio" name="platformStatus" value="2">�ر�</label>	</div>
									<%end if %>
								</div>
							</div>
					
							<div class="col-md-12">	
								<label> �Ѵ����İ汾��</label>			
								<%	set rs7 = server.CreateObject("ADODB.RecordSet")
								rs7.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" order by platformId desc",conn,3,3
								do while not rs7.eof
									if rs7("platformStatus") = "2" then							
										
										%><br>
										<a href="admPlatformEdit-<%=rs7("plat_pjtId")%>-<%=rs7("platformId")%>.html">
										 <%=rs7("platformName")  %>���ѹرգ�
										</a><%
									else
										%><br>
										<a href="admPlatformEdit-<%=rs7("plat_pjtId")%>-<%=rs7("platformId")%>.html">
										 <%=rs7("platformName")  %>
										</a>
									<%end if 
								rs7.movenext
								loop
								rs7.close
								set rs7 = nothing
								%>
							</div>
					
				
							<div class="col-md-12">
								<hr> 
								 <input type="hidden" name="arr_platformName" value="<%=arr_platformName%>">
								 <input name="pjtId" type="hidden" value="<%=pjtId%>" />	
								 <input name="platformId" type="hidden" value="<%=platformId%>" /> 
								<div align="center"><button type="submit" class="btn btn-primary"  href="#">����</button></div>
								<br>
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

