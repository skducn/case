<!--#include file="frame.asp"-->

<title>�ҵ���� | <%=cstCompany%></title></title>

<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script language="javascript">  
function CheckPost()
{   	
$.notify({
title: "&nbsp;&nbsp;",
message: "����ɹ�",
icon: 'fa fa-check' 
},{
type: "success"
});
}
</script>

<style>
.abc a{margin: 2px;}
</style>

<!--  ����¼ -->	

<% if request("action") = "save" then
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
rs("userMemo") = request("userMemo")
rs.update
rs.close
set rs = nothing
response.Redirect "main.html"
end if %>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-dashboard"></i> �ҵ����</h1><p>Dashboard</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">�ҵ����</a></li></ul></div>
	</div>
	
	<div class="row">
							
		<!-- ��ʾ ִ��������������򣺵�100%ʱ�ɵ���������Ա��棩 -->
		<%
		varNoResult = 0 
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_project where pjtStatus='1' order by pjtId desc",conn,3,3
		do while not rs.eof
		set rs1 = server.createobject("adodb.recordset")
		rs1.open "select * from tbl_platform where plat_pjtId="&rs("pjtId")&" and platformStatus='1' and verIsReport<>'done' and plat_rptStatus is null order by platformId desc",conn,3,3
		do while not rs1.eof
		set rs2 = server.createobject("adodb.recordset")
		rs2.open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
		varRecord = rs2.recordcount
		if varRecord <> 0 then
		do while not rs2.eof
		if rs2("caseResult") <> "empty" or rs2("caseStatus") <> "1" then
		varNoResult = varNoResult + 1
		end if 
		rs2.movenext
		loop %>					
		<div class=" col-md-3 ">
		<div class="card">
		<h3 class="card-title"><%=rs("pjtName")%> - <%=rs1("platformName")%></h3>		
		<!-- /.info-box -->
		<% var1 = int(varNoResult/varRecord*100)%>
		<% if var1 < 30 then %> 					  
		<div class="info-box bg-red"> 
		<% elseif  var1 < 80 then %> 
		<div class="info-box bg-yellow">
		<% else %> 
		<div class="info-box bg-green">
		<%end if %>
		
		<span class="info-box-icon"><h4>
		<div class="row">
		<div class="col-md-1" align="left"><%=var1%>%</div>
		<div class="col-md-11" align="right">  <%=varNoResult%> / <%=varRecord%>s</div>
		</div>
		</h4></span>					  									
		
		<div class="info-box-content">																								
		<div class="progress">
		<div class="progress-bar" style="width: <%=var1%>%"></div>
		</div>
		<span class="progress-description">
		<%
		if var1 <> 100 then 
			Set rs70 = Server.CreateObject("Adodb.Recordset")
			Set rs78 = Server.CreateObject("Adodb.Recordset")
			Set rs79 = Server.CreateObject("Adodb.Recordset")
			rs70.Open "select * from tbl_label where lbl_pjtId="&rs("pjtId")&" and lbl_platformId="&rs1("platformId")&" order by lblId asc",conn,3,3 
			rs78.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&session("userName")&"' and caseStage=1 order by caseId asc",conn,3,3 
			rs79.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseCreateUser='"&session("userName")&"' and caseStage=2 order by caseId asc",conn,3,3 
			if rs78.recordcount > 0 then %>
			<a href="excTestcase-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-1.html" class="text-black"><i class="fa fa-edit"></i> ִ������</a> 
			<%elseif rs79.recordcount > 0 then%>
			<a href="excTestcase-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-2.html" class="text-black"><i class="fa fa-edit"></i> ִ������</a>												
			<%else%>
			<a href="excTestcase-<%=rs("pjtId")%>-<%=rs1("platformId")%>-<%=rs70("lblId")%>-3.html" class="text-black"><i class="fa fa-edit"></i> ִ������</a>
			<% end if 	 
		else
			set rs03 = server.CreateObject("ADODB.RecordSet")
			rs03.Open "select * from tbl_case where case_pjtId="&rs("pjtId")&" and case_platformId="&rs1("platformId")&" and caseResult='empty' and caseStatus='1' ",conn,3,3
			if rs03.recordcount = 0 then
				set rs13 = server.CreateObject("ADODB.RecordSet")
				rs13.Open "select * from tbl_report where rpt_pjtId="&rs("pjtId")&" and rpt_platformId="&rs1("platformId")&"",conn,3,3
				if rs13.recordcount = 0 then
					%>									
						<a href="sltReportCreate-<%=rs("pjtId")%>-<%=rs1("platformId")%>-0.html" class="text-black" ><i class="fa fa-edit"></i> �½����Ա���</a>		
					<%
				else
					if rs13("rptStatus") = "undone" then														
					%><a href="sltReportShow-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html"><font color="blue"><i class="fa fa-edit"></i> ���Ա��� - �����</font></a><%
					elseif rs13("rptStatus") = "reject" then	
					%><a href="sltReportShow-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html"><font color="red"><i class="fa fa-edit"></i> ���Ա��� - �Ѿܾ�</font></a><%
					else
					%><a href="sltReportShow-<%=rs("pjtId")%>-<%=rs1("platformId")%>.html"><i class="fa fa-book"></i> ���Ա��� - �����</a><%
					end if 
				end if
				rs13.close
			end if    
		end if %>
		</span>
		</div><!-- /.info-box-content -->
		</div></div>
		</div><!-- /.col -->
		
		<% end if 
		varNoResult = 0
		rs1.movenext
		loop
		rs.movenext
		loop%>	
		
	</div>	  
				 
	
	<div class="row">
	
		<!-- ��������-->
	
		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title"><i class="fa fa-plus text-danger"> <%=cstNewCase%></i></h3><hr>
					<table class="table table-hover table-bordered" id="sampleTable1">
					<thead><tr>
					<th style="white-space: nowrap; width: 10%;">���</th>
					<th style="white-space: nowrap; width: 20%;">��Ŀ/�汾</th>
					<th style="white-space: nowrap; width: 50%;">��������</th>
					<th style="white-space: nowrap; width: 20%;">��������</th>
					</tr></thead><tbody>
					<%
					set rs = Server.CreateObject("ADODB.recordset")
					rs.Open "select top 10 * from tbl_case where caseCreateUser='"&session("userName")&"' order by caseCreateDate desc",conn,3,3					
					do while not rs.eof 
						set rs22 = Server.CreateObject("ADODB.recordset")
						rs22.Open "select * from tbl_platform where platformId="&rs("case_platformId")&" order by platformId desc",conn,3,3 
						set rs11 = Server.CreateObject("ADODB.recordset")
						rs11.Open "select * from tbl_project where pjtId="&rs("case_pjtId")&" and pjtStatus='1' order by pjtId desc",conn,3,3 
						do while not rs11.eof%>
						<tr>
						<td><%=rs("caseId")%></td>
						<td style="white-space: nowrap;"><%=rs11("pjtName")%>/<%=rs22("platformName")%></td> 
						<td><a href="sltTestcaseEdit-<%=rs("caseId")%>.html" target="_blank"><%=rs("caseTitle")%></a></td>
						<td><%=rs("caseCreateDate")%></td>
						</tr>
						<% rs11.movenext
						loop
						rs11.close
						rs22.close
					rs.movenext
					loop
					rs.close
					set rs = nothing				
					%>	
					</tbody>
					</table>
				</div>
			</div>
		</div>
	
		<!-- ִ������-->

		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title"><i class="fa fa-edit text-primary"> <%=cstExcCase%></i></h3><hr>
					<table class="table table-hover table-bordered" id="sampleTable2">
					<thead><tr>
					<th style="white-space: nowrap;width: 10%;">���</th>
					<th style="white-space: nowrap;width: 20%;">��Ŀ/�汾</th>
					<th style="white-space: nowrap;width: 50%;">��������</th>
					<th style="white-space: nowrap;width: 20%;">ִ������</th>
					</tr></thead><tbody>
					<%
					set rs = Server.CreateObject("ADODB.recordset")
					rs.Open "select top 10 * from tbl_case where caseCreateUser='"&session("userName")&"' and caseExcDate is not null order by caseExcDate desc",conn,3,3
					do while not rs.eof 
						set rs22 = Server.CreateObject("ADODB.recordset")
						rs22.Open "select * from tbl_platform where platformId="&rs("case_platformId")&" order by platformId desc",conn,3,3 
						set rs11 = Server.CreateObject("ADODB.recordset")
						rs11.Open "select * from tbl_project where pjtId="&rs("case_pjtId")&" and pjtStatus='1' order by pjtId desc",conn,3,3 
						do while not rs11.eof%>
						<tr>
						<td><%=rs("caseId")%></td>
						<td style="white-space: nowrap;"><%=rs11("pjtName")%>/<%=rs22("platformName")%></td> 
						<td><a href="excTestcaseEdit-<%=rs("caseId")%>.html" target="_blank"><%=rs("caseTitle")%></a></td>
						<td><%=rs("caseExcDate")%></td>
						</tr>
						<%  rs11.movenext
						loop
						rs11.close
						rs22.close
					rs.movenext
					loop
					rs.close
					set rs = nothing
			
					%>	
					</tbody>
					</table>
				</div>
			</div>
		</div>		
	</div>
		
	<div class="row">
		
		<!-- �������-->

		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title"><i class="fa fa-edit text-warning"> <%=cstChangeCase%></i></h3><hr>
					<table class="table table-hover table-bordered" id="sampleTable3">
					<thead><tr>
					<th style="white-space: nowrap;width: 10%;">���</th>
					<th style="white-space: nowrap;width: 20%;">��Ŀ/�汾</th>
					<th style="white-space: nowrap;width: 50%;">��������</th>
					<th style="white-space: nowrap;width: 20%;">�������</th>
					</tr></thead><tbody>
					<%
					set rs = Server.CreateObject("ADODB.recordset")
					rs.Open "select top 10 * from tbl_case where caseCreateUser='"&session("userName")&"' and caseExcDate is null order by caseLatestDate desc",conn,3,3
					do while not rs.eof 
						set rs22 = Server.CreateObject("ADODB.recordset")
						rs22.Open "select * from tbl_platform where platformId="&rs("case_platformId")&" order by platformId desc",conn,3,3 
						set rs11 = Server.CreateObject("ADODB.recordset")
						rs11.Open "select * from tbl_project where pjtId="&rs("case_pjtId")&" and pjtStatus='1' order by pjtId desc",conn,3,3 
						do while not rs11.eof%>
						<tr>
						<td><%=rs("caseId")%></td>
						<td style="white-space: nowrap;"><%=rs11("pjtName")%>/<%=rs22("platformName")%></td> 
						<td><a href="excTestcaseEdit-<%=rs("caseId")%>.html" target="_blank"><%=rs("caseTitle")%></a></td>
						<td><%=rs("caseLatestDate")%></td>
						</tr>
						<%  rs11.movenext
						loop
						rs11.close
						rs22.close
					rs.movenext
					loop
					rs.close
					set rs = nothing				
					%>	
					</tbody>
					</table>
				</div>
			</div>
		</div>						

		<!-- ʧ������-->

		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title"><i class="fa fa-bug"></i> <%=cstBugCase%></h3><hr>
					<table class="table table-hover table-bordered" id="sampleTable4">
					<thead><tr>
					<th style="white-space: nowrap;width: 10%;">���</th>
					<th style="white-space: nowrap;width: 20%;">��Ŀ/�汾</th>
					<th style="white-space: nowrap;width: 50%;">��������</th>
					<th style="white-space: nowrap;width: 20%;">ִ������</th>

					</tr></thead><tbody>
					<% 
					set rs = Server.CreateObject("ADODB.recordset")
					rs.Open "select * from tbl_case where caseResult='error' and caseCreateUser='"&session("userName")&"' order by caseExcDate desc",conn,3,3
					do while not rs.eof
						set rs22 = Server.CreateObject("ADODB.recordset")
						rs22.Open "select * from tbl_platform where platformId="&rs("case_platformId")&" order by platformId desc",conn,3,3 
						set rs11 = Server.CreateObject("ADODB.recordset")
						rs11.Open "select * from tbl_project where pjtId="&rs("case_pjtId")&" and pjtStatus='1' order by pjtId desc",conn,3,3 
						do while not rs11.eof%>
						<tr>
						<td><%=rs("caseId")%></td>
						<td style="white-space: nowrap;"><%=rs11("pjtName")%>/<%=rs22("platformName")%></td> 
						<td><a href="excTestcaseEdit-<%=rs("caseId")%>.html" target="_blank"><%=rs("caseTitle")%></a></td>
						<td><%=rs("caseExcDate")%></td>
						</tr>
						<% rs11.movenext
						loop
						rs11.close
							rs22.close
					rs.movenext
					loop
					rs.close
					set rs = nothing

					%>	
					</tbody>
					</table>
				</div>
			</div>
		</div>	
	</div>		
	
	<div class="row">
		
		<!-- �ƻ��б�-->

		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title"><i class="fa fa-briefcase"></i> <%=cstPlanList%></h3><hr>
					<table class="table table-hover table-bordered" id="sampleTable5">
					<thead><tr>
					<th style="white-space: nowrap;width: 10%;">���</th>
					<th style="white-space: nowrap;width: 22.5%;">��Ŀ</th>
					<th style="white-space: nowrap;width: 22.5%;">�汾</th>
					<th style="white-space: nowrap;width: 22.5%;">��������</th>
					<th style="white-space: nowrap;width: 22.5%;">�������</th>
					</tr></thead><tbody>
					<% 									
						set rs11 = Server.CreateObject("ADODB.recordset")
						rs11.Open "select * from tbl_plan where planAuthor='"&session("userName")&"'",conn,3,3 				
						do while not rs11.eof						
							set rs22 = Server.CreateObject("ADODB.recordset")
							rs22.Open "select * from tbl_project where pjtId="&rs11("plan_pjtId")&" ",conn,3,3 																
							if rs22("pjtStatus") = "1" then
								set rs33 = Server.CreateObject("ADODB.recordset")
								rs33.Open "select * from tbl_platform where plat_pjtId="&rs22("pjtId")&" and platformId="&rs11("plan_platformId")&" and verIsPlan='on' order by platformId DESC",conn,3,3 
								%>
								<tr>
								<td><%=rs11("planId")%></td>
								<td><%=rs22("pjtName")%></td> 
								<td><a href="sltTestPlanList-<%=rs11("planId")%>.html" target="_blank"><%=rs33("platformName")%></a></td>
								<td><%=rs11("planCreatedDate")%></td>
								<td><%=rs11("planLatestDate")%></td>							
								</tr>
							<%  rs33.close
							end if 
							rs22.close
							
						rs11.movenext
						loop							
						rs11.close
					%>	
					</tbody>
					</table>
				</div>
			</div>
		</div>	
		
		
		<!-- ���Ա���-->

		<div class="col-md-6">
			<div class="card">
				<div class="card-body">
					<h3 class="card-title"><i class="fa fa-book"></i> <%=cstReport%></h3><hr>
					<table class="table table-hover table-bordered" id="sampleTable6">
					<thead><tr>
					<th style="white-space: nowrap;width: 10%;">���</th>
					<th style="white-space: nowrap;width: 20%;">��Ŀ</th>
					<th style="white-space: nowrap;width: 20%;">�汾</th>
					<th style="white-space: nowrap;width: 20%;">����/�������</th>
					<th style="white-space: nowrap;width: 10%;">����״̬</th>
					<th style="white-space: nowrap;width: 20%;">��������</th>
					
					</tr></thead><tbody>
					<% 					
					set rs = Server.CreateObject("ADODB.recordset")
					rs.Open "select * from tbl_report where rptAuthor='"&session("userName")&"' order by rptId desc",conn,3,3													
					do while not rs.eof
						set rs1 = Server.CreateObject("ADODB.recordset")
					rs1.Open "select * from tbl_project where pjtId="&rs("rpt_pjtId")&" order by pjtId desc",conn,3,3
						set rs2 = Server.CreateObject("ADODB.recordset")
						rs2.Open "select * from tbl_platform where platformId="&rs("rpt_platformId")&" order by platformId desc",conn,3,3
						if cdate(rs("rptCreatedDate")) > userRegDate then	
					%>
					<tr>
					<td><%=rs("rptId")%></td>
					<td><%=rs1("pjtName")%></td>
					<td><a href="sltReportShow-<%=rs("rpt_pjtId")%>-<%=rs("rpt_platformId")%>.html" target="_blank"><%=rs2("platformName")%></a></td>
					<td><%if rs("rptTestResult") = "pass" then %>
					<i class="fa fa-check text-green"></i>&nbsp;ͨ��
					<% else %>
					<i class="fa fa-close (alias) text-red"></i>&nbsp;��ͨ��
					<% end if  %> / 
					<%if rs("rptOnlineResult") = "pass" then %>
					<i class="fa fa-check text-green"></i>&nbsp;ͨ��
					<% else %>
					<i class="fa fa-close (alias) text-red"></i>&nbsp;��ͨ��
					<% end if  %>
					</td>
					<td><% if rs("rptStatus") = "done" then
					response.write "�����"
					elseif rs("rptStatus") = "reject" then
					response.write "<font color='red'>"
					response.write "�Ѿܾ�"
					response.write "</font>"
					else
					response.write "<font color='blue'>"
					response.write "�����"
					response.write "</font>"
					end if %></td>
					<td><%=rs("rptCreatedDate")%></td>
					</tr>
					<% 
						end if 
					rs.movenext
					loop
					rs.close
					set rs = nothing
					rs1.close
					rs2.close
					%>		
					</tbody>
					</table>
				</div>
			</div>
		</div>		
	</div>	 <!-- /.row -->
	

	<div class="card">
		<div class="row">
			<div class="col-md-12">		
				<h3 class="card-title"><i class="fa fa-list"></i> �����嵥</h3>				
				<form class="form-horizontal" method="post" name="addForm" onSubmit="return CheckPost()" action="mainSave.html#tasklist"> 
				<%set rs = server.createobject("adodb.recordset")
				rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3%>								
				<script type="text/plain" id="userMemo" style="width:100%; height:300px" name="userMemo"><%=rs("userMemo")%></script>	
				<script>var editor_a = UE.getEditor('userMemo');</script>
				<%rs.close
				set rs = nothing%>				
				<br />
				<table width="100%" border="0">
				<tr><td><div align="center"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;���� �����嵥</button></div></td></tr>
					<a id='tasklist'></a>
				</table>						
				</form>
			</div>	
			<!-- top��ť -->
			<div class="col-md-12" align="right">	
				<hr>
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>			
			</div>
		</div>
	</div>
		
			
	
