<!--#include file="admFrame.asp"-->
<!--#include file="../md5.asp"-->

<title><%=admUserEdit%> | <%=admProject%></title>


<%userId = request("userId")%>

<!--  获取所有用户的昵称 -->
<%
dim arr_nickName
set rs = server.createobject("ADODB.RecordSet")
rs.open "select * from tbl_user where userId<>"&userId&"",conn,3,3
do while not rs.eof
if arr_nickName = "" Then
	arr_nickName = rs("userNickname")
else
	arr_nickName = arr_nickName&","&rs("userNickname")
end if 
rs.Movenext
loop
rs.close
set rs = nothing 
%>

<script language="javascript">
function CheckPost()
{	
	if (addForm.userNickname.value == ""){
	alert("温馨提示：昵称不能为空", function () {
	}, {type: 'warning', confirmButtonText: '确定'});
	addForm.userNickname.focus();
	return false;
	}
	  
	// 昵称(去重)
	var arr = addForm.arr_nickName.value
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
	
	var gnl=confirm("确定要保存?");
	if (gnl==true){
		return true;}
	else{
		return false;}

}
</script>


<!--  重置密码	-->	

<% if request("action")="del" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_user where userId="&userId&" and userName<>'admin'",conn,3,3
	if not rs.eof then
		rs("userPass") = md5("123456")
		rs.update
	end if 
	response.Redirect("admUserEdit-"&userId&".html")
end if %>


<!--  保存	-->

<% if request("action")="save" then 
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_user where userId="&request("userId")&"",conn,3,3	
	rs("userNickname") = request("userNickname")
	rs("userTitle") = request("userTitle")
	rs("userEmail") = request("userEmail")
	rs("userPower") = request("userPower")
	rs("userStatus") = request("userStatus")
	rs.update
	response.Redirect("admUserEdit-"&request("userId")&".html")	
	rs.close
	set rs = nothing 	
end if 
%>


<form  action="admUserEditSave-<%=userId%>.html" method="post"  name="addForm" onSubmit="return CheckPost()" >		
<%set rs = server.CreateObject("ADODB.RecordSet")
					rs.Open "select * from tbl_user where userId="&userId&"",conn,3,3%>

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">perm_identity</span><%=admUserPanel%> - <%=admUserEdit%></h1>
			<p class="text-muted m-0 desc">User Panel</p>
		</div> 
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-md-12">
				<div class="card mb-4">
					<div class="card-header">编辑用户</div>
					<div class="card-body">																
						<div class="row">									
							<div class="col-md-12">
								<div class="form-group" align="center">													
									<img src="<%=rs("userImg")%>" width="100"><br><br>
								</div>	
							</div>											
														
							<div class="col-md-6">
								<div class="form-group">	
									<label>用户名 </label>							
									<input type="text" name="userName" maxlength="6" class="form-control" value="<%=rs("userName")%>" disabled="disabled">
								</div>
							</div>
																								
							<div class="col-md-6">
								<div class="form-group">
									<label>密码 </label> 
									<input type="password" name="userPass"  maxlength="15" class="form-control"  value="<%=rs("userPass")%>" disabled>																						
								</div>
							</div>
				
							<div class="col-md-6">
								<div class="form-group">
									<label>昵称 (<6)</label>
									<input type="text" name="userNickname"  id="userNickname" maxlength="6" class="form-control" value="<%=rs("userNickname")%>">
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>职称 (<15)</label>
									<input type="text" name="userTitle"  maxlength="15" class="form-control" value="<%=rs("userTitle")%>" >
								</div>
							</div>
															
							<div class="col-md-6">
								<div class="form-group">
									<label>邮箱 * (<32)</label>
									<input type="text" name="userEmail" id="userEmail"  maxlength="32" class="form-control"  onKeyUp="value=value.replace(/[^\a-\z\A-\Z0-9\u4E00-\u9FA5\@\.]/g,'')" value="<%=rs("userEmail")%>">
								</div>
							</div>
				
							<% if rs("userPower") <> "1" then%>
								<div class="col-md-6">
									<%
									set rs1 = server.CreateObject("ADODB.RecordSet")
									rs1.Open "select * from tbl_power where powerId<>1",conn,3,3 
									%>
									<div class="form-group">
										<label>权限</label>
										<select class="form-control" name="userPower" >
										<% 
										do while not rs1.eof
										if rs1("powerId") = rs("userPower") then %>
										<option value="<%=rs1("powerId")%>" selected="selected"><%=rs1("powerName")%></option>
										<%else%>
										<option value="<%=rs1("powerId")%>"><%=rs1("powerName")%></option>
										<%end if 														
										rs1.movenext
										loop
										rs1.close
										%>
										</select>						
									</div>
								</div>
							<%else%>
								<input name="userPower" type="hidden" value="1" />	
							<%end if %>
										

							<div class="col-md-6">
								<div class="form-group">
									<label>账号状态</label><br>
									<% if rs("userPower") <> "1" then %>				
										<% if rs("userStatus") = "1" then %>
											<div class="radio">
												<label><input type="radio" name="userStatus" value="1" checked>开启</label>
												<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="userStatus"  value="2">关闭</label>	
											</div>																								
										<% elseif rs("userStatus") = "2" then %>
											<div class="radio">
											<label><input type="radio" name="userStatus" value="1" >开启</label>
											<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="userStatus"  value="2" checked>关闭</label>
											</div>
										<%end if %>
									<%else %>		
										<input name="userStatus" type="hidden" value="1" />																						
										 正常
									<%end if %>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									
									<% if rs("userPower") <> "1" then %>
										<label>初始化密码 </label> <br>
										<a href="admUserEditDel-<%=userId%>.html" class="btn btn-danger" onClick="return confirm('温馨提示，是否将此用户账号密码重置为 123456 ？')">重置密码</a>
									<%end if %>
								</div>
							</div>
																							
							<div class="col-md-12">
								<hr>
								<input type="hidden" name="arr_nickName" value="<%=arr_nickName%>">
								<input name="userId" type="hidden" value="<%=request("userId")%>" />
								<div align="center"><button type="submit" class="btn btn-primary" href="#">保存</button></div>							
							</div>
							
						</div>							
					</div>
				</div>
			</div>				    
		</div>
	</div>
</div>

<%rs.close
set rs = nothing%>
</form>

</body>
</html>




