<!--#include file="frame.asp"-->

<title>新建测试报告 | <%=cstCompany%></title>
<script src="upload/js/plupload.full.min.js"></script>

<script language="javascript">
function CheckPost()
{
	
	//缺陷平台bug数不能为空及必须是整数
	if (addForm.rptIbug.value == "")
	{alert("iOS bug数不能为空！");addForm.rptIbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptIbug.value)) {alert("iOS bug数必须是整数！");addForm.rptIbug.focus();return false;}}
	  
	if (addForm.rptAbug.value == "")
	{alert("android bug数不能为空！");addForm.rptAbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptAbug.value)) {alert("android bug数必须是整数！");addForm.rptAbug.focus();return false;}}
	
	if (addForm.rptSbug.value == "")
	{alert("数据库/接口类 bug数不能为空！");addForm.rptSbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptSbug.value)) {alert("数据库/接口类 bug数必须是整数！");addForm.rptSbug.focus();return false;}}
	
	if (addForm.rptPbug.value == "")
	{alert("web php C/S bug数不能为空！");addForm.rptPbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptPbug.value)) {alert("web php C/S bug数必须是整数！");addForm.rptPbug.focus();return false;}}
  

	//缺陷严重程度bug数不能为空及必须是整数
	if (addForm.rptJdegree.value == "")
	{alert("紧急 bug数不能为空！");addForm.rptJdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptJdegree.value)) {alert("紧急 bug数必须是整数！");addForm.rptJdegree.focus();return false;}}
	  
	if (addForm.rptGdegree.value == "")
	{alert("高 bug数不能为空！");addForm.rptGdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptGdegree.value)) {alert("高 bug数必须是整数！");addForm.rptGdegree.focus();return false;}}
	
	if (addForm.rptPdegree.value == "")
	{alert("普通 bug数不能为空！");addForm.rptPdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptPdegree.value)) {alert("普通 bug数必须是整数！");addForm.rptPdegree.focus();return false;}}
	
	if (addForm.rptDdegree.value == "")
	{alert("低 bug数不能为空！");addForm.rptDdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptDdegree.value)) {alert("低 bug数必须是整数！");addForm.rptDdegree.focus();return false;}}
	
	
	//缺陷状态统计bug数不能为空及必须是整数
	if (addForm.rptWstatus.value == "")
	{alert("未处理 bug数不能为空！");addForm.rptWstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptWstatus.value)) {alert("未处理 bug数必须是整数！");addForm.rptWstatus.focus();return false;}}
	  
	if (addForm.rptCstatus.value == "")
	{alert("处理中 bug数不能为空！");addForm.rptCstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptCstatus.value)) {alert("处理中 bug数必须是整数！");addForm.rptCstatus.focus();return false;}}
	
	if (addForm.rptJstatus.value == "")
	{alert("已解决 bug数不能为空！");addForm.rptJstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptJstatus.value)) {alert("已解决 bug数必须是整数！");addForm.rptJstatus.focus();return false;}}
	
	if (addForm.rptFstatus.value == "")
	{alert("已反馈 bug数不能为空！");addForm.rptFstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptFstatus.value)) {alert("已反馈 bug数必须是整数！");addForm.rptFstatus.focus();return false;}}	
  
//提交前弹框确认		
var gnl=confirm("确定要提交?");
if (gnl==true){
return true;
}else{
return false;
}
 
}
</script>

<!--  新建报告 -->	

