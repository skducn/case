<!--#include file="frame.asp"-->

<title>�½����Ա��� | <%=cstCompany%></title>

<script language="javascript">
function CheckPost()
{
	
	//ȱ��ƽ̨bug������Ϊ�ռ�����������
	if (addForm.rptIbug.value == "")
	{alert("iOS bug������Ϊ�գ�");addForm.rptIbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptIbug.value)) {alert("iOS bug��������������");addForm.rptIbug.focus();return false;}}
	  
	if (addForm.rptAbug.value == "")
	{alert("android bug������Ϊ�գ�");addForm.rptAbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptAbug.value)) {alert("android bug��������������");addForm.rptAbug.focus();return false;}}
	
	if (addForm.rptSbug.value == "")
	{alert("���ݿ�/�ӿ��� bug������Ϊ�գ�");addForm.rptSbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptSbug.value)) {alert("���ݿ�/�ӿ��� bug��������������");addForm.rptSbug.focus();return false;}}
	
	if (addForm.rptPbug.value == "")
	{alert("web php C/S bug������Ϊ�գ�");addForm.rptPbug.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptPbug.value)) {alert("web php C/S bug��������������");addForm.rptPbug.focus();return false;}}
  

	//ȱ�����س̶�bug������Ϊ�ռ�����������
	if (addForm.rptJdegree.value == "")
	{alert("���� bug������Ϊ�գ�");addForm.rptJdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptJdegree.value)) {alert("���� bug��������������");addForm.rptJdegree.focus();return false;}}
	  
	if (addForm.rptGdegree.value == "")
	{alert("�� bug������Ϊ�գ�");addForm.rptGdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptGdegree.value)) {alert("�� bug��������������");addForm.rptGdegree.focus();return false;}}
	
	if (addForm.rptPdegree.value == "")
	{alert("��ͨ bug������Ϊ�գ�");addForm.rptPdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptPdegree.value)) {alert("��ͨ bug��������������");addForm.rptPdegree.focus();return false;}}
	
	if (addForm.rptDdegree.value == "")
	{alert("�� bug������Ϊ�գ�");addForm.rptDdegree.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptDdegree.value)) {alert("�� bug��������������");addForm.rptDdegree.focus();return false;}}
	
	
	//ȱ��״̬ͳ��bug������Ϊ�ռ�����������
	if (addForm.rptWstatus.value == "")
	{alert("δ���� bug������Ϊ�գ�");addForm.rptWstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptWstatus.value)) {alert("δ���� bug��������������");addForm.rptWstatus.focus();return false;}}
	  
	if (addForm.rptCstatus.value == "")
	{alert("������ bug������Ϊ�գ�");addForm.rptCstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptCstatus.value)) {alert("������ bug��������������");addForm.rptCstatus.focus();return false;}}
	
	if (addForm.rptJstatus.value == "")
	{alert("�ѽ�� bug������Ϊ�գ�");addForm.rptJstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptJstatus.value)) {alert("�ѽ�� bug��������������");addForm.rptJstatus.focus();return false;}}
	
	if (addForm.rptFstatus.value == "")
	{alert("�ѷ��� bug������Ϊ�գ�");addForm.rptFstatus.focus();return false;}else{var re = /^[0-9]+.?[0-9]*$/;if (!re.test(addForm.rptFstatus.value)) {alert("�ѷ��� bug��������������");addForm.rptFstatus.focus();return false;}}	
  
//�ύǰ����ȷ��		
var gnl=confirm("ȷ��Ҫ�ύ?");
if (gnl==true){
return true;
}else{
return false;
}
 
}
</script>

