<!--#include file="frame.asp"-->

<title>执行Ta的用例 | <%=cstCompany%></title>

<script language="javascript">     
function CheckPost()
{      	
	
	// 判断测试结果5个不能全为空
	var chestr="";
	var str = document.getElementsByName("caseWebResult");
	for (i=0;i<str.length;i++){
		if(str[i].checked == true){
			chestr+=str[i].value+",";}}
	
	var str = document.getElementsByName("caseIosResult");
	for (i=0;i<str.length;i++){
		if(str[i].checked == true){
			chestr+=str[i].value+",";}}
	
	var str = document.getElementsByName("caseAndroidResult");
	for (i=0;i<str.length;i++){
		if(str[i].checked == true){
			chestr+=str[i].value+",";}}
	
	var str = document.getElementsByName("caseCSResult");
	for (i=0;i<str.length;i++){
		if(str[i].checked == true){
			chestr+=str[i].value+",";}}
	
	var str = document.getElementsByName("caseDeviceResult");
	for (i=0;i<str.length;i++){
		if(str[i].checked == true)	{
			chestr+=str[i].value+",";}}
		
	if(chestr == ""){
		alert("测试结果不能为空！");
		return false;}
		  
    //提交前弹框确认      
    var gnl=confirm("确定要执行吗?");
    if (gnl==true){
        return true;
    }else{
        return false;}
		
}
</script>

<!--  执行 TA的测试用例	-->

<% if request("action")="save" then  	
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_case where caseId="&request("caseId")&"",conn,3,3 
	rs1("case_lblId") = request("case_lblId")
	rs1("caseStep") = request("caseStep")
	rs1("caseWeb") = request("caseWeb")
	rs1("caseIos") = request("caseIos")
	rs1("caseAndroid") = request("caseAndroid")
	rs1("caseCs") = request("caseCS")
	rs1("caseDevice") = request("caseDevice")
	rs1("caseStage") = request("caseStage")
	rs1("caseWebResult") = request("caseWebResult")
	rs1("caseIosResult") = request("caseIosResult")
	rs1("caseAndroidResult") = request("caseAndroidResult")
	rs1("caseCSResult") = request("caseCSResult")
	rs1("caseDeviceResult") = request("caseDeviceResult")
	rs1("caseMemo") = request("caseMemo")
	rs1("caseExcDate") = now()
	if rs1("caseIosResult") = "ng" or rs1("caseAndroidResult") = "ng" or rs1("caseWebResult") = "ng" or rs1("caseCSResult") = "ng" or rs1("caseDeviceResult") = "ng" then
		rs1("caseResult") = "error"
	elseif request("caseIosResult") = "" and request("caseAndroidResult")= "" and request("caseWebResult") = "" and request("caseCSResult")= "" and request("caseDeviceResult") = "" then
		rs1("caseExcDate") = null
	else
		 rs1("caseResult") = "ok"
	end if 
	rs1("caseExcUser") = session("userName")
	rs1("caseStatus") = request("caseStatus")
	rs1("caseProblem") = request("caseProblem")
	rs1("caseErrorType") = request("caseErrorType")	
	rs1.update
	pjtId = rs1("case_pjtId")
	platformId = rs1("case_platformId")
	lblId = rs1("case_lblId")
	caseStage = rs1("caseStage")
	user = request("user")
	rs1.close
	set rs1 = nothing  
	if caseStatus = "2" then
		response.Write("<script>;alert('当前用例已暂停！');window.location.href='excTestcase-"&pjtId&"-"&platformId&"-"&lblId&"-"&caseStage&".html';</script>")
	elseif caseStatus = "3" then
		response.Write("<script>;alert('当前用例已搁置！');window.location.href='excTestcase-"&pjtId&"-"&platformId&"-"&lblId&"-"&caseStage&".html';</script>")		
	else
		response.Redirect("excTestcaseTa-"&pjtId&"-"&platformId&"-"&lblId&"-"&caseStage&"-"&user&".html")
	end if 
 end if %>
	