<%
if request("action") = "submit" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	rptBugQty = cstr(request("rptIbug")) + "," + cstr(request("rptAbug")) + "," + cstr(request("rptSbug")) + "," + cstr(request("rptPbug"))
	rptBugDegree = cstr(request("rptJdegree")) + "," + cstr(request("rptGdegree")) + "," + cstr(request("rptPdegree")) + "," + cstr(request("rptDdegree"))
	rptBugStatus = cstr(request("rptWstatus")) + "," + cstr(request("rptCstatus")) + "," + cstr(request("rptJstatus")) + "," + cstr(request("rptFstatus"))

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("rpt_pjtId") = pjtId
		rs("rpt_platformId") = platformId
		rs("rptStatus") = "undone"
		
		rs("rptNo") = request("rptNo")
		rs("rptGoal") = request("rptGoal")
		rs("rptCaption") = request("rptCaption")
		rs("rptRef") = request("rptRef")

		rs("rptTestObject") = request("rptTestObject")
		rs("rptScene") = request("rptScene")
		rs("rptTestGoal") = request("rptTestGoal")
		rs("rptStoryDate") = request("rptStoryDate")
		rs("rptStoryMemo") = request("rptStoryMemo")
		rs("rptDesignDate") = request("rptDesignDate")
		rs("rptDesignMemo") = request("rptDesignMemo")
		rs("rptExcDate") = request("rptExcDate")
		rs("rptExcMemo") = request("rptExcMemo")
		rs("rptBugDate") = request("rptBugDate")
		rs("rptBugMemo") = request("rptBugMemo")
				
		rs("rptMember") = request("rptMember")
		rs("rptBasis") = request("rptBasis")
		rs("rptSoft")= request("rptSoft")
		rs("rptHard")= request("rptHard")
		rs("rptTerminal") = request("rptTerminal")
		rs("rptTestWay") = request("rptTestWay")

		rs("rptBugQty") = rptBugQty
		rs("rptBugDegree") = rptBugDegree
		rs("rptBugStatus") = rptBugStatus 
		rs("rptTestResult") = request("rptTestResult")
		rs("rptOnlineResult") = request("rptOnlineResult")
		rs("rptFeedback") = request("rptFeedback")
		rs("rptRisk") = request("rptRisk")
		rs("rptConclusion") = request("rptConclusion")		
		rs("rptAdvice") = request("rptAdvice")

		rs("rptVedioPrefix") = request("rptVedioPrefix")	
		currentPath = server.mappath(Request.ServerVariables("SCRIPT_NAME"))
        currentPath = split(currentPath,"sltReport")(0) + "mp4"
		rs("rptVedioPath") = "\mp4" 
		'rs("rptRedminePic") = request("rptRedminePic")
		rs("rptAuthor") = session("userName")
		rs("rptCreatedDate") = now()
		x = ""
		for i=1 to 10
			if request("errStory"&i) = "" then
				x = x + "0," 
			else
				if i = 10 then
					x = x + cstr(abs(request("errStory"&i)))
				else			
					x = x + cstr(abs(request("errStory"&i))) + ","
				end if
				
			end if 
		Next
		rs("rptErrStory") = x	
		rs.update
	else
		response.Write("<script>;alert('警告！测试报告已创建，请联系管理员。');window.location.href='main.asp';</script>")
		response.end 
	end if 
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
	rs("verIsReport") = "undone"
	rs.update
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
	rs("pjtIsReport") = "on"
	rs.update
	rs.close
	set rs = nothing
	
	response.Redirect("sltReportShow.asp?pjtId="&pjtId&"&platformId="&platformId&"")
end if 
		



pjtId = request("pjtId")
platformId = request("platformId")

set rs = server.createobject("adodb.recordset")
set rs2 = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs("pjtName")

rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
pjtRedmine = rs2("platformRedmine")
platformName = rs2("platformName")
rs2.close
rs.close
set rs2 = nothing
set rs = nothing

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
platformName = rs1("platformName")
platformRedmine = rs1("platformRedmine")
rs1.close
%>

   
<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> 测试报告 - 新建测试报告</h1><p>create testReport</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">测试报告</a></li></ul></div>
	</div>
	
	<div class="card">	
	
		<form  action="sltReportCreateSubmit.html" method="post"  name="addForm" onSubmit="return CheckPost()" >		

	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">
														 
					<div class="row">					
						<div class="col-md-10" align="left"><h3 class="box-title"><%=pjtName%> - <%=platformName%> 测试报告</h3>
						</div>									
						
							
			
					<div class="col-md-2" align="right">
					<button type="submit" class="btn btn-primary " href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;提交</button>	
					<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>		
					</div>	
					</div>
					
					<hr>
															
					
