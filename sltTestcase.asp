<!--#include file="frame.asp"-->

<title> �������� | <%=cstCompany%></title>

<script language="javascript">     
function CheckPost()
{		
//�ύǰ����ȷ��		
var gnl=confirm("ȷ��Ҫ�ύ?");
if (gnl==true){
return true;
}else{
return false;
}
}
</script>

<% if request("action") = "submit" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	lblId = request("lblId")
	i = request("varcount")
	' ͳ�Ʊ�ǩ�µ�case��������������
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_case where case_pjtId="&pjtId&" and case_lblId="&lblId&"",conn,3,3
	varTotleSort = rs.recordcount
	rs.close
	set rs = nothing
	' ��������
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_case ",conn,3,3
	'����������
	set rs3 = server.CreateObject("ADODB.RecordSet")
	rs3.Open "select * from tbl_casepool ",conn,3,3	
	if request("caseTitle("&i&")") = ""  then
		response.Write("<script>;alert('��ܰ��ʾ���������ⲻ��Ϊ�գ�');window.location.href='sltTestcase-"&pjtId&"-"&platformId&"-"&lblId&".html';</script>")
		response.end 
	end if 	
	if request("maoyan("&i&")") = "" and request("zhengshi("&i&")") = "" and  request("huigui("&i&")")="" then
		response.Write("<script>;alert('��ܰ��ʾ�����Խ׶β���Ϊ�գ�');window.location.href='sltTestcase-"&pjtId&"-"&platformId&"-"&lblId&".html';</script>")
		response.end 
	end if 
	
	'pool,
	if request("caseTitle("&i&")") <> "" and request("pool("&i&")") > "0" then
		rs3.addnew
		if request("pool("&i&")") = "1" then
			rs3("poolSort") = "1"
			rs3("poolAudit") =  "0"
		elseif request("pool("&i&")") = "2" then
			rs3("poolSort") = "2"
		end if 
		rs3("poolTitle") = request("caseTitle("&i&")")	
		if request("caseStep("&i&")") = "" then  
		rs3("poolStep") = "��"	  
		else
		rs3("poolStep") = request("caseStep("&i&")")	
		end if 
		rs3("poolWeb") = request("checkbox1("&i&")")
		rs3("poolIos") = request("checkbox2("&i&")")
		rs3("poolAndroid") = request("checkbox3("&i&")")
		rs3("poolCS") = request("checkbox4("&i&")")
		rs3("poolDevice") = request("checkbox5("&i&")")
		rs3("poolUser") = session("userName")
		rs3("poolShow") = 1
		rs3("poolCreateDate") = now
		rs3.update
	end if 
	
	'case,ð��
	if request("caseTitle("&i&")") <> "" and request("maoyan("&i&")") = "on" then
		rs1.addnew 
		rs1("case_pjtId")= int(pjtId)  
		rs1("case_lblId") = int(lblId)
		rs1("case_platformId") = platformId
		rs1("caseTitle") = request("caseTitle("&i&")")	
		if request("caseStep("&i&")") = "" then  
		rs1("caseStep") = "��"	  
		else
		rs1("caseStep") = request("caseStep("&i&")")	
		end if    
		rs1("caseWeb") = request("checkbox1("&i&")")
		rs1("caseIos") = request("checkbox2("&i&")")
		rs1("caseAndroid") = request("checkbox3("&i&")")
		rs1("caseCS") = request("checkbox4("&i&")")
		rs1("caseDevice") = request("checkbox5("&i&")")
		rs1("caseStage") = 1	
		rs1("caseCreateDate") = now
		rs1("caseCreateUser") = session("userName")
		rs1("caseSort") = varTotleSort + 1
		rs1("caseStatus") = 1	
		rs1("caseResult") = "empty"	
		rs1("caseErrorType") = request("caseErrorType("&i&")")
		rs1("caseProblem")= request("caseProblem("&i&")")
		varSum = varSum + 1
		rs1.update
	
	end if 

	'case,��ʽ
	if request("caseTitle("&i&")") <> "" and request("zhengshi("&i&")") = "on" then
		rs1.addnew 
		rs1("case_pjtId")= int(pjtId)  
		rs1("case_lblId") = int(lblId)
		rs1("case_platformId") = platformId
		rs1("caseTitle") = request("caseTitle("&i&")")	
		if request("caseStep("&i&")") = "" then  
		rs1("caseStep") = "��"	  
		else
		rs1("caseStep") = request("caseStep("&i&")")	
		end if    
		rs1("caseWeb") = request("checkbox1("&i&")")
		rs1("caseIos") = request("checkbox2("&i&")")
		rs1("caseAndroid") = request("checkbox3("&i&")")
		rs1("caseCS") = request("checkbox4("&i&")")
		rs1("caseDevice") = request("checkbox5("&i&")")
		rs1("caseStage") = 2	
		rs1("caseCreateDate") = now
		rs1("caseCreateUser") = session("userName")
		rs1("caseSort") = varTotleSort + 1
		rs1("caseStatus") = 1	
		rs1("caseResult") = "empty"
		rs1("caseErrorType") = request("caseErrorType("&i&")")
		rs1("caseProblem")= request("caseProblem("&i&")")
		varSum = varSum + 1
		rs1.update
	
	end if 
	
	'case,�ع�
	if request("caseTitle("&i&")") <> "" and request("huigui("&i&")") = "on" then
		rs1.addnew 
		rs1("case_pjtId")= int(pjtId)  
		rs1("case_lblId") = int(lblId)
		rs1("case_platformId") = platformId
		rs1("caseTitle") = request("caseTitle("&i&")")	
		if request("caseStep("&i&")") = "" then  
		rs1("caseStep") = "��"	  
		else
		rs1("caseStep") = request("caseStep("&i&")")	
		end if    
		rs1("caseWeb") = request("checkbox1("&i&")")
		rs1("caseIos") = request("checkbox2("&i&")")
		rs1("caseAndroid") = request("checkbox3("&i&")")
		rs1("caseCS") = request("checkbox4("&i&")")
		rs1("caseDevice") = request("checkbox5("&i&")")
		rs1("caseStage") = 3
		rs1("caseCreateDate") = now
		rs1("caseCreateUser") = session("userName")
		rs1("caseSort") = varTotleSort + 1
		rs1("caseStatus") = 1
		rs1("caseResult") = "empty"		
		rs1("caseErrorType") = request("caseErrorType("&i&")")		
		rs1("caseProblem")= request("caseProblem("&i&")")		
		varSum = varSum + 1
		rs1.update
	end if 
	rs3.close
	set rs3 =nothing 
	rs1.close
	set rs1 = nothing  
	response.Redirect("sltTestcase-"&pjtId&"-"&platformId&"-"&lblId&".html")
