<!--#include file="admFrame.asp"-->
<!--#include file="../md5.asp"-->

<title><%=admUserNew%> | <%=admCompany%></title>

<!--  获取所有账号及昵称 -->
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
	// 账号
	if (addForm.userName.value == "" || addForm.userName.value.length < 4){
		alert("温馨提示：账号长度范围 4 - 15个字符", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userName.focus();
		return false;}	
	// 密码
	if (addForm.userPass.value == "" || addForm.userPass.value.length < 6){
		alert("温馨提示：密码长度范围不 6 - 15个字符", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
		
	// 账号(去重)
	var arr = addForm.arr_userName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userName.value == arr[i]){
			alert("温馨提示：账号已存在", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.userName.focus();
			return false;}}
	
	// 昵称(去重)
	var arr = addForm.arr_Nickname.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.userNickname.value == arr[i]){
			alert("温馨提示：昵称已存在", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.userNickname.focus();
			return false;}}
			
	// 邮箱验证
	var reg = new RegExp("^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$"); //正则表达式
　　var obj = document.getElementById("userEmail"); //要验证的对象
　  if(!reg.test(obj.value)){
		alert("温馨提示：邮箱验证失败", function () {}, {type: 'warning', confirmButtonText: '确定'});
　　　　return false;}
	
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
 
</script>

<!--  删除User	-->	
<% if request("action")="del" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_user where userId="&request("userId")&"",conn,3,3
	if not rs.eof then
	'rs.delete
	'rs.update
	end if 
end if %>


<!--  新增用户	-->
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
	response.Write("<script>;alert('新增成功');</script>")
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
							<label>账号 * (4-15)</label>
							<input type="text" name="userName"   maxlength="15" class="form-control" >
							</div>
						</div>
			
						<div class="col-md-6">
							<div class="form-group">
							<label>密码 * (6-15)(默认：123456)</label>
							<input type="password" name="userPass" maxlength="15" class="form-control"  value="123456" >						
							</div>
						</div>
					
						<div class="col-md-6">
							<div class="form-group">
							<label>昵称 (<6)</label>
							<input type="text" name="userNickname"   maxlength="6" class="form-control"  >
							</div>
						</div>
						
						<div class="col-md-6">
							<div class="form-group">
							<label>职称 (<10)</label>
							<input type="text" name="userTitle"   maxlength="10" class="form-control" placeholder="" value="测试工程师">
							</div>
						</div>
			
						<div class="col-md-6">
							<div class="form-group">
							<label>邮箱 * (<32)</label>
							<input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  onKeyUp="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'')">
							</div>
						</div>
					
						<div class="col-md-6">
							<%set rs = server.CreateObject("ADODB.RecordSet")
							rs.Open "select * from tbl_power where powerId<>1",conn,3,3 %>
							<div class="form-group">
							<label>权限</label>
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
							<div align="center"><button type="submit" class="btn btn-primary" href="#">提交</button></div>
								
						</div>
					</div>
		</form>	
				

					</div>
				</div>
			</div>
														
			<div class="col-lg-6">
				<div class="card mb-4">
					<div class="card-header">							
						<div class="alert alert-primary" role="alert">成员账号列表</div>
						<div class="card-body">	
							<table class="table table-striped m-0">
							<thead>
							<tr>
							<% set rs = server.CreateObject("ADODB.RecordSet")	
							if session("userPower") = "1" then  %>
								<th>账号</th>
								<th>昵称</th>							
								<th>状态</th>
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
								<td><span class="badge badge-info">开启</span></td>
								<%else%>
								<td><span class="badge badge-danger">关闭</span></td>
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
								<th>账号</th>
								<th>昵称</th>
								<th>状态</th>
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

	

