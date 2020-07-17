<!--#include file="frame.asp"-->


<%caseId = request("caseId") 
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_case where caseId="&caseId&"",conn,3,3
if rs.eof then
	response.Redirect("index.html")
else
	pjtId = rs("case_pjtId")
	platformId = rs("case_platformId")
	caseStage = rs("caseStage")
end if
rs.close
%>

<title><%=cstChangeCase%><%=caseId%> | <%=cstCompany%></title>

<!--  获取当前项目版本的所有用例标题 -->

<%
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" and caseId<>"&request("caseId")&" and caseStage="&caseStage&"",conn,3,3
Do while not rs.eof
	If arr_caseTitle = "" then
		arr_caseTitle = rs("caseTitle")
	else
		arr_caseTitle = arr_caseTitle&","&rs("caseTitle")
	end if
rs.Movenext
loop
rs.close
set rs = nothing 
%>


<script language="javascript">     
function CheckPost()
{		
	if (addForm.caseTitle.value == "")
      {
		  alert("温馨提示：用例标题不能为空", function () {
            }, {type: 'warning', confirmButtonText: '确定'});
          addForm.caseTitle.focus();
          return false;
      }

	// 用例标题去重
	var arr = addForm.arr_caseTitle.value
	arr = arr.split(",") 
	for(var i=0;i<arr.length;i++){
		if (addForm.caseTitle.value == arr[i]){
			alert("温馨提示：用例标题已存在！", function () {}, {type: 'warning', confirmButtonText: '确定'});
			addForm.caseTitle.focus();
			return false;}
	}
	
	//提交前弹框确认		
	var gnl=confirm("温馨提示：变更用例后需重新执行用例哦，确定要提交?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>

<script type="text/javascript" charset="gbk" src="ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="ueditor/ueditor.all.min.js"> </script>	
<script type="text/javascript" charset="gbk" src="ueditor/lang/zh-cn/zh-cn.js"></script>


<% 


' 提交
if request("action")="save" then
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_case where caseId="&caseId&"",conn,3,3
	rs1("case_lblId") = request("case_lblId")
	rs1("caseTitle") = request("caseTitle")
	rs1("caseStep") = request("caseStep")
	rs1("caseWeb") = request("caseWeb")
	rs1("caseIos") = request("caseIos")
	rs1("caseAndroid") = request("caseAndroid")
	rs1("caseCS") = request("caseCS")
	rs1("caseDevice") = request("caseDevice")
	rs1("caseStage") = request("caseStage")	
	rs1("caseStatus") = request("caseStatus")
	rs1("caseWebResult") = ""
	rs1("caseIosResult") = ""
	rs1("caseAndroidResult") = ""
	rs1("caseCSResult") = ""
	rs1("caseDeviceResult") = ""
	rs1("caseResult") = "empty"
	rs1("caseExcDate") = None
	rs1("caseExcUser") = ""
	rs1("caseErrorType") = request("caseErrorType")
	rs1("caseProblem") = request("caseProblem")
	rs1("caseLatestUser") = session("username")
	rs1("caseLatestDate") = now
	rs1.update
	pjtId = rs1("case_pjtId")
	platformId = rs1("case_platformId")
	lblId = rs1("case_lblId")
	caseStage = rs1("caseStage")
	rs1.close
	set rs1 = nothing
	response.Redirect("sltTestcaseList-"&pjtId&"-"&platformId&"-"&lblId&"-"&caseStage&".html")

end if 


set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_case where caseId="&caseId&" order by caseId DESC",conn,3,3 
pjtId = rs("case_pjtId")
platformId = rs("case_platformId")
lblId = rs("case_lblId")
set rs2 = server.createobject("adodb.recordset")
rs2.open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3 
pjtName = rs2("pjtName")
set rs3 = server.createobject("adodb.recordset")
rs3.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
platformName = rs3("platformName") 
set rs4 = server.createobject("adodb.recordset")
rs4.open "select * from tbl_label where lblId="&lblId&"",conn,3,3 
lblName = rs4("lblName")
rs4.close
set rs4 = nothing
rs3.close
set rs3 = nothing
rs2.close
set rs2 = nothing
%>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit text-warning"> <%=cstChangeCase%></i></h1><p>change testcase</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#"><%=cstChangeCase%></a></li></ul></div>
	</div>

	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">										
					<div class="box-body">
					
					<form role="form" action="sltTestcaseEditSave.html" method="post" name="addForm" onSubmit="return CheckPost()" >

						<div class="box box-danger box-solid box-default">	
						
							<div class="row">
								<div class="col-md-6" align="left">
									<h3 class="box-title"><% response.write pjtName + " - " + platformName %></h3>						
								</div>				
								<div class="col-md-6" align="right">								
									<button type="submit" class="btn btn-warning " href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;提交</button>	
									<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>		
								</div>	
							</div>
																		
							<hr>
						
							<div class="row">
								<div class="col-md-7">
									<div class="well bs-component">								
										<fieldset>																						
										<div class="row">	
											<div class="col-md-12">						
												<h4 class="box-title">用例标题 * (1<50)（ID：<%=caseId%>） </h4>
												<input type="text" name="caseTitle"  maxlength="50" value="<%=rs("caseTitle")%>" class="form-control">
											</div>	
										</div>		
										
										<br>												
										
										<div class="row">	
															
											<div class="col-md-4">
												<h4 class="box-title">用例标签</h4>
												<% set rs66 = server.createobject("adodb.recordset")
												rs66.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&"",conn,3,3 %>
												<select name="case_lblId" id="case_lblId" class="form-control">
												<%do while not rs66.eof%>
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
												<h4 class="box-title">测试阶段</h4>
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
											   <h4 class="box-title">用例状态</h4>
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
												<h4 class="box-title">用例步骤 * </h4>
												<script id="caseStep" style="width:100%; height:400px" name="caseStep"><%=rs("caseStep")%></script>	
												<script > var editor_a = UE.getEditor('caseStep');</script>
											</div>
										</div>				

										</fieldset>
									</div>
								</div>	
			
								<div class="col-md-5">	
																						
									<div class="row">
										<div class="col-md-12">	
											<h4 class="box-title">测试对象 *</h4>		
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
									
									<br>
									
									<div class="row">
										<div class="col-md-12">							
											<h4 class="box-title">需求问题类型 </h4>
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
										<h4 class="box-title">需求问题</h4>
										<textarea  name="caseProblem" class="form-control" rows="25" placeholder="请输入 ..."><%=rs("caseProblem")%></textarea>
										</div>
									</div>
									
								</div>
							</div>

							<input type="hidden" name="arr_caseTitle" value="<%=arr_caseTitle%>">
							<input type="hidden" name="caseId" value="<%=request("caseId")%>" />
							

	
							<div class="col-md-12">		
								<br>		
								<hr>				
								<div align="center"><button type="submit" class="btn btn-warning"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;提交</button></div>

							</div>	
						</div>					
					</form>	
				</div>
					<div class="col-md-12" align="right">						
						<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
						<a id='DD'></a>				
					</div>
			</div>
		</div>
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
