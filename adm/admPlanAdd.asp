<!--#include file="admframe.asp"-->

<title>��̨-�½��ƻ� | <%=cstCompany%></title>


<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

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

function CheckPostCopy()
{			
	//�ύǰ����ȷ��		
	var gnl=confirm("����ģ����Զ��ύ��ȷ��Ҫ����ģ��?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}

</script>

<!--  �½����Լƻ� -->	

<%
if request("action") = "submit" then
	pjtId = request("pjtId")
	platformId = request("platformId")

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("plan_pjtId") = pjtId
		rs("plan_platformId") = platformId
	end if 
	rs("planGoal") = request("planGoal")
	rs("planScene") = request("planScene")
	rs("planInfo") = request("planInfo")
	rs("planTask") = request("planTask")
	rs("planSource") = request("planSource")
	rs("planInOut") = request("planInOut")
	rs("plan1Task") = request("plan1Task")
	rs("plan1Work") = request("plan1Work")
	rs("plan1Date") = request("plan1Date")
	rs("plan2Task") = request("plan2Task")
	rs("plan2Work") = request("plan2Work")
	rs("plan2Date") = request("plan2Date")
	rs("plan3Task") = request("plan3Task")
	rs("plan3Work") = request("plan3Work")
	rs("plan3Date") = request("plan3Date")
	rs("plan4Task") = request("plan4Task")
	rs("plan4Work") = request("plan4Work")
	rs("plan4Date") = request("plan4Date")
	rs("plan5Task") = request("plan5Task")
	rs("plan5Work") = request("plan5Work")
	rs("plan5Date") = request("plan5Date")
	rs("plan6Task") = request("plan6Task")
	rs("plan6Work") = request("plan6Work")
	rs("plan6Date") = request("plan6Date")
	rs("plan7Task") = request("plan7Task")
	rs("plan7Work") = request("plan7Work")
	rs("plan7Date") = request("plan7Date")
	rs("plan8Task") = request("plan8Task")
	rs("plan8Work") = request("plan8Work")
	rs("plan8Date") = request("plan8Date")
	rs("plan9Task") = request("plan9Task")
	rs("plan9Work") = request("plan9Work")
	rs("plan9Date") = request("plan9Date")
	rs("plan10Task") = request("plan10Task")
	rs("plan10Work") = request("plan10Work")
	rs("plan10Date") = request("plan10Date")
	rs("planInterface") = request("planInterface")
	rs("planFunc") = request("planFunc")
	rs("planSystem")= request("planSystem")
	rs("planPerformance")= request("planPerformance")
	rs("planCompatible") = request("planCompatible")
	rs("planAuto") = request("planAuto")
	rs("planDefect") = request("planDefect")	
	rs("planWay") = request("planWay")	
	rs("planLimit") = request("planLimit")	
	rs("planRisk") = request("planRisk")	
	rs("planCreatedDate") = now()	
	rs.update
	rs.close
	set rs = nothing	

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
	rs("verIsPlan") = "on"
	rs.update
	rs.close
	set rs = nothing
	
	response.Redirect("admTestPlanList-"&pjtId&"-"&platformId&".html")
end if 


'����ģ��'

if request("action") = "copy" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("plan_pjtId") = pjtId
		rs("plan_platformId") = platformId
	end if 
	
	rs("planGoal") = "�������ϵͳ�Ĳ��Լ���֤����Ļ��������ԣ����ܵ������ԣ����ݵ�׼ȷ�Եȡ�"
	
	rs("planInfo") = "ð�̲��ԣ�������������ҵ�����̲���Ҫ��ͨ��<br>" &chr(13)&chr(10) & _
"�������ԣ����������ܲ���Ҫ��ͨ��<br>" &chr(13)&chr(10) & _
"�ع���ԣ�Ԥ����������ҵ�����̲���Ҫ��ͨ��"
		
	rs("planTask") = "A���롶XXXϵͳ�������˵���顷�Ƚϣ������������ɵĹ��ܣ��Ƿ�����������˵��������ϣ�<br>"&chr(13)&chr(10) & _
"B������ҵ���Ƿ��ܹ���ȷ��ɣ�<br>"&chr(13)&chr(10) & _
"C������ϵͳ�Ƿ��ܹ��ȶ������У�<br>"&chr(13)&chr(10) & _
"D��������������װ˵���ļ��Ƿ���׼ȷ��"

	rs("planSource") = request("planSource")
	
	rs("planInOut") = "1������ҵ�������������ԡ���ȷ�ԣ�������ͨ���������Ʒ�߿�ͼ�����ͼ��<br>" &chr(13)&chr(10) & _
"2����������������������ͨ��ð�̲����ж��Ƿ�ɼ������ԣ���ȱ��a,b���ۼƳ�����������30%�������ҵ�����̵Ĳ����������޷�����ð�̲��ԣ�����ͣ���ԣ��˻ؿ�����"

	rs("planInterface") = "A. ���ݽӿ��ĵ���������֤��ȷ���쳣�����ķ��ؽ����<br>" &chr(13)&chr(10) & _
"B. ����ʱ����ȣ�����ӿ��Զ�����������֤�ӿڷ���ֵ�����ݿ�ֵ��<br>"&chr(13)&chr(10) & _
"ͨ����׼����ȷ���쳣������ͨ����"

	rs("planFunc") = "A�����ݲ����������в��ԣ�<br>"&chr(13)&chr(10) & _
"B����һ��ð�̲���ͨ����׼����ҵ�����̼���Ҫ���ܲ���ͨ����<br>"&chr(13)&chr(10) & _
"C���ڶ�����������ͨ����׼�����й��ܲ���ͨ����"&chr(13)&chr(10) & _
"D�������ֻع����ͨ����׼����ҵ�񳡾������̼���Ҫ���ܻع�ͨ����<br>"&chr(13)&chr(10) & _
"ͨ����׼�����ֶ�����ͨ����"

	rs("planSystem")= "A������������˵�����е�ҵ�񳡾������̣�<br>"&chr(13)&chr(10) & _
"B���������ԣ����ϵͳ����ɵĸ�ҵ�񳡾������Ƿ���ȷ��<br>"&chr(13)&chr(10) & _
"C�����������ԣ���ϵͳ���漰��������ݣ��Ƿ�����ȷ��ҵ������������ÿ���׶�����ӳ�����ݽ���Ƿ���ȷ��<br>"&chr(13)&chr(10) & _
"ͨ����׼����ҵ�񳡾�ͨ����"

	rs("planPerformance") = request("planPerformance")
	
	rs("planCompatible")= "A������ʱ����ȣ�����������ϵͳ���õ��������ͻ����ֻ��ȣ�����������������ʱ�Ƿ�������ȷ��<br>"&chr(13)&chr(10) & _
"B��ƽ̨��windows��macϵͳ ��<br> "&chr(13)&chr(10) & _
"C���������google��firefox��360�����˫�ˡ�safari��<br>"&chr(13)&chr(10) & _
"D���ͻ��ˣ�android\iOS�ȡ�<br>"&chr(13)&chr(10) & _
"E��������ƽ̨�����Բ��Եȡ�"
	

	rs("planAuto") = "A��������Ŀʱ����ȣ������Զ����ع���ԡ�<br>"&chr(13)&chr(10) & _
"B�����ܡ�ϵͳ���ع����ͨ�������ȶ�����Ҫ���ܣ�Ʃ�磺�漰��������Ȩ�ޡ�ע�ᡢ״̬�ȣ�����ҵ�񳡾��ſɽ����Զ�����<br>"&chr(13)&chr(10) & _
"C��������Ŀ����Ҫ��ʱ����ȣ������Զ�����ʱִ�С�<br>"&chr(13)&chr(10) & _
"ͨ����׼�����Զ�������ͨ����"

	rs("planDefect") = request("planDefect")

	rs("planWay") = "���Է��������ֹ����Զ�������"
	
	rs("planLimit") = "���Ա߽�Ķ��壬�����Ե������Ҫ��һ�������绷���������β���ֻ����������ܣ�Ĭ�����绷��Ϊ������<br>"&chr(13)&chr(10) & _
"���β����ݲ������û����顣"

	rs("planRisk") = "�ڲ��Թ����У����ܻ�������Ʒ��������������Ա���ڳ����ٵ�ԭ����ɹ�ͨȷ���ӳ٣��Ӷ�Ӱ����Ŀ���ȡ�<br>"&chr(13)&chr(10) & _
"��Ӳ����Դ���ƻ���ɱ����޷�ȫ���ǣ�Ʃ��ͻ���app���Եȡ�<br>"&chr(13)&chr(10) & _
"������Աʹ�õĹ����뷽�����ܵ��²��Բ���֡�<br>"&chr(13)&chr(10) & _
"�������ȼ������仯������ԭ������ҵ���߼��ĸı䣬�Ӷ�Ӱ���Ʒ��������<br>"&chr(13)&chr(10) & _
"��Ŀ����ĳ��ԭ����ͣ���������Ӳ������Ա�ȡ�<br>"&chr(13)&chr(10) & _
"��Ŀ��ͣ����������Ŀ���Ե�������Ҫ��ȷ��"
	rs("planCreatedDate") = now()	
	rs.update
	rs.close
	set rs = nothing	
	response.Redirect("admPlanAdd-"&pjtId&"-"&platformId&".html")
end if 
%>

<% pjtId = request("pjtId")
platformId = request("platformId")

set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs("pjtName")
set rs2 = server.createobject("adodb.recordset")
rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
pjtRedmine = rs2("platformRedmine")
platformName = rs2("platformName")
rs2.close
rs.close
set rs2 = nothing
set rs = nothing

set rs3 = server.createobject("adodb.recordset")
rs3.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
x = rs3.recordcount
%>

<form role="form2" action="admPlanAddCopy.html" method="post" name="addForm" onSubmit="return CheckPostCopy()">			
<input name="pjtId" type="hidden" value="<%=pjtId%>" />
<input name="platformId" type="hidden" value="<%=platformId%>" />
<input name="planCreatedDate" type="hidden" value="<%=now%>" />		
<button type="submit" class="btn btn-danger" href="#">����ģ��</button>
</form>

	<form role="form" action="admPlanAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >		

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">date_range</span>�ƻ����� - �½��ƻ�</h1>
			<p class="text-muted m-0 desc">Plan management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-12">
				<div class="card mb-4">
					<div class="card-body">	
						<div class="row">		
							<div class="col-md-12">	
								<h3 class="box-title" align="center"><%=pjtName%> - <%=platformName%></h3>															
							</div>
							<div class="col-md-12">	
								<h3 class="box-title">һ������</h3>					
								<label>1.1 ��дĿ��</label>
								<textarea  name="planGoal" class="form-control" rows="5" placeholder="������д��Ŀ�ġ�Լ�����ĵ��ı��ŷ�ʽ"><%if x<>0 then response.write rs3("planGoal") end if %></textarea>						
								<label>1.2 ����</label>
								<textarea  name="planScene" class="form-control" rows="5" placeholder="������Ŀ����"><%if x<>0 then response.write rs3("planScene") end if %></textarea>						
								<label>1.3 ������ο�</label>
								<textarea  name="planInfo" class="form-control" rows="5" placeholder="����д�ο��������������"><%if x<>0 then response.write rs3("planInfo") end if %></textarea>			
												
								<p></p>											
								<h3 class="box-title">����Լ��</h3>
									   
								<label>2.1 ����Ŀ��������</label>
								<textarea  name="planTask" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planTask") end if %></textarea>
								<label>2.2 ��Ա���豸</label>
								<textarea  name="planSource" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planSource") end if %></textarea>
								<label>2.3 ���������롢�����</label>
								<textarea  name="planInOut" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planInOut") end if %></textarea>
									
													
			<label>2.4 ���Խ���</label>
			<table class="table table-bordered">
			<tr>               
			<th style="width: 20%">���Խ׶�</th>
			<th style="width: 40%">��������</th>
			<th style="width: 15%">������/��Ա</th>
			<th style="width: 25%">��ֹʱ��</th>
			</tr>
			
			<tr>
			<td>�׶�1�������������Ʒ���������ĵ��ȣ�</td>
			<td>
			<textarea  name="plan1Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan1Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan1Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan1Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">			
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan1Date" class="form-control pull-right" id="reservation1" value=<%if x<>0 then response.write rs3("plan1Date") end if %>>
			</div>
			</div>
			</td>
			</tr>			

			<tr>			
			<td>�׶�2����Ʊ�д����</td>
			<td>
			<textarea  name="plan2Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan2Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan2Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan2Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan2Date" class="form-control pull-right" id="reservation2" value=<%if x<>0 then response.write rs3("plan2Date") end if %>>				
			</div>
			</td>
			</tr>
			
			<tr>
			<td>�׶�3���ӿڲ���</td>
			<td>
			<textarea  name="plan3Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan3Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan3Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan3Work") end if %></textarea>
			</td>
			<td>
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan3Date" class="form-control pull-right" id="reservation3" value=<%if x<>0 then response.write rs3("plan3Date") end if %>>
			</div>
			
			</td>
			</tr>
					
			<tr>
			<td>�׶�4�����ܲ���</td>
			<td>
			<textarea  name="plan4Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan4Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan4Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan4Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan4Date" class="form-control pull-right" id="reservation4" value=<%if x<>0 then response.write rs3("plan4Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>�׶�5��ϵͳ����</td>
			<td>
			<textarea  name="plan5Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan5Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan5Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan5Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan5Date" class="form-control pull-right" id="reservation5" value=<%if x<>0 then response.write rs3("plan5Date") end if %>>
			</div>
	
			</td>
			</tr>
					
			<tr>
			<td>�׶�6�����ܲ���</td>
			<td>
			<textarea  name="plan6Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan6Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan6Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan6Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan6Date" class="form-control pull-right" id="reservation6" value=<%if x<>0 then response.write rs3("plan6Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>�׶�7�����ݲ���</td>
			<td>
			<textarea  name="plan7Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan7Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan7Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan7Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan7Date" class="form-control pull-right" id="reservation7" value=<%if x<>0 then response.write rs3("plan7Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>�׶�8���ع����</td>
			<td>
			<textarea  name="plan8Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan8Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan8Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan8Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan8Date" class="form-control pull-right" id="reservation8" value=<%if x<>0 then response.write rs3("plan8Date") end if %>>
			</div>
	
			</td>
			</tr>
					
			<tr>
			<td>�׶�9���Զ�������</td>
			<td>
			<textarea  name="plan9Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan9Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan9Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan9Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan9Date" class="form-control pull-right" id="reservation9" value=<%if x<>0 then response.write rs3("plan9Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>�׶�10����������</td>
			<td>
			<textarea  name="plan10Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan10Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan10Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan10Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan10Date" class="form-control pull-right" id="reservation10" value=<%if x<>0 then response.write rs3("plan10Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			</table>
		
					
			
			<h3 class="box-title">�����������༰���Ա�׼</h3>
			<br>
			<div class="row">
				<div class="col-md-12">
				<label>3.1 �ӿڲ��Խ׶�</label>
				<textarea  name="planInterface" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.2 ���ܲ��Խ׶�</label>
				<textarea  name="planFunc" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.3 ϵͳ���Խ׶�</label>
				<textarea  name="planSystem" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.4 ���ܲ��Խ׶�</label>
				<textarea  name="planPerformance" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.5 ���ݲ��Խ׶�</label>
				<textarea  name="planCompatible" class="form-control" rows="5" placeholder="Enter ..."></textarea>			
				<label>3.6 �Զ�������</label>
				<textarea  name="planAuto" class="form-control" rows="5" placeholder="Enter ..."></textarea>			
				</div>
			</div>
	
			<p></p>
			<h3 class="box-title">�ġ����Է���</h3>
			<br>
			<div class="row">
				<div class="col-md-12">
				<label>4.1 ȱ�����ȼ�</label>
				<textarea  name="planDefect" class="form-control" rows="6" placeholder="Enter ..."></textarea>						
				<label>4.2 ���Է���������</label>
				<textarea  name="planWay" class="form-control" rows="6" placeholder="Enter ..."></textarea>						
				<label>4.3 ����Լ������</label>
				<textarea  name="planLimit" class="form-control" rows="6" placeholder="Enter ..."></textarea>						
				</div>
			</div> 
		
			<p></p>
			<h3 class="box-title">�塢���չ���</h3>
			<br>
			<div class="row">
				<div class="col-md-12">			
				<textarea  name="planRisk" class="form-control" rows="6" placeholder="Enter ..."><%if x<>0 then response.write rs3("planRisk") end if %></textarea>
				</div> 						
			</div>
						
			
		
					
							<div class="col-md-12">		
								<br />  			
								<input name="pjtId" type="hidden" value="<%=pjtId%>" />
								<input name="platformId" type="hidden" value="<%=platformId%>" />
								<input name="planCreatedDate" type="hidden" value="<%=now%>" />
							<div align="center"><button type="submit" class="btn btn-primary"  href="#">�ύ</button></div>									
				
						</div><!-- /.row -->					
					</div>
				</div>	 
			</div> <!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.content -->
</div>
</form>




<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="../plugins/select2/select2.full.min.js"></script>
<!-- InputMask -->
<script src="../plugins/input-mask/jquery.inputmask.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="../plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="../plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="../plugins/iCheck/icheck.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>


<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();
    //Date range picker
    $('#reservation1').daterangepicker();
	$('#reservation2').daterangepicker();
	$('#reservation3').daterangepicker();
	$('#reservation4').daterangepicker();  
	$('#reservation5').daterangepicker();  
	$('#reservation6').daterangepicker();  
	$('#reservation7').daterangepicker();  
	$('#reservation8').daterangepicker();  
	$('#reservation9').daterangepicker();  
	$('#reservation10').daterangepicker();  
  });
</script>
</body>
</html>
