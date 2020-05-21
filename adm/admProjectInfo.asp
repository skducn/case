<!--#include file="admFrame.asp"-->
<title>后台-项目列表 | <%=cstCompany%></title>


<!--  非法输入pjtId，则退出系统 -->

<%
pjtId = request("pjtId")  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3
if rs.eof  then
	response.Redirect("../index.html")
end if 

%>



<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">table_chart</span>项目管理</h1>
			<p class="text-muted m-0 desc">Project management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-6 ">
				<div class="card mb-4">
					<div class="card-header"><b>项目列表</b></div>
					<div class="card-body">	
						<div class="row">						
							<div class="col-md-6">
								<div class="form-group">
								<label>项目名称 *</label>
								<input type="text" name="pjtName"   maxlength="12" class="form-control"  value="<%=rs("pjtName")%>" disabled>
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
							
							<% if rs("pjtDBDatabase") <>"" then%>
							<div class="col-md-12">
								<div class="form-group">
								<label>查表信息</label> <br>
								<a href="admDatabase-<%=rs("pjtId")%>-<%=rs("pjtDBDatabase")%>.html"><button type="button" class="btn btn-info pull-left"  href="#"> 表结构、类型、数据</button></a><br><br>
								</div>
							</div>
							<%end if %>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>服务器IP</label>
									<input type="text" name="pjtDBServer" class="form-control" value="<%=rs("pjtDBServer")%>" disabled>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>数据库</label>
									<input type="text" name="pjtDBDatabase" class="form-control" value="<%=rs("pjtDBDatabase")%>" disabled>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>用户名</label>
									<input type="text" name="pjtDBUser" class="form-control" value="<%=rs("pjtDBUser")%>" disabled>
								</div>
							</div>
							
							<div class="col-md-6">
								<div class="form-group">
									<label>密码</label>
									<input type="text" name="pjtDBPassword" class="form-control" value="******" disabled>
								</div>
							</div>	
											
						</div><!-- /.row -->					
					</div>
				</div>	 
			</div> <!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.content -->
</div>

<%rs.close
set rs = nothing
%>

</body>
</html>


