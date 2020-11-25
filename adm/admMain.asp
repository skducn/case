<!--#include file="admFrame.asp"-->

<title><%=admDashboard%> | <%=admCompany%></title>


<% if request("action") = "exit" then
	Session.Abandon()
	response.Redirect "../index.html"

end if 

if request("action") = "save" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
	rs("userMemo") = request("userMemo")
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admMain.html")
end if 
%>
	

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons">dashboard</span> <%=admDashboard%></h1>
			<p class="text-muted m-0 desc">Project Dashboard</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end">
			</div>
		</div>
	</div> 
	
	<div class="content">
		<div class="card mb-4">
			<div class="card-body  p-lg-4">	
				<div class="card mb-4">
					<div class="card-header p-0">
						<ul class="nav nav-tabs active-thik nav-primary border-0" id="myTab" role="tablist">
						<li class="nav-item">
						<a class="nav-link px-4 py-3 rounded-0" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">����Ա</a>
						</li>
						<li class="nav-item">
						<a class="nav-link px-4 py-3 active rounded-0" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">����Ŀ</a>
						</li>			
						</ul>
					</div>
				
					<div class="card-body">			
						<div class="tab-content" id="myTabContent">
							<div class="tab-pane fade " id="home" role="tabpanel" aria-labelledby="home-tab">
					
					
<!-- ����Ա����ʾ��Ŀ�嵥�����򣺵�100%ʱ�ɵ���������Ա��棩 -->
<%set rs7 = server.createobject("adodb.recordset")
rs7.open "select * from tbl_user where userPower=2 and userStatus='1' order by userName",conn,3,3
do while not rs7.eof
	response.write "<h3>"
	response.write rs7("userNickName")
	response.write "</h3>"%>
	
	<div class="row">
	
		<%varNoResult = 0 
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_project where pjtStatus='1' order by pjtId desc",conn,3,3		 
		do while not rs.eof
		
			set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where plat_pjtId="&rs("pjtId")&" and platformStatus<>'2' and plat_rptStatus is null order by platformId desc",conn,3,3			
			do while not rs1.eof
			
				set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' order by caseId desc",conn,3,3
				varRecord = rs2.recordcount
				if varRecord <> 0 then				  
					do while not rs2.eof
						if rs2("caseResult") <> "empty" or rs2("caseStatus") <> "1" then
							varNoResult = varNoResult + 1
						end if 
					rs2.movenext
					loop 
					var1 = int(varNoResult/varRecord*100)%>
											 
					<div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
						<div class="media align-items-center">
							<%if var1 <> 100 then%>
								<span class="material-icons text-red mr-4 circle p-3 border border-red bg-red-light25">apps</span>									  
							<%else		
								set rs19 = server.createobject("adodb.recordset")
								rs19.open "select * from tbl_report where rpt_pjtId="&rs("pjtId")&" and rpt_platformId="&rs1("platformId")&" order by rptId desc",conn,3,3 
								if rs19.eof then%>
									<span class="material-icons text-warning mr-4 circle p-3 border border-warning bg-warning-light25">subject</span>	<%								
								else
									if rs19("rptStatus") = "undone" then %>
										<span class="material-icons text-primary mr-4 circle p-3 border border-primary bg-primary-light35">edit</span>	
									<%elseif rs19("rptStatus") = "reject" then %>						
										<span class="material-icons text-danger mr-4 circle p-3 border border-danger bg-danger-light25">close</span>																	
									<%else%>
										<span class="material-icons text-black mr-4 circle p-3 border border-dark bg-dark-light25">done</span>							
									<%end if 
								end if %>
							<%end if %>
							<div class="media-body">	
								<br>									  
								<h4 class="weight-400 m-0"><%=rs("pjtName")%>&nbsp;<%=rs1("platformName")%>&nbsp;(<%=varNoResult%>/<%=varRecord%>s)</h4>
															
		<%
		Set rs70 = Server.CreateObject("Adodb.Recordset")
		Set rs78 = Server.CreateObject("Adodb.Recordset")
		Set rs79 = Server.CreateObject("Adodb.Recordset")
		rs70.Open "select * from tbl_label where lbl_pjtId="&rs("pjtId")&" and lbl_platformId="&rs1("platformId")&" order by lblId asc",conn,3,3 
		rs78.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' and caseStage=1 order by caseId asc",conn,3,3		
		rs79.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' and caseStage=2 order by caseId asc",conn,3,3		
		if rs78.recordcount > 0 then %>
		<% if var1 <> 100 then
			response.write "�������ڣ�<br>"
			response.write "�༭���ڣ�<br>"		
			response.write "������ڣ�<br>" 
		%>
		
