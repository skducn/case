<!--#include file="frame.asp"-->

<!--  上传图片控件	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<title>编辑测试报告 <%=cstCompany%></title>

<script language="javascript">
function CheckPost()
{$.notify({title: "&nbsp;&nbsp;",message: "保存成功",icon: 'fa fa-check' },{type: "success"});

	
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
  
 
//需求缺陷统计
if (addForm.errStory1.value == "")
{alert("需求变更数不能为空！");addForm.errStory1.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory1.value)) {alert("需求变更数必须是整数！");addForm.errStory1.focus();return false;}}
  
if (addForm.errStory2.value == "")
{alert("需求描述不清数不能为空！");addForm.errStory2.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory2.value)) {alert("需求描述不清数必须是整数！");addForm.errStory2.focus();return false;}}

if (addForm.errStory3.value == "")
{alert("缺少逻辑或条件数不能为空！");addForm.errStory3.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory3.value)) {alert("缺少逻辑或条件数必须是整数！");addForm.errStory3.focus();return false;}}

if (addForm.errStory4.value == "")
{alert("缺少范围边界数不能为空！");addForm.errStory4.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory4.value)) {alert("缺少范围边界数必须是整数！");addForm.errStory4.focus();return false;}}	

if (addForm.errStory5.value == "")
{alert("文案缺失错误数不能为空！");addForm.errStory5.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory5.value)) {alert("文案缺失错误数必须是整数！");addForm.errStory5.focus();return false;}}
  
if (addForm.errStory6.value == "")
{alert("线框图缺失错误数不能为空！");addForm.errStory6.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory6.value)) {alert("线框图缺失错误数必须是整数！");addForm.errStory6.focus();return false;}}

if (addForm.errStory7.value == "")
{alert("设计图缺失错误数不能为空！");addForm.errStory7.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory7.value)) {alert("设计图缺失错误数必须是整数！");addForm.errStory7.focus();return false;}}

if (addForm.errStory8.value == "")
{alert("无场景说明数不能为空！");addForm.errStory8.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory8.value)) {alert("无场景说明数必须是整数！");addForm.errStory8.focus();return false;}}	
//缺陷状态统计bug数不能为空及必须是整数
if (addForm.errStory9.value == "")
{alert("缺失对象或权限数不能为空！");addForm.errStory9.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory9.value)) {alert("缺失对象或权限数必须是整数！");addForm.errStory9.focus();return false;}}
	  
if (addForm.errStory10.value == "")
{alert("其他数不能为空！");addForm.errStory10.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.errStory10.value)) {alert("其他数必须是整数！");addForm.errStory10.focus();return false;}}			
}
</script>


<!--  编辑报告	-->	
<%
if request("action") = "save" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	rptBugQty = cstr(request("rptIbug")) + "," + cstr(request("rptAbug")) + "," + cstr(request("rptSbug")) + "," + cstr(request("rptPbug"))
	rptBugDegree = cstr(request("rptJdegree")) + "," + cstr(request("rptGdegree")) + "," + cstr(request("rptPdegree")) + "," + cstr(request("rptDdegree"))
	rptBugStatus = cstr(request("rptWstatus")) + "," + cstr(request("rptCstatus")) + "," + cstr(request("rptJstatus")) + "," + cstr(request("rptFstatus"))
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId desc",conn,3,3
	if not rs.eof then
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
		rs("rptFeedback") = request("rptFeedback")
		rs("rptRisk") = request("rptRisk")
		rs("rptConclusion") = request("rptConclusion")
		rs("rptAdvice") = request("rptAdvice")		
		rs("rptTestResult") = request("rptTestResult")
		rs("rptOnlineResult") = request("rptOnlineResult")				
		rs("rptBugQty") = rptBugQty
		rs("rptBugDegree") = rptBugDegree
		rs("rptBugStatus") = rptBugStatus 			
		rs("rptVedioPrefix") = request("rptVedioPrefix")
		'rs("rptVedioPath") = getFolderSlt + "mp4" 
		rs("rptVedioPath") = "\mp4" 
		'rs("rptRedminePic") = request("rptRedminePic")  upload.asp已经上传了此文件。			
		rs("rptEditor") = session("userName")
		rs("rptLatestDate") = now()	
		rs("rptCaseTotal") = request("caseTotal")
		rs("rptCasePass") = request("casePass")
		rs("rptNoPass") = request("caseNoPass")
		rs("rptNoTest") = request("caseNoTest")
		rs("rptCaseCoverage") = request("caseCoverage")				
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
		response.Write("<script>;alert('警告！测试报告不存在，请联系管理员。');window.location.href='main.html';</script>")
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
	
	response.Redirect("sltReportShow-"&pjtId&"-"&platformId&".html")