<% set rs8 = server.createobject("adodb.recordset")
rs8.open "select * from tbl_report where rptId="&request("rptId")&" order by rptId desc ",conn,3,3 %>

<div class="row">  
	<div class="col-md-2">
		<div class="form-group">
			<h4 class="box-title">默认模板名</h4>
			
			<input type="text" name="rptNo" class="form-control" size="5" maxlength="20"  placeholder="请输入 ..." value="<%=pjtName%><%=platformName%>"></input>
			
		</div>	
	</div>
	
	<div class="col-md-2">	 
		<h4 class="box-title">导入模板</h4>
		<% set rs66 = server.createobject("adodb.recordset")
		rs66.open "select * from tbl_report where rptAuthor='"&session("userName")&"' and rpt_pjtId="&request("pjtId")&" order by rptId desc ",conn,3,3 %>		
		<select name="caseErrorType(<%=varcount%>)" id="caseErrorType" class="form-control select2" onChange="window.location=this.value;">
		<% if request("rptId") = "0" then%>
			<option value="sltReportCreate-<%=request("pjtId")%>-<%=request("platformId")%>-0.html" >请选择 ...</option>
		<%else%>
			<% set rs266 = server.createobject("adodb.recordset")
			rs266.open "select * from tbl_report where rptId="&request("rptId")&" order by rptId desc ",conn,3,3 %>		
			<option value="" ><%=rs266("rptNo")%></option>
			<%rs266.close%>
		<%end if %>
		<% do while not rs66.eof%>
		<option value="sltReportCreate-<%=request("pjtId")%>-<%=request("platformId")%>-<%=rs66("rptId")%>.html" ><%=rs66("rptNo")%></option>
		<%rs66.movenext
		loop
		rs66.close
		set rs66 = nothing %>
		</select>									
	</div>
</div>

<h3 class="box-title">第1章 引言</h3>
					
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 1.1 目的</h4><i>说明这份测试分析报告的具体编写目的及相关预期的读者范围。</i>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptGoal" class="form-control" rows="5" placeholder="请输入 ..."><%=rs8("rptGoal")%></textarea>
				<%else%>
				<textarea  name="rptGoal" class="form-control" rows="5" placeholder="XXX软件项目的测试报告，目的在于总结测试阶段的测试情况以及分析测试结果，描述系统是否符合需求（或达到XXX功能目标）并对测试质量进行分析。作为测试质量参考文档提供给用户、测试人员、开发人员、项目管理者、其他质量管理人员和需要阅读本报告的高层经理阅读。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>
		
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 1.2 名词解释</h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptCaption" class="form-control" rows="5" placeholder="缩写词或术语（中文/英文）。请输入 ..."><%=rs8("rptCaption")%></textarea>
				<%else%>
				<textarea  name="rptCaption" class="form-control" rows="5" placeholder="缩写词或术语（中文/英文）。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>
								

		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 1.3 参考及引用资料 </h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptRef" class="form-control" rows="5" placeholder="与之相关的文档和参考文献。请输入 ..."><%=rs8("rptRef")%></textarea>
				<%else%>
				<textarea  name="rptRef" class="form-control" rows="5" placeholder="与之相关的文档和参考文献。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>
		
