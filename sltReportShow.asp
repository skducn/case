<!--#include file="frame.asp"-->
  
<%
pjtId = request("pjtId")
platformId = request("platformId")
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtid="&pjtId&" order by pjtId DESC",conn,3,3
set rs1 = server.CreateObject("ADODB.RecordSet")
rs1.Open "select * from tbl_platform where platformId="&platformId&" order by platformId DESC",conn,3,3
platformNameTitle = replace(rs1("platformName"),".","")
pjtName = rs("pjtName")
%>



<title><%=pjtName%><%=platformName%>测试报告_<%=session("userName")%>_<%=year(now)%><%=month(now)%><%=day(now)%></title>
<%
rs1.close
rs.close
%>


<!--  upload控件	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>


<!--  删除bug截图 -->	
<% 
if request("action")="del" then  
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
rs("rptRedminePic") = ""
rs.update
rs.close
set rs = nothing 
end if 
%>

<!--  已审核已完成 -->	
<% 
if request("action") = "done" then
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_report where pjtId="&pjtId&" and platformId="&platformId&" order by rptId DESC",conn,3,3
rs("rptStatus") = "done"
rs.update
rs.close
set rs = nothing
end if 

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs1("pjtName")
rs1.close

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
platformName = rs1("platformName")
platformRedmine = rs1("platformRedmine")
rs1.close

set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" ",conn,3,3
if rs.eof then
response.Redirect("index.html")
end if 
%>

