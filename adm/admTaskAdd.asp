<!--#include file="admFrame.asp"-->

<title><%=admMessageNew%> | <%=admCompany%></title>

<!--  获取所有消息名称 -->

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
	//消息名称不能为空判断
	if (addForm.taskName.value == "")
      {
		  alert("温馨提示", "消息名称不能为空", function () {
            }, {type: 'warning', confirmButtonText: '确定'});
          addForm.taskName.focus();
          return false;
      }
	 
	// 消息名称去重
	var arr = addForm.arr_taskName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.taskName.value == arr[i]){
			alert("温馨提示","消息名称已存在", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.taskName.focus();
			return false;}
	}
	
	
	//提交前弹框确认		
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>


<!--  新建任务	-->

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


<form role="form" action="admTaskAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">filter_1</span> <%=admMessagePanel%> - <%=admMessageNew%> </h1>
			<p class="text-muted m-0 desc">Message Panel</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

<div class="content">
<div class="card mb-4">				
<div class="card-body">											

	<div class="row">								
		<div class="col-md-6">						
			<label>消息名称 * (<16)</label>
			<input type="text" name="taskName"  maxlength="16" class="form-control"  placeholder="简洁明了哦 ...">						
		</div>						
		<div class="col-md-6">															
			<label>发送对象 *</label>										
			<select class="form-control" name="taskTo" >
			<option value="all">所有人</option>
			<%set rs1 = server.CreateObject("ADODB.RecordSet")
			rs1.Open "select * from tbl_user where userPower=2 and userStatus='1' order by userId desc",conn,3,3
			do while not rs1.eof%>
			<option value="<%=rs1("userName")%>"><%=rs1("userName")%> (<%=rs1("userNickname")%>)</option>
			<%rs1.movenext
			loop
			rs1.close%>
			</select>
		</div>
	</div><!--<div class="row">-->

	<br>

	<div class="row">
		<div class="col-md-12">
			<label>消息内容 *</label>
			<script type="text/plain" id="taskContent" style="width:100%; height:500px" name="taskContent"></script>	
			<script>var editor_a = UE.getEditor('taskContent');</script>
		</div>
	</div><!--<div class="row">-->

	<input type="hidden" name="arr_taskName" value="<%=arr_taskName%>">

	<div class="col-md-12">
		<br>
		<div align="center"><button type="submit" class="btn btn-primary" href="#">提交</button></div>
		<br>
	</div>							

	 
</div> <!-- /.card-body -->
</div><!-- /.card mb-4 -->
</div><!-- /.content -->

</form>

</body>
</html>