<h3 class="box-title">第2章 测试概述</h3>

		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 2.1 测试对象</h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptTestObject" class="form-control" rows="5" placeholder="简要说明测试的软件。请输入 ..."><%=rs8("rptTestObject")%></textarea>
				<%else%>
				<textarea  name="rptTestObject" class="form-control" rows="5" placeholder="简要说明测试的软件。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>
		
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 2.2 项目背景 </h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptScene" class="form-control" rows="5" placeholder="简要说明及简史，参考需求、招标文件等。请输入 ..."><%=rs8("rptScene")%></textarea>
				<%else%>
				<textarea  name="rptScene" class="form-control" rows="5" placeholder="简要说明及简史，参考需求、招标文件等。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>
		
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 2.3 测试目的</h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptTestGoal" class="form-control" rows="5" placeholder="简要说明软件的测试目的（要点、范围）。请输入 ..."><%=rs8("rptTestGoal")%></textarea>
				<%else%>
				<textarea  name="rptTestGoal" class="form-control" rows="5" placeholder="简要说明软件的测试目的（要点、范围）。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>
		
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 2.4 测试进度表</h4>
					<div class="form-group">

					<table class="table table-bordered">
					<tr>               
					<th style="width: 20%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试类目</h4></th>
					<th style="width: 30%" bgcolor="#f1f1f1"><h4 class="box-title"> 开始结束日期</h4></th>				
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> 备注</h4></th>
					</tr>
					
					<tr>
					<td>需求文档分析</td>
					<td>
					 
					 <!-- Date range -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<%if request("rptId")<>0 then%>
								<input  name="rptStoryDate" class="form-control pull-right" id="reservation"  type="text" value="<%=rs8("rptStoryDate")%>">
							<%else%>
								<input  name="rptStoryDate" class="form-control pull-right" id="reservation"  type="text">
							<%end if%>
						
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					
					</td>
								  
	  
					<td>
					<div class="form-group">	
						<%if request("rptId")<>0 then%>
							<textarea  name="rptStoryMemo" class="form-control" rows="5" placeholder="请输入 ..."><%=rs8("rptStoryMemo")%></textarea>
						<%else%>
							<textarea  name="rptStoryMemo" class="form-control" rows="5" placeholder="请输入 ..."></textarea>
						<%end if%>					 
				
					</div>
					</td>
					</tr>
				
					<tr>
					<td>设计编写用例</td>
					<td> 
					
					 <!-- Date range -->
						<div class="input-group">
							<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
							<%if request("rptId")<>0 then%>
								<input  name="rptDesignDate" class="form-control pull-right" id="reservation1"  type="text" value="<%=rs8("rptDesignDate")%>">
							<%else%>
								<input  name="rptDesignDate" class="form-control pull-right" id="reservation1"  type="text">
							<%end if%>						
						</div>
					
					</td>
				
					
					<td>
					<div class="form-group">
						<%if request("rptId")<>0 then%>
							<textarea  name="rptDesignMemo" class="form-control" rows="5" placeholder="请输入 ..."><%=rs8("rptDesignMemo")%></textarea>
						<%else%>
							<textarea  name="rptDesignMemo" class="form-control" rows="5" placeholder="请输入 ..."></textarea>
						<%end if%>		
				
					</div>
					</td>
					</tr>
					
					<tr>
					<td>执行测试用例</td>
					<td> 
					
					 <!-- Date range -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
								<%if request("rptId")<>0 then%>
								<input  name="rptExcDate" class="form-control pull-right" id="reservation2"  type="text" value="<%=rs8("rptExcDate")%>">
							<%else%>
								<input  name="rptExcDate" class="form-control pull-right" id="reservation2"  type="text">
							<%end if%>
						
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				

					<td>
					<div class="form-group">
						<%if request("rptId")<>0 then%>
							<textarea  name="rptExcMemo" class="form-control" rows="5" placeholder="请输入 ..."><%=rs8("rptExcMemo")%></textarea>
						<%else%>
							<textarea  name="rptExcMemo" class="form-control" rows="5" placeholder="请输入 ..."></textarea>
						<%end if%>		
					
					</div>
					</td>
					</tr>
					
					<tr>
					<td>bug验证回归</td>
					<td> 
					
				 <!-- Date range -->
					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<%if request("rptId")<>0 then%>
								<input  name="rptBugDate" class="form-control pull-right" id="reservation3"  type="text" value="<%=rs8("rptBugDate")%>">
							<%else%>
								<input  name="rptBugDate" class="form-control pull-right" id="reservation3"  type="text">
							<%end if%>
						
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				
					
					<td>
					<div class="form-group"> 
						<%if request("rptId")<>0 then%>
							<textarea  name="rptBugMemo" class="form-control" rows="5" placeholder="请输入 ..."><%=rs8("rptBugMemo")%></textarea>
						<%else%>
							<textarea  name="rptBugMemo" class="form-control" rows="5" placeholder="请输入 ..."></textarea>
						<%end if%>	
				
					</div>
					</td>
					</tr>
					</table>
				</div>
			</div>
		</div>
		
	
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 2.5 参与人员</h4>
				<%if request("rptId")<>0 then%>
					<textarea  name="rptMember" class="form-control" rows="5" placeholder="如项目经理、产品、设计、开发、测试、实施等。请输入 ..."><%=rs8("rptMember")%></textarea>
				<%else%>
					<textarea  name="rptMember" class="form-control" rows="5" placeholder="如项目经理、产品、设计、开发、测试、实施等。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>