<!--  ajax-form	-->	
<script type="text/javascript" src="js/jo.ajax.js"></script>
<script type="text/javascript" src="js/ajax_form.js"></script>
<!--  ajax提示框效果	-->	
<link href="js/alertify.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.alertify.js"></script>

<script type="text/javascript" charset="gbk" src="ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="ueditor/ueditor.all.min.js"> </script>	
<script type="text/javascript" charset="gbk" src="ueditor/lang/zh-cn/zh-cn.js"></script>


<%
set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_case where caseId="&request("caseId")&" order by caseId DESC",conn,3,3 
	pjtId = rs("case_pjtId")
	platformId = rs("case_platformId")
	lblId = rs("case_lblId")
%>	

<%
Set rs1 = Server.CreateObject("Adodb.Recordset")
rs1.Open "select * from tbl_user where userName='"&request("user")&"'",conn,3,3
%>



<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit text-primary"><%=cstExcCase%> 之 <%=rs1("userNickname")%><%rs1.close%></i> </h1><p>execute testcase</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#"><%=cstExcCase%></a></li></ul></div>
	</div>
	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">
					<div class="box-body">

					<form role="form" action="excTestcaseEditTaSave.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
					
						<div class="box box-danger box-solid box-default">
							<div class="box-header with-border"><h3 class="box-title">
							<%
							set rs2 = server.createobject("adodb.recordset")
							rs2.open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3 
							set rs3 = server.createobject("adodb.recordset")
							rs3.open "select * from tbl_platform where plat_pjtId="&rs2("pjtId")&" and platformId="&platformId&"",conn,3,3 
							platformRedmine = rs3("platformRedmine")
							set rs4 = server.createobject("adodb.recordset")
							rs4.open "select * from tbl_label where lblId="&lblId&"",conn,3,3 
							lblName = rs4("lblName")%>
							
							<%=rs2("pjtName")%> - <%=rs3("platformName")%>
							<%rs4.close
							set rs4 = nothing
							rs3.close
							set rs3 = nothing
							rs2.close
							set rs2 = nothing
							%>
							</h3>
							</div>
		
							<div class="row">
								<div class="col-md-7">
									<div class="well bs-component">								
										<fieldset>
										<hr>	
										
										<div class="row">	
											<div class="col-md-12">
												<h4> <%=rs("caseTitle")%>（<%=cstr(rs("caseId"))%>）</h4>
											</div>
										</div>	
										
										<br>					
												
										<div class="row">	
											
											
											<div class="col-md-4">
												<label>用例标签 </label>
												<% set rs66 = server.createobject("adodb.recordset")
												rs66.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&"",conn,3,3 %>
												<select name="case_lblId" id="case_lblId" class="form-control ">
												<% do while not rs66.eof%>				
														<%if rs66("lblId") = lblId then%>
														<option value="<%=rs66("lblId")%>" selected><%=rs66("lblName")%></option>				
														<%else%>
														<option value="<%=rs66("lblId")%>" ><%=rs66("lblName")%></option>
														<%end if%>				
												<%rs66.movenext
												loop
												rs66.close
												set rs66 = nothing %>
												</select>
											</div>
						
											<div class="col-md-4">
												<label>测试阶段</label>
												<select name="caseStage" id="stageId" class="form-control" style="width: 100%;">
												<% if rs("caseStage") = 1 then %>
												  <option value="1" selected="selected">冒烟测试</option>
												  <option value="2">正式测试</option>
												  <option value="3">回归测试</option>
												<%end if %>
												<% if rs("caseStage") = 2 then %>
												  <option value="2" selected="selected">正式测试</option>
												  <option value="1">冒烟测试</option>
												  <option value="3">回归测试</option>
												<%end if %>
												<% if rs("caseStage") = 3 then %>
												  <option value="3" selected="selected">回归测试</option>
												  <option value="1">冒烟测试</option>
												  <option value="2">正式测试</option>
												<%end if %>
												</select>  
											</div>
	
											<div class="col-md-4">
											     <label>用例状态</label>
											     <select class="form-control" name="caseStatus">
												  <%if rs("caseStatus") = 1 then%>
													<option value="1" selected="selected">正常</option>
													<option value="2">暂停</option>
													<option value="3">搁置</option>
												  <% elseif rs("caseStatus") = 2 then%>
													 <option value="2" selected="selected">暂停</option>
													<option value="1">正常</option>
													<option value="3">搁置</option>
												  <% else%>
													<option value="3" selected="selected">搁置</option>
													<option value="1">正常</option>
													<option value="2">暂停</option>	
													<%end if %>
											     </select>
											</div>	
										</div>
					
										<br>
					
										<div class="row">
											<div class="col-md-12">
												<label >用例步骤 * </label>
													<script id="caseStep" style="width:100%; height:400px" name="caseStep"><%=rs("caseStep")%></script>	
													<script> var editor_a = UE.getEditor('caseStep');</script>
											</div>
										</div>
																						
										</fieldset>
									</div>
								</div>	
							
								<div class="col-md-5">	
									<br><br>															
									<div class="row">
										<div class="col-md-12">	
											<label>测试对象 *</label>	
											<div class="animated-checkbox">
												<label>
												<% if rs("caseWeb") = "on" then%>
													<input name="caseWeb" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseWeb" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-windows"></i> B/S</span></label>
												&nbsp;&nbsp;，																																																																															
												<label>
												<% if rs("caseIos") = "on" then%>
													<input name="caseIos" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseIos" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-apple"></i> iOS</span></label>
												&nbsp;&nbsp;，												
												<label>
												<% if rs("caseAndroid") = "on" then%>
													<input name="caseAndroid" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseAndroid" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-android"></i> android</span></label>
												&nbsp;&nbsp;，
												<label>
												<% if rs("caseCS") = "on" then%>
												<input name="caseCS" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseCS" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-archive"></i> C/S</span></label>
												&nbsp;&nbsp;，
												<label>
												<% if rs("caseDevice") = "on" then%>
												<input name="caseDevice" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseDevice" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-sitemap"></i> 终端设备</span></label>
											</div>
										</div>
									</div>
	
										<br><br>
									
									<div class="row">
									<div class="col-md-12">	
										<label class="control-label" for="focusedInput">需求问题类型</label>						
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_errortype ",conn,3,3 %>
										<select name="caseErrorType" id="caseErrorType" class="form-control select2">
										<option value=0  selected="selected">无</option>
										<% do while not rs66.eof%>
										<% if rs("caseErrorType") = rs66("errorId") then %>
										<option value=<%=rs66("errorId")%> selected="selected"><%=rs66("errorName")%></option>
										<%else%>
										<option value="<%=rs66("errorId")%>" ><%=rs66("errorName")%></option>
										<%end if %>
										<%rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>														
									</div>
									</div>
				
									<br>

									<div class="row">
									<div class="col-md-12">	
										<label class="control-label" for="focusedInput">需求问题描述</label> 
										<textarea  name="caseProblem" class="form-control" rows="8" placeholder="请注明日期"><%=rs("caseProblem")%></textarea>
									</div>		
									</div>
									
									<br>
									
									<div class="row">									
									<div class="col-md-12">										
										<label>测试备注：</label>
										<label><a href="<%=platformRedmine%>" target="_blank">buglist</i></a>
										</label>
										<textarea  name="caseMemo" class="form-control" rows="8" placeholder="Enter ..."><%=rs("caseMemo")%></textarea>
									</div>
									</div>
																
								<br>	
								
	
								<div class="row"> 
						
								<div class="col-md-12">
									<label>测试结果 *</label>
									<div class="box box-solid box-default">
									  <table class="table table-bordered">
										<tr>
										  <th style="white-space: nowrap;width: 20%;"><i class="fa fa-windows"></i> B/S 结果</th>
										  <th style="white-space: nowrap;width: 20%;"><i class="fa fa-apple"></i> iOS 结果</th>
										  <th style="white-space: nowrap;width: 20%;"><i class="fa fa-android"></i> android 结果</th>
										  <th style="white-space: nowrap;width: 20%;"><i class="fa fa-archive"></i> C/S 结果</th>
										  <th style="white-space: nowrap;width: 20%;"><i class="fa fa-sitemap"></i> device 结果</th>
										</tr>
										<tr>
										  <!-- web结果 -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <%if rs("caseWebResult") = "pass" then%><input  type="checkbox"  name="caseWebResult" value="pass" checked="checked" />
												  <%else%><input  type="checkbox"  name="caseWebResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-circle-o"></i> 正确</span></label>
											  </div>  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseWebResult") = "ng" then%><input  type="checkbox"  name="caseWebResult" value="ng"  checked="checked" />
												  <%else%><input type="checkbox" name="caseWebResult" value="ng"  />
												  <%end if %>
												    <span class="label-text"><i class="fa fa-close"></i> 错误</span></label>
											  </div>			  
										  </td>
										  
										  <!-- ios结果 -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseIosResult") = "pass" then%><input  type="checkbox"  name="caseIosResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseIosResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-circle-o"></i> 正确</span></label>
											  </div>			  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseIosResult") = "ng" then%><input  type="checkbox" name="caseIosResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseIosResult" value="ng"  />
												  <%end if %>
												 <span class="label-text"><i class="fa fa-close"></i> 错误</span></label>
											  </div>
										  </td>
										  
										  <!-- android结果 -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseAndroidResult") = "pass" then%><input  type="checkbox"  name="caseAndroidResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseAndroidResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-circle-o"></i> 正确</span></label>
											  </div>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseAndroidResult") = "ng" then%><input  type="checkbox" name="caseAndroidResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseAndroidResult" value="ng"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-close"></i> 错误</span></label>
											  </div>
										  </td>
										  
										  <!-- C/s结果 -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseCSResult") = "pass" then%><input  type="checkbox"  name="caseCSResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseCSResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-circle-o"></i> 正确</span></label>
											  </div>			  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseCSResult") = "ng" then%><input  type="checkbox" name="caseCSResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseCSResult" value="ng"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-close"></i> 错误</span></label>
											 </div>
										  </td>
										  
										  <!-- device结果 -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseDeviceResult") = "pass" then%><input  type="checkbox"  name="caseDeviceResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseDeviceResult" value="pass"  />
												  <%end if %>
												 <span class="label-text"><i class="fa fa-circle-o"></i> 正确</span></label>
											  </div>			  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseDeviceResult") = "ng" then%><input  type="checkbox" name="caseDeviceResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseDeviceResult" value="ng"  />
												  <%end if %>
												  <span class="label-text"><i class="fa fa-close"></i> 错误</span></label>
											  </div>
										  </td>
										</tr>									  
									  </table>
									</div>
								</div>
							</div> 
							</div>	
								
  
							<input name="caseId" type="hidden" value="<%=request("caseId")%>" />
							<input name="user" type="hidden" value="<%=request("user")%>" />
	
							<div class="col-md-12">		
											<br>	<br>		
								<div align="center"><button type="submit" class="btn btn-primary" style="margin-right: 5px;"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;执行用例</button></div>
							
							</div>	
						</div>					
					</form>	
				</div>
			</div>
		</div>
	</div>
</div>



	<div class="row">
			<div class="col-md-12" align="right">	
				<hr>
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
				<a id='DD'></a>		
			</div>
		</div>


<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="plugins/select2/select2.full.min.js"></script>
<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();   
  });
</script>

<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

</body>
</html>