<i>������ ...</i>
		<%end if %>
		<%elseif rs79.recordcount > 0 then%>
		<% if var1 <> 100 then
			response.write "�������ڣ�<br>"
			response.write "�༭���ڣ�<br>"		
			response.write "������ڣ�<br>" %>
		<a href="admExcTestcaseTa-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-2-<%=rs7("userName")%>.html" class="text-black"><span class="nav-icon material-icons ">edit</span> ִ������ </a>	
		<%end if %>											
		<%else%>
		<a href="admExcTestcaseTa-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-3-<%=rs7("userName")%>.html" class="text-black"><span class="nav-icon material-icons ">edit</span> ִ������ </a>
		<%	response.write "�������ڣ�<br>"
			response.write "�༭���ڣ�<br>"		
			response.write "������ڣ�<br>" 
		end if %>
		<% if var1 = 100 then 		
				set rs9 = server.createobject("adodb.recordset")
				rs9.open "select * from tbl_report where rpt_pjtId="&rs("pjtId")&" and rpt_platformId="&rs1("platformId")&" order by rptId desc",conn,3,3 
				if rs9.eof then
					response.write "�������ڣ�<br>"
					response.write "�༭���ڣ�<br>"		
					response.write "������ڣ�<br>" 
						%><span class="nav-icon material-icons ">report_off</span>���Ա���(δ����)<%																						
				else
					if rs9("rptAuthor") = rs7("userName") then
						response.write "�������ڣ�"&rs9("rptCreatedDate")&"<br>"
					else
						response.write "�������ڣ�<br>"
					end if 
					
					if rs9("rptEditor") = rs7("userName") then
						response.write "�༭���ڣ�"&rs9("rptLatestDate")&"<br>"
					else
						response.write "�༭���ڣ�<br>"		
					end if 
					
					response.write "������ڣ�"&rs9("rptDoneDate")&"<br>"
					if rs9.recordcount = 0 then
						%><span class="nav-icon material-icons ">report_off</span>���Ա���(δ����)<%																	
					else
						if rs9("rptStatus") = "undone" then 			
							%> <a href="admReportAudit-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html">���Ա���(�����)</a><%																	
						elseif rs9("rptStatus") = "reject" then 			
							%> <a href="admReportAudit-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html"><font color="red">���Ա���(�Ѿܾ�)</font></a><%																	
						else
							%><a href="../sltReportShow-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html" target="_blank"><font color="black">���Ա���(�����)</font></a>
							<a href="admReportAuditRevise-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html" onClick="return confirm('��ܰ��ʾ���Ƿ�������ˣ�')">�������</a>							
							
							<%	
						end if 
				end if 
			end if 
		end if %>

					</div> <!--<div class="media-body">	-->					
				</div> 	<!--<div class="media align-items-center">-->
						
				<div class="progress mt-3" style="height: 6px;">
					<%if var1 <> 100 then%>
						<div class="progress-bar bg-danger" role="progressbar" style="width: <%=var1%>%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
					<%else%>
						<div class="progress-bar bg-info" role="progressbar" style="width: <%=var1%>%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
					<%end if %>							
				</div>

			</div>  <!--<div class="col-md-6 col-lg-3 mb-4 mb-lg-0"> -->
								  
				<% end if 
			varNoResult = 0
			rs1.movenext
			loop
		rs.movenext
		loop%>	
		</div> <!--<div class="row">-->		
		<hr> 
	<%rs7.movenext
	loop
	rs7.close
	set rs7 = nothing%>		
					
	</div>  <!-- <div class="tab-pane fade " id="home" role="tabpanel" aria-labelledby="home-tab"> -->
					
					
					<div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab">
					
									
