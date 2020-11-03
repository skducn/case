<!--#include file="frame.asp"-->

<title><%=cstEditPlan%> | <%=cstCompany%></title>

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

<!--  �༭���Լƻ� -->	

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
	rs("planAuthor") = session("userName")
	rs("planLatestDate") = now()	
	rs.update
	planId = rs("planId")
	rs.close
	set rs = nothing	
	response.Redirect("sltTestPlanList-"&planId&".html")
end if 

%>

<% 
'set rs5 = server.createobject("adodb.recordset")
'rs5.open "select * from tbl_plan where planId="&request("planId")&"",conn,3,3
'if rs5("planAuthor") <> session("userName") then
'	response.Redirect("index.html")
'end if 
pjtId = request("pjtId")
platformId = request("platformId")

set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtId="&int(pjtId)&" order by pjtId desc",conn,3,3
pjtName = rs("pjtName")
set rs2 = server.createobject("adodb.recordset")
rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
if rs2.eof then
	response.Redirect("index.html")
else
pjtRedmine = rs2("platformRedmine")
platformName = rs2("platformName")
end if 
rs2.close
rs.close
set rs2 = nothing
set rs = nothing

set rs3 = server.createobject("adodb.recordset")
rs3.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
x = rs3.recordcount
%>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> �ƻ����� - �༭�ƻ�</h1><p>Testplan panel</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">�ƻ�����</a></li></ul></div>
	</div>
	
	<div class="card">	
		<form role="form" action="sltPlanEditSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
		<div class="row">
			<div class="col-md-6" align="left">
				<h3 class="box-title"><%=pjtName%> - <%=platformName%></h3>	
			</div>
			<div class="col-md-6" align="right">	
				<button type="submit" class="btn btn-primary " href="#"><i class="fa fa-fw  fa-check-circle"></i>����</button>				
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>
			</div>	
		</div>
	
		<hr>																					
		
		<h3 class="box-title">һ������</h3>
						
		<div class="row">
			<div class="col-md-4">						
				<h4>1.1 ��дĿ��</h4>
				<textarea  name="planGoal" class="form-control" rows="5" placeholder="������д��Ŀ�ġ�Լ�����ĵ��ı��ŷ�ʽ"><%=rs3("planGoal")%></textarea>						
			</div>			
			<div class="col-md-4">	
				<h4>1.2 ����</h4>
				<textarea  name="planScene" class="form-control" rows="5" placeholder="������Ŀ����"><%=rs3("planScene")%></textarea>						
			</div>		
			<div class="col-md-4">	
				<h4>1.3 ������ο�</h4>
				<textarea  name="planInfo" class="form-control" rows="5" placeholder="����д�ο��������������"><%=rs3("planInfo")  %></textarea>			
			</div>	
		</div>
						
								
		<h3 class="box-title">����Լ��</h3>

		<div class="row">
			<div class="col-md-4">	
				<h4>2.1 ����Ŀ��������</h4>
				<textarea  name="planTask" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planTask")%></textarea>
			</div>
			<div class="col-md-4">	
				<h4>2.2 ��Ա���豸</h4>
				<textarea  name="planSource" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planSource") %></textarea>
			</div>
			<div class="col-md-4">	
				<h4>2.3 ���������롢�����</h4>
				<textarea  name="planInOut" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planInOut")  %></textarea>
			</div>
					
			<div class="col-md-12"><br>		
			<h4>2.4 ���Խ���</h4>
			<table class="table table-bordered">
			<tr>               
			<th style="width: 20%" bgcolor="#f1f1f1">���Խ׶�</th>
			<th style="width: 30%" bgcolor="#f1f1f1">��������</th>
			<th style="width: 30%" bgcolor="#f1f1f1">������/��Ա</th>
			<th style="width: 20%" bgcolor="#f1f1f1">��ֹʱ��</th>
			</tr>			
			<tr>
			<td>�׶�1���������<br>����Ʒ���������ĵ��ȣ�</td>
			<td>
			<textarea  name="plan1Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan1Task")  %></textarea>
			</td>
			<td>
			<textarea  name="plan1Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan1Work") %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">			
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>				
				<input type="text" name="plan1Date" class="form-control pull-right" id="reservation1" value="<%=rs3("plan1Date")  %>">
			</div>
			</td>
			</tr>			
			<tr>			
			<td>�׶�2����Ʊ�д����</td>
			<td>
			<textarea  name="plan2Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan2Task")  %></textarea>
			</td>
			<td>
			<textarea  name="plan2Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan2Work")  %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan2Date" class="form-control pull-right" id="reservation2" value="<%=rs3("plan2Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>�׶�3���ӿڲ���</td>
			<td>
			<textarea  name="plan3Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan3Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan3Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan3Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan3Date" class="form-control pull-right" id="reservation3" value="<%=rs3("plan3Date") %>">
			</div>
			</td>
			</tr>				
			<tr>
			<td>�׶�4�����ܲ���</td>
			<td>
			<textarea  name="plan4Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan4Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan4Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan4Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan4Date" class="form-control pull-right" id="reservation4" value="<%=rs3("plan4Date") %>">
			</div>
			</td>
			</tr>			
			<tr>
			<td>�׶�5��ϵͳ����</td>
			<td>
			<textarea  name="plan5Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan5Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan5Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan5Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan5Date" class="form-control pull-right" id="reservation5" value="<%=rs3("plan5Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>�׶�6�����ܲ���</td>
			<td>
			<textarea  name="plan6Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan6Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan6Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan6Work") %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan6Date" class="form-control pull-right" id="reservation6" value="<%=rs3("plan6Date") %>">
			</div>
			</td>
			</tr>	
			<tr>
			<td>�׶�7�����ݲ���</td>
			<td>
			<textarea  name="plan7Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan7Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan7Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan7Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan7Date" class="form-control pull-right" id="reservation7" value="<%=rs3("plan7Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>�׶�8���ع����</td>
			<td>
			<textarea  name="plan8Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan8Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan8Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan8Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan8Date" class="form-control pull-right" id="reservation8" value="<%=rs3("plan8Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>�׶�9���Զ�������</td>
			<td>
			<textarea  name="plan9Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan9Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan9Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan9Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan9Date" class="form-control pull-right" id="reservation9" value="<%=rs3("plan9Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>�׶�10����������</td>
			<td>
			<textarea  name="plan10Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan10Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan10Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan10Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan10Date" class="form-control pull-right" id="reservation10" value="<%=rs3("plan10Date") %>">
			</div>
			</td>
			</tr>		
			</table>
			</div>
		</div> 
					
			
		<h3 class="box-title">�����������༰���Ա�׼</h3>

		<div class="row">
			<div class="col-md-4">
				<h4>3.1 �ӿڲ��Խ׶�</h4>
				<textarea  name="planInterface" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planInterface") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.2 ���ܲ��Խ׶�</h4>
				<textarea  name="planFunc" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planFunc") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.3 ϵͳ���Խ׶�</h4>
				<textarea  name="planSystem" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planSystem") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.4 ���ܲ��Խ׶�</h4>
				<textarea  name="planPerformance" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planPerformance") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.5 ���ݲ��Խ׶�</h4>
				<textarea  name="planCompatible" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planCompatible") %></textarea>		
			</div>
			<div class="col-md-4">
				<h4>3.6 �Զ�������</h4>
				<textarea  name="planAuto" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planAuto") %></textarea>		
			</div>
		</div>
	
			
		<h3 class="box-title">�ġ����Է���</h3>

		<div class="row">
			<div class="col-md-4">
				<h4>4.1 ȱ�����ȼ�</h4>
				<textarea  name="planDefect" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planDefect") %></textarea>		
			</div>
			<div class="col-md-4">			
				<h4>4.2 ���Է���������</h4>
				<textarea  name="planWay" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planWay") %></textarea>					
			</div>
			<div class="col-md-4">
				<h4>4.3 ����Լ������</h4>
				<textarea  name="planLimit" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planLimit") %></textarea>					
			</div>
		</div> 
	
		<h3 class="box-title">�塢���չ���</h3>

		<div class="row">
			<div class="col-md-12">			
				<textarea  name="planRisk" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planRisk") %></textarea>
			</div> 						
		</div>				
						
		<input name="pjtId" type="hidden" value="<%=pjtId%>" />
		<input name="platformId" type="hidden" value="<%=platformId%>" />
		<input name="planCreatedDate" type="hidden" value="<%=now%>" />											
				
		<div class="row">
			<div class="col-md-12">		
				<br>  
				<hr>
				<div align="center"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;����</button></div>
			</div>
		</div>
			
		</form>

		<div class="row">
			<div class="col-md-12" align="right">	
				
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>	
				<a id='DD'></a>		
			</div>
		</div>

</div>
</div>	







<script src="731/dist/js/plugins/pace.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>
<script>
$(function () {
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