<h3 class="box-title">第3章 测试概要</h3>


			
		
        	<div class="col-md-12">
			<h4 class="box-title">3.1 测试用例</h3>	
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>
		
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
					<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 编号</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 标签</h4></th>
				<th style="width: 40%" bgcolor="#f1f1f1"><h4 class="box-title"> 标题</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试对象</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试阶段</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试结果</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">创建/执行者</h4></th>
				</tr>
				</thead>
				<tbody>	  
				<% set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseStage ,caseId asc",conn,3,3 
				do while not rs2.eof %>
					<tr>
					<td><a href="excTestcaseEdit.asp?caseId=<%=rs2("caseId")%>" target="_blank"><%=rs2("caseId")%></td>
					<td>
					<% set rs3 = server.createobject("adodb.recordset")
					rs3.open "select * from tbl_label where lblId="&rs2("case_lblId")&"  order by lblId asc",conn,3,3 
					response.write rs3("lblName")
					rs3.close
					%>
					</td>
					<td><%=rs2("caseTitle")%></td>
					<td> 
					<% varSum2 = ""
					if rs2("caseWeb") = "on" then
					varSum2 =  "B/S &nbsp;" + varSum2  
					end if
					if rs2("caseIos") = "on" then
					varSum2 =  "iOS &nbsp;" + varSum2  
					end if
					if rs2("caseAndroid") = "on" then
					varSum2 =  "android &nbsp;" + varSum2  
					end if
					if rs2("caseCS") = "on" then
					varSum2 =  "C/S &nbsp;" + varSum2  
					end if
					if rs2("caseDevice") = "on" then
					varSum2 =  "外设 &nbsp;" + varSum2  
					end if
					response.write varSum2 %>		
					</td>
					<td>
					<% if rs2("caseStage") =1 then
					response.write "冒烟"
					elseif rs2("caseStage") =2 then
					response.write "正式"
					elseif rs2("caseStage") =3 then
					response.write "回归"
					end if %>
					</td>
				    <td>
					<% if rs2("caseResult") ="error" then
					response.write "<font color=red>未通过</font>"
					elseif rs2("caseResult") = "ok" then
					response.write "<font color=green>通过</font>"
					elseif rs2("caseStatus") = "3" then
					response.write "<font color=black>搁置</font>"
					elseif rs2("caseStatus") = "2" then
					response.write "<font color=blue>暂停</font>"
					end if %>
					</td>
					<td>
						<%set rs4 = server.createobject("adodb.recordset")
						rs4.open "select * from tbl_user where userName='"&rs2("caseCreateUser")&"' order by userId ",conn,3,3 
						response.write rs4("userNickname")
						rs4.close%>
