<!--#include file="admFrame.asp"-->

<title><%=admLabelNew%> | <%=admProject%></title>

<!--  非法输入，则退出系统 -->

<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 
%>


<!--  获取所有标签名 -->

<%
dim arr_lblName,rs
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_label where lbl_pjtId="&request("pjtId")&" and lbl_platformId="&request("platformId")&"",conn,3,3
Do while not rs.eof
	If arr_lblName = "" then
		arr_lblName = rs("lblName")
	else
		arr_lblName = arr_lblName&","&rs("lblName")
	end if
rs.Movenext
loop
rs.close
set rs = nothing 
%>


<script language="javascript">     
function CheckPost()
{		
	if (addForm.lblName.value == "")
      {
		  alert("温馨提示：标签名不能为空", function () {
            }, {type: 'warning', confirmButtonText: '确定'});
          addForm.lblName.focus();
          return false;
      }

	// 版本号去重
	var arr = addForm.arr_lblName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.lblName.value == arr[i]){
			alert("温馨提示：标签名已存在", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.lblName.focus();
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


<!--  新建标签	-->

<% 
if request("action") = "submit" then   
	pjtId = request("pjtId")
	platformId = request("platformId")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_label where lbl_platformId="&platformId&" and lbl_pjtId="&pjtId&" order by lblId DESC",conn,3,3	
	rs.addnew
		rs("lbl_pjtId") = pjtId
		rs("lbl_platformId") = platformId
		rs("lblName") = request("lblName")
	rs.update
	rs.close
	set rs = nothing 
	response.Redirect("admLabelAdd-"&pjtId&"-"&platformId&".html")
end if 
%>



<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where platformId="&request("platformId")&" and plat_pjtId="&request("pjtId")&" order by platformId DESC",conn,3,3
set rs1 = server.CreateObject("ADODB.RecordSet")
rs1.Open "select * from tbl_project where pjtId="&request("pjtId")&" order by pjtId DESC",conn,3,3
%>

<form role="form" action="admLabelAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	


<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">notes</span><%=admLabelPanel%> - <%=admLabelNew%></h1>
			<p class="text-muted m-0 desc">Label Panel</p>
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
								<label>项目名称</label>
								<input type="text" name="pjtName"   maxlength="12" class="form-control" value="<%=rs1("pjtName")%>" disabled="disabled">
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
								<label>版本号</label>
								<input type="text" name="platformName"   maxlength="12" class="form-control" value="<%=rs("platformName")%>" disabled="disabled">
								</div>
							</div>
							<% rs1.close
						  rs.close%>
					
							<div class="col-md-6">
								<div class="form-group">
								<label>标签名称 * (<10)</label>
								<input type="text" name="lblName" maxlength="10" class="form-control"  placeholder="如：登录模块">
								</div>
							</div>
							
							<div class="col-md-6">	
								<label> 已创建的标签名：</label>			
								<%	set rs = server.CreateObject("ADODB.RecordSet")
								rs.Open "select * from tbl_label where lbl_pjtId="&request("pjtId")&" and lbl_platformId="&request("platformId")&"",conn,3,3
								do while not rs.eof								
										%><br>
										<a href="admLabelEdit-<%=rs("lbl_pjtId")%>-<%=rs("lbl_platformId")%>-<%=rs("lblId")%>.html">
										 <%=rs("lblName")  %>
										</a><%
									rs.movenext
								loop
								rs.close
							
								%>
							</div>
					 					 					 
							<div class="col-md-12">
								<hr> 
								<input type="hidden" name="arr_lblName" value="<%=arr_lblName%>">
								<input name="pjtId" type="hidden" value="<%=request("pjtId")%>" />
								<input name="platformId" type="hidden" value="<%=request("platformId")%>" /> 
								<div align="center"><button type="submit" class="btn btn-primary"  href="#">提交</button></div>				
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


