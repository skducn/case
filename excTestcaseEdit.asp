<!--#include file="frame.asp"-->

<%
caseId = request("caseId")
set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_case where caseId="&caseId&" order by caseId DESC",conn,3,3 
	pjtId = rs("case_pjtId")
	platformId = rs("case_platformId")
	lblId = rs("case_lblId")
%>	

<title><%=cstExcCase%><%=caseId%> | <%=cstCompany%></title>

 
<script language="javascript">     
function CheckPost()
{      	
	

		  
    //�ύǰ����ȷ��      
    var gnl=confirm("ȷ��Ҫִ����?");
    if (gnl==true){
        return true;
    }else{
        return false;}
		
}
</script>
 


<!--  ִ�� ��������	-->

<% if request("action")="save" then  
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_case where caseId="&request("caseId")&"",conn,3,3 
	rs1("case_lblId") = request("case_lblId")	
	rs1("caseTitle") = request("caseTitle")
	rs1("caseStep") = request("caseStep")
	rs1("caseWeb") = request("caseWeb")
	rs1("caseIos") = request("caseIos")
	rs1("caseAndroid") = request("caseAndroid")
	rs1("caseCs") = request("caseCS")
	rs1("caseDevice") = request("caseDevice")
	rs1("caseStage") = request("caseStage")
	rs1("caseWebResult") = request("caseWebResult")
	rs1("caseIosResult") = request("caseIosResult")
	rs1("caseAndroidResult") = request("caseAndroidResult")
	rs1("caseCSResult") = request("caseCSResult")
	rs1("caseDeviceResult") = request("caseDeviceResult")
	rs1("caseMemo") = request("caseMemo")
	rs1("caseExcDate") = now	
	rs1("caseStatus") = request("caseStatus")
	if rs1("caseStatus") = "1" then
		if rs1("caseIosResult") = "ng" or rs1("caseAndroidResult") = "ng" or rs1("caseWebResult") = "ng" or rs1("caseCSResult") = "ng" or rs1("caseDeviceResult") = "ng" then
			rs1("caseResult") = "error"
		elseif request("caseIosResult") = "" and request("caseAndroidResult")= "" and request("caseWebResult") = "" and request("caseCSResult")= "" and request("caseDeviceResult") = "" then
			rs1("caseExcDate") = null
		else
			rs1("caseResult") = "ok"
		end if 
	else
		rs1("caseResult") = "empty"
	end if 
	rs1("caseExcUser") = session("userName")
	
	rs1("caseProblem") = request("caseProblem")
	rs1("caseErrorType") = request("caseErrorType")	
	rs1.update
	caseResult = rs1("caseResult")
	pjtId = rs1("case_pjtId")
	platformId = rs1("case_platformId")
	lblId = rs1("case_lblId")
	caseStage = rs1("caseStage")
	caseStatus = rs1("caseStatus")
	rs1.close
	set rs1 = nothing  
	response.Redirect("excTestcase-"&pjtId&"-"&platformId&"-"&lblId&"-"&caseStage&".html")

 end if %>
	

<!--  ajax-form	-->	
<script type="text/javascript" src="js/jo.ajax.js"></script>
<script type="text/javascript" src="js/ajax_form.js"></script>
<!--  ajax��ʾ��Ч��	-->	
<link href="js/alertify.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.alertify.js"></script>
<script type="text/javascript" charset="gbk" src="ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="ueditor/ueditor.all.min.js"> </script>	
<script type="text/javascript" charset="gbk" src="ueditor/lang/zh-cn/zh-cn.js"></script>