end if 
%>


<% 
pjtId = request("pjtId")
platformId = request("platformId")	
set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs1("pjtName")
set rs2 = server.createobject("adodb.recordset")
rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
pjtRedmine = rs2("platformRedmine")
platformName = rs2("platformName")
rs1.close
rs2.close
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" and rptAuthor='"&session("userName")&"' order by rptId desc",conn,3,3
if rs.eof then
response.Redirect("index.html")
end if 
%>
  
  
<div class="content-wrapper">
	<div class="page-title">
		<div>
			<h1><i class="fa fa-edit"></i> 编辑测试报告</h1><p>edit testreport</p>
		</div>
		<div>
			<ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">编辑测试报告</a></li></ul>
		</div>
	</div>
																				
	<div class="card">
		<form id="form1" name="addForm" onSubmit="return CheckPost()" method="post" action="sltReportEditSave.html">
		
		<div class="row">
			<div class="col-md-6" align="left">
				<h1><%=pjtName%><%=platformName%> 测试报告
				<%if rs("rptStatus") = "done" then%>			
					（已完成）					
				<%elseif rs("rptStatus") = "undone" then%>
					（待审核）</h3>						
				<%else%>
					（已拒绝）																
				<%end if %>											
				</h1>
			</div>				
			<div class="col-md-6" align="right">
				<button type="submit" class="btn btn-primary " href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>		
			</div>	
		</div>

		<hr>
										
				
		<h1 >第1章 引言 </h1>	
							     					
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 1.1 目标</h3></div>
			<div class="form-group"><textarea  name="rptGoal" class="form-control" rows="5"><%=rs("rptGoal")%></textarea></div>
		</div>
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 1.2 名词解释</h3></div>
			<div class="form-group"><textarea  name="rptCaption" class="form-control" rows="5"><%=rs("rptCaption")%></textarea></div>
		</div>					
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 1.3 参考及引用资料</h3></div>
			<div class="form-group"><textarea  name="rptRef" class="form-control" rows="5"><%=rs("rptRef")%></textarea></div>
		</div>										
		
					
		<div class="row"></div>
		<br>				
					
		 
		<h1>第2章 测试概述</h1>

		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 2.1 测试对象</h3></div>
			<div class="form-group"><textarea  name="rptTestObject" class="form-control" rows="5"><%=rs("rptTestObject")%></textarea></div>
		</div>
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 2.2 项目背景</h3></div>
			<div class="form-group"><textarea  name="rptScene" class="form-control" rows="5"><%=rs("rptScene")%></textarea></div>
		</div>
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 2.3 测试目的</h3></div>
			<div class="form-group"><textarea  name="rptTestGoal" class="form-control" rows="5"><%=rs("rptTestGoal")%></textarea></div>
		</div>
							
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 2.4 测试进度表</h3></div>
			<div class="form-group">
			<table class="table table-bordered"><tr>
			<th style="width: 20%" bgcolor="#f1f1f1"><h3 class="box-title"> 测试类目</h3></th>
			<th style="width: 30%" bgcolor="#f1f1f1"><h3 class="box-title"> 开始结束日期</h3></th>
			<th style="width: 50%" bgcolor="#f1f1f1"><h3 class="box-title"> 备注</h3></th></tr>
			<tr><td>需求文档分析</td><td>
			<div class="form-group"><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="rptStoryDate" class="form-control pull-right" id="reservation" value="<%=rs("rptStoryDate")%>"></div></div></td>
			<td><div class="form-group"><textarea  name="rptStoryMemo" class="form-control" rows="5"><%=rs("rptStoryMemo")%></textarea></div></td></tr>
			
			<tr><td>设计编写用例</td><td> 
			<div class="form-group"><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="rptDesignDate" class="form-control pull-right" id="reservation1" value="<%=rs("rptDesignDate")%>"></div></div></td>
			<td><div class="form-group"><textarea  name="rptDesignMemo" class="form-control" rows="5"><%=rs("rptDesignMemo")%></textarea> </div></td></tr>
			
			<tr><td>执行测试用例</td><td> 
			<div class="form-group"><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="rptExcDate" class="form-control pull-right" id="reservation2" value="<%=rs("rptExcDate")%>"></div></div></td>
			<td><div class="form-group"><textarea  name="rptExcMemo" class="form-control" rows="5"><%=rs("rptExcMemo")%></textarea> </div></td></tr>
			
			<tr><td>bug验证回归</td><td> 
			<div class="form-group"><div class="input-group"><div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="rptBugDate" class="form-control pull-right" id="reservation3" value="<%=rs("rptBugDate")%>"></div></div></td>
			<td><div class="form-group"> <textarea  name="rptBugMemo" class="form-control" rows="5"><%=rs("rptBugMemo")%></textarea> </div></td></tr>
			</table>
			</div>
		</div>
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title">2.5 测试人员</h3></div>
			<div class="form-group"><textarea  name="rptMember" class="form-control" rows="5"><%=rs("rptMember")%></textarea></div>
		</div>
							
		<div class="row"></div>
		<br>			 

		
		<h1>第3章 测试方法</h1>					   
	
		<div class="col-md-12">
			<h3 class="box-title"> 3.1 测试用例</h3>	
			<table id="example2" class="table table-bordered table-hover"><thead><tr>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 用例编号</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 标签</h4></th>
			<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> 标题</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试对象</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试阶段</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title"> 测试结果</h4></th>
			</tr></thead><tbody>	  
			<% set rs2 = server.createobject("adodb.recordset")
			rs2.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseStage ,caseId asc",conn,3,3 
			do while not rs2.eof %>
			<tr><td><a href="excTestcaseEdit-<%=rs2("caseId")%>-<%=rs2("case_pjtId")%>.html" target="_blank"><%=rs2("caseId")%></td><td>
			<% set rs3 = server.createobject("adodb.recordset")
			rs3.open "select * from tbl_label where lblId="&rs2("case_lblId")&"  order by lblId asc",conn,3,3 
			response.write rs3("lblName")
			rs3.close
			%>
			</td><td><%=rs2("caseTitle")%></td><td> 
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
			</td><td>
			<% if rs2("caseStage") =1 then
			response.write "冒烟"
			elseif rs2("caseStage") =2 then
			response.write "正式"
			elseif rs2("caseStage") =3 then
			response.write "回归"
			end if %>
			</td><td>
			<% if rs2("caseResult") ="error" then
			response.write "<font color=red>未通过</font>"
			elseif rs2("caseResult") = "ok" then
			response.write "<font color=green>通过</font>"
			elseif rs2("caseStatus") = "3" then
			response.write "<font color=grey>搁置</font>"
			elseif rs2("caseStatus") = "2" then
			response.write "<font color=blue>暂停</font>"
			end if %>
			</td></tr>
			<%rs2.movenext
			loop
			rs2.close %>   
			</tbody></table>				
		</div>
	
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 3.2 测试环境</h3></div>
			<div class="form-group"><textarea  name="rptBasis" class="form-control" rows="5" ><%=rs("rptBasis")%></textarea></div>
		</div>
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title">3.3 软件说明</h3></div>
			<div class="form-group"><textarea  name="rptSoft" class="form-control" rows="5" ><%=rs("rptSoft")%></textarea></div>
		</div>
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title">3.4 硬件说明</h3></div>
			<div class="form-group"><textarea  name="rptHard" class="form-control" rows="5" ><%=rs("rptHard")%></textarea></div>
		</div>
		
			
		<!-- 上传图片，参数 pjtId, platformId -->
		<div class="col-md-12">
			<div id="container1">
				<a id="pickfiles1" >请选择服务器架构拓扑图</a>														
				<div id="filelist1"></div>				
				<br>
				<a id="uploadfiles1" href="javascript:;"><button type="submit" class="btn btn-success pull-left" href="#">上传</button></a> 
			</div>	
			<script id="testScript" src="upload/js/uploadRedmine.js" pjtId="<%=pjtId%>" platformId="<%=platformId%>"></script>										
		</div>
		
		<div class="row"></div>	<br>
		
		<!--  显示上传的图片 --> 
		<div class="col-md-12">		
			<% 
			rptHardPic = split(replace(rs("rptHardPic"),"*",""),",")					
			for i=1 to ubound(rptHardPic)%>							
					<p><img src=<%="upload\plupload\"+rptHardPic(i)%>>					
						
					</p>
			<%next%>
			
			<br>
		</div>
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title">3.5 测试终端设备</h3></div>
			<div class="form-group"><textarea  name="rptTerminal" class="form-control" rows="5" ><%=rs("rptTerminal")%></textarea></div>
		</div>
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title">3.6 测试方法</h3></div>
			<div class="form-group"><textarea  name="rptTestWay" class="form-control" rows="5" ><%=rs("rptTestWay")%></textarea></div>
		</div>
		
		
		<div class="row"></div>
		<br>	
		
		<h1>第4章 测试结果分析</h1>
					 

		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title">4.1 测试覆盖率</h3></div>
			<table id="example2" class="table table-bordered table-hover"><thead><tr>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 版本</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 标签</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 用例总数</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 已通过数</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 未通过数</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 未测试数(搁置/暂停）</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title"> 用例执行覆盖率</h4></th>
			</tr></thead><tbody>
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
			<td>
			<%if rs("rptCaseTotal") <> "" then %>
			
				<input maxlength="6" type="text" name="caseTotal" class="form-control" value="<%=rs6.recordcount%>" readonly="">				 
			<%end if %>				
			</td>
			<%
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
			if rs6("caseResult")= "empty" and rs6("caseStatus") = "1" then
				varEmptySum3 = varEmptySum3 + 1
			end if 
			if rs6("caseStatus") = "2" then
				varEmptySum3 = varEmptySum3 + 1
			end if 
			if rs6("caseStatus") = "3" then
				varEmptySum3 = varEmptySum3 + 1
			end if 
			rs6.movenext
			loop
			 caseCoverage = cstr(int((varOkSum3+varErrorSum3)/rs6.recordcount*100)) + "%" 
			%>
			
			<td>				
			<%if rs("rptCasePass") <> "" then %>			
				<input maxlength="6" type="text" name="casePass" class="form-control" value="<%=varOkSum3%>" readonly="">				 
			<%end if %>
			</td>
			
			<td>
			<%if rs("rptNoPass") <> "" then %>				
				<input maxlength="6" type="text" name="caseNoPass" class="form-control" value="<%=varErrorSum3%>" readonly="">				 
			<%end if %>
			</td>
			
			<td>
			<%if rs("rptNoTest") <> "" then %>				
				<input maxlength="6" type="text" name="caseNoTest" class="form-control" value="<%=varEmptySum3%>" readonly="">				 
			<%end if %>
			</td>
			
			<td>
			<%if rs("rptCaseCoverage") <> "" then %>													
				<input maxlength="6" type="text" name="caseCoverage" class="form-control" value="<%=caseCoverage%>" readonly="">				 
			<%end if 
		
			rs6.close%>
			</td>
			</tr>
			<% rs5.movenext
			loop
			rs5.close
			rs4.movenext
			loop
			rs4.close %>	       
			</tbody></table>
		</div>

		<div class="col-md-12">
			<h3 class="box-title"> 4.2 缺陷统计(<a href="<%=platformRedmine%>" target="_blank">禅道</i></a>)</h3>

			<div class="col-md-4">	
				<div class="box">
					<div class="box-header"><h3 class="box-title">4.2.1 缺陷平台统计</h3></div>
					<div class="box-body"><table id="example2" class="table table-bordered table-hover"><thead><tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> 系统平台</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> Bug数</h4></th></tr></thead><tbody><tr> 
					<td>iOS</td><td><div class="form-group"><input maxlength="3" type="text" name="rptIbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(0)%>" oninput="value=value.replace(/[^\d]/g,'')" ></div></td></tr><tr>
					<td>android</td><td><div class="form-group"><input maxlength="3" type="text" name="rptAbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(1)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>数据库/接口类</td><td><div class="form-group"><input maxlength="3" type="text" name="rptSbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(2)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>web php C/S</td><td><div class="form-group"><input maxlength="3" type="text" name="rptPbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(3)%>" oninput="value=value.replace(/[^\d]/g,'')">
			</td></tr></tbody></table>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="box">
					<div class="box-header"><h3 class="box-title">4.2.2 缺陷严重程度统计</h3></div>
					<div class="box-body"><table id="example2" class="table table-bordered table-hover"><thead><tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> 严重程度</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> Bug数</h4></th></tr></thead><tbody><tr>
					<td>紧急</td><td><div class="form-group"><input maxlength="3" type="text" name="rptJdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(0)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>高</td><td><div class="form-group"><input maxlength="3" type="text" name="rptGdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(1)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>普通</td><td><div class="form-group"><input maxlength="3" type="text" name="rptPdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(2)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>低</td><td><div class="form-group"><input maxlength="3" type="text" name="rptDdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(3)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr></tbody></table>
					</div>
				</div>
			</div>

			<div class="col-md-4">
				<div class="box">
					<div class="box-header"><h3 class="box-title">4.2.3 缺陷状态统计</h3></div>
					<div class="box-body"><table id="example2" class="table table-bordered table-hover"><thead><tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> 缺陷状态</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title"> Bug数</h4></th></tr></thead><tbody><tr>
					<td>未处理(新建)</td><td><div class="form-group"><input maxlength="3" type="text" name="rptWstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(0)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>处理中</td><td><div class="form-group"><input maxlength="3" type="text" name="rptCstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(1)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>已解决</td><td><div class="form-group"><input maxlength="3" type="text" name="rptJstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(2)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr><tr>
					<td>已反馈</td><td><div class="form-group"><input maxlength="3" type="text" name="rptFstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(3)%>" oninput="value=value.replace(/[^\d]/g,'')"></div></td></tr></tbody></table>
					</div>
				</div>
			</div>			
		</div>
	

		<div class="col-md-12">	
			<div class="box-header"><h3 class="box-title">4.3 需求缺陷统计</h3></div>
			<div class="box-body">
				<table id="example2" class="table table-bordered table-hover"><thead><tr>
				<%
				set rs4 = server.createobject("adodb.recordset")
				rs4.open "select * from tbl_errortype ",conn,3,3
				do while not rs4.eof%>			
					<th bgcolor="#f1f1f1"><%=rs4("errorName")%></th>
				<%						
				rs4.movenext
				loop
				rs4.movefirst
				%>		
				</tr></thead><tbody><tr>
				<% x = 0
				do while not rs4.eof
					x = x + 1%>
					<td><input maxlength="3" type="text" name="errStory<%=x%>" class="form-control" value="<%=split(rs("rptErrStory"),",")(x-1)%>"></td>			
				<%rs4.movenext
				loop
				rs4.close%>
			
				</tr></tbody></table>
			</div>
		</div>
	
		
	
		<div class="row"></div>
		<br>	
		

		<h1>第5章 测试总结与建议</h1>

		<div class="col-md-12">
			<h3 class="box-title"> 5.1 软件质量</h3>					  
			<div class="col-md-2">							
				<h4 class="box-title"> 测试环境结果</h4><br>
				<div class="animated-radio-button">
				<%if rs("rptTestResult") = "pass" then%>									
				<label><input type="radio" name="rptTestResult" value="pass" checked><span class="label-text"><font color="green"><i class="fa fa-check"></i>通过</font></span></label>&nbsp;&nbsp;	
				<label><input type="radio" name="rptTestResult" value="failed"><span class="label-text"><font color="red"><i class="fa fa-close"></i>不通过</font></span></label>															
				<%else%>
				<label><input type="radio" name="rptTestResult" value="pass"><span class="label-text"><font color="green"><i class="fa fa-check"></i>通过</font></span></label>&nbsp;&nbsp;
				<label><input type="radio" name="rptTestResult" value="failed" checked><span class="label-text"><font color="red"><i class="fa fa-close"></i>不通过</font></span></label>									
				<%end if %>								
				</div>
			</div>						
			
			<div class="col-md-6">					
				<h4 class="box-title"> 生产环境结果</h4><br>
				<div class="animated-radio-button">
				<% if rs("rptOnlineResult") = "pass" then%>
				<label><input type="radio" name="rptOnlineResult" value="pass" checked><span class="label-text"><font color="green"><i class="fa fa-check"></i>通过</font></span></label>	&nbsp;&nbsp;
				<label><input type="radio" name="rptOnlineResult" value="failed"><span class="label-text"><font color="red"><i class="fa fa-close"></i>不通过</font></span></label>															
				<%else%>
				<label><input type="radio" name="rptOnlineResult" value="pass"><span class="label-text"><font color="green"><i class="fa fa-check"></i>通过</font></span></label>&nbsp;&nbsp;
				<label><input type="radio" name="rptOnlineResult" value="failed" checked><span class="label-text"><font color="red"><i class="fa fa-close"></i>不通过</font></span></label>									
				<%end if %>	
				</div>
			</div>	
		</div>
		
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.2 遗留问题</h3></div>
			<div class="form-group"><textarea  name="rptFeedback" class="form-control" rows="5" ><%=rs("rptFeedback")%></textarea></div>
		</div>
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.3 软件风险</h3></div>
			<div class="form-group"><textarea  name="rptRisk" class="form-control" rows="5" ><%=rs("rptRisk")%></textarea></div>
		</div>
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.4 测试结论</h3></div>
			<div class="form-group"><textarea  name="rptConclusion" class="form-control" rows="5" ><%=rs("rptConclusion")%></textarea></div>
		</div>
		
		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.5 测试建议</h3></div>
			<div class="form-group"><textarea  name="rptAdvice" class="form-control" rows="5" ><%=rs("rptAdvice")%></textarea></div>
		</div>
		
  		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.6 附图</h3></div>
			
			<!-- 上传图片，参数 pjtId, platformId -->
			<div class="col-md-12">
				<div id="container2">
					<a id="pickfiles2" >请选择图片</a>														
					<div id="filelist2"></div>				
					<br>
					<a id="uploadfiles2" href="javascript:;"><button type="submit" class="btn btn-success pull-left" href="#">上传</button></a> 
				</div>	
				<script id="testScript2" src="upload/js/uploadRedmine2.js" pjtId="<%=pjtId%>" platformId="<%=platformId%>"></script>										
			</div>
			
			<div class="row"></div>	<br>
			
			<!--  显示上传的图片 --> 
			<div class="col-md-12">		
				<%rptRedminePic = split(replace(rs("rptRedminePic"),"*",""),",")					
				for i=1 to ubound(rptRedminePic)%>				
					<p><img src=<%="upload\plupload\"+rptRedminePic(i)%>>					
						<h3><% response.write "附图"&i %></h3><br>
					</p>				
				<%next%>
				
				<br>
			</div>

		</div>
	



		<div class="row">
			<div class="col-md-12">	
				<hr>
				<div align="center"><button type="submit" class="btn btn-primary" ><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button></div>
			</div>
		</div>
		
		
		<input name="pjtId" type="hidden" value="<%=pjtId%>" />
		<input name="platformId" type="hidden" value="<%=platformId%>" />
		<input name="rptLatestdDate" type="hidden" value="<%=now%>" />		
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
<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script>
<!-- Select2 -->
<script src="plugins/select2/select2.full.min.js"></script>
<!-- InputMask -->
<script src="plugins/input-mask/jquery.inputmask.js"></script>
<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="plugins/iCheck/icheck.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>

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
