<!--#include file="frame.asp"-->

<title>项目信息 | <%=cstCompany%> </title>

<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script language="javascript">  
function CheckPost()
{   	
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "保存成功",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});
}
</script>

<!--  编辑项目信息	-->

<% if request("action")="save" then    
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_project where pjtId="&request("pjtId")&"",conn,3,3
	rs("pjtDBServer") = request("pjtDBServer")
	rs("pjtDBDatabase") = request("pjtDBDatabase")
	rs("pjtDBUser") = request("pjtDBUser")
	rs("pjtDBPassword") = request("pjtDBPassword")		
	rs("pjtIntro") = request("pjtIntro")
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("sltProjectInfo-"&request("pjtId")&".html")
end if 
%>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> 项目信息</h1><p>project info</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">项目信息</a></li></ul></div>
	</div>
	
	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">		
					<%
					pjtId = request("pjtId")  
					set rs = server.CreateObject("ADODB.RecordSet")
					rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3
					if rs.eof then
						response.Redirect("index.html")
					end if 
					%>
					<div class="row">
						<div class="col-md-6" align="left">
							<h3 class="box-title"> <%=rs("pjtName")%></h3>					
						</div>				
						<div class="col-md-6" align="right">
							<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>		
						</div>	
					</div>
		
					<hr>
						
					<form role="form" action="sltProjectInfoSave.html" method="post" name="addForm" onSubmit="return CheckPost()">
					
					
				    <div class="col-md-3">
						<div class="form-group">
						<h4 class="box-title">服务器IP</h4>
						<input type="text" name="pjtDBServer" class="form-control" maxlength="15" value="<%=rs("pjtDBServer")%>">
						</div>
					</div>
					
					<div class="col-md-3">
						<div class="form-group">
						<h4 class="box-title">数据库（<30）</h4>
						<input type="text" name="pjtDBDatabase" class="form-control" maxlength="30" value="<%=rs("pjtDBDatabase")%>">
						</div>
					</div>
					
					<div class="col-md-3">
						<div class="form-group">
						<h4 class="box-title">用户名（<30）</h4>
						<input type="text" name="pjtDBUser" class="form-control" maxlength="30" value="<%=rs("pjtDBUser")%>">
						</div>
					</div>
					
					<div class="col-md-3">
						<div class="form-group">
						<h4 class="box-title">密码（<30）</h4>
						<input type="text" name="pjtDBPassword" class="form-control" maxlength="30" value="<%=rs("pjtDBPassword")%>">
						</div>
					</div>
					
					<% if rs("pjtDBDatabase") <>"" then%>
						<div class="col-md-12">
							<div class="form-group">
							<h4 class="box-title">查表信息</h4> <br>
							<!-- <a href="sltDatabase-< %=rs("pjtId")%>-< %=rs("pjtDBDatabase")%>.html"><button type="button" class="btn btn-info pull-left"  href="#"> 表结构、类型、数据</button></a><br><br>  </-->
							</div>
						</div>
					<%end if %>
					
					<div class="col-md-12">
						<div class="form-group">
						<h4 class="box-title">项目信息</h4>
						<script type="text/plain" id="pjtIntro" style="width:100%; height:400px" name="pjtIntro"><%=rs("pjtIntro")%> </script>	
						<script>var editor_a = UE.getEditor('pjtIntro');</script>
						</div>
					</div>
					
					<input name="pjtId" type="hidden" value="<%=rs("pjtId")%>" />	
					
					<div class="col-md-12">					
					<hr>
						<div align="center"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button></div>

					</div>
			
					
					</form>
					
					<!-- top按钮 -->
					<div class="col-md-12" align="right">	
					
						<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
						<a id='DD'></a>			
					</div>
	
		
					<%rs.close
					set rs = nothing
					%>
				</div>
			</div>
		</div>
	</div>
	


</div>




<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script>


<script src="731/dist/js/bootstrap.min.js"></script>



</body>
</html>