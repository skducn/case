<!--#include file="frame.asp"-->
  
<!--  �ϴ�ͼƬ�ؼ�	-->	
<script type="text/javascript" src="uploadPic/js/plupload.full.min.js"></script>

  
<%
pjtId = request("pjtId")
platformId = request("platformId")
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_project where pjtid="&pjtId&" order by pjtId DESC",conn,3,3
set rs1 = server.CreateObject("ADODB.RecordSet")
rs1.Open "select * from tbl_platform where platformId="&platformId&" order by platformId DESC",conn,3,3
platformNameTitle = replace(rs1("platformName"),".","")
platformName = rs1("platformName")
pjtName = rs("pjtName")
%>
<title><%=pjtName%>_<%=platformName%>_���Ա���_<%=year(now)%><%=month(now)%><%=day(now)%></title>
<%
rs1.close
rs.close
%>


<!--  ɾ��ͼƬ -->	
<% if request("action")="del" then  
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
	
	rptHardPic = rs("rptHardPic")
	rs("rptHardPic") = ""	
	rs("rptHardPic") = replace(rptHardPic,"," + request("picPath"),"")

	rptRedminePic = rs("rptRedminePic")
	rs("rptRedminePic") = ""	
	rs("rptRedminePic") = replace(rptRedminePic,","+request("picPath"),"")
	
	
	rs.update
	rs.close
	set rs = nothing 
	response.Redirect("sltReportShow-"&pjtId&"-"&platformId&".html")
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
rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&"",conn,3,3
if rs.eof then
response.Redirect("index.html")
end if 
%>