<!-- ����Ŀ����ʾ��Ŀ�嵥�����򣺵�100%ʱ�ɵ���������Ա��棩 -->	
<%set rs47 = server.createobject("adodb.recordset")
rs47.open "select * from tbl_project where pjtStatus='1' order by pjtName",conn,3,3
do while not rs47.eof
	response.write "<h3>"
	response.write rs47("pjtName")
	response.write "</h3>"%>
	
	<div class="row">
		 	
	<%varNoResult = 0 
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_project where pjtStatus='1' and pjtName='"&rs47("pjtName")&"' order by pjtId desc",conn,3,3
	
	do while not rs.eof	
		set rs1 = server.createobject("adodb.recordset")
		rs1.open "select * from tbl_platform where plat_pjtId="&rs("pjtId")&" and platformStatus<>'2' and plat_rptStatus is null order by platformId desc",conn,3,3
		do while not rs1.eof
	
			set rs7 = server.createobject("adodb.recordset")
			rs7.open "select * from tbl_user  where userPower=2 and userStatus='1'",conn,3,3
			do while not rs7.eof	
				set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' order by caseId desc",conn,3,3
				varRecord = rs2.recordcount
				if varRecord <> 0 then
					do while not rs2.eof
						if rs2("caseResult") <> "empty" or rs2("caseStatus") <> "1" then
							varNoResult = varNoResult + 1
						end if 
					rs2.movenext
					loop 
					var1 = int(varNoResult/varRecord*100)%>
					
						 
					<div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
						<div class="media align-items-center">
							<%if var1 <> 100 then%>
								<span class="material-icons text-red mr-4 circle p-3 border border-red bg-red-light25">apps</span>								  
							<%else
								set rs19 = server.createobject("adodb.recordset")
								rs19.open "select * from tbl_report where rpt_pjtId="&rs("pjtId")&" and rpt_platformId="&rs1("platformId")&" order by rptId desc",conn,3,3 
								if rs19.eof then
									%><span class="material-icons text-primary mr-4 circle p-3 border border-primary bg-primary-light25">subject</span>	<%
								
								else
									if rs19("rptStatus") = "undone" then %>
										<span class="material-icons text-primary mr-4 circle p-3 border border-primary bg-primary-light35">edit</span>		
									<%elseif rs19("rptStatus") = "reject" then %>						
										<span class="material-icons text-danger mr-4 circle p-3 border border-danger bg-danger-light25">close</span>																	
									<%else%>
										<span class="material-icons text-black mr-4 circle p-3 border border-dark bg-dark-light25">done</span>							
									<%end if 
								end if %>								
							<%end if %>
							<div class="media-body">	<BR>									  
								<h4 class="weight-400 m-0"><%=rs("pjtName")%>&nbsp;<%=rs1("platformName")%>&nbsp;(<%=varNoResult%>/<%=varRecord%>s)<h5><%=rs7("userNickName")%></h5></h4>
							
		<%
		Set rs70 = Server.CreateObject("Adodb.Recordset")
		Set rs78 = Server.CreateObject("Adodb.Recordset")
		Set rs79 = Server.CreateObject("Adodb.Recordset")
		rs70.Open "select * from tbl_label where lbl_pjtId="&rs("pjtId")&" and lbl_platformId="&rs1("platformId")&" order by lblId asc",conn,3,3 
		rs78.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' and caseStage=1 order by caseId asc",conn,3,3		
		rs79.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&rs7("userName")&"' and caseStage=2 order by caseId asc",conn,3,3		
		if rs78.recordcount > 0 then %>
			<% if var1 <> 100 then
				response.write "�������ڣ�<br>"
				response.write "�༭���ڣ�<br>"		
				response.write "������ڣ�<br>" 
				%>