<!--  �½����� -->	

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
		response.Write("<script>;alert('���棡���Ա����Ѵ���������ϵ����Ա��');window.location.href='main.asp';</script>")
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
%>

  

		
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

   
<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> ���Ա��� - �½����Ա���</h1><p>create testReport</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">���Ա���</a></li></ul></div>
	</div>
	
	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">
					
						<div class="row" align="center">
							<h3> <%=pjtName%> - <%=platformName%></h3>
						 </div>
					
						<div class="row">
						   <div class="col-md-9"></div>
						   <div class="col-md-2">				 
							  <% set rs66 = server.createobject("adodb.recordset")
								rs66.open "select * from tbl_report where rptAuthor='"&session("userName")&"' and rptStatus='done' order by rptId desc ",conn,3,3 %>
								<select name="caseErrorType(<%=varcount%>)" id="caseErrorType" class="form-control select2" onChange="window.location=this.value;">
								<option value="0"  selected="selected">< �뵼�뱨��ģ�� ></option>
								<option value="sltReportCreate-<%=request("pjtId")%>-<%=request("platformId")%>-0.html" >��</option>
								<% do while not rs66.eof%>
									<option value="sltReportCreate-<%=request("pjtId")%>-<%=request("platformId")%>-<%=rs66("rptId")%>.html" ><%=rs66("rptNo")%></option>
									<%rs66.movenext
								loop
								rs66.close
								set rs66 = nothing %>
								</select>										
							</div>
						</div>

					<form  action="sltReportCreateSubmit.html" method="post"  name="addForm" onSubmit="return CheckPost()" >		

					<h3 class="box-title">���Ը�Ҫ</h3>
					
					 <% set rs8 = server.createobject("adodb.recordset")
						rs8.open "select * from tbl_report where rptId="&request("rptId")&" order by rptId desc ",conn,3,3 %>
								
					<div class="box-body">
						<div class="row">  		
							<div class="col-md-4">
								<div class="form-group">
								<label>ģ������</label>
								<%if request("rptId")<>0 then%>
									<input type="text" name="rptNo" class="form-control" maxlength="20"  placeholder="Enter ..." value="<%=rs8("rptNo")%>">
								<%else%>
									<input type="text" name="rptNo" class="form-control" maxlength="20"  placeholder="Enter ..." value="<%=pjtName%><%=platformName%>">
								<%end if%>	
								</div>	
							</div>			
							<div class="col-md-4">      
								<div class="form-group">
								<label>��������</label>
								<%if request("rptId")<>0 then%>
									<textarea  name="rptPeriod" class="form-control" rows="3" placeholder="Enter ..." ><%=rs8("rptPeriod")%></textarea>
								<%else%>
									<textarea  name="rptPeriod" class="form-control" rows="3" placeholder="��ʼ - ��������"></textarea>
								<%end if%>
								
								</div>				
							</div>
							<div class="col-md-4">
								<div class="form-group">
									<label>������Ա</label>
									<%if request("rptId")<>0 then%>
										<textarea  name="rptMember" class="form-control" rows="3" placeholder="Enter ..."><%=rs8("rptMember")%></textarea>
									<%else%>
										<textarea  name="rptMember" class="form-control" rows="3" placeholder="���в�����Ա����"></textarea>
									<%end if%>
									
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
								<label>����˵��</label>
									<%if request("rptId")<>0 then%>
										<textarea  name="rptBasis" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptBasis")%></textarea>
									<%else%>
										<textarea  name="rptBasis" class="form-control" rows="6" placeholder="�磺���Ի�����ַ��jenkins�����������ȡ�"></textarea>
									<%end if%>
							
								</div>
							</div>									          						
							<div class="col-md-4">
								<div class="form-group">
								  <label>���ƽ̨</label>
								  	<%if request("rptId")<>0 then%>
										<textarea  name="rptTerminal" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptTerminal")%></textarea>
									<%else%>
										<textarea  name="rptTerminal" class="form-control" rows="6" placeholder="Enter ..."></textarea>
									<%end if%>
							
								</div>
							</div>
							<div class="col-md-4">
								<div class="form-group">
								  <label>����</label>
								   	<%if request("rptId")<>0 then%>
										<textarea  name="rptRisk" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptRisk")%></textarea>
									<%else%>
										<textarea  name="rptRisk" class="form-control" rows="6" placeholder="��֪���⼰Ǳ�ڷ���"></textarea>
									<%end if%>
					
								</div>
							</div>
							
							<div class="col-md-4"></div>
							
							<div class="col-md-2">							
								<label>���Ի������</label><br>
								 <div class="animated-radio-button">					   															
									<label><input type="radio" name="rptTestResult" value="pass" ><span class="label-text"><i class="fa fa-check"></i>ͨ��</span></label>&nbsp;&nbsp;��	
									<label><input type="radio" name="rptTestResult" value="failed" checked><span class="label-text"><i class="fa fa-close"></i>��ͨ��</span></label>															
							
								</div>
							</div>
								
							<div class="col-md-6">					
								<label>�����������</label><br>
								<div class="animated-radio-button">
							
									<label><input type="radio" name="rptOnlineResult" value="pass"><span class="label-text"><i class="fa fa-check"></i>ͨ��</span></label>&nbsp;&nbsp;��	
									<label><input type="radio" name="rptOnlineResult" value="failed" checked><span class="label-text"><i class="fa fa-close"></i>��ͨ��</span></label>									
							
								</div>
							</div>	
					
																						
						</div>
  
         
	
						<h3 class="box-title">1������</h3>
					 
						<div class="col-md-6">
							<div class="form-group">
							<label>1.1 Ŀ��</label>
							   	<%if request("rptId")<>0 then%>
									<textarea  name="rptGoal" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptGoal")%></textarea>
								<%else%>
									<textarea  name="rptGoal" class="form-control" rows="6" placeholder="Enter ..."></textarea>
								<%end if%>
							
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
							<label>1.2 ����</label>
							   	<%if request("rptId")<>0 then%>
									<textarea  name="rptScene" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptScene")%></textarea>
								<%else%>
									<textarea  name="rptScene" class="form-control" rows="6" placeholder="Enter ..."></textarea>
								<%end if%>
						
							</div>
						</div>
						<div class="col-md-6">				
							<div class="form-group">
							<label>1.3 �������</label>
							  	<%if request("rptId")<>0 then%>
									<textarea  name="rptSoft" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptSoft")%></textarea>
								<%else%>
									<textarea  name="rptSoft" class="form-control" rows="6" placeholder="Enter ..."></textarea>
								<%end if%>
						
							</div>
						</div>
						<div class="col-md-6">		
							<div class="form-group">
							<label>1.4 Ӳ����Դ</label>
								<%if request("rptId")<>0 then%>
									<textarea  name="rptHard" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptHard")%></textarea>
								<%else%>
									<textarea  name="rptHard" class="form-control" rows="6" placeholder="Enter ..."></textarea>
								<%end if%>
						
						</div>
					</div>
				
				
				<div class="form-group">
					<label>1.5 ���Խ���</label>
					<table class="table table-bordered">
					<tr>               
					<th style="width: 15%">������Ŀ</th>
					<th style="width: 20%">��ʼ - ��������</th>				
					<th style="width: 65%">��ע</th>
					</tr>
					
					<tr>
					<td>�����ĵ�����</td>
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
							<textarea  name="rptStoryMemo" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptStoryMemo")%></textarea>
						<%else%>
							<textarea  name="rptStoryMemo" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>					 
				
					</div>
					</td>
					</tr>
				
					<tr>
					<td>��Ʊ�д����</td>
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
							<textarea  name="rptDesignMemo" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptDesignMemo")%></textarea>
						<%else%>
							<textarea  name="rptDesignMemo" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>		
				
					</div>
					</td>
					</tr>
					
					<tr>
					<td>ִ�в�������</td>
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
							<textarea  name="rptExcMemo" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptExcMemo")%></textarea>
						<%else%>
							<textarea  name="rptExcMemo" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>		
					
					</div>
					</td>
					</tr>
					
					<tr>
					<td>bug��֤�ع�</td>
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
							<textarea  name="rptBugMemo" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptBugMemo")%></textarea>
						<%else%>
							<textarea  name="rptBugMemo" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>	
				
					</div>
					</td>
					</tr>
					</table>
				</div>
			
			<div class="col-md-6">
				<div class="form-group">
				<label>1.6 ����</label>
				<%if request("rptId")<>0 then%>
					<textarea  name="rptCaption" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptCaption")%></textarea>
				<%else%>
					<textarea  name="rptCaption" class="form-control" rows="6" placeholder="Enter ..."></textarea>
				<%end if%>	
			
				</div>
			</div>
			<div class="col-md-6">			
				<div class="form-group">
				<label>1.7 �ο�����</label>
				<%if request("rptId")<>0 then%>
					<textarea  name="rptRef" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptRef")%></textarea>
				<%else%>
					<textarea  name="rptRef" class="form-control" rows="6" placeholder="Enter ..."></textarea>
				<%end if%>	
			
				</div>
			</div>
		</div> <!-- .col --> 	 
	


			<h3 class="box-title">2����������</h3>		
		
        	<div class="col-md-12">
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>
		
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th>����ID</th>
				<th>��ǩ</th>
				<th>��������</th>
				<th>���Զ���</th>
				<th>���Խ׶�</th>
				<th>���Խ��</th>
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
	


			<h3 class="box-title">3�����Է���</h3>
	
		
   
			<div class="col-md-12">
				<div class="box-header">
				<h3 class="box-title">3.1  ���Ը�����</h3>
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th>�汾</th>
				<th>��ǩ</th>
				<th>��������</th>
				<th>��ͨ����(s)</th>
				<th>δͨ����</th>
				<th>δ������(���ã�</th>
				<th>����ִ�и�����</th>
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
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.2 ȱ��ƽ̨ͳ��</h3> 
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>ϵͳƽ̨</th>
					<th>Bug�� ��<a href="<%=platformRedmine%>" target="_blank"> buglist</i></a>��</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>iOS</td>
					<td><div class="form-group">
					<input type="text" name="rptIbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<input type="text" name="rptAbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>���ݿ�/�ӿ���</td>
					<td><div class="form-group">
					<input type="text" name="rptSbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<input type="text" name="rptPbug" class="form-control" placeholder="����">
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
					<h3 class="box-title">3.3 ȱ�����س̶�</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>���س̶�</th>
					<th>Bug�� ��<a href="<%=platformRedmine%>" target="_blank"> buglist</i></a>��</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>����</td>
					<td><div class="form-group">
					<input type="text" name="rptJdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group">
					<input type="text" name="rptGdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>��ͨ</td>
					<td><div class="form-group">
					<input type="text" name="rptPdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group">
					<input type="text" name="rptDdegree" class="form-control" placeholder="����">
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
						<h3 class="box-title">3.4 ȱ��״̬ͳ��</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>ȱ��״̬</th>
					<th>Bug�� ��<a href="<%=platformRedmine%>" target="_blank"> buglist</i></a>��</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>δ����(�½�)</td>
					<td><div class="form-group">
					<input type="text" name="rptWstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>������</td>
					<td><div class="form-group">
					<input type="text" name="rptCstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>�ѽ��</td>
					<td><div class="form-group">
					<input type="text" name="rptJstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>�ѷ���</td>
					<td><div class="form-group">
					<input type="text" name="rptFstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
		

			
			
			<div class="col-md-12">	
		<div class="box-header"><h3 class="box-title"> ����ȱ��ͳ��</h3></div>
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
				<td><input maxlength="3" type="text" name="errStory<%=x%>" class="form-control" ></td>			
			<%rs4.movenext
			loop
			rs4.close%>
		
			</tr></tbody></table>
		</div>
	</div>
			
			<div class="col-md-4">
				<div class="form-group">
					<label>3.5 ����/����</label>
						<%if request("rptId")<>0 then%>
							<textarea  name="rptFeedback" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptFeedback")%></textarea>
						<%else%>
							<textarea  name="rptFeedback" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>	
				
				</div>
			</div>
			<div class="col-md-4">			
				<div class="form-group">
					<label>3.6 ���Խ�����</label>
						<%if request("rptId")<>0 then%>
							<textarea  name="rptDelivery" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptDelivery")%></textarea>
						<%else%>
							<textarea  name="rptDelivery" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>	
			

				</div>
			</div>

			<div class="col-md-4">					
				<div class="form-group">
					<label>3.7 ����</label>
						<%if request("rptId")<>0 then%>
							<textarea  name="rptAdvice" class="form-control" rows="6" placeholder="Enter ..."><%=rs8("rptAdvice")%></textarea>
						<%else%>
							<textarea  name="rptAdvice" class="form-control" rows="6" placeholder="Enter ..."></textarea>
						<%end if%>	
				
				</div>
			</div><!-- /.col -->


 
			<h3 class="box-title">4�����Խ���</h3>			
				<div class="col-md-12">
					<div class="form-group">				
					<label>���Խ���</label>
						<%if request("rptId")<>0 then%>
							<textarea  name="rptConclusion" class="form-control" rows="12" placeholder="Enter ..."><%=rs8("rptConclusion")%></textarea>
						<%else%>
							<textarea  name="rptConclusion" class="form-control" rows="12" placeholder="Enter ..."></textarea>
						<%end if%>	
				
					</div>				
				</div>  <!-- /.col -->
 

			<input name="pjtId" type="hidden" value="<%=pjtId%>" />	
			<input name="platformId" type="hidden" value="<%=platformId%>" />
			<input name="rptCreatedDate" type="hidden" value="<%=now%>" />     
		
			<div class="col-md-12">			
				<hr>  
				<div align="center"><button type="submit" class="btn btn-primary" style="margin-right: 5px;"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;�ύ ���Ա���</button></div>
				<br>
			</div>



	</form>
	
	
</div>
</div>
</div>
</div>


	<!-- ����top��ť -->
	<div class="row">
	<div class="col-md-2">
	<a href="#top"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-arrow-circle-up"></i> ����</button></a>
	</div>
	<div class="col-md-10" align="right">
	<a href="#top"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-arrow-circle-up"></i> ����</button></a>
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
