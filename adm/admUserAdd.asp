<!--#include file="admFrame.asp"-->
<!--#include file="../md5.asp"-->

<title><%=admUserNew%> | <%=admCompany%></title>

<!--  ��ȡ�����˺ż��ǳ� -->
<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.open "select * from tbl_user",conn,3,3
do while not rs.eof
if arr_Nickname = "" Then
	arr_Nickname = rs("userNickname")
else
	arr_Nickname = arr_Nickname&","&rs("userNickname")
end if
if arr_userName = "" Then
	arr_userName = rs("userName")
else
	arr_userName = arr_userName&","&rs("userName")
end if
rs.Movenext
loop
rs.close
set rs = nothing 
%>

<script language="javascript">
function CheckPost()
{
	// �˺�
	if (addForm.userName.value == "" || addForm.userName.value.length < 4){
		alert("��ܰ��ʾ���˺ų��ȷ�Χ 4 - 15���ַ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userName.focus();
		return false;}	
	// ����
	if (addForm.userPass.value == "" || addForm.userPass.value.length < 6){
		alert("��ܰ��ʾ�����볤�ȷ�Χ�� 6 - 15���ַ�", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
		
	// �˺�(ȥ��)
	var arr = addForm.arr_userName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userName.value == arr[i]){
			alert("��ܰ��ʾ���˺��Ѵ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.userName.focus();
			return false;}}
	
	// �ǳ�(ȥ��)
	var arr = addForm.arr_Nickname.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickname.value == arr[i]){
			alert("��ܰ��ʾ���ǳ��Ѵ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
			addForm.userNickname.focus();
			return false;}}
			
	// ������֤
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //������ʽ
����var obj = document.getElementById("userEmail"); //Ҫ��֤�Ķ���
��  if(!reg.test(obj.value)){
		alert("��ܰ��ʾ��������֤ʧ��", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
��������return false;}
	
	var gnl=confirm("ȷ��Ҫ�ύ?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
 
</script>

<!--  ɾ��User	-->	
<% if request("action")="del" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_user where userId="&request("userId")&"",conn,3,3
	if not rs.eof then
	'rs.delete
	'rs.update
	end if 
end if %>


<!--  �����û�	-->
<% 
if request("action") = "submit" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_user",conn,3,3
	rs.addnew
	rs("userName") = request.form("userName")
	rs("userPass") = md5(request.form("userPass"))   
	rs("userPower") =  request.form("userPower")
	if request.form("userNickname") = "" then
		rs("userNickname") = request.form("userName")
	else
		rs("userNickname") = request.form("userNickname")
	end if 
	rs("userTitle") = request.form("userTitle")
	rs("userImg") = "images\head\default.jpg"
	rs("userEmail") = request.form("userEmail")
	rs("userStatus") = "1"
	rs("userRegDate") = now
	rs.update
	response.Write("<script>;alert('�����ɹ�');</script>")
	response.Redirect("admUserAdd.html")
	rs.close
	set rs = nothing 
end if 
%>



<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"> <span class="nav-icon material-icons ">perm_identity</span><%=admUserPanel%> - <%=admUserNew%></h1>
			<p class="text-muted m-0 desc">User Panel</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 


<div class="content">
	<div class="row">
		<div class="col-lg-6">
			<div class="card mb-4">
				<div class="card-body">					
					<div class="form-group col-md-12" align="center">
						<img src="../images/head/default.jpg" width="100" height="100">
						<br><br>
					</div>
						
					<form role="form" action="admUserAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
	
					<div class="row">									
						<div class="col-md-6">
							<div class="form-group">
							<label>�˺� * (4-15)</label>
							<input type="text" name="userName"   maxlength="15" class="form-control" >
							</div>
						</div>
			
						<div class="col-md-6">
							<div class="form-group">
							<label>���� * (6-15)(Ĭ�ϣ�123456)</label>
							<input type="password" name="userPass" maxlength="15" class="form-control"  value="123456" >						
							</div>
						</div>
					
						<div class="col-md-6">
							<div class="form-group">
							<label>�ǳ� (<6)</label>
							<input type="text" name="userNickname"   maxlength="6" class="form-control"  >
							</div>
						</div>
						
						<div class="col-md-6">
							<div class="form-group">
							<label>ְ�� (<10)</label>
							<input type="text" name="userTitle"   maxlength="10" class="form-control" placeholder="" value="���Թ���ʦ">
							</div>
						</div>
			
						<div class="col-md-6">
							<div class="form-group">
							<label>���� * (<32)</label>
							<input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  onKeyUp="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'')">
							</div>
						</div>
					
						<div class="col-md-6">
							<%set rs = server.CreateObject("ADODB.RecordSet")
							rs.Open "select * from tbl_power where powerId<>1",conn,3,3 %>
							<div class="form-group">
							<label>Ȩ��</label>
							  <select class="form-control" name="userPower" >
							  <% do while not rs.eof %>
								<option value="<%=rs("powerId")%>"><%=rs("powerName")%></option>
								<%rs.movenext
								loop
								rs.close%>
							  </select>						
							 </div>
						</div>

						
		
		
						<div class="col-md-12">			
							<hr>
							<input type="hidden" name="arr_Nickname" value="<%=arr_Nickname%>">
							<input type="hidden" name="arr_userName" value="<%=arr_userName%>">
							<div align="center"><button type="submit" class="btn btn-primary" href="#">�ύ</button></div>
								
						</div>
					</div>
		</form>	
				

					</div>
				</div>
			</div>
														
			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">							
						<div class="alert alert-primary" role="alert">��Ա�˺��б�</div>
						<div class="card-body">	
							<table class="table table-striped m-0">
							<thead>
							<tr>
							<% set rs = server.CreateObject("ADODB.RecordSet")	
							if session("userPower") = "1" then  %>
								<th>�˺�</th>
								<th>�ǳ�</th>							
								<th>״̬</th>
								</tr></thead><tbody>
								<%		
								set rs = server.CreateObject("ADODB.RecordSet")
								rs.Open "select * from tbl_user where userPower<>1 order by userPower,userId",conn,3,3
								do while not rs.eof
								set rs1 = server.CreateObject("ADODB.RecordSet")
								rs1.Open "select * from tbl_power ",conn,3,3
								do while not rs1.eof						
								if rs("userPower") = rs1("powerId") then%>
								<tr>
								<td><a href="admUserEdit-<%=rs("userId")%>.html"><%=rs("userName")%></a></td>
								<td><%=rs("userNickName")%></td>
								
								
								<%if rs("userStatus") = "1" then%>
								<td><span class="badge badge-info">����</span></td>
								<%else%>
								<td><span class="badge badge-danger">�ر�</span></td>
								<%end if %>																				
								</tr>
								<%end if 
								rs1.movenext
								loop
								rs.movenext
								loop
								rs1.close
								rs.close
								set rs1 = nothing
								set rs = nothing
								%>																
								</tbody>
								</table>
							<%else%>
								<th>�˺�</th>
								<th>�ǳ�</th>
								<th>״̬</th>
								</tr></thead>
								</table>							
							<%end if
							 %>
						</div>	
						</div>		
				</div><!-- "card mb-4" --> 	
			</div><!-- col-lg-6 --> 	
						
		</div>
	</div>
</div>
</body>
</html>

	