<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> 测试报告</h1><p>testReport</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">测试报告</a></li></ul></div>
	</div>	
								
	<div class="card">		
		<div class="row">
			<div class="col-md-6" align="left">
				<h3 class="box-title"><% if rs("rptStatus") = "undone" then%>
					<%=pjtName%> <%=platformName%> （待审核）
					<% elseif rs("rptStatus") = "reject" then%>
					<%=pjtName%> <%=platformName%> （已拒绝）
					<% else %>
					<%=pjtName%> <%=platformName%> (已完成)
					<% end if %></h3>						
			</div>				
			<div class="col-md-6" align="right">
				<% if rs("rptStatus") <> "done" then%>
					<a class='btn btn-warning' href='sltReportEdit-<%=pjtId%>-<%=platformId%>.html' data-toggle="tooltip" data-original-title="编辑"><i class='fa fa-edit'></i></a>	
					
				<%end if %>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>		
			</div>							
		</div>
		
		<div class="row">
			<div class="col-md-12" align="left">
			<% if rs("rptRejectReason") <> "" then%>		
				反馈：<%=replace(rs("rptRejectReason"),chr(13),"<BR>")%>
			<%end if %>
			</div>
		</div>
	
		<hr>
		
		<div class="row">
			<div class="col-md-12">
				<h3 class="box-title">概要</h3>
				<div class="row">
					<div class="col-md-12">							
						<table id="example2" class="table table-bordered table-hover">
						<thead>
						<tr>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> 模板名称</h4></div></th>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> 交付周期</h4></div></th>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> 参与人员</h4></div></th>
						</tr>
						</thead>
						<tbody>	  
						<tr>
						<td><%=replace(rs("rptNo"),chr(13),"<BR>")%></td>
						<td><%=replace(rs("rptPeriod"),chr(13),"<BR>")%></td>
						<td><%=replace(rs("rptMember"),chr(13),"<BR>")%></td>																
						</tr>
						</tbody>					
						</table>
					</div>	
					
					<div class="col-md-12">							
						<table id="example2" class="table table-bordered table-hover">
						<thead>
						<tr>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> 相关平台</h4></div></th>	
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> 环境配置</h4></div></th>		
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> 风险</h4></div></th>						
						</tr>
						</thead>
						<tbody>	  
						<tr>
						<td><%=replace(rs("rptTerminal"),chr(13),"<BR>")%></td>		
							<td><%=replace(rs("rptBasis"),chr(13),"<BR>")%></td>						
						<td><%=replace(rs("rptRisk"),chr(13),"<BR>")%></td>												
						</tr>
						</tbody>					
						</table>
					</div>
					
		
					
					<div class="col-md-12">	
					<h3 class="box-title">测试结果</h3>
					测试环境：
					<% if rs("rptTestResult") = "pass" then %>
							&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;通过</font>
						<%else%>							
							&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;不通过</font>
						<%end if %>					 
					<br>
					生产环境：
						<% if rs("rptOnlineResult") = "pass" then %>
							&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;通过</font>
						<%else%>
							&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;不通过</font>
						<%end if %>  
					</div>
										        
				</div><!-- /.row -->
				
				<br>
  
				<div class="row">	 
					<div class="col-md-4">
						<div class="box box-default">
							<div class="box-header with-border">			
								<h3 class="box-title">缺陷平台统计</h3>
							</div>
							<div class="box-body">
								<div id="graph" style="height: 300px;"></div>
							</div><!-- /.box-body-->			
						</div><!-- /.box -->
					</div><!-- /.col -->
		

					<div class="col-md-4">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">缺陷程度统计</h3>
							</div>
								<div class="box-body">
								<div id="graph1" style="height: 300px;"></div>
							</div><!-- /.box-body-->
						</div><!-- /.box -->
					</div><!-- /.col -->
		
					<div class="col-md-4">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">缺陷状态统计</h3>
							</div>		
							<div class="col-md-4">
								<ul class="chart-legend clearfix">
								<li><i class="fa fa-circle-o text-red"></i> 未处理</li>
								<li><i class="fa fa-circle-o text-aqua"></i> 处理中</li>
								<li><i class="fa fa-circle-o text-green"></i> 已解决</li>
								<li><i class="fa fa-circle-o text-yellow"></i> 已反馈</li>              
								</ul>
							</div>							
							<div class="box-body">
								<div id="donut-chart3" style="height: 300px;"></div>
							</div><!-- /.box-body-->
						</div><!-- /.box -->
					</div><!-- /.col -->
				</div>

				<br> <br> <br> 
				
				<div class="col-md-12">
					<div class="box box-default">
						<div class="box-header with-border">						
							<h3 class="box-title">需求问题统计</h3>
						</div>
							<div class="box-body">
							<div id="graph2" style="height: 300px;"></div>
						</div><!-- /.box-body-->
					</div><!-- /.box -->
				</div><!-- /.col -->		
			</div>
			</div>				  			
		
			<br><br><br>
			
			<h3 class="box-title">1、引言</h3>
									
			<div class="row">			
				<div class="col-md-12">							
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.1 目的</h4></div></th>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.2 背景</h4></div></th>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.3 软件软件</h4></div></th>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.4 硬件资源</h4></div></th>
					</tr>
					</thead>
					<tbody>	  
					<tr>
					<td><%=replace(rs("rptGoal"),chr(13),"<BR>")%></td>
					<td><%=replace(rs("rptScene"),chr(13),"<BR>")%></td>
					<td><%=replace(rs("rptSoft"),chr(13),"<BR>")%></td>
					<td><%=replace(rs("rptHard"),chr(13),"<BR>")%></td>
					</tr>
					</tbody>					
					</table>
				</div>	
	
			</div>					
			
			<div class="box-header"><h4 class="box-title">1.5 测试进度</h4></div>
			<div class="form-group">
				<table class="table table-bordered">
				<tr>               
				<th style="width: 20%" bgcolor="#f1f1f1"><h4 class="box-title">测试类目</h4></th>
				<th style="width: 30%" bgcolor="#f1f1f1"><h4 class="box-title">开始结束日期</h4></th>
				<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">备注</h4></th>
				</tr>					
				<tr>
				<td>需求文档分析</td>
				<td>							
				 <!-- Date start -->
				<div class="form-group">
					<div class="input-group">
					<%=rs("rptStoryDate")%> 
					</div><!-- /.input group -->
				</div><!-- /.form group -->
				</td>
				<td>
				<div class="form-group">						 
					<%=replace(rs("rptStoryMemo"),chr(13),"<BR>")%>
				</div>
				</td>
				</tr>
				<tr>
				<td>设计编写用例</td>
				<td> 					
				<div class="form-group">
					<div class="input-group">
					<%=rs("rptDesignDate")%>
					</div><!-- /.input group -->
				</div><!-- /.form group -->
				</td>					
				<td>
				<div class="form-group">
					<%=replace(rs("rptDesignMemo"),chr(13),"<BR>")%>
				</div>
				</td>
				</tr>				
				<tr>
				<td>执行测试用例</td>
				<td> 				
				<div class="form-group">
					<div class="input-group">
					<%=rs("rptExcDate")%>
					</div><!-- /.input group -->
				</div><!-- /.form group -->
				</td>	
				<td>
				<div class="form-group">
					<%=replace(rs("rptExcMemo"),chr(13),"<BR>")%>
				</div>
				</td>
				</tr>				
				<tr>
				<td>bug验证回归</td>
				<td> 
				<div class="form-group">
					<div class="input-group">
					<%=rs("rptBugDate")%>
					</div><!-- /.input group -->
				</div><!-- /.form group -->
				</td>							
				<td>
				<div class="form-group"> 
					<%=replace(rs("rptBugMemo"),chr(13),"<BR>")%>
				</div>
				</td>
				</tr>
				</table>
			</div>
			
			<div class="row">	
				<div class="col-md-12">							
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.6 定义</h4></div></th>		
					<th style="width: 50%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.7 参考资料</h4></div></th>		
					</tr>
					</thead>
					<tbody>	  
					<tr>
					<td><%=replace(rs("rptCaption"),chr(13),"<BR>")%></td>						
					<td><%=replace(rs("rptRef"),chr(13),"<BR>")%></td>						
					</tr>
					</tbody>					
					</table>
				</div>
			</div>
					
				
			<h3 class="box-title">2、测试用例</h3>
	
			<div class="row">
        		<div class="col-md-12">
				<% set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
				do while not rs1.eof %>
				
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">编号</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">标签</h4></th>
				<th style="width: 40%" bgcolor="#f1f1f1"><h4 class="box-title">标题</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">测试对象</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">测试阶段</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">测试结果</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">创建/执行者</h4></th>
			
				</tr>
				</thead>
				<tbody>	  
				<% set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseId asc",conn,3,3 
				do while not rs2.eof %>
					<tr>
					<td><a href="excTestcaseEdit-<%=rs2("caseId")%>.html" target="_blank"><%=rs2("caseId")%></td>
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
						response.write "<font color=grey>搁置</font>"
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
			</div><!-- /.row -->	  

			<h3 class="box-title">3、测试分析</h3>
		
		
			<div class="row">
			<div class="col-md-12">
				<div class="box-header"><h4 class="box-title">3.1 测试覆盖率</h4></div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">版本</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">标签</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">用例总数</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">已通过数</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">未通过数</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">未测试数(搁置/暂停）</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">用例执行覆盖率</h4></th>
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
						<td><% if rs("rptCaseTotal") <>"" then
						
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
								if rs6("caseResult")="empty" and rs6("caseStatus") = "1"  then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
									if rs6("caseStatus") = "3" or rs6("caseStatus") = "2" then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
							rs6.movenext
							loop
						
						if rs("rptCasePass") <>"" then
						
							response.write varOkSum3
						end if %>							
						</td>
						<td>
						<% if rs("rptNoPass") <>"" then
						
							response.write varErrorSum3
						end if %>
						
						</td>
						<td>
						<%  if rs("rptNoTest") <>"" then
							
							response.write varEmptySum3
						end if %>
						
						</td>
						<td>
							<%  if rs("rptCaseCoverage") <>"" then
							
							varFGL = int((varOkSum3+varErrorSum3)/rs6.recordcount*100)
							response.write cstr(varFGL) + "%"
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
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header"><h4 class="box-title">3.2 缺陷平台统计</h4></div>
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
					<%varIos=split(rs("rptBugQty"),",")(0)%>
					<%=split(rs("rptBugQty"),",")(0)%>
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<%varAndroid=split(rs("rptBugQty"),",")(1)%>
					<%=split(rs("rptBugQty"),",")(1)%>
					</div></td>
					</tr>
					<tr>
					<td>数据库/接口类</td>
					<td><div class="form-group">
					<%varServer=split(rs("rptBugQty"),",")(2)%>
					<%=split(rs("rptBugQty"),",")(2)%>
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<%varPhp=split(rs("rptBugQty"),",")(3)%>
					<%=split(rs("rptBugQty"),",")(3)%>
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
					<div class="box-header"><h4 class="box-title">3.3 缺陷严重程度</h4></div>
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
					<td><div class="form-group"><%varUrgent=split(rs("rptBugDegree"),",")(0)%>
					<%=split(rs("rptBugDegree"),",")(0)%>
					</div></td>
					</tr>
					<tr>
					<td>高</td>
					<td><div class="form-group"> <%varHigh=split(rs("rptBugDegree"),",")(1)%>
					<%=split(rs("rptBugDegree"),",")(1)%>
					</div></td>
					</tr>
					<tr>
					<td>普通</td>
					<td><div class="form-group"><%varNormal=split(rs("rptBugDegree"),",")(2)%>
					<%=split(rs("rptBugDegree"),",")(2)%>
					</div></td>
					</tr>
					<tr>
					<td>低</td>
					<td><div class="form-group"><%varLow=split(rs("rptBugDegree"),",")(3)%>
					<%=split(rs("rptBugDegree"),",")(3)%>
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
					<div class="box-header"><h4 class="box-title">3.4 缺陷状态统计</h4></div>
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
					<td><div class="form-group"><%varNew=split(rs("rptBugStatus"),",")(0)%>
					<%=split(rs("rptBugStatus"),",")(0)%>
					</div></td>
					</tr>
					<tr>
					<td>处理中</td>
					<td><div class="form-group"><%varProcess=split(rs("rptBugStatus"),",")(1)%>
					<%=split(rs("rptBugStatus"),",")(1)%>
					</div></td>
					</tr>
					<tr>
					<td>已解决</td>
					<td><div class="form-group"><%varOk=split(rs("rptBugStatus"),",")(2)%>
					<%=split(rs("rptBugStatus"),",")(2)%>
					</div></td>
					</tr>
					<tr>
					<td>已反馈</td>
					<td><div class="form-group"><%varFeedback=split(rs("rptBugStatus"),",")(3)%>
					<%=split(rs("rptBugStatus"),",")(3)%>
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
			
			<div class="row">
						
				<div class="col-md-12">							
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">3.5 遗留问题</h4></div></th>	
					<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">3.6 建议</h4></div></th>		
					<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">3.7 测试交付物</h4></div></th>		
					</tr>
					</thead>
					<tbody>	  
					<tr>
					<td><%=replace(rs("rptFeedback"),chr(13),"<BR>")%></td>	
					<td><%=replace(rs("rptAdvice"),chr(13),"<BR>")%></td>						
					<td><%=replace(rs("rptDelivery"),chr(13),"<BR>")%></td>						
					</tr>
					</tbody>					
					</table>
				</div>
			</div>
					
					
							
	

		<h3 class="box-title">4、测试结论</h3>
				
		<div class="row">			
			<div class="col-md-12">							
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<td><%=replace(rs("rptConclusion"),chr(13),"<BR>")%>	</td>
	
				</tr>
				</thead>
								
				</table>
			</div>	
		</div>	
			

		

		<div class="row">
			<div class="col-md-12" align="right">	
			
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
				<a id='DD'></a>		
			</div>
		</div>
		
	</div>

	
	

</div><!-- ./wrapper -->





<%
rs.close
set rs = nothing
%>


<!-- 需求问题统计 -->
<%
dim error1,error2,error3,error4,error5,error6,error7,error8,error9,error10,error11
error1 = 0
error2 = 0
error3 = 0
error4 = 0
error5 = 0
error6 = 0
error7 = 0
error8 = 0
error9 = 0
error10 = 0




		
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_case where case_pjtid="&pjtId&" and case_platformId="&platformId&" order by caseId asc",conn,3,3
do while not rs.eof

	select case rs("caseErrortype")
	 case 1
		 error1 = error1 + 1 
	 case 2
		 error2 = error2 + 1 
	 case 3
		 error3 = error3 + 1 
	 case 4
		 error4 = error4 + 1 
	 case 5
		 error5 = error5 + 1
	 case 6
		 error6 = error6 + 1 
	 case 7
		 error7 = error7 + 1 
	 case 8
		 error8 = error8 + 1 
	 case 9
		 error9 = error9 + 1 
	 case 10
		 error10 = error10 + 1 
	 case else
		str = "未知"
	end select
	
rs.movenext
loop
rs.close

set rs4 = server.createobject("adodb.recordset")
rs4.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&"",conn,3,3
error1 = error1 + split(rs4("rptErrStory"),",")(0)
error2 = error2 + split(rs4("rptErrStory"),",")(1)
error3 = error3 + split(rs4("rptErrStory"),",")(2)
error4 = error4 + split(rs4("rptErrStory"),",")(3)
error5 = error5 + split(rs4("rptErrStory"),",")(4)
error6 = error6 + split(rs4("rptErrStory"),",")(5)
error7 = error7 + split(rs4("rptErrStory"),",")(6)
error8 = error8 + split(rs4("rptErrStory"),",")(7)
error9 = error9 + split(rs4("rptErrStory"),",")(8)
error10 = error10 + split(rs4("rptErrStory"),",")(9)



%>


<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="plugins/morris.js-0.5.1/raphael-min.js"></script>
<script src="plugins/morris.js-0.5.1/morris.js"></script>
<link rel="stylesheet" href="test/morris.js-0.5.1/morris.css">
<!-- ChartJS 1.0.1 -->
<script src="plugins/chartjs/Chart.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- FLOT CHARTS -->
<script src="plugins/flot/jquery.flot.min.js"></script>
<!-- FLOT RESIZE PLUGIN - allows the chart to redraw when the window is resized -->
<script src="plugins/flot/jquery.flot.resize.min.js"></script>
<!-- FLOT PIE PLUGIN - also used to draw donut charts -->
<script src="plugins/flot/jquery.flot.pie.min.js"></script>
<!-- FLOT CATEGORIES PLUGIN - Used to draw bar charts -->
<script src="plugins/flot/jquery.flot.categories.min.js"></script>


<script>

$(function () {

  // 缺陷平台统计
Morris.Bar({
  element: 'graph',
  data: [
    {x: 'iOS', y: <%=varIos%>},
    {x: 'android', y: <%=varAndroid%>},
    {x: 'server', y: <%=varServer%>},
    {x: 'php', y: <%=varPhp%>}
  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['数量'],
  barColors: function (row, series, type) {
    if (type === 'bar') {
      var red = Math.ceil(255 * row.y / this.ymax);
      return 'rgb(' + red + ',50,110)';
    }
    else {
      return '#000';
    }
  }
});

  // 缺陷程度统计
Morris.Bar({
  element: 'graph1',
  data: [
    {x: '紧急', y: <%=varUrgent%>},
    {x: '高', y: <%=varHigh%>},
    {x: '普通', y: <%=varNormal%>},
    {x: '低', y: <%=varLow%>}
  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['数量'],
  barColors: function (row, series, type) {
    if (type === 'bar') {
      var red = Math.ceil(255 * row.y / this.ymax);
      return 'rgb(' + red + ',50,110)';
    }
    else {
      return '#000';
    }
  }
});



// 需求问题统计
Morris.Bar({
  element: 'graph2',
  data: [    	

    {x: '需求变更', y: <%=error1%>},
    {x: '需求描述不清', y: <%=error2%>},
    {x: '缺少业务逻辑或条件', y: <%=error3%>},
	{x: '缺少范围边界', y: <%=error4%>},
    {x: '文案缺失错误', y: <%=error5%>},
    {x: '线框图缺失错误', y: <%=error6%>},
	{x: '无设计图线框图', y: <%=error7%>},
	{x: '无场景说明', y: <%=error8%>},
    {x: '缺失使用对象或权限', y: <%=error9%>},
    {x: '其他', y: <%=error10%>}

  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['数量'],
  barColors: function (row, series, type) {
    if (type === 'bar') {
      var red = Math.ceil(255 * row.y / this.ymax);
      return 'rgb(' + red + ',50,110)';
    }
    else {
      return '#000';
    }
  }
}); 
	   /*
     * 缺陷状态统计charJS
     * ----------- http://www.sioe.cn/yingyong/yanse-rgb-16/
     */

    var donutData3 = [
      {label: "未处理", data: <%=varNew%>, color: "#3c8dbc"},
      {label: "处理中", data: <%=varProcess%>, color: "#DB7093"},
	  {label: "已解决", data: <%=varOk%>, color: "#3CB371"},
      {label: "已反馈", data: <%=varFeedback%>, color: "#FFA500"}
    ];
    $.plot("#donut-chart3", donutData3, {
      series: {
        pie: {
          show: true,
          radius: 1,
          innerRadius: 0.5,
          label: {
            show: true,
            radius: 5 / 7,
            formatter: labelFormatter,
            threshold: 0.1
          }

        }
      },
      legend: {
        show: false
      }
    });
    /*
     * END 缺陷状态统计charJS
     */
	 
  });

  /*
   * Custom Label formatter
   * ----------------------
   */
  function labelFormatter(label, series) {
    return '<div style="font-size:13px; text-align:center; padding:2px; color: #fff; font-weight: 600;">'
        + label
        + "<br>"
        + Math.round(series.percent) + "%</div>";
  }
</script>
</body>
</html>
