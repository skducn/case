<!--#include file="admFrame.asp"-->

<title><%=admReportAudit%> | <%=admProject%></title>

<script language="javascript">     
function CheckPost()
{		
	
	//提交前弹框确认		
	var gnl=confirm("是否审核不通过，确定吗？");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>

<%
pjtId = request("pjtId")
platformId = request("platformId")
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId desc",conn,3,3
if rs.recordcount = 0 then
	response.Redirect("../index.html")
end if 
%>

<!--  重新审核，恢复到待审核 -->	

<% 
if request("action") = "revise" then
set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
	rs("rptStatus") = "undone"
	rs("rptRejectReason") = ""
	rs("rptDoneDate") = now()
	rs.update
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId DESC",conn,3,3
	rs("verIsReport") = "undone"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admMain.html")
end if
%>



<!--  审核通过 -->	

<% 
if request("action") = "audit" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
	rs("rptStatus") = "done"
	rs("rptRejectReason") = ""
	rs("rptDoneDate") = now()
	rs.update
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId DESC",conn,3,3
	rs("verIsReport") = "done"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admMain.html")
end if %>


<!--  审核不通过 -->	

<% 
if request("action") = "noAudit" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
	rs("rptStatus") = "reject"
	rs("rptRejectReason") = request("rejectReason")
	rs("rptDoneDate") = now()
	rs.update
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId DESC",conn,3,3
	rs("verIsReport") = "reject"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admMain.html")
end if %>

<% 

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs1("pjtName")
rs1.close

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
platformRedmine = rs1("platformRedmine")
platformName = rs1("platformName")
rs1.close

%>

  
<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">filter_1</span> 报告管理 </h2>
			<p class="text-muted m-0 desc">Report Panel</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 
	
<div class="content">
<div class="card mb-4">				
<div class="card-body">		 


			<div class="row">
			<div class="col-md-10">	
			<h2>
			
			<% if rs("rptStatus") = "undone" then%>
				<%=rs("rptName")%>（未审核）
			<% elseif rs("rptStatus") = "reject" then%>	
				<%=rs("rptName")%>（已拒绝）
			<%else%>
				<%=rs("rptName")%>（已完成）
			<%end if %>
			
			</h2>	</div>
			<div class="col-md-2" align="right">	
			<a href="#DD" ><button class="btn btn-info px-2 rounded mx-0"><i class="material-icons">arrow_downward</i></button></a>
			</div>
			</div>
	
		

		
		<hr>
	
	
<h2>第1章 引言 </h2>
	
	<div class="col-md-12">	
	<h3 class="box-title"> 1.1 目的</h3>						
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptGoal"),chr(13),"<BR>")%></p>				
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 1.2 名称解释</h3>						
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptCaption"),chr(13),"<BR>")%></p>				
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 1.3 参考及引用资料</h3>						
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptRef"),chr(13),"<BR>")%></p>				
	</div>	
				
				     

<br><h2>第2章 测试概述 </h2>

	<div class="col-md-12">	
	<h3 class="box-title"> 2.1 测试对象</h3>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTestObject"),chr(13),"<BR>")%></p>				
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 2.2 项目背景</h3>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptScene"),chr(13),"<BR>")%></p>
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 2.3 测试目的</h3>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTestGoal"),chr(13),"<BR>")%></p>					
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 2.4 测试进度表</h3><br>								
	<div class="form-group">
	<table class="table table-bordered"><tr>               
	<th style="width: 20%" bgcolor="#f1f1f1"><h5>测试类目</h5></th>
	<th style="width: 20%" bgcolor="#f1f1f1"><h5>开始结束日期</h5></th>
	<th style="width: 60%" bgcolor="#f1f1f1"><h5>备注</h5></th>
	</tr>
	<tr><td>需求文档分析</td><td><div class="form-group"><div class="input-group"><%=rs("rptStoryDate")%> </div></div></td>
	<td><div class="form-group"><textarea  name="rptStoryMemo" class="form-control" rows="5" disabled><%=rs("rptStoryMemo")%></textarea></div></td></tr>
	<tr><td>设计编写用例</td><td> <div class="form-group"><div class="input-group"><%=rs("rptDesignDate")%></div></div></td>
	<td><div class="form-group"><textarea  name="rptDesignMemo" class="form-control" rows="5" disabled><%=rs("rptDesignMemo")%></textarea> </div></td></tr>
	<tr><td>执行测试用例</td><td> <div class="form-group"><div class="input-group"><%=rs("rptExcDate")%></div></div></td>
	<td><div class="form-group"><textarea  name="rptExcMemo" class="form-control" rows="5" disabled><%=rs("rptExcMemo")%></textarea></div></td></tr>	
	<tr><td>bug验证回归</td><td><div class="form-group"><div class="input-group"><%=rs("rptBugDate")%></div></div></td>			
	<td><div class="form-group"> <textarea  name="rptBugMemo" class="form-control" rows="5" disabled><%=rs("rptBugMemo")%></textarea></div></td></tr>
	</table>
	</div>
			
			
	<div class="col-md-12">	
	<h3 class="box-title"> 2.5 测试人员</h3><br>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptMember"),chr(13),"<BR>")%></p>					
	</div>	
				
		
				
			
<br><h2>第3章 测试方法 </h2>
			
		
<div class="col-md-12">

	<h3 class="box-title"> 3.1 测试用例</h3><br>
        	
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>
			
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 10%" bgcolor="#f1f1f1"><h5>编号</h5></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h5>标签</h5></th>
				<th style="width: 40%" bgcolor="#f1f1f1"><h5>标题</h5></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h5>测试对象</h5></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h5>测试阶段</h5></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h5>测试结果</h5></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h5>创建/执行者</h5></th>
				</tr>
				</thead>
				<tbody>	  
				<% set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseStage ,caseId asc",conn,3,3 
				do while not rs2.eof %>
					<tr>
					<td><a href="../excTestcaseEdit-<%=rs2("caseId")%>-<%=rs2("case_pjtId")%>.html" target="_blank"><%=rs2("caseId")%></td>
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
	<h3 class="box-title"> 3.2 测试环境</h3><br>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptBasis"),chr(13),"<BR>")%></p>					
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 3.3 软件/硬件说明</h3><br>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptSoft"),chr(13),"<BR>")%></p>		
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptHard"),chr(13),"<BR>")%></p>	
		<!--  显示图片 --> 
			<% if rs("rptHardPic") <> "*" then  
				rptHardPic = split(replace(rs("rptHardPic"),"*",""),",")					
				for i=1 to ubound(rptHardPic)														
			%>				
					<p><a href="sltReportShowDel-<%=pjtId%>-<%=platformId%>-<%=rptHardPic(i)%>.html" onClick="return confirm('是否要删除此图片？')" >
					<img src=<%="uploadPic\plupload\"+rptHardPic(i)%>> </a>
					</p>
				<%next%>
			<% end if %>			
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 3.4 测试终端/设备</h3><br>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTerminal"),chr(13),"<BR>")%></p>					
	</div>	
	
	<div class="col-md-12">	
	<h3 class="box-title">3.5 测试方法</h3><br>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTestWay"),chr(13),"<BR>")%></p>					
	</div>	

		
			
		  
	


<br><h2>第4章 测试结果及缺陷分析 </h2>
		
	<div class="col-md-12">
	<h3 class="box-title"> 4.1 测试用例覆盖率</h3>
	<table id="example2" class="table table-bordered table-hover">
	<thead>
	<tr> 

	<th style="width: 14.28%" bgcolor="#f1f1f1"><h5>标签</h5></th>
	<th style="width: 14.28%" bgcolor="#f1f1f1"><h5>用例总数</h5></th>
	<th style="width: 14.28%" bgcolor="#f1f1f1"><h5>已通过数</h5></th>
	<th style="width: 14.28%" bgcolor="#f1f1f1"><h5>未通过数</h5></th>
	<th style="width: 14.28%" bgcolor="#f1f1f1"><h5>未测试数</h5></th>
	<th style="width: 14.28%" bgcolor="#f1f1f1"><h5>执行覆盖率%</h5></th>
	</tr>
	</thead>
	<tbody>
	<% set rs4 = server.createobject("adodb.recordset")
	rs4.open "select * from tbl_platform where platformId="&platformId&" order by platformId asc",conn,3,3 
	do while not rs4.eof 
		set rs5 = server.createobject("adodb.recordset")
		rs5.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3 
			do while not rs5.eof
			 %>
			<tr>
			
			<td><%=rs5("lblName")%></td>						
			<td><% 
			response.write rs("rptCaseTotal") 
			 %>
			</td>
			<td><%				
			
				response.write rs("rptCasePass")
			%>							
			</td>
			<td>
			<% 
				response.write rs("rptNoPass")
			 %>
			</td>
			<td>
			<% 
				response.write rs("rptNoTest")
			 %>
			</td>
			<td>
			<%  
				response.write rs("rptCaseCoverage")
			 
			%>
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
	</div>
		
			
		

		<div class="col-md-12">
		<h3 class="box-title"> 4.2 缺陷统计（<a href="<%=platformRedmine%>" target="_blank">禅道</i></a>）</h3>
				
		<br>
		

		<div class="row">	
				
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">4.2.1 缺陷平台统计</h3> 
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h5>系统平台</h5></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h5>Bug数量</h5></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>iOS</td>
					<td><div class="form-group">
					<input type="text" name="rptIbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(0)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<input type="text" name="rptAbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(1)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>数据库/接口类</td>
					<td><div class="form-group">
					<input type="text" name="rptSbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(2)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<input type="text" name="rptPbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(3)%>" disabled>
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
					<h3 class="box-title">4.2.2 缺陷严重程度</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h5>严重程度</h5></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h5>Bug数量</h5></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>紧急</td>
					<td><div class="form-group">
					<input type="text" name="rptJdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(0)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>高</td>
					<td><div class="form-group"> 
					<input type="text" name="rptGdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(1)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>普通</td>
					<td><div class="form-group">
					<input type="text" name="rptPdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(2)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>低</td>
					<td><div class="form-group">
					<input type="text" name="rptDdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(3)%>" disabled>
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
					<h3 class="box-title">4.2.3 缺陷状态统计</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h5>缺陷状态</h5></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h5>Bug数量</h5></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>未处理(新建)</td>
					<td><div class="form-group">
					<input type="text" name="rptWstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(0)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>处理中</td>
					<td><div class="form-group">
					<input type="text" name="rptCstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(1)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>已解决</td>
					<td><div class="form-group">
					<input type="text" name="rptJstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(2)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>已反馈</td>
					<td><div class="form-group">
					<input type="text" name="rptFstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(3)%>" disabled>
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
			
				<!--  上传redmine截图 --> 
				<% if  instr(rs("rptRedminePic"),"upload") then%>						
						<img src=<%="../"&rs("rptRedminePic")%> /><br><br>			
				<% end if %>
				
				
				

<br><h2>第5章 测试总结与建议</h2>

			
	<div class="col-md-12">	
	<h3 class="box-title"> 5.1 软件质量</h3>
	<label>测试环境结果：</label>
	<% if rs("rptTestResult") = "pass" then %>
	&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;通过</font>
	<%else%>							
	&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;不通过</font>
	<%end if %> 
	<br>
	<label>生产环境结果：</label>
	<% if rs("rptOnlineResult") = "pass" then %>
	&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;通过</font>
	<%else%>
	&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;不通过</font>
	<%end if %>  
	</div>
								
	<div class="col-md-12">	
	<h3 class="box-title"> 5.2 遗留问题</h3>		
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptFeedback"),chr(13),"<BR>")%></p>
	</div>	
	
	
	<div class="col-md-12">	
	<h3 class="box-title"> 5.3 软件风险</h3>	
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptRisk"),chr(13),"<BR>")%></p>
	</div>		
	
	<div class="col-md-12">	
	<h3 class="box-title"> 5.4 测试结论</h3>
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptConclusion"),chr(13),"<BR>")%></p>
	
	</div>			
	
	<div class="col-md-12">	
	<h3 class="box-title"> 5.5 测试建议</h3>	
	<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptAdvice"),chr(13),"<BR>")%></p>
	</div>					
	
	<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.6 附图</h3></div>
			
		<!--  显示图片 --> 
		<% if rs("rptRedminePic") <> "*" then  
			rptRedminePic = split(replace(rs("rptRedminePic"),"*",""),",")					
			for i=1 to ubound(rptRedminePic)														
		%>				
				<p><a href="sltReportShowDel-<%=pjtId%>-<%=platformId%>-<%=rptRedminePic(i)%>.html" onClick="return confirm('是否要删除此图片？')" >
				<img src=<%="uploadPic\plupload\"+rptRedminePic(i)%>> </a>
				<h3><% response.write "附图"&i %></h3></p><br>
				
			<%next%>
		<% end if %>
		</div>
	
				

			</div><!-- /.row -->	  
		</div><!-- /.body -->
	</div><!-- /.body default-->
  
 

		<form role="form" action="admReportAuditNoaudit-<%=pjtId%>-<%=platformId%>.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
		<% if rs("rptStatus") <> "done" then%>
		
		<hr>
			<div class="row">
				<div class="col-md-12" align="center">
					<h3 class="box-title"> 审核意见</h3>	
					
					<textarea name="rejectReason" cols="100%" rows="5" placeholder="请输入..."><%=rs("rptRejectReason")%></textarea>
					<br><br>
				</div>				
	
				<div class="col-md-12" align="center">
					<a href="admReportAuditAudit-<%=pjtId%>-<%=platformId%>.html" onClick="return confirm('是否审核通过，确定吗？')">
					<button type="button" class="btn btn-info pull-left" style="margin-right: 5px;"  href="#" >审核通过</button></a>										
					<button type="submit" class="btn btn-danger"  href="#">拒绝</button> 
					<br><br>
				</div>	
			</div>
		
							
		<% end if %>
		</form>
     
    <br>
	</section><!-- ./col -->
<a id='DD'></a>		
<a href="#0" class="cd-top">Top</a>
	
</div><!-- ./wrapper -->

<%
rs.close
set rs = nothing
%>



</body>
</html>