end if %>



<%
pjtId = request("pjtId")
platformId = request("platformId")
lblId = request("lblId")
%>


<div class="content-wrapper">
<div class="page-title">
	<div><h1><i class="fa fa-plus text-danger">&nbsp;<%=cstNewCase%></i></h1><p>add testcase</p></div>
	<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#"><%=cstNewCase%></a></li></ul></div>
</div>
	
<div class="card">
<div class="row">
<div class="col-md-12">
	<div class="nav-tabs-custom">
		<ul class="nav nav-tabs pull-right">

		<!-- ������ǩ����Ĭ����ߵ�һ����ǩactive -->
		<% counts = 0
		Set rs3 = Server.CreateObject("Adodb.Recordset")
		rs3.Open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3
		varLebelTotal = rs3.recordcount
		reDim lblId_array(varLebelTotal)
		' �����ǩ
		if varLebelTotal > 1 then  
			do while not rs3.eof 		
				lblId_array(counts) = rs3("lblId")
				' rs66.recordcount ��ȡ��ǰ��ǩ ��ǰ�����µ���������
				set rs66 = server.createobject("adodb.recordset")
				rs66.open "select * from tbl_case where  case_lblId="&lblId_array(counts)&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3					
				if rs3("lblId") = int(lblId) then  %>
					<li class="active"><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs3("lblName")%>
					<%if rs66.recordcount >0 then %>
						<span class="label label-danger"><%=rs66.recordcount%></span>
					<%end if %>
					</a></li>
				<%else%>
					<li><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs3("lblName")%>
					<%if rs66.recordcount >0 then %>
						<span class="label label-danger"><%=rs66.recordcount%></span>
					<%end if %>
					</a></li>
				<%end if 
				rs66.close												
				counts = counts + 1 
			rs3.movenext
			loop  
		'1����ǩ	 
		elseif varLebelTotal = 1 then
			lblId_array(counts) = rs3("lblId")%> 
			<li class="active"><a href="#tab_1-1" data-toggle="tab"><%=rs3("lblName")%></a></li>
		<%else
			response.Redirect("index.html")
		end if%>             
		<li class="dropdown">
			<a class="dropdown-toggle text-red" data-toggle="dropdown" href="#">���� <span class="caret"></span></a>
			<ul class="dropdown-menu">
				<li role="presentation"><a role="menuitem" tabindex="-1" target="_blank" href="sltProjectInfo-<%=pjtId%>.html">��Ŀ��Ϣ</a></li>
				<li role="presentation"><a role="menuitem" tabindex="-1" target="_blank" href="sltTestcaseList-<%=pjtId%>-<%=platformId%>-<%=lblId%>-1.html">�������</a></li>
			</ul>
		</li>			  
		</ul>
			
		<div class="tab-content">
			<% varcount = 0										
			do while varcount < varLebelTotal 
				if lblId_array(varcount) = int(lblId) then %>
					<div class="tab-pane active" id="tab_1-<%=varcount%>">
				<%else%>
					<div class="tab-pane" id="tab_1-<%=varcount%>">
				<%end if %>
						
		
		<form role="form" action="sltTestcaseSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	

		<!-- ��������ҳ�� -->

		<div class="box box-danger box-solid box-default">
		<div class="box-header with-border">
			<h2 class="box-title">
			
			<!-- ��ʾ��Ŀ�� - ƽ̨�� -->
			<%Set rs4 = Server.CreateObject("Adodb.Recordset")
			rs4.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3%>
			<%Set rs5 = Server.CreateObject("Adodb.Recordset")
			rs5.Open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" ",conn,3,3			
			response.write rs4("pjtName") & rs5("platformName")
			rs5.close
			set rs5 = nothing
			
			%>
			</h2>
		</div>
														
												
		<div class="row">
			<div class="col-md-7">
				<div class="well bs-component">								
				<fieldset>
					<hr>
					<div class="row">	
						<div class="col-md-12">						
							<h4 class="box-title">�������� * ��1<50��</h4>
							<input type="text" name="caseTitle(<%=varcount%>)"  maxlength="50" class="form-control"  placeholder="�������Ŷ ...">
						</div>		
						<br>
					</div>
	
					<br>
	
					<div class="row">	
						<div class="col-md-12">						
							<h4 class="box-title">�������� *</h4>
							<script id="caseStep(<%=varcount%>)" style="position:relative;z-index:0;width:100%; height:400px" name="caseStep(<%=varcount%>)"></script>	
							<script>var editor_a = UE.getEditor('caseStep(<%=varcount%>)');</script>	
						</div>
					</div>				
				</fieldset>
				</div>
			</div>	
							
							
			<div class="col-md-5">	
				<br><br>	
				<div class="row">										
					<div class="col-md-12">
						<!-- ���Խ׶� -->									
						<h4 class="box-title">���Խ׶� *</h4>
						
						<div class="animated-checkbox">
						<%Set rs8 = Server.CreateObject("Adodb.Recordset")
						rs8.Open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseId desc",conn,3,3
						if rs8.eof then %>
							<label><input type="checkbox" name="maoyan(<%=varcount%>)" checked><span class="label-text"><i class="fa fa-fire"></i> ð�̲���</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="zhengshi(<%=varcount%>)" ><span class="label-text"><i class="fa fa-ellipsis-h"></i> ��ʽ����</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="huigui(<%=varcount%>)" ><span class="label-text"><i class="fa fa-chrome"></i> �ع����</span></label>
						
						<!-- ������������������Զ�ƥ�����һ�ι�ѡ�Ĳ��Խ׶�-->
						<%elseif rs8("caseStage") = "1" then %>
							<label><input type="checkbox" name="maoyan(<%=varcount%>)" checked><span class="label-text"><i class="fa fa-fire"></i> ð�̲���</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="zhengshi(<%=varcount%>)" ><span class="label-text"><i class="fa fa-ellipsis-h"></i> ��ʽ����</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="huigui(<%=varcount%>)" ><span class="label-text"><i class="fa fa-chrome"></i> �ع����</span></label>
						<%elseif rs8("caseStage") = "2" then%>
							<label><input type="checkbox" name="maoyan(<%=varcount%>)"><span class="label-text"><i class="fa fa-fire"></i> ð�̲���</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="zhengshi(<%=varcount%>)" checked><span class="label-text"><i class="fa fa-ellipsis-h"></i> ��ʽ����</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="huigui(<%=varcount%>)" ><span class="label-text"><i class="fa fa-chrome"></i> �ع����</span></label>
						<%else%>
							<label><input type="checkbox" name="maoyan(<%=varcount%>)" ><span class="label-text"><i class="fa fa-fire"></i> ð�̲���</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="zhengshi(<%=varcount%>)" ><span class="label-text"><i class="fa fa-ellipsis-h"></i> ��ʽ����</span></label>&nbsp;&nbsp;��
							<label><input type="checkbox" name="huigui(<%=varcount%>)" checked><span class="label-text"><i class="fa fa-chrome"></i> �ع����</span></label>
						<%end if%>
	
					</div>
				</div>

				<br><br><br><br>						
										
				<div class="col-md-12">
				<!-- ���Զ��� -->
				<div class="form-group">
				<h4 class="box-title">���Զ��� *</h4>
				
				<div class="animated-checkbox">
					<label>
					<%if rs8.eof then %>	
						<%if Instr(rs4("pjtObject"), "web")>0 then%>
						<input type="checkbox" name="checkbox1(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox1(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-windows"></i> B/S</span>
						&nbsp;&nbsp;��</label>
						
						<label>
						<%if Instr(rs4("pjtObject"), "iOS")>0 then%>
						<input type="checkbox" name="checkbox2(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox2(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-apple"></i> iOS</span>
						&nbsp;&nbsp;��</label>
						
						<label>
						<%if Instr(rs4("pjtObject"), "android")>0 then%>
						<input type="checkbox" name="checkbox3(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox3(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-android"></i> android</span>
						&nbsp;&nbsp;��</label>
					
						<label>
						<%if Instr(rs4("pjtObject"), "CS")>0 then%>
						<input type="checkbox" name="checkbox4(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox4(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-archive"></i> C/S</span>
						&nbsp;&nbsp;��</label>
						
						<label>
						<%if Instr(rs4("pjtObject"), "device")>0 then%>
						<input type="checkbox" name="checkbox5(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox5(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-sitemap"></i> �ն��豸</span>
						<%rs4.close%>
					<%else%>
						<!-- ������������������Զ�ƥ�����һ�ι�ѡ�Ĳ��Զ���-->
					
						<%if rs8("caseWeb") = "on" then%>
							<input type="checkbox" name="checkbox1(<%=varcount%>)" checked="checked">
						<%else%>
							<input type="checkbox" name="checkbox1(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-windows"></i> B/S</span>
						&nbsp;&nbsp;��</label>
						
						<label>
						<%if rs8("caseIos") = "on" then%>
						<input type="checkbox" name="checkbox2(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox2(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-apple"></i> iOS</span>
						&nbsp;&nbsp;��</label>
						
						<label>
						<%if rs8("caseAndroid") = "on" then%>
						<input type="checkbox" name="checkbox3(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox3(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-android"></i> android</span>
						&nbsp;&nbsp;��</label>
					
						<label>
						<%if rs8("caseCS") = "on" then%>
						<input type="checkbox" name="checkbox4(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox4(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-archive"></i> C/S</span>
						&nbsp;&nbsp;��</label>
						
						<label>
						<%if rs8("caseDevice") = "on" then%>
						<input type="checkbox" name="checkbox5(<%=varcount%>)" checked="checked">
						<%else%>
						<input type="checkbox" name="checkbox5(<%=varcount%>)" >
						<%end if %>	
						<span class="label-text"><i class="fa fa-sitemap"></i> �ն��豸</span>
						</label>
					
					<%end if %>		
				</div>
				<%rs8.close%>

			</div>
		</div>
	</div>
								
								
										
				<div class="row">
				<div class="col-md-12">	
				<div class="form-group">
				<h4 class="box-title">������������</h4>									 
				<% set rs66 = server.createobject("adodb.recordset")
				rs66.open "select * from tbl_errortype ",conn,3,3 %>
				<select name="caseErrorType(<%=varcount%>)" id="caseErrorType" class="form-control select2">
				<option value=0  selected="selected">��</option>
				<% do while not rs66.eof%>
				<option value="<%=rs66("errorId")%>" ><%=rs66("errorName")%></option>
				<%rs66.movenext
				loop
				rs66.close
				set rs66 = nothing %>
				</select>										
				</div>
				</div>	
				</div>
				
				<div class="row">
				<div class="col-md-12">		
				<div class="form-group">
				<h4 class="box-title">������������</h4> 
				<textarea  name="caseProblem(<%=varcount%>)" class="form-control" rows="17" placeholder="��ע������"></textarea>
				</div>
				</div></div>			
				</div>	
				</div>								 		  						

				<input name="varcount" type="hidden" value="<%=varcount%>" />
				<input name="pjtId" type="hidden" value="<%=pjtId%>" />	
				<input name="platformId" type="hidden" value="<%=platformId%>" />
				<input name="lblId" type="hidden" value="<%=lblId_array(varcount)%>" />
				<div class="col-md-12">		
							<br>			
								<hr>
					<div align="center"><button type="submit" class="btn btn-danger" style="margin-right: 5px;"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;�ύ</button></div>

				</div>														
			</div>
		</div>
					
		</form>
 
	<% 
	varcount = varcount + 1
	loop
	%> 				

</div>
			
				<!-- top��ť -->
				<div class="col-md-12" align="right">	
				
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>			
				</div>
				
			</div>
		</div>
	</div>
</div>



<!-- Select2 -->
<script src="plugins/select2/select2.full.min.js"></script>
<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();   
  });
</script>





</body>
</html>