/
					<%if rs2("caseExcUser") <> "" then
						set rs5 = server.createobject("adodb.recordset")
						rs5.open "select * from tbl_user where userName='"&rs2("caseExcUser")&"' order by userId ",conn,3,3 
						response.write rs5("userNickname")
						rs5.close
					end if%>
					</td>
					</tr>
				<%rs2.movenext
				loop
				rs2.close %>   
				</tbody>
				<tfoot>
				
				</tfoot>
				</table>
			<% rs1.movenext
			loop
			rs1.close %> 
			</div><!-- /.col -->



		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 3.2 测试环境</h4>
					<%if request("rptId")<>0 then%>
						<textarea  name="rptBasis" class="form-control" rows="5" placeholder="依据项目情况，可能还需要其他环境描述。请输入 ..."><%=rs8("rptBasis")%></textarea>
					<%else%>
						<textarea  name="rptBasis" class="form-control" rows="5" placeholder="依据项目情况，可能还需要其他环境描述。请输入 ..."></textarea>
					<%end if%>
			</div>
		</div>

		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 3.3 软件/硬件说明</h4>
					<%if request("rptId")<>0 then%>
						<textarea  name="rptSoft" class="form-control" rows="5" placeholder="测试软件/其他工具。请输入 ..."><%=rs8("rptSoft")%></textarea>
					<%else%>
						<textarea  name="rptSoft" class="form-control" rows="5" placeholder="测试软件/其他工具。请输入 ..."></textarea>
					<%end if%>
					<br>
					<%if request("rptId")<>0 then%>
						<textarea  name="rptHard" class="form-control" rows="5" placeholder="服务器硬件。请输入 ..."><%=rs8("rptHard")%></textarea>
					<%else%>
						<textarea  name="rptHard" class="form-control" rows="5" placeholder="服务器硬件。请输入 ..."></textarea>
					<%end if%>
			</div>
		</div>

		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 3.4 测试终端/设备</h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptTerminal" class="form-control" rows="5" placeholder="测试硬件，如PC，ipad，扫描仪等。请输入 ..."><%=rs8("rptTerminal")%></textarea>
				<%else%>
				<textarea  name="rptTerminal" class="form-control" rows="5" placeholder="测试硬件，如PC，ipad，扫描仪等。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>

		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 3.5 测试方法</h4>
				<%if request("rptId")<>0 then%>
				<textarea  name="rptTestWay" class="form-control" rows="5" placeholder="黑盒测试（等价类划分法、边界值分析法、错误推测法、因果图法、判定表驱动法、正交试验设计法、功能图法、场景法等），白盒测试（代码检査法、静态结构分析法、静态质量度量法、逻辑覆盖法、基本路径测试法、域测试、符号测试、路径覆盖和程序变异），静态测试（MT），动态测试（DT），人工测试（MT），自动化测试（AT）。请输入 ..."><%=rs8("rptTestWay")%></textarea>
				<%else%>
				<textarea  name="rptTestWay" class="form-control" rows="5" placeholder="黑盒测试（等价类划分法、边界值分析法、错误推测法、因果图法、判定表驱动法、正交试验设计法、功能图法、场景法等），白盒测试（代码检査法、静态结构分析法、静态质量度量法、逻辑覆盖法、基本路径测试法、域测试、符号测试、路径覆盖和程序变异），静态测试（MT），动态测试（DT），人工测试（MT），自动化测试（AT）。请输入 ..."></textarea>
				<%end if%>
			</div>
		</div>