</div>	
		
 
	
<!-- Javascripts-->
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>

<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script>

<script language="javascript">  
function CheckPost()
{
  
$.notify({
title: "&nbsp;&nbsp;",
message: "����ɹ�",
icon: 'fa fa-check' 
},{
type: "success"
});
}
</script>
<!-- table-->
<script type="text/javascript" src="731/dist/js/plugins/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">$('#sampleTable1').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 3, "desc" ]],
"aLengthMenu": [[10, 20, 50], [10, 20, 50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );</script>	
<script type="text/javascript">$('#sampleTable2').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 3, "desc" ]],
"aLengthMenu": [[10, 20, 50], [10, 20, 50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );</script>	
<script type="text/javascript">$('#sampleTable3').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 3, "desc" ]],
"aLengthMenu": [[10, 20, 50], [10, 20, 50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );</script>	
<script type="text/javascript">$('#sampleTable4').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 3, "desc" ]],
"aLengthMenu": [[10, 20, 50], [10, 20, 50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );</script>	
<script type="text/javascript">$('#sampleTable5').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 3, "desc" ]],
"aLengthMenu": [[10, 20, 50], [10, 20, 50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );</script>	
<script type="text/javascript">$('#sampleTable6').DataTable({
//�������±�һ������һ�д�0��ʼ���������ʼ��ʱ��������Ĭ�Ͻ���
"order": [[ 5, "desc" ]],
"aLengthMenu": [[10, 20, 50], [10, 20, 50]],
"oLanguage": {
"sSearch": "������",
"sLengthMenu": "ÿҳ��ʾ _MENU_ ����¼",
"sZeroRecords": "��Ǹ�� û���ҵ�",
"sInfo": "�� _START_ �� _END_ /�� _TOTAL_ ������",
"sInfoEmpty": "û������",
"sInfoFiltered": "(�� _MAX_ �������м���)",
"oPaginate": {
"sFirst": "��ҳ",
"sPrevious": "ǰһҳ",
"sNext": "��һҳ",
"sLast": "βҳ"
},
"sZeroRecords": "û�м���������",
"sProcessing": "<img src='./loading.gif' />"
}
} );</script>		

  </body>
</html>





	  

