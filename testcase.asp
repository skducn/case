<!--#include file="touristframe.asp"-->

<title><%=cstCompany%> | �鿴�༭����</title>
<link href="bootstrap/css/custom.css" rel="stylesheet">


<div class="content-wrapper">

    <section class="content-header">
      <h1>
        �鿴����
		<small> 
			  <!-- ��ʾ��Ŀ�� - ƽ̨�� -->
			  <% Set rs4 = Server.CreateObject("Adodb.Recordset")
				 rs4.Open "select * from tbl_project where pjtId="&request("pjtId")&" ",conn,3,3
			     Set rs5 = Server.CreateObject("Adodb.Recordset")
  				 rs5.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&" ",conn,3,3
				 Set rs6 = Server.CreateObject("Adodb.Recordset")
 				 rs6.Open "select * from tbl_case where case_pjtId="&request("pjtId")&" and case_platformId="&request("platformId")&"  ",conn,3,3%>
          		<%=rs4("pjtName")%> - <%=rs5("platformName")%> <span class="label label-warning"><%=rs6.recordcount%></span>
				<%
				rs6.close
				rs5.close
				rs4.close%>
			</small>  
      </h1>
      <ol class="breadcrumb">
        <li><i class="fa fa-align-justify"></i> Home</li>
      </ol>
    </section>

<!-- Main content -->
<section class="content">
<div class="row">
    <div class="col-md-12">
          <!-- Custom Tabs (Pulled to the right) -->
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs pull-right">
			
			<!-- ������ǩ����Ĭ��active��һ����ǩ -->
			  <%
			  pjtId = request("pjtId")
			  platformId = request("platformId")
			  lblId = request("lblId")
			  counts = 0
			  Set rs3 = Server.CreateObject("Adodb.Recordset")
			  rs3.Open "select * from tbl_label where lbl_pjtId="&request("pjtId")&" and lbl_platformId="&request("platformId")&" order by lblId asc",conn,3,3
			  varLebelTotal = rs3.recordcount
			  reDim lblId_array(varLebelTotal)  
				
			  ' �����ǩ
			  if varLebelTotal > 1 then  
				do while not rs3.eof 		
					lblId_array(counts) = rs3("lblId")
					' rs66.recordcount ��ȡ��ǰ��ǩ ��ǰ�����µ���������
					set rs66 = server.createobject("adodb.recordset")
					rs66.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(counts)&"  order by caseId desc",conn,3,3
					
					if rs3("lblId") = int(lblId) then  %>
						<li class="active"><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs3("lblName")%>
						<% if rs66.recordcount >0 then %>
						<span class="label label-warning"><%=rs66.recordcount%></span>
						<%end if %>
						</a></li>
					<%else%>
						<li><a href="#tab_1-<%=counts%>" data-toggle="tab"><%=rs3("lblName")%>
						<% if rs66.recordcount >0 then %>
						<span class="label label-warning"><%=rs66.recordcount%></span>
						<%end if %></a></li>
					<%end if 
					counts = counts + 1 
				rs3.movenext
				loop  
			  '1����ǩ	 
			  elseif varLebelTotal = 1 then
			     set rs77 = server.createobject("adodb.recordset")
				 rs77.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId&" order by caseId desc",conn,3,3
			  		lblId_array(counts) = rs3("lblId") %> 
				   <li class="active"><a href="#tab_1-1" data-toggle="tab"><%=rs3("lblName")%>
					<% if rs77.recordcount >0 then %>
					<span class="label label-warning"><%=rs77.recordcount%></span>
					<%end if %></a></li>
				   <%rs77.close%>
			 <%else
			     response.write "no label"
			  end if  %>
             
           
			 
            </ul>
			
			
     <div class="tab-content">
	
	
<% 
varcount = 0
do while varcount < varLebelTotal 
	if lblId_array(varcount) = int(lblId) then %>
		<div class="tab-pane active" id="tab_1-<%=varcount%>">
	<%else%>
		<div class="tab-pane" id="tab_1-<%=varcount%>">
	<%end if %>
	
			  
	<!-- �鿴�����������ٻ�ɫ�ָ��� -->
	<div class="box box-warning">
		<div class="box-header with-border">
			<div class="row">
				<div class="col-lg-2" >
					<h3 class="box-title"  style="white-space: nowrap;">
					<% if request("caseStage") = 1 then
						response.write "<i class='fa fa-fire'></i>&nbsp;ð�̲��� "
					elseif request("caseStage") = 2 then
						response.write "<i class='fa fa-ellipsis-h'></i>&nbsp;��ʽ����"
					else
						response.write ("<i class='fa fa-chrome'></i>&nbsp;�ع����")
					end if  
					%>
					</h3>
				</div>
			
				<div class="col-lg-10">
				<!-- �л����� -->
				
					<a class="dropdown-toggle" data-toggle="dropdown" href="#" nowrap="nowrap">
					�л����� <span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
					<li role="presentation"><a role="menuitem" tabindex="-1" href="testcase-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-1.html">ð�̲���</a></li>
					<li role="presentation"><a role="menuitem" tabindex="-1" href="testcase-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-2.html">��ʽ����</a></li>
					<li role="presentation"><a role="menuitem" tabindex="-1" href="testcase-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-3.html">�ع����</a></li>
					</ul>
				
				</div>
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
		
		<br />
		<% 
		set rs6 = server.createobject("adodb.recordset")
		rs6.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(varcount)&"  order by caseId desc",conn,3,3
		if not rs6.eof then 					
			do while not rs6.eof%>
				<div class="layout clear">
					<dl class="demo-methods">
					<dt1> 
					<span class="code"><span class="self">չ��</span>&nbsp;</span>	
					<%=rs6("caseId")%> , &nbsp;<%=rs6("caseTitle")%>
				
					</dt1><dd><pre class="markup"><%=rs6("caseStep")%></pre></dd>
					</dl>
				</div>
			<%rs6.movenext
			loop
		end if 
		rs6.close
		set rs6 = nothing%>
	
		</div><!-- .box-body -->
</div>
</div>  
<% 
varcount = varcount + 1
loop
%> 
</div>
</div>
</div>
</div>
</section>
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
<!-- ��� չ�� ������� Bootstrap 3.3.5���� -->
<script src="bootstrap/js/jquery.js"></script>  
<script src="bootstrap/js/custom.js?v=0.9.1"></script>
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

</body>
</html>
