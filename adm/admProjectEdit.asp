<!--#include file="admFrame.asp"-->


<title><%=admProjectEdit%> | <%=admCompany%></title>


<!--  非法输入pjtId，则退出系统 -->

<%
pjtId = request("pjtId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 
rs.close
%>


<!--  获取所有项目名称 -->

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
	//项目名称不能为空判断
	if (addForm.pjtName.value == "")
      {
		  alert("温馨提示：项目名称不能为空", function () {
            }, {type: 'warning', confirmButtonText: '确定'});
          addForm.pjtName.focus();
          return false;
      }

	// 项目名称去重
	var arr = addForm.arr_pjtName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.pjtName.value == arr[i]){
			alert("温馨提示：项目名称已存在", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.pjtName.focus();
			return false;}
	}
	
	//提交前弹框确认		
	var gnl=confirm("确定要保存?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>


<!--  编辑项目	-->

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
	
	'项目的开或关，同时更新报表	
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
								<label>项目名称 * (<12)</label>
								<input type="text" name="pjtName"   maxlength="12" class="form-control" value="<%=rs("pjtName")%>">
								</div>
							</div>
									
							<div class="col-md-6">
								<div class="form-group">
									<label>项目状态 * </label>
									<% if rs("pjtStatus") = 1 then %>
										<div class="radio"><label><input type="radio" name="pjtStatus" value="1" checked>开启</label></div>
										<div class="radio"><label><input type="radio" name="pjtStatus"  value="2">关闭</label>	</div>
									<% elseif rs("pjtStatus") = 2 then %>
										<div class="radio"><label><input type="radio" name="pjtStatus" value="1" >开启</label></div>
										<div class="radio"><label><input type="radio" name="pjtStatus"  value="2" checked>关闭</label>	</div>
									<%end if %>
								</div>
							</div>
					
							<div class="col-md-6">
								<div class="form-group">
							
									<label>默认测试对象</label>
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "web")>0 then%>
										<label><input type="checkbox" name="checkbox1" checked="checked"><i class="fa fa-windows"></i> B/S（web平台）</label>
									<%else%>
										<label><input type="checkbox" name="checkbox1" ><i class="fa fa-windows"></i> B/S（web平台）</label>
									<%end if %>
									</div>
								
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "iOS")>0 then%>
										<label><input type="checkbox" name="checkbox2" checked="checked"><i class="fa fa-apple"></i> iOS（APP平台）</label>
									<%else%>
										<label><input type="checkbox" name="checkbox2" ><i class="fa fa-apple"></i> iOS（APP平台）</label>
									<%end if %>
									</div>
								
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "android")>0 then%>
										<label><input type="checkbox" name="checkbox3" checked="checked"><i class="fa fa-android"></i> android（APP平台）</label>
									<%else%>
										<label><input type="checkbox" name="checkbox3" ><i class="fa fa-android"></i> android（APP平台）</label>
									<%end if %>
									</div>
							
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "CS")>0 then%>
										<label><input type="checkbox" name="checkbox4" checked="checked"><i class="fa fa-archive"></i> C/S（web客户端程序，如.exe文件）</label>
									<%else%>
										<label><input type="checkbox" name="checkbox4" ><i class="fa fa-archive"></i> C/S（web客户端程序，如.exe文件）</label>
									<%end if %>
									</div>
									
									<div class="checkbox">
									<%if Instr(rs("pjtObject"), "device")>0 then%>
										<label><input type="checkbox" name="checkbox5" checked="checked"><i class="fa fa-sitemap"></i> device（外置设备，如终端机、高拍仪等）</label>
									<%else%>
										<label><input type="checkbox" name="checkbox5" ><i class="fa fa-sitemap"></i> device（外置设备，如终端机、高拍仪等）</label>
									<%end if %>
									</div>
								</div>
							</div>
					
							<div class="col-md-12">
								<div class="form-group">
								<label>项目信息</label>
								<script type="text/plain" id="pjtIntro" style="width:100%; height:300px" name="pjtIntro"><%=rs("pjtIntro")%> </script>	
								<script>var editor_a = UE.getEditor('pjtIntro');</script>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>服务器IP</label>
								<input type="text" name="pjtDBServer" class="form-control" value="<%=rs("pjtDBServer")%>" >
								</div>
							</div>
					
							<div class="col-md-6">
								<div class="form-group">
								<label>数据库</label>
								<input type="text" name="pjtDBDatabase" class="form-control" value="<%=rs("pjtDBDatabase")%>">
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>用户名</label>
								<input type="text" name="pjtDBUser" class="form-control" value="<%=rs("pjtDBUser")%>">
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>密码</label>
								<input type="password" name="pjtDBPassword" class="form-control" value="<%=rs("pjtDBPassword")%>">
								</div>
							</div>
					
					
							<div class="col-md-12">
								<hr>  
								<input type="hidden" name="arr_pjtName" value="<%=arr_pjtName%>">
								<input name="pjtId" type="hidden" value="<%=rs("pjtId")%>" />	
								<div align="center"><button type="submit" class="btn btn-primary"  href="#">保存</button></div>
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


