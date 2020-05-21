<!--#include file="admframe.asp"-->

<title><%=cstCompany%> | 测试计划</title>
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<!--  新建报告 -->	

<%
if request("action") = "submit" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	
	'数字输入框自动去掉负数符号
	rptAbug = replace(request("rptAbug"),"-","")
	rptIbug = replace(request("rptIbug"),"-","")
	rptSbug = replace(request("rptSbug"),"-","")
	rptPbug = replace(request("rptPbug"),"-","")
	rptJdegree = replace(request("rptJdegree"),"-","")
	rptGdegree = replace(request("rptGdegree"),"-","")
	rptPdegree = replace(request("rptPdegree"),"-","")
	rptDdegree = replace(request("rptDdegree"),"-","")
	rptWstatus = replace(request("rptWstatus"),"-","")
	rptCstatus = replace(request("rptCstatus"),"-","")
	rptJstatus = replace(request("rptJstatus"),"-","")
	rptFstatus = replace(request("rptFstatus"),"-","")

	if rptAbug = "" then 
		rptAbug = 0 
	end if 
	if rptIbug = "" then 
		rptIbug = 0 
	end if 
	if rptSbug = "" then
		rptSbug = 0
	end if 
	if rptPbug = "" then
		rptPbug = 0
	end if 
	if rptJdegree = "" then
		rptJdegree = 0
	end if 
	if rptGdegree = "" then
		rptGdegree = 0
	end if 
	if rptPdegree = "" then
		rptPdegree = 0
	end if 
	if rptDdegree = "" then
		rptDdegree = 0
	end if 	
	if rptWstatus = "" then
		rptWstatus = 0
	end if 
	if rptCstatus = "" then
		rptCstatus = 0
	end if 
	if rptJstatus = "" then
		rptJstatus = 0
	end if 
	if rptFstatus = "" then
		rptFstatus = 0
	end if

	'检查是否是数字
	if not IsNumeric(rptAbug) or not IsNumeric(rptIbug) or not IsNumeric(rptSbug) or not IsNumeric(rptPbug) then
		response.Write("<script>;alert('缺陷平台数量只能输入0-999数字!');window.location.href='sltReportCreate.asp?pjtId="&pjtId&"&platformId="&platformId&"';</script>")
		response.end 
	end if
	if not IsNumeric(rptJdegree) or not IsNumeric(rptGdegree) or not IsNumeric(rptPdegree) or not IsNumeric(rptDdegree) then
		response.Write("<script>;alert('缺陷严重程度数量只能输入0-999数字!');window.location.href='sltReportCreate.asp?pjtId="&pjtId&"&platformId="&platformId&"';</script>")
		response.end 
	end if
	if not IsNumeric(rptWstatus) or not IsNumeric(rptCstatus) or not IsNumeric(rptJstatus) or not IsNumeric(rptFstatus) then
		response.Write("<script>;alert('缺陷状态数量只能输入0-999数字!');window.location.href='sltReportCreate.asp?pjtId="&pjtId&"&platformId="&platformId&"';</script>")
		response.end 
	end if

	rptBugQty = cstr(rptAbug) + "," + cstr(rptIbug) + "," + cstr(rptSbug) + "," + cstr(rptPbug)
	rptBugDegree = cstr(rptJdegree) + "," + cstr(rptGdegree) + "," + cstr(rptPdegree) + "," + cstr(rptDdegree)
	rptBugStatus = cstr(rptWstatus) + "," + cstr(rptCstatus) + "," + cstr(rptJstatus) + "," + cstr(rptFstatus)

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("rpt_pjtId") = pjtId
		rs("rpt_platformId") = platformId
		rs("rptStatus") = "undone"
		rs("rptTestResult") = request("rptTestResult")
		rs("rptOnlineResult") = request("rptOnlineResult")
		rs("rptNo") = request("rptNo")
		rs("rptMember") = request("rptMember")
		rs("rptPeriod") = request("rptPeriod")
		rs("rptTerminal") = request("rptTerminal")
		rs("rptBasis") = request("rptBasis")
		rs("rptRisk") = request("rptRisk")
		rs("rptGoal") = request("rptGoal")
		rs("rptScene") = request("rptScene")
		rs("rptSoft")= request("rptSoft")
		rs("rptHard")= request("rptHard")
		rs("rptStoryDate") = request("rptStoryDate")
		rs("rptStoryMemo") = request("rptStoryMemo")
		rs("rptDesignDate") = request("rptDesignDate")
		rs("rptDesignMemo") = request("rptDesignMemo")
		rs("rptExcDate") = request("rptExcDate")
		rs("rptExcMemo") = request("rptExcMemo")
		rs("rptBugDate") = request("rptBugDate")
		rs("rptBugMemo") = request("rptBugMemo")
		rs("rptCaption") = request("rptCaption")
		rs("rptRef") = request("rptRef")
		rs("rptBugQty") = rptBugQty
		rs("rptBugDegree") = rptBugDegree
		rs("rptBugStatus") = rptBugStatus 
		rs("rptFeedback") = request("rptFeedback")
		rs("rptDelivery") = request("rptDelivery")
		rs("rptAdvice") = request("rptAdvice")
		rs("rptConclusion") = request("rptConclusion")
		rs("rptVedioPrefix") = request("rptVedioPrefix")	
		currentPath = server.mappath(Request.ServerVariables("SCRIPT_NAME"))
        currentPath = split(currentPath,"sltReport")(0) + "mp4"
		rs("rptVedioPath") = "\mp4" 
		'rs("rptRedminePic") = request("rptRedminePic")
		rs("rptAuthor") = session("userName")
		rs("rptCreatedDate") = now()
	
		rs.update
	else
		response.Write("<script>;alert('警告！测试报告已创建，请联系管理员。');window.location.href='main.asp';</script>")
		response.end 
	end if 
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
	rs("plat_rptStatus") = "undone"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("sltReportShow.asp?pjtId="&pjtId&"&platformId="&platformId&"")
