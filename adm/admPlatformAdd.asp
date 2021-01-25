<!--#include file="admFrame.asp"-->

<title><%=admVerNew%> | <%=admProject%></title>


<!--  非法输入pjtId，则退出系统 -->

<%
pjtId = request("pjtId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 
%>

<!--  获取所有版本号 -->

<%
dim arr_platformName,rs
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&"",conn,3,3
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
		  alert("温馨提示：版本号不能为空", function () {
            }, {type: 'warning', confirmButtonText: '确定'});
          addForm.platformName.focus();
          return false;
      }

	// 版本号去重
	var arr = addForm.arr_platformName.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.platformName.value == arr[i]){
			alert("温馨提示：版本号已存在", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.platformName.focus();
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


<!--  新建版本	-->

<% 
if request("action") = "submit" then   
	pjtId = request("pjtId")
	platformName = request("platformName")
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_platform ",conn,3,3	
	rs.addnew
		rs("platformStatus") = "1"
		rs("verIsLabel") = "off"
		rs("verIsPlan") = "on"
		rs("verIsReport") = "off"
		rs("plat_pjtId") = pjtId
		rs("platformName") = platformName
		rs("platformRedmine") = request("platformRedmine")
		rs("platformStatus") = "1"
		rs("verCreateDate") = now()
	rs.update
	rs.close
	set rs = nothing
	
	' 更新项目中的是否有版本的状态
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3	
	rs("pjtIsVer") = "on"
	rs.update
	rs.close
	set rs = nothing
		
	' 默认新建版本后自动新建一个业务场景标签
	set rs2 = server.CreateObject("ADODB.RecordSet")
	rs2.Open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformName='"&request("platformName")&"' order by platformId ",conn,3,3
	platformId = rs2("platformId")
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_label",conn,3,3
	rs1.addnew
		rs1("lbl_pjtId") = pjtId
		rs1("lbl_platformId") = platformId
		rs1("lblName") = "业务场景"
	rs1.update
	rs1.close
	set rs1 = nothing
	rs2("verIsLabel") = "on"
	rs2.update
	rs2.close
	set rs2 = nothing 

	response.Write("<script>;alert('版本新建成功，请新建标签！');window.location.href='admLabelAdd-"&pjtId&"-"&platformId&".html';</script>")		

end if 
%>


<form role="form" action="admPlatformAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">filter_1</span> <%=admVerPanel%> - <%=admVerNew%></h1>
			<p class="text-muted m-0 desc">Version Panel</p>
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
								<label>版本号 * (<10)</label>
								<input type="text" name="platformName"   maxlength="10" class="form-control"  placeholder="如：1.0 ">
								</div>
							</div>
						
							<div class="col-md-6">
								<div class="form-group">
								<label>缺陷平台URL </label>
								<input type="text" name="platformRedmine"   maxlength="100" class="form-control"  placeholder="如：192.168.1.100/rojects">
								</div>
							</div>
					
							<div class="col-md-6">	
								<label> 已创建的版本号</label>			
								<%	set rs = server.CreateObject("ADODB.RecordSet")
								rs.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" order by platformId desc",conn,3,3
								do while not rs.eof
									if rs("platformStatus") = "2" then															
										%><br>
										<a href="admPlatformEdit-<%=rs("plat_pjtId")%>-<%=rs("platformId")%>.html">
										 <%=rs("platformName")  %>（已关闭）
										</a><%
									else
										%><br>
										<a href="admPlatformEdit-<%=rs("plat_pjtId")%>-<%=rs("platformId")%>.html">
										 <%=rs("platformName")  %>
										</a>
									<%end if 
								rs.movenext
								loop
								rs.close
								set rs = nothing
								%>
							</div>
							
							 
							<div class="col-md-12">
								<hr> 
								 <input type="hidden" name="arr_platformName" value="<%=arr_platformName%>">
								 <input name="pjtId" type="hidden" value="<%=request("pjtId")%>" /> 
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