<i>������ ...</i>
			<%	
				end if 
		elseif rs79.recordcount > 0 then
		if var1 <> 100 then%>
		<a href="admExcTestcaseTa-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-2-<%=rs7("userName")%>.html" class="text-black"><span class="nav-icon material-icons ">edit</span> ִ������ </a>	
		<%	response.write "�������ڣ�<br>"
			response.write "�༭���ڣ�<br>"		
			response.write "������ڣ�<br>" 
		end if 											
		else%>
		<a href="admExcTestcaseTa-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-3-<%=rs7("userName")%>.html" class="text-black"><span class="nav-icon material-icons ">edit</span></i> ִ������ </a>
		<%	response.write "�������ڣ�<br>"
			response.write "�༭���ڣ�<br>"		
			response.write "������ڣ�<br>" 
		end if 
		
		if var1 = 100 then 
			set rs9 = server.createobject("adodb.recordset")
			rs9.open "select * from tbl_report where rpt_pjtId="&rs("pjtId")&" and rpt_platformId="&rs1("platformId")&" order by rptId desc",conn,3,3 
			if rs9.eof then
				response.write "�������ڣ�<br>"
				response.write "�༭���ڣ�<br>"		
				response.write "������ڣ�<br>" 
				%><span class="nav-icon material-icons ">report_off</span>���Ա���(δ����)<%
			else
				if rs9("rptAuthor") = rs7("userName") then
					response.write "�������ڣ�"&rs9("rptCreatedDate")&"<br>"
				else
					response.write "�������ڣ�<br>"
				end if 
				
				if rs9("rptEditor") = rs7("userName") then
					response.write "�༭���ڣ�"&rs9("rptLatestDate")&"<br>"
				else
					response.write "�༭���ڣ�<br>"		
				end if 
				
				response.write "������ڣ�"&rs9("rptDoneDate")&"<br>"
				
				if rs9.recordcount = 0 then
				%><span class="nav-icon material-icons ">report_off</span>���Ա���(δ����)<%																	
				else
				if rs9("rptStatus") = "undone" then 			
					%> <a href="admReportAudit-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html" class="text-yellow"> ���Ա���(�����)</a><%																	
				elseif rs9("rptStatus") = "reject" then 			
					%> <a href="admReportAudit-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html" class="text-red"><font color="red">���Ա���(�Ѿܾ�)</font></a><%																	
				else
				%><a href="../sltReportShow-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html" target="_blank"><font color="black"><b>���Ա���(�����)</b></font></a>
				<a href="admReportAuditRevise-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html" onClick="return confirm('��ܰ��ʾ���Ƿ�������ˣ�')">�������</a><%	
				end if 
			end if 
		
		end if 
		end if %>

						</div> <!--<div class="media-body">	-->					
					</div> 	<!--<div class="media align-items-center">-->
						
					<div class="progress mt-3" style="height: 6px;">
						<%if var1 <> 100 then%>
							<div class="progress-bar bg-danger" role="progressbar" style="width: <%=var1%>%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
						<%else%>
							<div class="progress-bar bg-info" role="progressbar" style="width: <%=var1%>%" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
						<%end if %>							
					</div>

			</div>  <!--<div class="col-md-6 col-lg-3 mb-4 mb-lg-0"> -->
								  
				<% end if 
			varNoResult = 0
			rs7.movenext
			loop
		
		rs1.movenext
		loop
			
	rs.movenext
	loop
	rs.close
	set rs = nothing%>	
	
	</div>	 <!--<div class="row">-->			
	<hr>
	<%rs47.movenext
	loop
	rs47.close
	set rs47 = nothing%>	
					</div>	<!-- 	<div class="tab-pane fade show active" id="profile" role="tabpanel" aria-labelledby="profile-tab"> -->
						 			
				</div>			 <!-- <div class="tab-content" id="myTabContent"> -->
			</div>  <!--<div class="card-body">-->
		
	
	<form id="form1" name="form1" method="post" action="admMainSave.html">
		<div class="row">	
			<div class="col-md-12" align="center">
				<%
				set rs8 = server.createobject("adodb.recordset")
				rs8.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
				userMemo = rs8("userMemo")		
				rs8.close
				set rs8 = nothing
				%>
			
				<div align="left"><h1 class="weight-300 h3 title">&nbsp;&nbsp;�����嵥</h1></div>
				<script type="text/plain" id="userMemo" style="width:99%; height:400px" name="userMemo"><%=userMemo%></script>	
				<script>var editor_a = UE.getEditor('userMemo');</script>
			</div>
		</div>
		<br>
		<div align="center">
			<button type="submit" class="btn btn-primary text-white py-1 px-2"><span class="material-icons mr-1 align-top">save</span> ����</button>
		</div>
		<br>
	</form>	
	
</div>
</div>
</div>		
</div>
<a href="#0" class="cd-top">Top</a>
</body>
</html>
