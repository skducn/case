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



<title><%=pjtName%><%=platformName%>���Ա���_<%=session("userName")%>_<%=year(now)%><%=month(now)%><%=day(now)%></title>
<%
rs1.close
rs.close
%>


<!--  upload�ؼ�	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>


<!--  ɾ��bug��ͼ -->	
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

<!--  ���������� -->	
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
		<div><h1><i class="fa fa-edit"></i> ���Ա���</h1><p>testReport</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">���Ա���</a></li></ul></div>
	</div>	
								
	<div class="card">		
		<div class="row">
			<div class="col-md-6" align="left">
				<h3 class="box-title"><% if rs("rptStatus") = "undone" then%>
					<%=pjtName%> <%=platformName%> ������ˣ�
					<% elseif rs("rptStatus") = "reject" then%>
					<%=pjtName%> <%=platformName%> ���Ѿܾ���
					<% else %>
					<%=pjtName%> <%=platformName%> (�����)
					<% end if %></h3>						
			</div>				
			<div class="col-md-6" align="right">
				<% if rs("rptStatus") <> "done" then%>
					<a class='btn btn-warning' href='sltReportEdit-<%=pjtId%>-<%=platformId%>.html' data-toggle="tooltip" data-original-title="�༭"><i class='fa fa-edit'></i></a>	
					
				<%end if %>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
			</div>							
		</div>
		
		<div class="row">
			<div class="col-md-12" align="left">
			<% if rs("rptRejectReason") <> "" then%>		
				������<%=replace(rs("rptRejectReason"),chr(13),"<BR>")%>
			<%end if %>
			</div>
		</div>
	
		<hr>
		
		<div class="row">
			<div class="col-md-12">
				<h3 class="box-title">��Ҫ</h3>
				<div class="row">
					<div class="col-md-12">							
						<table id="example2" class="table table-bordered table-hover">
						<thead>
						<tr>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> ģ������</h4></div></th>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> ��������</h4></div></th>
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> ������Ա</h4></div></th>
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
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> ���ƽ̨</h4></div></th>	
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> ��������</h4></div></th>		
						<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title"> ����</h4></div></th>						
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
					<h3 class="box-title">���Խ��</h3>
					���Ի�����
					<% if rs("rptTestResult") = "pass" then %>
							&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;ͨ��</font>
						<%else%>							
							&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;��ͨ��</font>
						<%end if %>					 
					<br>
					����������
						<% if rs("rptOnlineResult") = "pass" then %>
							&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;ͨ��</font>
						<%else%>
							&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;��ͨ��</font>
						<%end if %>  
					</div>
										        
				</div><!-- /.row -->
				
				<br>
  
				<div class="row">	 
					<div class="col-md-4">
						<div class="box box-default">
							<div class="box-header with-border">			
								<h3 class="box-title">ȱ��ƽ̨ͳ��</h3>
							</div>
							<div class="box-body">
								<div id="graph" style="height: 300px;"></div>
							</div><!-- /.box-body-->			
						</div><!-- /.box -->
					</div><!-- /.col -->
		

					<div class="col-md-4">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">ȱ�ݳ̶�ͳ��</h3>
							</div>
								<div class="box-body">
								<div id="graph1" style="height: 300px;"></div>
							</div><!-- /.box-body-->
						</div><!-- /.box -->
					</div><!-- /.col -->
		
					<div class="col-md-4">
						<div class="box box-default">
							<div class="box-header with-border">
								<h3 class="box-title">ȱ��״̬ͳ��</h3>
							</div>		
							<div class="col-md-4">
								<ul class="chart-legend clearfix">
								<li><i class="fa fa-circle-o text-red"></i> δ����</li>
								<li><i class="fa fa-circle-o text-aqua"></i> ������</li>
								<li><i class="fa fa-circle-o text-green"></i> �ѽ��</li>
								<li><i class="fa fa-circle-o text-yellow"></i> �ѷ���</li>              
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
							<h3 class="box-title">��������ͳ��</h3>
						</div>
							<div class="box-body">
							<div id="graph2" style="height: 300px;"></div>
						</div><!-- /.box-body-->
					</div><!-- /.box -->
				</div><!-- /.col -->		
			</div>
			</div>				  			
		
			<br><br><br>
			
			<h3 class="box-title">1������</h3>
									
			<div class="row">			
				<div class="col-md-12">							
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.1 Ŀ��</h4></div></th>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.2 ����</h4></div></th>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.3 ������</h4></div></th>
					<th style="width: 25%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.4 Ӳ����Դ</h4></div></th>
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
			
			<div class="box-header"><h4 class="box-title">1.5 ���Խ���</h4></div>
			<div class="form-group">
				<table class="table table-bordered">
				<tr>               
				<th style="width: 20%" bgcolor="#f1f1f1"><h4 class="box-title">������Ŀ</h4></th>
				<th style="width: 30%" bgcolor="#f1f1f1"><h4 class="box-title">��ʼ��������</h4></th>
				<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">��ע</h4></th>
				</tr>					
				<tr>
				<td>�����ĵ�����</td>
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
				<td>��Ʊ�д����</td>
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
				<td>ִ�в�������</td>
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
				<td>bug��֤�ع�</td>
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
					<th style="width: 50%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.6 ����</h4></div></th>		
					<th style="width: 50%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">1.7 �ο�����</h4></div></th>		
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
					
				
			<h3 class="box-title">2����������</h3>
	
			<div class="row">
        		<div class="col-md-12">
				<% set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
				do while not rs1.eof %>
				
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">��ǩ</h4></th>
				<th style="width: 40%" bgcolor="#f1f1f1"><h4 class="box-title">����</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���Զ���</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���Խ׶�</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���Խ��</h4></th>
				<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">����/ִ����</h4></th>
			
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
					varSum2 =  "���� &nbsp;" + varSum2  
					end if
					response.write varSum2 %>		
					</td>
					<td>
					<% if rs2("caseStage") =1 then
					response.write "ð��"
					elseif rs2("caseStage") =2 then
					response.write "��ʽ"
					elseif rs2("caseStage") =3 then
					response.write "�ع�"
					end if %>
					</td>
				    <td>
					<% if rs2("caseResult") ="error" then
						response.write "<font color=red>δͨ��</font>"
					elseif rs2("caseResult") = "ok" then
						response.write "<font color=green>ͨ��</font>"
					elseif rs2("caseStatus") = "3" then
						response.write "<font color=grey>����</font>"
					elseif rs2("caseStatus") = "2" then
						response.write "<font color=blue>��ͣ</font>"
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

			<h3 class="box-title">3�����Է���</h3>
		
		
			<div class="row">
			<div class="col-md-12">
				<div class="box-header"><h4 class="box-title">3.1 ���Ը�����</h4></div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">�汾</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">��ǩ</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">��������</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">��ͨ����</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">δͨ����</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">δ������(����/��ͣ��</h4></th>
				<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">����ִ�и�����</h4></th>
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
					<div class="box-header"><h4 class="box-title">3.2 ȱ��ƽ̨ͳ��</h4></div>
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">ϵͳƽ̨</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug��</h4></th>
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
					<td>���ݿ�/�ӿ���</td>
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
					<div class="box-header"><h4 class="box-title">3.3 ȱ�����س̶�</h4></div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">���س̶�</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug��</h4></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>����</td>
					<td><div class="form-group"><%varUrgent=split(rs("rptBugDegree"),",")(0)%>
					<%=split(rs("rptBugDegree"),",")(0)%>
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group"> <%varHigh=split(rs("rptBugDegree"),",")(1)%>
					<%=split(rs("rptBugDegree"),",")(1)%>
					</div></td>
					</tr>
					<tr>
					<td>��ͨ</td>
					<td><div class="form-group"><%varNormal=split(rs("rptBugDegree"),",")(2)%>
					<%=split(rs("rptBugDegree"),",")(2)%>
					</div></td>
					</tr>
					<tr>
					<td>��</td>
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
					<div class="box-header"><h4 class="box-title">3.4 ȱ��״̬ͳ��</h4></div>
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">ȱ��״̬</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug��</h4></th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>δ����(�½�)</td>
					<td><div class="form-group"><%varNew=split(rs("rptBugStatus"),",")(0)%>
					<%=split(rs("rptBugStatus"),",")(0)%>
					</div></td>
					</tr>
					<tr>
					<td>������</td>
					<td><div class="form-group"><%varProcess=split(rs("rptBugStatus"),",")(1)%>
					<%=split(rs("rptBugStatus"),",")(1)%>
					</div></td>
					</tr>
					<tr>
					<td>�ѽ��</td>
					<td><div class="form-group"><%varOk=split(rs("rptBugStatus"),",")(2)%>
					<%=split(rs("rptBugStatus"),",")(2)%>
					</div></td>
					</tr>
					<tr>
					<td>�ѷ���</td>
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
					<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">3.5 ��������</h4></div></th>	
					<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">3.6 ����</h4></div></th>		
					<th style="width: 33%" bgcolor="#f1f1f1"><div class="box-header"><h4 class="box-title">3.7 ���Խ�����</h4></div></th>		
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
					
					
							
	

		<h3 class="box-title">4�����Խ���</h3>
				
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
			
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>	
				<a id='DD'></a>		
			</div>
		</div>
		
	</div>

	
	

</div><!-- ./wrapper -->





<%
rs.close
set rs = nothing
%>


<!-- ��������ͳ�� -->
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
		str = "δ֪"
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

  // ȱ��ƽ̨ͳ��
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
  labels: ['����'],
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

  // ȱ�ݳ̶�ͳ��
Morris.Bar({
  element: 'graph1',
  data: [
    {x: '����', y: <%=varUrgent%>},
    {x: '��', y: <%=varHigh%>},
    {x: '��ͨ', y: <%=varNormal%>},
    {x: '��', y: <%=varLow%>}
  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['����'],
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



// ��������ͳ��
Morris.Bar({
  element: 'graph2',
  data: [    	

    {x: '������', y: <%=error1%>},
    {x: '������������', y: <%=error2%>},
    {x: 'ȱ��ҵ���߼�������', y: <%=error3%>},
	{x: 'ȱ�ٷ�Χ�߽�', y: <%=error4%>},
    {x: '�İ�ȱʧ����', y: <%=error5%>},
    {x: '�߿�ͼȱʧ����', y: <%=error6%>},
	{x: '�����ͼ�߿�ͼ', y: <%=error7%>},
	{x: '�޳���˵��', y: <%=error8%>},
    {x: 'ȱʧʹ�ö����Ȩ��', y: <%=error9%>},
    {x: '����', y: <%=error10%>}

  ],
  xkey: 'x',
  ykeys: ['y'],
  labels: ['����'],
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
     * ȱ��״̬ͳ��charJS
     * ----------- http://www.sioe.cn/yingyong/yanse-rgb-16/
     */

    var donutData3 = [
      {label: "δ����", data: <%=varNew%>, color: "#3c8dbc"},
      {label: "������", data: <%=varProcess%>, color: "#DB7093"},
	  {label: "�ѽ��", data: <%=varOk%>, color: "#3CB371"},
      {label: "�ѷ���", data: <%=varFeedback%>, color: "#FFA500"}
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
     * END ȱ��״̬ͳ��charJS
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