<div class="content-wrapper">
	
													
	<div class="card">		
		<div class="row">
			<div class="col-md-12" align="left">
			<% if rs("rptRejectReason") <> "" then%>		
				<b><font color="red">����ԭ��</font></b><%=replace(rs("rptRejectReason"),chr(13),"<BR>")%>
				<hr>
			<%end if %>
			</div>
		</div>
		
		<div class="row">							
			<%if rs("rptStatus") = "undone" and rs("rptAuthor")=session("userName") then%>
				<div class="col-md-10">
				<h2><div><%=rs("rptName")%>������ˣ�</div></h2>																			
				</div>
				<div class="col-md-2" align="right">
				<a class='btn btn-warning' href='sltReportEdit-<%=pjtId%>-<%=platformId%>.html' data-toggle="tooltip" data-original-title="�༭"><i class='fa fa-edit'>&nbsp;�༭</i></a>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
				</div>
			<%elseif rs("rptStatus") = "reject" and rs("rptAuthor")=session("userName") then%>				
				<div class="col-md-10">
				<h2><div><%=rs("rptName")%>��δͨ����</div></h2>																			
				</div>
				<div class="col-md-2" align="right">
				<a class='btn btn-warning' href='sltReportEdit-<%=pjtId%>-<%=platformId%>.html' data-toggle="tooltip" data-original-title="�༭"><i class='fa fa-edit'>&nbsp;�༭</i></a>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
				</div>
			<%else%>
				<div class="col-md-12" align="center">
					<h2><div><%=rs("rptName")%></div></h2>																			
				</div>
			<% end if %>																	
		</div>				
		
		<hr>							
				
		<h2>��1�� ���� </h2>
													
		<div class="col-md-12">	
			<h3 class="box-title"> 1.1 ��дĿ��</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptGoal"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 1.2 ���ƽ���</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptCaption"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 1.3 �ο�����������</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptRef"),chr(13),"<BR>")%></p>				
		</div>	
				
						
		<div class="row"></div>
		<br>
		
				
		<h2>��2�� ���Ը��� </h2>
		
		<div class="col-md-12">	
			<h3 class="box-title"> 2.1 ���Զ���</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTestObject"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 2.2 ��Ŀ����</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptScene"),chr(13),"<BR>")%></p>
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 2.3 ����Ŀ��</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTestGoal"),chr(13),"<BR>")%></p>					
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 2.4 ʱ����ȱ�</h3>
			<div class="form-group">
				<table class="table table-bordered"><tr>               
				<th style="width: 20%" bgcolor="#f1f1f1"><h4 class="box-title">����</h4></th>
				<th style="width: 20%" bgcolor="#f1f1f1"><h4 class="box-title">������ʼ</h4></th>
				<th style="width: 60%" bgcolor="#f1f1f1"><h4 class="box-title">��ע</h4></th></tr>
				<tr><td>�����ĵ�����</td><td>							
				<div class="form-group"><div class="input-group"><%=rs("rptStoryDate")%></div></div></td><td>
				<div class="form-group"><%=replace(rs("rptStoryMemo"),chr(13),"<BR>")%></div></td></tr>
				
				<tr><td>��Ʊ�д����</td><td> 					
				<div class="form-group"><div class="input-group"><%=rs("rptDesignDate")%></div></div></td><td>
				<div class="form-group"><%=replace(rs("rptDesignMemo"),chr(13),"<BR>")%></div></td></tr>				
				
				<tr><td>ִ�в�������</td><td><div class="form-group"><div class="input-group"><%=rs("rptExcDate")%></div></div></td><td>
				<div class="form-group"><%=replace(rs("rptExcMemo"),chr(13),"<BR>")%></div></td></tr>				
				
				<tr><td>bug��֤�ع�</td><td> <div class="form-group"><div class="input-group"><%=rs("rptBugDate")%></div></div></td><td>
				<div class="form-group"> <%=replace(rs("rptBugMemo"),chr(13),"<BR>")%></div></td></tr>
				</table>
			</div>			
		</div>	

		<div class="col-md-12">	
			<h3 class="box-title"> 2.5 ������Ա</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptMember"),chr(13),"<BR>")%></p>					
		</div>	
				
						
		<div class="row"></div>
		<br>
				
			
		<h2>��3�� ���Է��� </h2>
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.1 �����������ο���������ϸ�����β��ĸ�����</h3>		
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>		
			<table id="example2" class="table table-bordered table-hover"><thead><tr>
			<th style="width: 5%" bgcolor="#f1f1f1"><h4 class="box-title">���</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">��ǩ</h4></th>
			<th style="width: 40%" bgcolor="#f1f1f1"><h4 class="box-title">����</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���Զ���</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���Խ׶�</h4></th>
			<th style="width: 10%" bgcolor="#f1f1f1"><h4 class="box-title">���Խ��</h4></th>
			<th style="width: 15%" bgcolor="#f1f1f1"><h4 class="box-title">������/ִ����</h4></th>
			</tr></thead><tbody>	  
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
			</table>
			<% rs1.movenext
			loop
			rs1.close %> 	
						
		</div>	

		<div class="col-md-12">	
			<h3 class="box-title"> 3.2 ���Ի���</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptBasis"),chr(13),"<BR>")%></p>					
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.3 ���˵��</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptSoft"),chr(13),"<BR>")%></p>		
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.3 Ӳ��˵��</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptHard"),chr(13),"<BR>")%></p>				
				
			<!--  ��ʾͼƬ --> 
			<% if rs("rptHardPic") <> "*" then  
				rptHardPic = split(replace(rs("rptHardPic"),"*",""),",")					
				for i=1 to ubound(rptHardPic)														
			%>				
					<p><a href="sltReportShowDel-<%=pjtId%>-<%=platformId%>-<%=rptHardPic(i)%>.html" onClick="return confirm('�Ƿ�Ҫɾ����ͼƬ��')" >
					<img src=<%="uploadPic\plupload\"+rptHardPic(i)%>> </a>
					</p>
				<%next%>
			<% end if %>
		
		</div>

		<div class="col-md-12">	
			<h3 class="box-title"> 3.4 �����ն�/�豸</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTerminal"),chr(13),"<BR>")%></p>					
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title">3.5 ���Է���</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptTestWay"),chr(13),"<BR>")%></p>					
		</div>	
				
										
		<div class="row"></div>
		<br>
	

		<h2>��4�� ���Խ����ȱ�ݷ��� </h2>
									
		<div class="col-md-12">	
			<h3 class="box-title"> 4.1 �������������ʣ����ݲ���������</h3>
			<table id="example2" class="table table-bordered table-hover"><thead><tr>			
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">��ǩ</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">��������</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">��ͨ����</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">δͨ����</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">δ������</h4></th>
			<th style="width: 14.28%" bgcolor="#f1f1f1"><h4 class="box-title">ִ�и�����</h4></th></tr></thead><tbody>	
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
			<h3 class="box-title"> 4.2 ȱ��ͳ��</h3><br>					
			<div class="col-md-4">
				<div class="box">
					<div class="box-header"><h4 class="box-title">4.2.1 ȱ��ƽ̨ͳ��</h4></div>
					<div class="box-body">
						<table id="example2" class="table table-bordered table-hover"><thead><tr>
						<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">ϵͳƽ̨</h4></th>
						<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug��</h4></th>
						</tr></thead><tbody>						
						<tr><td>iOS</td><td><div class="form-group"><%varIos=split(rs("rptBugQty"),",")(0)%><%=split(rs("rptBugQty"),",")(0)%></div></td></tr>			
						<tr><td>android</td><td><div class="form-group"><%varAndroid=split(rs("rptBugQty"),",")(1)%><%=split(rs("rptBugQty"),",")(1)%></div></td></tr>			
						<tr><td>���ݿ�/�ӿ���</td><td><div class="form-group"><%varServer=split(rs("rptBugQty"),",")(2)%><%=split(rs("rptBugQty"),",")(2)%></div></td></tr>			
						<tr><td>web php C/S</td><td><div class="form-group"><%varPhp=split(rs("rptBugQty"),",")(3)%><%=split(rs("rptBugQty"),",")(3)%></div></td></tr>
						</tbody></table>
					</div> 
				</div>
			</div>
					
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header"><h4 class="box-title">4.2.2 ȱ�����س̶�</h4></div>			
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover"><thead><tr>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">���س̶�</h4></th>
					<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug��</h4></th>
					</tr></thead><tbody>
					<tr><td>����</td><td><div class="form-group"><%varUrgent=split(rs("rptBugDegree"),",")(0)%><%=split(rs("rptBugDegree"),",")(0)%></div></td></tr>
					<tr><td>��</td><td><div class="form-group"> <%varHigh=split(rs("rptBugDegree"),",")(1)%><%=split(rs("rptBugDegree"),",")(1)%></div></td></tr>
					<tr><td>��ͨ</td><td><div class="form-group"><%varNormal=split(rs("rptBugDegree"),",")(2)%><%=split(rs("rptBugDegree"),",")(2)%></div></td></tr>
					<tr><td>��</td><td><div class="form-group"><%varLow=split(rs("rptBugDegree"),",")(3)%><%=split(rs("rptBugDegree"),",")(3)%></div></td></tr>
					</tbody></table>
					</div> 
				</div>
			</div>
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header"><h4 class="box-title">4.2.3 ȱ��״̬ͳ��</h4></div>
					<div class="box-body">
						<table id="example2" class="table table-bordered table-hover">
						<thead><tr><th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">ȱ��״̬</h4></th>
						<th style="width: 50%" bgcolor="#f1f1f1"><h4 class="box-title">Bug��</h4></th>
						</tr></thead><tbody>
						<tr><td>δ����(�½�)</td><td><div class="form-group"><%varNew=split(rs("rptBugStatus"),",")(0)%><%=split(rs("rptBugStatus"),",")(0)%></div></td></tr><tr>
						<td>������</td><td><div class="form-group"><%varProcess=split(rs("rptBugStatus"),",")(1)%><%=split(rs("rptBugStatus"),",")(1)%></div></td></tr><tr>
						<td>�ѽ��</td><td><div class="form-group"><%varOk=split(rs("rptBugStatus"),",")(2)%><%=split(rs("rptBugStatus"),",")(2)%></div></td></tr><tr>
						<td>�ѷ���</td><td><div class="form-group"><%varFeedback=split(rs("rptBugStatus"),",")(3)%><%=split(rs("rptBugStatus"),",")(3)%></div></td></tr>
						</tbody></table>
					</div>
				</div>			
			</div>

			<!-- ͼ��-->
			
			<div class="col-md-4">
				<div class="box box-default">
					<div class="box-header with-border">			
						<h3 class="box-title">ȱ��ƽ̨ͳ��</h3>
					</div>
					<div class="box-body">
						<div id="graph" style="height: 300px;"></div>
					</div>			
				</div>
			</div>


			<div class="col-md-4">
				<div class="box box-default">
					<div class="box-header with-border">
						<h3 class="box-title">ȱ�ݳ̶�ͳ��</h3>
					</div>
					<div class="box-body">
						<div id="graph1" style="height: 300px;"></div>
					</div>
				</div>
			</div>
		
			<div class="col-md-4">
				<div class="box box-default">
					<div class="box-header with-border">
						<h3 class="box-title">ȱ��״̬ͳ��</h3>
					</div>		
												
					<div class="box-body">
						<br><br>
						<div id="donut-chart3" style="height: 300px;"></div>
						<br><br>
					</div>
				</div>
			</div>						
		</div>								
				
		<div class="col-md-12"><br><br><br>
			<div class="box box-default">
				<div class="box-header with-border">						
					<h3 class="box-title">4.3 ��������ͳ��</h3>
				</div>
				<div class="box-body">
					<div id="graph2" style="height: 300px;"></div>
				</div>
			</div>
		</div>	
		
				
				
		<div class="row"></div>
		<br><br><br><br>
				
				
				
		<h2>��5�� �����ܽ��뽨��</h2>
									
		<div class="col-md-12">	
			<h3 class="box-title"> 5.1 �������</h3>
			���Ի�����
			<% if rs("rptTestResult") = "pass" then %>
			&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;ͨ��</font><br>
			<%else%>							
			&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;��ͨ��</font>
			<%end if %>					 
			<br>
			����������
			<% if rs("rptOnlineResult") = "pass" then %>
			&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;ͨ��</font><br>
			<%else%>
			&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;��ͨ��</font>
			<%end if %>  
			<br>
		</div>	
			
		<div class="col-md-12">	
			<h3 class="box-title"> 5.2 ��������</h3>	
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptFeedback"),chr(13),"<BR>")%></p>
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 5.3 �������</h3>	
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptRisk"),chr(13),"<BR>")%></p>
		</div>		
		
		<div class="col-md-12">	
			<h3 class="box-title"> 5.4 ���Խ���</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptConclusion"),chr(13),"<BR>")%></p>
		</div>			
		
		<div class="col-md-12">	
			<h3 class="box-title"> 5.5 ���Խ���</h3>
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs("rptAdvice"),chr(13),"<BR>")%></p>
		</div>	

		<div class="col-md-12">
			<div class="box-header"><h3 class="box-title"> 5.6 ��ͼ</h3></div>
			
		<!--  ��ʾͼƬ --> 
		<% if rs("rptRedminePic") <> "*" then  
			rptRedminePic = split(replace(rs("rptRedminePic"),"*",""),",")					
			for i=1 to ubound(rptRedminePic)														
		%>				
				<p><a href="sltReportShowDel-<%=pjtId%>-<%=platformId%>-<%=rptRedminePic(i)%>.html" onClick="return confirm('�Ƿ�Ҫɾ����ͼƬ��')" >
				<img src=<%="uploadPic\plupload\"+rptRedminePic(i)%>> </a>
				<h3><% response.write "��ͼ"&i %></h3></p><br>
				
			<%next%>
		<% end if %>
		</div>
			
			
		<div class="row">
			
		</div>
	</div><!-- <div class="card">	 -->