end if 
%>

  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
		
		<% pjtId = request("pjtId")
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

      <h1>
        <%=pjtName%> <%=platformName%>- 测试报告
        <small>新建中 ...</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="main.asp"><i class="fa fa-align-justify"></i> Home</a></li>
      </ol>
    </section>


<form id="form1" name="form1" method="post" action="sltReportCreate.asp?action=submit">

<!-- Main content -->
<section class="content">
      
	  
	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">测试概要</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
		</div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
					<label>报告编号</label>
					<input type="text" name="rptNo" class="form-control" placeholder="如：dkzy_<%=pjtName%>_1_0">
					</div>				      
					<div class="form-group">
					<label>交付周期</label>
					<textarea  name="rptPeriod" class="form-control" rows="3" placeholder="Enter ..."></textarea>
					</div>				
					<div class="form-group">
					<label>测试环境</label>
					<textarea name="rptBasis" class="form-control" rows="3" placeholder="Enter ..."></textarea>
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<!-- radio -->
							<div class="form-group">
								<label>测试环境结果</label>
								<div class="radio">
									<label>
									<input type="radio" name="rptTestResult"  value="pass" checked>
									<i class="fa fa-check text-green"></i> &nbsp;通过
									</label>
								</div>
								<div class="radio">
									<label>
									<input type="radio" name="rptTestResult"  value="failed">
									<i class="fa fa-close (alias) text-red"></i>&nbsp;不通过
									</label>
								</div>
							</div>
						</div><!-- /.col -->
						
						<div class="col-md-6">
							<!-- radio -->
							<div class="form-group">
								<label>生产环境结果</label>
								<div class="radio">
									<label>
									<input type="radio" name="rptOnlineResult" value="pass" checked>
									<i class="fa fa-check text-green"></i> &nbsp;通过
									</label>
								</div>
								<div class="radio">
									<label>
									<input type="radio" name="rptOnlineResult"  value="failed">
									<i class="fa fa-close (alias) text-red"></i>&nbsp;不通过
									</label>
								</div> 
							</div>
						</div><!-- /.col -->
					</div> <!-- /.row -->
				</div>  <!-- /.col -->
          
				<div class="col-md-6">
                	<div class="form-group">
                  		<label>参与人员</label>
                 		<textarea  name="rptMember" class="form-control" rows="3" placeholder="Enter ..."></textarea>
                	</div>
            		<div class="form-group">
					  <label>相关平台</label>
					  <textarea  name="rptTerminal" class="form-control" rows="3" placeholder="Enter ..."></textarea>
					</div>
					<div class="form-group">
					  <label>风险</label>
					  <textarea  name="rptRisk" class="form-control" rows="6" placeholder="Enter ..."></textarea>
					</div>

				</div><!-- /.col -->
			</div><!-- /.row -->
		</div> <!-- /.body -->
	</div><!-- /.box-default -->
  
         
	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">1、引言</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
        </div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
            <div class="col-md-12">

				<div class="form-group">
				<label>1.1 目的</label>
				<textarea  name="rptGoal" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
				<div class="form-group">
				<label>1.2 背景</label>
				<textarea  name="rptScene" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
				<div class="form-group">
				<label>1.3 软件环境</label>
				<textarea  name="rptSoft" class="form-control" rows="5" placeholder="Enter ...">1，公司网络环境Wifi
