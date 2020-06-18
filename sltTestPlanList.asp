<!--#include file="frame.asp"-->

<title>���Լƻ��б� | <%=cstCompany%></title>
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<% 
set rs5 = server.createobject("adodb.recordset")
rs5.open "select * from tbl_plan where planId="&request("planId")&"",conn,3,3
if rs5.recordcount =0 then
	response.Redirect("index.html")
else
	pjtId = rs5("plan_pjtId")
	platformId = rs5("plan_platformId")
end if 

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
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> �ƻ����� - �ƻ��б�</h1><p>Testplan List</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">�ƻ�����</a></li></ul></div>
	</div>
	
	<div class="card">				
		<div class="row">
			<div class="col-md-6" align="left">
				<h3 class="box-title"><%=pjtName%> - <%=platformName%></h3>						
			</div>				
			<div class="col-md-6" align="right">
			<%if rs3("planAuthor") = session("userName") then%>
				<a class='btn btn-warning' href='sltPlanEdit-<%=rs3("plan_pjtId")%>-<%=rs3("plan_platformId")%>.html' data-toggle="tooltip" data-original-title="�༭"><i class='fa fa-edit'></i></a>		
			<%end if %>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-down"></i></a>		
			</div>	
		</div>

		<hr>

		<div class="row">
			<div class="col-md-12">
				<div class="box-body">	
						
						<!-- һ������  -->		
							
						<h3 class="box-title">һ������</h3>	
						<div class="row">
							<div class="col-md-4">							
								<h4>1.1 Ŀ��</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planGoal")%></textarea></td></tr>
								</table>																	
							</div>
							
							<div class="col-md-4">							
								<h4>1.2 ����</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planScene")%></textarea></td></tr>
								</table>																	
							</div>
							
								<div class="col-md-4">							
								<h4>1.3 ������ο�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planInfo")%></textarea></td></tr>
								</table>																	
							</div>
						</div>
						<!-- һ������ over -->		
			       
	   
						<!-- ����Լ�� -->
				
						<h3 class="box-title">����Լ��</h3>		
						<div class="row">
							<div class="col-md-4">							
								<h4>2.1 ��������</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planTask")%></textarea></td></tr>
								</table>																	
							</div>
							
							<div class="col-md-4">
								<h4>2.2 ��Ա���豸</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planSource")%></textarea></td></tr>					
								</table>							
							</div>
							
							<div class="col-md-4">
								<h4>2.3 ���������롢�����</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planInOut")%></textarea></td></tr>					
								</table>
							</div>
							
							<div class="col-md-12">
								<div class="form-group">
									<h4>2.4 ���Խ���</h4>
									<table class="table table-bordered">
									<tr>               
										<th style="width: 20%" bgcolor="f1f1f1">���Խ׶�</th>
										<th style="width: 30%" bgcolor="f1f1f1">��������</th>
										<th style="width: 30%" bgcolor="f1f1f1">������/��Ա</th>
										<th style="width: 20%" bgcolor="f1f1f1">��ֹʱ��</th>
									</tr>					
									<tr>
									<td>�׶�1���������</td>
									<td><%=replace(rs3("plan1Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan1Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan1Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�2����Ʊ�д����</td>
									<td><%=replace(rs3("plan2Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan2Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan2Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�3���ӿڲ���</td>
									<td><%=replace(rs3("plan3Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan3Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan3Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�4�����ܲ���</td>
									<td><%=replace(rs3("plan4Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan4Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan4Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�5��ϵͳ���ɲ���</td>
									<td><%=replace(rs3("plan5Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan5Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan5Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�6�����ܲ���</td>
									<td><%=replace(rs3("plan6Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan6Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan6Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�7�������Բ���</td>
									<td><%=replace(rs3("plan7Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan7Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan7Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�8���ع����</td>
									<td><%=replace(rs3("plan8Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan8Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan8Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�9���Զ�������</td>
									<td><%=replace(rs3("plan9Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan9Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan9Date")%></td>
									</tr>
									
									<tr>
									<td>�׶�10����������</td>
									<td><%=replace(rs3("plan10Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan10Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan10Date")%></td>
									</tr>
													
									</table>
								</div>							
							</div> <!-- .col --> 	
						</div>  <!-- .row -->    
	
						<!-- ����Լ�� -->

	
						<!-- �����������༰���Ա�׼ -->
			
						<h3 class="box-title">�����������༰���Ա�׼</h3>
						
						<div class="row">
							<div class="col-md-4">							
								<h4>3.1 �ӿڲ��Խ׶�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planInterface")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>3.2 ���ܲ��Խ׶�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planFunc")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>3.3 ϵͳ���Խ׶�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planSystem")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>3.4 ���ܲ��Խ׶�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planPerformance")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>3.5 ���ݲ��Խ׶�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planCompatible")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>3.6 �Զ�������</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planAuto")%></textarea></td></tr>
								</table>																	
							</div>
						</div>
			
						<!-- �����������༰���Ա�׼ over -->	
	
	
						<h3 class="box-title">�ġ����Է���</h3>
				
						<div class="row">
							<div class="col-md-4">							
								<h4>4.1 ȱ�����ȼ�</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planDefect")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>4.2 ���Է���������</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planWay")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4>4.3 ����Լ������</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planLimit")%></textarea></td></tr>
								</table>																	
							</div>			
						</div><!-- /.row -->
		  
	
	
			<h3 class="box-title">�塢���չ���</h3>
		
			<div class="row">
				<div class="col-md-12">
					<table class="table table-bordered">												
					<tr><td><textarea class="form-control" rows="5" placeholder="��" disabled="disabled"><%=rs3("planRisk")%></textarea></td></tr>
					</table>		
				</div>  <!-- /.col -->
			</div><!-- /.row -->
			
			<div class="row">
			<div class="col-md-12" align="right">	
			<hr>
			<%if rs3("planAuthor") = session("userName") then%>
				<a class='btn btn-warning' href='sltPlanEdit-<%=rs3("plan_pjtId")%>-<%=rs3("plan_platformId")%>.html' data-toggle="tooltip" data-original-title="�༭"><i class='fa fa-edit'></i></a>		
			<%end if %>	
			<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>	
			<a id='DD'></a>		
			</div>
			</div>
			<%rs3.close%>

</div>
</div>
</div>
</div>  
</div>
</div>
</div>



<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>


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