<%
rs.close
set rs = nothing
%>



<!-- ��������ͳ�� -->

<%
dim error1,error2,error3,error4,error5,error6,error7,error8,error9,error10,error11
error1 = 0:error2 = 0:error3 = 0:error4 = 0:error5 = 0:error6 = 0:error7 = 0:error8 = 0:error9 = 0:error10 = 0		
set rs = server.CreateObject("ADODB.RecordSet")
rs.Open "select * from tbl_case where case_pjtid="&pjtId&" and case_platformId="&platformId&" order by caseId asc",conn,3,3
do while not rs.eof
	select case rs("caseErrortype")
	case 1 : error1 = error1 + 1 
	case 2 : error2 = error2 + 1 
	case 3 : error3 = error3 + 1 
	case 4 : error4 = error4 + 1 
	case 5 : error5 = error5 + 1
	case 6 : error6 = error6 + 1 
	case 7 : error7 = error7 + 1 
	case 8 : error8 = error8 + 1 
	case 9 : error9 = error9 + 1 
	case 10: error10 = error10 + 1 
	case else: str = "δ֪"
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






<script>
$(function () {
<!-- ȱ��ƽ̨ͳ��-->

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

<!-- ȱ�ݳ̶�ͳ��-->
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


<!-- ��������ͳ��-->
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
 * RGB��ɫֵת����ʮ��������ɫ�� http://www.sioe.cn/yingyong/yanse-rgb-16/
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
            radius: 5 / 6,
            formatter: labelFormatter,
            threshold: 0.1
          }

        }
      },
      legend: {
        show: true
      }
    });	 
  });
  function labelFormatter(label, series) {
    return '<div style="font-size:13px; text-align:center; padding:2px; color: #fff; font-weight: 400;">'
        + label
        + "<br>"+ "<br>"+ "<br>"
        + Math.round(series.percent) + "%</div>";
  }
</script>
<a id='DD'></a>		
<a href="#0" class="cd-top">Top</a>

</body>
</html>


 <!-- Javascripts-->
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>

<!-- Bootstrap 3.3.5 -->
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