<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit text-primary"> <%=cstExcCase%></i></h1><p>execute testcase</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#"><%=cstExcCase%></a></li></ul></div>
	</div>

	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">	
					<div class="box-body">

						<form role="form" action="excTestcaseEditSave.html" method="post" name="addForm" onSubmit="return CheckPost()">

						<div class="box box-danger box-solid box-default">
							
							
							<div class="row">
								<div class="col-md-6" align="left">
									<h3 class="box-title"><h3 class="box-title">
								<!-- ��ʾ��Ŀ�� - ƽ̨�� -->
								<%Set rs4 = Server.CreateObject("Adodb.Recordset")
								rs4.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3%>
								<%Set rs5 = Server.CreateObject("Adodb.Recordset")
								rs5.Open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" ",conn,3,3%>
								<%=rs4("pjtName")%> <%=rs5("platformName")%> 
								<%rs5.close
								set rs5 = nothing
								%></h3></h3>						
								</div>				
								<div class="col-md-6" align="right">								
									<button type="submit" class="btn btn-primary" href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;ִ������</button>	
									<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
								</div>	
							</div>
									
				   		    <hr>			
												
							<div class="row">
								<div class="col-md-7">
									<div class="well bs-component">								
										<fieldset>
										
										<div class="row">	
											<div class="col-md-12">
												<h4 class="box-title">�������⣨<%=caseId%>�� </h4>
												<input type="text" name="caseTitle" class="form-control pull-right" maxlength="50" value="<%=rs("caseTitle")%>">
												
											</div>
										</div>	
										
										<br>
																
										<div class="row">	
											<div class="col-md-4">
												<h4 class="box-title">������ǩ </h4>
												<% set rs66 = server.createobject("adodb.recordset")
												rs66.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&"",conn,3,3 %>
												<select name="case_lblId" id="case_lblId" class="form-control ">
												<% do while not rs66.eof%>				
														<%if rs66("lblId") = lblId then%>
														<option value="<%=rs66("lblId")%>" selected><%=rs66("lblName")%></option>				
														<%else%>
														<option value="<%=rs66("lblId")%>" ><%=rs66("lblName")%></option>
														<%end if%>				
												<%rs66.movenext
												loop
												rs66.close
												set rs66 = nothing %>
												</select>
											</div>
	
						
											<div class="col-md-4">
												<h4 class="box-title">���Խ׶�</h4>
												<select name="caseStage" id="stageId" class="form-control " style="width: 100%;">
												<% if rs("caseStage") = 1 then %>
												  <option value="1" selected="selected">ð�̲���</option>
												  <option value="2">��ʽ����</option>
												  <option value="3">�ع����</option>
												<%end if %>
												<% if rs("caseStage") = 2 then %>
												  <option value="2" selected="selected">��ʽ����</option>
												  <option value="1">ð�̲���</option>
												  <option value="3">�ع����</option>
												<%end if %>
												<% if rs("caseStage") = 3 then %>
												  <option value="3" selected="selected">�ع����</option>
												  <option value="1">ð�̲���</option>
												  <option value="2">��ʽ����</option>
												<%end if %>
												</select>  
											</div>
						
											
											<div class="col-md-4">
											     <h4 class="box-title">����״̬</h4>
											     <select class="form-control" name="caseStatus">
												  <%if rs("caseStatus") = 1 then%>
													<option value="1" selected="selected">����</option>
													<option value="2">��ͣ</option>
													<option value="3">����</option>
												  <% elseif rs("caseStatus") = 2 then%>
													 <option value="2" selected="selected">��ͣ</option>
													<option value="1">����</option>
													<option value="3">����</option>
												  <% else%>
													<option value="3" selected="selected">����</option>
													<option value="1">����</option>
													<option value="2">��ͣ</option>	
													<%end if %>
											      </select>
											</div>	
										</div>
				
										<br>						

										<div class="row">
											<div class="col-md-12">
												<h4 class="box-title">�������� * </h4>
												<script id="caseStep" style="width:100%; height:582px" name="caseStep"><%=rs("caseStep")%></script>	
												<script > var editor_a = UE.getEditor('caseStep');</script>
											</div>
										</div>
												
										</fieldset>
									</div>
								</div>	
		
							
								<div class="col-md-5">	
																							
									<div class="row">
										<div class="col-md-12">	
											<h4 class="box-title">���Զ��� *</h4>	
											<div class="animated-checkbox">
												<label>
												<% if rs("caseWeb") = "on" then%>
													<input name="caseWeb" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseWeb" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-windows"></i> B/S</span></label>
												&nbsp;&nbsp;��																																																																															
												<label>
												<% if rs("caseIos") = "on" then%>
													<input name="caseIos" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseIos" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-apple"></i> iOS</span></label>
												&nbsp;&nbsp;��												
												<label>
												<% if rs("caseAndroid") = "on" then%>
													<input name="caseAndroid" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseAndroid" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-android"></i> android</span></label>
												&nbsp;&nbsp;��
												<label>
												<% if rs("caseCS") = "on" then%>
												<input name="caseCS" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseCS" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-archive"></i> C/S</span></label>
												&nbsp;&nbsp;��
												<label>
												<% if rs("caseDevice") = "on" then%>
												<input name="caseDevice" type="checkbox"  checked="checked" />
												<%else%>
													<input name="caseDevice" type="checkbox"  />
												<%end if %>
												<span class="label-text"><i class="fa fa-sitemap"></i> �ն��豸</span></label>
											</div>
										</div>
									</div>
								
									<br><br>
									
									<div class="row">
									<div class="col-md-12">	
										<h4 class="box-title">������������</h4>						
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_errortype ",conn,3,3 %>
										<select name="caseErrorType" id="caseErrorType" class="form-control select2">
										<option value=0  selected="selected">��</option>
										<% do while not rs66.eof%>
										<% if rs("caseErrorType") = rs66("errorId") then %>
										<option value=<%=rs66("errorId")%> selected="selected"><%=rs66("errorName")%></option>
										<%else%>
										<option value="<%=rs66("errorId")%>" ><%=rs66("errorName")%></option>
										<%end if %>
										<%rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>														
									</div>
									</div>
				
									<br>
									
									<div class="row">
									<div class="col-md-12">	
										<h4 class="box-title">������������</h4> 
										<textarea  name="caseProblem" class="form-control" rows="8" placeholder="��ע������"><%=rs("caseProblem")%></textarea>
									</div>		
									</div>
									
									<br>
									
									<div class="row">									
									<div class="col-md-12">										
										<h4 class="box-title">���Ա�ע ��<a href="<%=platformRedmine%>" target="_blank">���¼����</i></a>��</h4>
										
										
										<textarea  name="caseMemo" class="form-control" rows="8" placeholder="Enter ..."><%=rs("caseMemo")%></textarea>
									</div>
									</div>
																
								<br>	
								
								
								
									<div class="row"> 
						
								<div class="col-md-12">
									<h4 class="box-title">���Խ�� *</h4>
									<div class="box box-solid box-default">
									  <table class="table table-bordered">
										<tr>
										  <th style="white-space: nowrap;width: 20%;"  bgcolor="#f1f1f1"><i class="fa fa-windows"></i> B/S ���</th>
										  <th style="white-space: nowrap;width: 20%;"  bgcolor="#f1f1f1"><i class="fa fa-apple"></i> iOS ���</th>
										  <th style="white-space: nowrap;width: 20%;"  bgcolor="#f1f1f1"><i class="fa fa-android"></i> android ���</th>
										  <th style="white-space: nowrap;width: 20%;"  bgcolor="#f1f1f1"><i class="fa fa-archive"></i> C/S ���</th>
										  <th style="white-space: nowrap;width: 20%;"  bgcolor="#f1f1f1"><i class="fa fa-sitemap"></i> device ���</th>
										</tr>
										<tr>
										  <!-- web��� -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <%if rs("caseWebResult") = "pass" then%><input  type="checkbox"  name="caseWebResult" value="pass" checked="checked" />
												  <%else%><input  type="checkbox"  name="caseWebResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><font color="green"><i class="fa fa-circle-o"></i> ��ȷ</font></span></label>
											  </div>  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseWebResult") = "ng" then%><input  type="checkbox"  name="caseWebResult" value="ng"  checked="checked" />
												  <%else%><input type="checkbox" name="caseWebResult" value="ng"  />
												  <%end if %>
												    <span class="label-text"><font color="red"><i class="fa fa-close"></i> ����</font></span></label>
											  </div>			  
										  </td>
										  
										  <!-- ios��� -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseIosResult") = "pass" then%><input  type="checkbox"  name="caseIosResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseIosResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><font color="green"><i class="fa fa-circle-o"></i> ��ȷ</font></span></label>
											  </div>			  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseIosResult") = "ng" then%><input  type="checkbox" name="caseIosResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseIosResult" value="ng"  />
												  <%end if %>
												 <span class="label-text"><font color="red"><i class="fa fa-close"></i> ����</font></span></label>
											  </div>
										  </td>
										  
										  <!-- android��� -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseAndroidResult") = "pass" then%><input  type="checkbox"  name="caseAndroidResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseAndroidResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><font color="green"><i class="fa fa-circle-o"></i> ��ȷ</font></span></label>
											  </div>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseAndroidResult") = "ng" then%><input  type="checkbox" name="caseAndroidResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseAndroidResult" value="ng"  />
												  <%end if %>
												  <span class="label-text"><font color="red"><i class="fa fa-close"></i> ����</font></span></label>
											  </div>
										  </td>
										  
										  <!-- C/s��� -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseCSResult") = "pass" then%><input  type="checkbox"  name="caseCSResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseCSResult" value="pass"  />
												  <%end if %>
												  <span class="label-text"><font color="green"><i class="fa fa-circle-o"></i> ��ȷ</font></span></label>
											  </div>			  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseCSResult") = "ng" then%><input  type="checkbox" name="caseCSResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseCSResult" value="ng"  />
												  <%end if %>
												  <span class="label-text"><font color="red"><i class="fa fa-close"></i> ����</font></span></label>
											 </div>
										  </td>
										  
										  <!-- device��� -->
										  <td>
											  <div class="animated-checkbox"><label>
												  <% if rs("caseDeviceResult") = "pass" then%><input  type="checkbox"  name="caseDeviceResult" value="pass"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseDeviceResult" value="pass"  />
												  <%end if %>
												 <span class="label-text"><font color="green"><i class="fa fa-circle-o"></i> ��ȷ</font></span></label>
											  </div>			  
											  <div class="animated-checkbox"><label>
												  <% if rs("caseDeviceResult") = "ng" then%><input  type="checkbox" name="caseDeviceResult" value="ng"  checked="checked" />
												  <%else%><input  type="checkbox" name="caseDeviceResult" value="ng"  />
												  <%end if %>
												  <span class="label-text"><font color="red"><i class="fa fa-close"></i> ����</font></span></label>
											  </div>
										  </td>
										</tr>									  
									  </table>
									</div>
								</div>
							</div> 
							</div>	
								
	
							<div class="col-md-12">		
								<br>			
								<hr>			
								<div align="center"><button type="submit" class="btn btn-primary" style="margin-right: 5px;"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;ִ������</button></div>

							</div>	
						</div>	
							<input name="caseId" type="hidden" value="<%=request("caseId")%>" />				
					</form>	
				</div>
				
				<div class="col-md-12" align="right">	
			
					<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>	
					<a id='DD'></a>				
				</div>
			</div>
		</div>
	</div>
</div>
</div>


<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="plugins/select2/select2.full.min.js"></script>
<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();   
  });
</script>

<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

</body>
</html>