2，firefox浏览器
3，Win7 系统
4，mysql数据库
				</textarea>
				</div>
				<div class="form-group">
				<label>1.4 硬件资源</label>
				<textarea  name="rptHard" class="form-control" rows="5" placeholder="Enter ...">1，android：华为P7、三星、小米、红米
2，iOS：iPhone 6 plus、iphone 6
3，PC：E470笔记本
				</textarea>
				</div>
	
				
				
				<div class="form-group">
					<label>1.5 测试进度</label>
					<table class="table table-bordered">
					<tr>               
					<th style="width: 20%">测试类目</th>
					<th style="width: 30%">开始 - 结束日期</th>
				
					<th style="width: 40%">备注</th>
					</tr>
					
					<tr>
					<td>需求文档分析</td>
					<td>
					 
					 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptStoryDate" class="form-control pull-right" id="reservation">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					
					</td>
								  
	  
					<td>
					<div class="form-group">						 
					<textarea  name="rptStoryMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea>
					</div>
					</td>
					</tr>
				
					<tr>
					<td>设计编写用例</td>
					<td> 
					
					 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptDesignDate" class="form-control pull-right" id="reservation1">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				
					
					<td>
					<div class="form-group">
					<textarea  name="rptDesignMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea> 
					</div>
					</td>
					</tr>
					
					<tr>
					<td>执行测试用例</td>
					<td> 
					
					 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptExcDate" class="form-control pull-right" id="reservation2">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				

					<td>
					<div class="form-group">
					<textarea  name="rptExcMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea>
					</div>
					</td>
					</tr>
					
					<tr>
					<td>bug验证回归</td>
					<td> 
					
				 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptBugDate" class="form-control pull-right" id="reservation3">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				
					
					<td>
					<div class="form-group"> 
					<textarea  name="rptBugMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea>
					</div>
					</td>
					</tr>
					</table>
				</div>
			
				<div class="form-group">
				<label>1.6 定义</label>
				<textarea  name="rptCaption" class="form-control" rows="5" placeholder="Enter ...">本次测试用例设计主要采用黑盒测试方法，功能测试采用的用例设计方法有等价类划分法、边界值划分法、错误猜测、模拟真实业务场景等。测试种类包括手工、接口、集成、系统测试。</textarea>
				</div>
				
				<div class="form-group">
				<label>1.7 参考资料</label>
				<textarea  name="rptRef" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
			</div> <!-- .col --> 	 
			</div>  <!-- .row -->    
		</div> <!-- .body -->
	</div><!-- .body default -->


	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">2、测试内容</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
        </div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
        	<div class="col-xs-12">
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>
				<div class="box-header">
				  <h3 class="box-title"><%=rs1("platformName")%></h3>
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th>用例ID</th>
				<th>标签</th>
				<th>用例标题</th>
				<th>测试对象</th>
				<th>测试阶段</th>
				<th>测试结果</th>
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
					response.write "<font color=red>error</font>"
					elseif rs2("caseResult") = "ok" then
					response.write "<font color=blue>ok</font>"
					elseif rs2("caseStatus") = "3" then
					response.write "<font color=blue>hang-up</font>"
					elseif rs2("caseStatus") = "2" then
					response.write "<font color=red>pause</font>"
					end if %>
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
			</div><!-- /.row -->	  
		</div><!-- /.body -->
	</div><!-- /.body default-->



	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">3、测试分析</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
        </div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
			<div class="col-xs-12">
				<div class="box-header">
				<h3 class="box-title">3.1  测试覆盖率</h3>
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th>平台-标签</th>
				<th>用例总数</th>
				<th>已通过数(s)</th>
				<th>未通过数</th>
				<th>未测试数(搁置）</th>
				<th>用例执行覆盖率</th>
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
						<td><% response.write rs4("platformName") + " - " + rs5("lblName")%></td>
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
								if isnull(rs6("caseResult")) then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
									if rs6("caseStatus") = "3" then
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
			
			<div class="col-xs-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.2 缺陷平台统计</h3> <a href="<%=platformRedmine%>" target="_blank"> Redmine</i></a>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>系统平台</th>
					<th>Bug数</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>iOS</td>
					<td><div class="form-group">
					<input type="text" name="rptIbug" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<input type="text" name="rptAbug" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>数据库/接口类</td>
					<td><div class="form-group">
					<input type="text" name="rptSbug" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<input type="text" name="rptPbug" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-xs-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.3 缺陷严重程度</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>严重程度</th>
					<th>Bug数</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>紧急</td>
					<td><div class="form-group">
					<input type="text" name="rptJdegree" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>高</td>
					<td><div class="form-group">
					<input type="text" name="rptGdegree" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>普通</td>
					<td><div class="form-group">
					<input type="text" name="rptPdegree" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>低</td>
					<td><div class="form-group">
					<input type="text" name="rptDdegree" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-xs-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.4 缺陷状态统计</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>缺陷状态</th>
					<th>Bug数</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>未处理(新建)</td>
					<td><div class="form-group">
					<input type="text" name="rptWstatus" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>处理中</td>
					<td><div class="form-group">
					<input type="text" name="rptCstatus" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>已解决</td>
					<td><div class="form-group">
					<input type="text" name="rptJstatus" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					<tr>
					<td>已反馈</td>
					<td><div class="form-group">
					<input type="text" name="rptFstatus" class="form-control" placeholder="数量">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->					
			</div><!-- /.col -->
			
			
			
			<div class="col-xs-12">
				<div class="form-group">
					<label>3.5 遗留/反馈</label>
					<textarea  name="rptFeedback" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
				
				<div class="form-group">
					<label>3.6 测试交付物</label>
					<textarea  name="rptDelivery" class="form-control" rows="5" placeholder="Enter ...">1，测试用例
2，Redmine缺陷
3，测试报告
4，测试环境业务场景录屏文件（如右侧所示）</textarea>

				</div>
				
				<div class="form-group">
					<label>3.7 建议</label>
					<textarea  name="rptAdvice" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
			</div><!-- /.col -->
			</div><!-- /.row -->	  
		</div><!-- /.body -->
	</div><!-- /.body default-->
  

 	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">4、测试结论</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
		</div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">				
					<label>测试结论</label>
					<textarea  name="rptConclusion" class="form-control" rows="6" placeholder="Enter ..."></textarea>
					</div>				
				</div>  <!-- /.col -->
			</div><!-- /.row -->
		</div> <!-- /.body -->
	</div><!-- /.box-default -->     
     
<button type="submit" class="btn btn-primary pull-right" style="margin-right: 5px;"  href="#"><i class="fa fa-angellist"></i> &nbsp;提交</button>
<br><br><br>
<input name="pjtId" type="hidden" value="<%=pjtId%>" />
<input name="platformId" type="hidden" value="<%=platformId%>" />
<input name="rptCreatedDate" type="hidden" value="<%=now%>" />


   
	</section><!-- ./col -->
	</form>
	
</div><!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
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