<h3 class="box-title">第4章 测试结果分析</h3>

		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 4.2 测试用例覆盖率</h4>
				
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 版本</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 标签</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 用例总数</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 已通过数</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 未通过数</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 未测试数(搁置/暂停）</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 通过覆盖率</h4></th>
				</tr>
				</thead>
				<tbody>
				<% set rs4 = server.createobject("adodb.recordset")
				rs4.open "select * from tbl_platform where platformId="&platformId&" order by platformId asc",conn,3,3 
				do while not rs4.eof 
					set rs5 = server.createobject("adodb.recordset")
					rs5.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3 
					do while not rs5.eof
						set rs6 = server.createobject("adodb.recordset")
						rs6.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" and case_lblId="&rs5("lblId")&" order by caseId asc",conn,3,3 %>
						<tr>
						<td><%=rs4("platformName")%></td>
						<td><%=rs5("lblName")%></td>
						<td><% if rs6.recordcount <> 0 then
						response.write rs6.recordcount
						end if %>
						</td>
						<td><%
						varOkSum3 = 0
						varErrorSum3 = 0
						varEmptySum3 = 0
							do while not rs6.eof
								if rs6("caseResult") = "ok" then
								   varOkSum3 = varOkSum3 + 1
								end if 
								if rs6("caseResult") = "error" then
								   varErrorSum3 = varErrorSum3 + 1
								end if 
								if rs6("caseResult")="empty" and rs6("caseStatus") = "1" then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
									if rs6("caseStatus") = "3" or rs6("caseStatus") = "2" then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
							rs6.movenext
							loop
						if varOkSum3 <> 0 then
						response.write varOkSum3
						end if %></td>
						<td><% if varErrorSum3 <> 0 then
						response.write varErrorSum3
						end if %></td>
						<td><% if varEmptySum3 <> 0 then
						response.write varEmptySum3
						end if %></td>
						<td><% 
						if rs6.recordcount <> 0 then
						response.write cstr(int((varOkSum3+varErrorSum3)/rs6.recordcount*100)) + "%"
						end if 
						rs6.close%>
						</td>
						</tr>
					<% rs5.movenext
					loop
					rs5.close
				rs4.movenext
				loop
				rs4.close %>	       
                </tbody>
                <tfoot>            
                </tfoot>
                </table>
			</div><!-- /.col -->
		


		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 4.3 缺陷统计表（<a href="<%=platformRedmine%>" target="_blank">禅道</i></a>）</h4>
				<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h4 class="box-title">4.3.1 缺陷平台</h4> 
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">系统平台</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug数</h4></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>iOS</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptIbug" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptAbug" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>数据库/接口类</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptSbug" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptPbug" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h4 class="box-title">4.3.2 缺陷严重程度</h4>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">严重程度</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug数</h4></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>紧急</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptJdegree" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>高</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptGdegree" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>普通</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptPdegree" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>低</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptDdegree" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
						<h4 class="box-title">4.3.3 缺陷状态</h4>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">缺陷状态</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug数</h4></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>未处理(新建)</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptWstatus" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>处理中</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptCstatus" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>已解决</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptJstatus" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					<tr>
					<td>已反馈</td>
					<td><div class="form-group">
					<input type="text" maxlength="3" name="rptFstatus" class="form-control"  oninput="value=value.replace(/[^\d]/g,'')">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			</div>
		</div>


		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 4.4 需求缺陷统计表</h4>
				
		<div class="box-body">
			<table id="example2" class="table table-bordered table-hover"><thead><tr>
			<%
			set rs4 = server.createobject("adodb.recordset")
			rs4.open "select * from tbl_errortype ",conn,3,3
			do while not rs4.eof%>			
				<th><%=rs4("errorName")%></th>
			<%						
			rs4.movenext
			loop
			rs4.movefirst
			%>		
			</tr></thead><tbody><tr>
			<% x = 0
			do while not rs4.eof
				x = x + 1%>
				<td><input maxlength="3" type="text" name="errStory<%=x%>" class="form-control" oninput="value=value.replace(/[^\d]/g,'')"></td>			
			<%rs4.movenext
			loop
			rs4.close%>
		
			</tr></tbody></table>
		</div>
			</div>
		</div>


<h3 class="box-title">第5章 测试总结与建议</h3>


		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 5.1 软件质量</h4>
				
<div class="col-md-2">							
<h4 class="box-title"> 测试环境结果</h4><br>
<div class="animated-radio-button">					   															
<label><input type="radio" name="rptTestResult" value="pass" ><span class="label-text"><font color="green"><i class="fa fa-check"></i>通过</font></span></label>&nbsp;&nbsp;	
<label><input type="radio" name="rptTestResult" value="failed" checked><span class="label-text"><font color="red"><i class="fa fa-close"></i>不通过</font></span></label>															
</div>
</div>
<div class="col-md-6">					
<h4 class="box-title"> 生产环境结果</h4><br>
<div class="animated-radio-button">
<label><input type="radio" name="rptOnlineResult" value="pass"><span class="label-text"><font color="green"><i class="fa fa-check"></i>通过</font></span></label>&nbsp;&nbsp;	
<label><input type="radio" name="rptOnlineResult" value="failed" checked><span class="label-text"><font color="red"><i class="fa fa-close"></i>不通过</font></span></label>									
</div>
</div>	
			</div>
		</div>
		

		<div class="col-md-12">
			<div class="form-group">
			<br>
				<h4 class="box-title"> 5.2 遗留问题</h4>
				<%if request("rptId")<>0 then%>
					<textarea  name="rptFeedback" class="form-control" rows="5" placeholder="本次软件迭代未能处理及未解决的已知问题。请输入 ..."><%=rs8("rptFeedback")%></textarea>
				<%else%>
					<textarea  name="rptFeedback" class="form-control" rows="5" placeholder="本次软件迭代未能处理及未解决的已知问题。请输入 ..."></textarea>
				<%end if%>	
			</div>
		</div>
		
		
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 5.3 软件风险</h4>
				   	<%if request("rptId")<>0 then%>
						<textarea  name="rptRisk" class="form-control" rows="5" placeholder="分析遗留问题（已知风险）及其他（未知风险，如网络，服务器断电，涉及第三方数据源等）。请输入 ..."><%=rs8("rptRisk")%></textarea>
					<%else%>
						<textarea  name="rptRisk" class="form-control" rows="5" placeholder="分析遗留问题（已知风险）及其他（未知风险，如网络，服务器断电，涉及第三方数据源等）。请输入 ..."></textarea>
					<%end if%>
			</div>
		</div>
		
		
		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 5.4 测试结论</h4><i>本次软件迭代的测试总结，应包含测试范围、缺陷范围、与测试计划是否相符、是否达到发布标准，是否可发布</i>
				<%if request("rptId")<>0 then%>
							<textarea  name="rptConclusion" class="form-control" rows="5" placeholder="如：经过两个阶段的多轮测试，虽遗留了一些缺陷没有解决，但系统功能已趋于稳定，且项目确定的范围、策略和测试计划均已实现，项目测试暂且结束， XXXX项目符合发布标准。请输入 ..."><%=rs8("rptConclusion")%></textarea>
					<%else%>
							<textarea  name="rptConclusion" class="form-control" rows="5" placeholder="如：经过两个阶段的多轮测试，虽遗留了一些缺陷没有解决，但系统功能已趋于稳定，且项目确定的范围、策略和测试计划均已实现，项目测试暂且结束， XXXX项目符合发布标准。请输入 ..."></textarea>
					<%end if%>	
			</div>
		</div>


		<div class="col-md-12">
			<div class="form-group">
				<h4 class="box-title"> 5.5 测试建议</h4>
					<%if request("rptId")<>0 then%>
							<textarea  name="rptAdvice" class="form-control" rows="5" placeholder="对软件各缺陷的改进建议，如 项目管理、遗留缺陷、产品设计、变更控制、版本控制、环境接口、用户体验建议等。请输入 ..."><%=rs8("rptAdvice")%></textarea>
						<%else%>
							<textarea  name="rptAdvice" class="form-control" rows="5" placeholder="对软件各缺陷的改进建议，如 项目管理、遗留缺陷、产品设计、变更控制、版本控制、环境接口、用户体验建议等。请输入 ..."></textarea>
						<%end if%>	
					
			</div>						
		</div>
		
	
			
		
		</div> <!-- .col --> 	 
			

		 <!-- /.col -->
 
		<div class="row">
			<div class="col-md-12">			
				<hr>  
				<div align="center"><button type="submit" class="btn btn-primary" style="margin-right: 5px;"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;提交</button></div>
				<br>
			</div>
</div></div>
</div>
</div>
			<input name="pjtId" type="hidden" value="<%=pjtId%>" />	
			<input name="platformId" type="hidden" value="<%=platformId%>" />
			<input name="rptCreatedDate" type="hidden" value="<%=now%>" />    
			
		</form>
	
			<div class="row">
				<div class="col-md-12" align="right">					
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
					<a id='DD'></a>		
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
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>

<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>


<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();

    //Date range picker
    $('#reservation').daterangepicker();
	$('#reservation1').daterangepicker();
	$('#reservation2').daterangepicker();
	$('#reservation3').daterangepicker();
   
  });
</script>
</body>
</html>
