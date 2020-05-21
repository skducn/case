<!--#include file="admframe.asp"-->

<title>case | ���Լƻ��б�</title>
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<% 
pjtId = request("pjtId")
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

%>


<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title">�ƻ�����</h1>
			<p class="text-muted m-0 desc">Project management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-12">
				<div class="card mb-4">
					<div class="card-header"><%=pjtName%> - <%=platformName%></div>
					<div class="card-body">	
						<div class="row">	
							<div class="col-md-12">	

								<!-- һ������ -->	
								<h3 class="box-title">һ������</h3>
				
								<div class="form-group">
									<label><h4><b>1.1 Ŀ��</b></h4></label>
									<br><%=rs3("planGoal")%>
								</div>
								<div class="form-group">
									<label><h4><b>1.2 ����</b></h4></label>
									<br><%=rs3("planScene")%>					
								</div>
								<div class="form-group">
									<label><h4><b>1.3 ������ο�</b></h4></label>
									<br><%=rs3("planInfo")%>						
								</div>	
						
		
	  
       							<hr>
	   
								<!-- ����Լ�� -->
			
								<h3 class="box-title">����Լ��</h3>															

								<div class="form-group">
									<label><h4><b>2.1 ����Ŀ��������</b></h4></label><br>
									<%response.write rs3("planTask")%>
								</div>
								<div class="form-group">
									<label><h4><b>2.2 ��Ա���豸</b></h4></label>
									<br><%response.write rs3("planSource")%>	
								</div>
								<div class="form-group">
									<label><h4><b>2.3 ���������롢�����</b></h4></label>
									<br><%response.write rs3("planInOut")%>				
								</div>
						
				
								<div class="form-group">
								<label><h4><b>2.4 ���Խ���</b></h4></label>
								<table class="table table-bordered">
									<tr>               
										<th style="width: 20%">���Խ׶�</th>
										<th style="width: 40%">��������</th>
										<th style="width: 15%">������/��Ա</th>
										<th style="width: 25%">��ֹʱ��</th>
									</tr>
									
									<tr>
									<td>�׶�1�������������Ʒ�����ĵ���</td>
									<td><%=rs3("plan1Task")%></td>
									<td><%=rs3("plan1Work")%></td>
									<td><%=rs3("plan1Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�2����Ʊ�д����</td>
									<td><%=rs3("plan2Task")%></td>
									<td><%=rs3("plan2Work")%></td>
									<td><%=rs3("plan2Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�3���ӿڲ���</td>
									<td><%response.write rs3("plan3Task")%></td>
									<td><%response.write rs3("plan3Work")%></td>
									<td><%response.write rs3("plan3Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�4�����ܲ���</td>
									<td><%response.write rs3("plan4Task")%></td>
									<td><%response.write rs3("plan4Work")%></td>
									<td><%response.write rs3("plan4Date")%></td>
									</tr>
					
									<tr>
									<td>�׶�5��ϵͳ���ɲ���</td>
									<td><%response.write rs3("plan5Task")%></td>
									<td><%response.write rs3("plan5Work")%></td>
									<td><%response.write rs3("plan5Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�6�����ܲ���</td>
									<td><%response.write rs3("plan6Task")%></td>
									<td><%response.write rs3("plan6Work")%></td>
									<td><%response.write rs3("plan6Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�7�������Բ���</td>
									<td><%response.write rs3("plan7Task")%></td>
									<td><%response.write rs3("plan7Work")%></td>
									<td><%response.write rs3("plan7Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�8���ع����</td>
									<td><%response.write rs3("plan8Task")%></td>
									<td><%response.write rs3("plan8Work")%></td>
									<td><%response.write rs3("plan8Date")%></td>
									</tr>
					
									<tr>
									<td>�׶�9���Զ�������</td>
									<td><%response.write rs3("plan9Task")%></td>
									<td><%response.write rs3("plan9Work")%></td>
									<td><%response.write rs3("plan9Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�10����������</td>
									<td><%response.write rs3("plan10Task")%></td>
									<td><%response.write rs3("plan10Work")%></td>
									<td><%response.write rs3("plan10Date")%></td>
									</tr>
													
									</table>
									</div>
								
			 						<hr>				
	
									<!-- �����������༰���Ա�׼ -->
					
									<h3 class="box-title">�����������༰���Ա�׼</h3>
						
							
									<div class="col-md-12">
										<div class="form-group">
											<label><h4><b>3.1 �ӿڲ��Խ׶�</b></h4></label>
											<br><%=rs3("planInterface")%>
										</div>
										
										<div class="form-group">
											<label><h4><b>3.2 ���ܲ��Խ׶�</b></h4></label>
											<br><%=rs3("planFunc")%>									
										</div>
										
										<div class="form-group">
											<label><h4><b>3.3 ϵͳ���Խ׶�</b></h4></label>
											<br><%=rs3("planSystem")%>
										</div>
										
										<div class="form-group">
											<label><h4><b>3.4 ���ܲ��Խ׶�</b></h4></label>
											<br><%=rs3("planPerformance")%>
										</div>	
										
										<div class="form-group">
											<label><h4><b>3.5 ���ݲ��Խ׶�</b></h4></label>
											<br><%=rs3("planCompatible")%>
										</div>	
									
										<div class="form-group">
											<label><h4><b>3.6 �Զ�������</b></h4></label>
											<br><%=rs3("planAuto")%>
										</div>									
									</div>
									
								 	<hr>
	
									<h3 class="box-title">�ġ����Է���</h3>
		
									<div class="col-md-12">
										<div class="form-group">				
										<label><h4><b>4.1 ȱ�����ȼ�</b></h3></label>
											<br><%=rs3("planDefect")%>
									
										</div>				
									</div>  <!-- /.col -->
									
									<div class="col-md-12">
										<div class="form-group">				
										<label><h4><b>4.2 ���Է���������</b></h4></label>
											<br><%=rs3("planWay")%>
									
										</div>				
									</div>  <!-- /.col -->
									
									<div class="col-md-12">
										<div class="form-group">				
										<label><h4><b>4.3 ����Լ������</b></h4></label>
											<br><%=rs3("planLimit")%>
									
										</div>				
									</div>  <!-- /.col -->
						
	  			 					<hr>

									<h3 class="box-title">�塢���չ���</h3>
					  
									<div class="col-md-12">
										<div class="form-group">				
											<%=rs3("planRisk")%>
										</div>				
									</div>  <!-- /.col -->
							</div>
						</div><!-- /.row -->					
					</div>
				</div>	 
			</div> <!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.content -->
</div>
</form>


</body>
</html>
