<!--#include file="frame.asp"-->

<title><%=cstNewPlan%> | <%=cstCompany%></title>

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
	rs("planAuthor") = session("userName")
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
	response.Redirect("sltTestPlanDone-"&pjtId&"-"&platformId&".html")
end if 





pjtId = request("pjtId")
platformId = request("platformId")
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
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
%>


<div class="content-wrapper">
<div class="page-title">
<div><h1><i class="fa fa-edit"></i> �ƻ����� - �½��ƻ�</h1><p>Testplan panel</p></div>
<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">�ƻ�����</a></li></ul></div>
</div>
<div class="card">	
<div class="row">
<div class="col-md-12">
<div class="nav-tabs-custom">	

			<form role="form" action="sltPlanAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >																
	<div class="row">
		<div class="col-md-8" align="left">
			<h3> <%=pjtName%> - <%=platformName%></h3>
		</div>
		
		<!--  ����ƻ�ģ�� -->			
		<div class="col-md-2"  align="center">				
			 <% set rs66 = server.createobject("adodb.recordset")
			rs66.open "select * from tbl_plan where planAuthor='"&session("userName")&"' and plan_pjtId="&pjtId&" order by planId desc ",conn,3,3 %>
			<select name="testplan" id="caseErrorType" class="form-control select2" onChange="window.location=this.value;">
			<option value="sltPlanAdd-<%=request("pjtId")%>-<%=request("platformId")%>-0.html" >��ѡ����ģ��</option>				
			<% do while not rs66.eof
				  set rs67 = server.createobject("adodb.recordset")
				  rs67.open "select * from tbl_project where pjtId="&rs66("plan_pjtId")&"  order by pjtId desc ",conn,3,3 
				  set rs68 = server.createobject("adodb.recordset")
				  rs68.open "select * from tbl_platform where plat_pjtId="&rs66("plan_pjtId")&" and platformId="&rs66("plan_platformId")&" order by platformId desc ",conn,3,3 
				  if rs67("pjtStatus") = "1" then %>
					<option value="sltPlanAdd-<%=request("pjtId")%>-<%=request("platformId")%>-<%=rs66("planId")%>.html"><%=rs67("pjtName")%>-<%=rs68("platformName")%> </option>	
				<% end if 
				rs68.close
				rs67.close
				rs66.movenext
			loop
			rs66.close
			%>
			</select>		

		</div>
		<div class="col-md-2" align="right">		
			<button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;�ύ</button>		
			<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>
		</div>
	</div>
	<hr>			

								
	

	<% 
	set rs3 = server.createobject("adodb.recordset")
	rs3.open "select * from tbl_plan where planId="&request("planId")&" order by planId desc",conn,3,3
	'rs3.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
	if request("planId")<>0 and  rs3.recordcount =0 then
		response.Redirect("index.html")
	end if 
	%>
					
	<div class="box-body">								
		<h3 class="box-title">һ������</h3>						
		<div class="row">
			<div class="col-md-4">						
				<h4>1.1 Ŀ��</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planGoal" class="form-control" rows="5" placeholder="������д��Ŀ�ġ�Լ�����ĵ��ı��ŷ�ʽ"><%=rs3("planGoal")%></textarea>					
				<%else%>
					 <textarea  name="planGoal" class="form-control" rows="5" placeholder="������д��Ŀ�ġ�Լ�����ĵ��ı��ŷ�ʽ" ></textarea>	
				<%end if%>	
			</div>
			<div class="col-md-4">						
				<h4>1.2 ����</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planScene" class="form-control" rows="5" placeholder="������Ŀ����"><%=rs3("planScene")%></textarea>					
				<%else%>
					  <textarea  name="planScene" class="form-control" rows="5" placeholder="������Ŀ����"></textarea>	
				<%end if%>	
			</div>
			<div class="col-md-4">						
				<h4>1.3 ������ο�</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planInfo" class="form-control" rows="5" placeholder="����д�ο��������������"><%=rs3("planInfo")%></textarea>					
				<%else%>
					 <textarea  name="planInfo" class="form-control" rows="5" placeholder="����д�ο��������������"></textarea>	
				<%end if%>					
			</div>
		</div>
						
								
		<h3 class="box-title">����Լ��</h3>
		<div class="row">
			<div class="col-md-4">			
				<h4>2.1 ��������</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planTask" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planTask")%></textarea>					
				<%else%>
					 <textarea  name="planTask" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4">						
				<h4>2.2 ��Ա���豸</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planSource" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planSource")%></textarea>					
				<%else%>
					 <textarea  name="planSource" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			
			</div>
			<div class="col-md-4">						
				<h4>2.3 ���������롢�����</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planInOut" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planInOut")%></textarea>					
				<%else%>
					 <textarea  name="planInOut" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
		
			</div>
		
		
			<div class="col-md-12">	<br>						
				<h4>2.4 ���Խ���</h4>
				<table class="table table-bordered"><tr>               
				<th style="width: 20%">���Խ׶�</th>
				<th style="width: 30%">��������</th>
				<th style="width: 30%">������/��Ա</th>
				<th style="width: 20%">��ֹʱ��</th></tr>
				
				<tr>
				<td>�׶�1���������</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan1Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan1Task")%></textarea>					
					<%else%>
						 <textarea  name="plan1Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan1Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan1Work")%></textarea>					
					<%else%>
					 	 <textarea  name="plan1Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">			
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan1Date" class="form-control pull-right" rows="5" id="reservation1" placeholder="������ ..." value="<%=rs3("plan1Date")%>">
						<%else%>
							 <input type="text" name="plan1Date" class="form-control pull-right" rows="5"  id="reservation1" placeholder="������ ...">		
						<%end if%>	
				</div>				
				</td>
				</tr>			

				<tr>			
				<td>�׶�2����Ʊ�д����</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan2Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan2Task")%></textarea>					
					<%else%>
						 <textarea  name="plan2Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan2Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan2Work")%></textarea>					
					<%else%>
						 <textarea  name="plan2Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan2Date" class="form-control pull-right" rows="5" id="reservation2" placeholder="������ ..." value="<%=rs3("plan2Date")%>">
						<%else%>
							 <input type="text" name="plan2Date" class="form-control pull-right" rows="5"  id="reservation2" placeholder="������ ...">		
						<%end if%>
				</div>
				</td>
				</tr>				
				<tr>
				<td>�׶�3���ӿڲ���</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan3Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan3Task")%></textarea>					
					<%else%>
						 <textarea  name="plan3Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan3Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan3Work")%></textarea>					
					<%else%>
						 <textarea  name="plan3Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>			
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan3Date" class="form-control pull-right" rows="5" id="reservation3" placeholder="������ ..." value="<%=rs3("plan3Date")%>">
						<%else%>
							 <input type="text" name="plan3Date" class="form-control pull-right" rows="5"  id="reservation3" placeholder="������ ...">		
						<%end if%>
				</div>			
				</td>
				</tr>
						
				<tr>
				<td>�׶�4�����ܲ���</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan4Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan4Task")%></textarea>					
					<%else%>
						 <textarea  name="plan4Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan4Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan4Work")%></textarea>					
					<%else%>
						 <textarea  name="plan4Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan4Date" class="form-control pull-right" rows="5" id="reservation4" placeholder="������ ..." value="<%=rs3("plan4Date")%>">
						<%else%>
							 <input type="text" name="plan4Date" class="form-control pull-right" rows="5"  id="reservation4" placeholder="������ ...">		
						<%end if%>			
				</div>
				</td>
				</tr>						
				<tr>
				<td>�׶�5��ϵͳ����</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan5Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan5Task")%></textarea>					
					<%else%>
						 <textarea  name="plan5Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan5Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan5Work")%></textarea>					
					<%else%>
						 <textarea  name="plan5Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan5Date" class="form-control pull-right" rows="5" id="reservation5" placeholder="������ ..." value="<%=rs3("plan5Date")%>">
						<%else%>
							 <input type="text" name="plan5Date" class="form-control pull-right" rows="5"  id="reservation5" placeholder="������ ...">		
						<%end if%>
				</div>	
				</td>
				</tr>						
				<tr>
				<td>�׶�6�����ܲ���</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan6Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan6Task")%></textarea>					
					<%else%>
						 <textarea  name="plan6Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan6Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan6Work")%></textarea>					
					<%else%>
						 <textarea  name="plan6Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan6Date" class="form-control pull-right" rows="5" id="reservation6" placeholder="������ ..." value="<%=rs3("plan6Date")%>">
						<%else%>
							 <input type="text" name="plan6Date" class="form-control pull-right" rows="5"  id="reservation6" placeholder="������ ...">		
						<%end if%>
				</div>		
				</td>
				</tr>						
				<tr>
				<td>�׶�7�����ݲ���</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan7Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan7Task")%></textarea>					
					<%else%>
						 <textarea  name="plan7Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan7Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan7Work")%></textarea>					
					<%else%>
						 <textarea  name="plan7Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan7Date" class="form-control pull-right" rows="5" id="reservation7" placeholder="������ ..." value="<%=rs3("plan7Date")%>">
						<%else%>
							 <input type="text" name="plan7Date" class="form-control pull-right" rows="5"  id="reservation7" placeholder="������ ...">		
						<%end if%>		
				</div>
				</td>
				</tr>	
				<tr>
				<td>�׶�8���ع����</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan8Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan8Task")%></textarea>					
					<%else%>
						 <textarea  name="plan8Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan8Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan8Work")%></textarea>					
					<%else%>
						 <textarea  name="plan8Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan8Date" class="form-control pull-right" rows="5" id="reservation8" placeholder="������ ..." value="<%=rs3("plan8Date")%>">
						<%else%>
							 <input type="text" name="plan8Date" class="form-control pull-right" rows="5"  id="reservation8" placeholder="������ ...">		
						<%end if%>			
				</div>
				</td>
				</tr>						
				<tr>
				<td>�׶�9���Զ�������</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan9Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan9Task")%></textarea>					
					<%else%>
						 <textarea  name="plan9Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan9Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan9Work")%></textarea>					
					<%else%>
						 <textarea  name="plan9Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan9Date" class="form-control pull-right" rows="5" id="reservation9" placeholder="������ ..." value="<%=rs3("plan9Date")%>">
						<%else%>
							 <input type="text" name="plan9Date" class="form-control pull-right" rows="5"  id="reservation9" placeholder="������ ...">		
						<%end if%>
				</div>		
				</td>
				</tr>						
				<tr>
				<td>�׶�10����������</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan10Task" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan10Task")%></textarea>					
					<%else%>
						 <textarea  name="plan10Task" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
					<%if request("planId")<>0 then%>
						 <textarea  name="plan10Work" class="form-control" rows="5" placeholder="������ ..."><%=rs3("plan10Work")%></textarea>					
					<%else%>
						 <textarea  name="plan10Work" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</td>
				<td>
				<div class="input-group">
					<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
						<%if request("planId")<>0 then%>
							 <input type="text" name="plan10Date" class="form-control pull-right" rows="5" id="reservation10" placeholder="������ ..." value="<%=rs3("plan10Date")%>">
						<%else%>
							 <input type="text" name="plan10Date" class="form-control pull-right" rows="5"  id="reservation10" placeholder="������ ...">		
						<%end if%>		
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
				<%if request("planId")<>0 then%>
					 <textarea  name="planInterface" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planInterface")%></textarea>					
				<%else%>
					 <textarea  name="planInterface" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4">			
				<h4>3.2 ���ܲ��Խ׶�</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planFunc" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planFunc")%></textarea>					
				<%else%>
					 <textarea  name="planFunc" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4">
				<h4>3.3 ϵͳ���Խ׶�</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planSystem" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planSystem")%></textarea>					
				<%else%>
					 <textarea  name="planSystem" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4"><br>
				<h4>3.4 ���ܲ��Խ׶�</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planPerformance" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planPerformance")%></textarea>					
				<%else%>
					 <textarea  name="planPerformance" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4"><br>
				<h4>3.5 ���ݲ��Խ׶�</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planCompatible" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planCompatible")%></textarea>					
				<%else%>
					 <textarea  name="planCompatible" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
				<div class="col-md-4"><br>
				<h4>3.6 �Զ�������</h4>
					<%if request("planId")<>0 then%>
						 <textarea  name="planAuto" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planAuto")%></textarea>					
					<%else%>
					 	 <textarea  name="planAuto" class="form-control" rows="5" placeholder="������ ..."></textarea>		
					<%end if%>
				</div>
			</div>
	
			
		<h3 class="box-title">�ġ����Է���</h3>

		<div class="row">
			<div class="col-md-4">
				<h4>4.1 ȱ�����ȼ�</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planDefect" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planDefect")%></textarea>					
				<%else%>
					 <textarea  name="planDefect" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4">
				<h4>4.2 ���Է���/����</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planWay" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planWay")%></textarea>					
				<%else%>
					 <textarea  name="planWay" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
			<div class="col-md-4">
				<h4>4.3 ����Լ������</h4>
				<%if request("planId")<>0 then%>
					 <textarea  name="planLimit" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planLimit")%></textarea>					
				<%else%>
					 <textarea  name="planLimit" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>
			</div>
		</div> 
		
		<h3 class="box-title">�塢���չ���</h3>
	
		<div class="row">
			<div class="col-md-12">		
				<%if request("planId")<>0 then%>
					 <textarea  name="planRisk" class="form-control" rows="5" placeholder="������ ..."><%=rs3("planRisk")%></textarea>					
				<%else%>
					 <textarea  name="planRisk" class="form-control" rows="5" placeholder="������ ..."></textarea>		
				<%end if%>	
			</div> 						
		</div>
						
		<input name="pjtId" type="hidden" value="<%=pjtId%>" />
		<input name="platformId" type="hidden" value="<%=platformId%>" />
		<input name="planCreatedDate" type="hidden" value="<%=now%>" />						
					
					
		<div class="col-md-12">		
			<br>  
			<hr>
			<div align="center"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;�ύ</button></div>

		</div>
		
		</form>
		
			
		
</div>
</div>
</div>
</div>
		<div class="row">
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
<script src="/plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="/bootstrap/js/bootstrap.min.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>
<script>
$(function () {
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
