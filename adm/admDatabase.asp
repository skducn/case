<!--#include file="admFrame.asp"-->

<title><%=cstCompany%> | ��Ŀ����Ϣ</title>


<div class="content-wrapper">
	<section class="content-header">
	<h1>
	��Ŀ����Ϣ
	<small>Project Table Info</small>
	</h1>
	<ol class="breadcrumb">
	<li><a href="admMain.html"><i class="fa fa-align-justify"></i> Home</a></li>
	</ol>
	</section>


<% 
pjtDBDatabase =  request("pjtDBDatabase")
pjtId = request("pjtId")

if pjtDBDatabase = "" then
	response.Write("<script>;alert('��̨û���ṩ����Ϣ������ϵ����Ա!');</script>")
	response.end 
end if 

set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtDBDatabase='"&pjtDBDatabase&"' and pjtId="&pjtId&" order by pjtId desc ",conn,3,3 
pjtDBServer = rs("pjtDBServer")
pjtDBUser = rs("pjtDBUser")
pjtDBPassword = rs("pjtDBPassword")
pjtName = rs("pjtName")
rs.close
set rs = nothing 


' ODBC ���ӷ�ʽ https://www.connectionstrings.com/mysql-connector-odbc-5-2/
dim con,constr,rs
set con = Server.CreateObject("ADODB.Connection") 
'constr = "Provider=MSDASQL;Driver={MySQL ODBC 5.3 UNICODE Driver};Server=192.168.31.177;Database=learn;User=root;Password=Jinhao2019!;Option=3;"
'constr = "Provider=SQLOLEDB.1;Server="& pjtDBServer & ";UID=" & pjtDBUser & ";PWD=" & pjtDBPassword & ";Database=" & pjtDBDatabase
'constr = "Provider=MSDASQL;Driver={MySQL ODBC 5.3 ANSI Driver};Server="+pjtDBServer+";Database="+pjtDBDatabase+";User="+pjtDBUser+";Password="+pjtDBPassword+";Option=3;"
'constr = "Driver={MySQL ODBC 5.3 ANSI Driver};Server="+pjtDBServer+";Database="+pjtDBDatabase+";User="+pjtDBUser+";Password="+pjtDBPassword+";Option=3;"
con.Open "DRIVER={MySQL ODBC 5.3 Driver};SERVER=192.168.31.177;PORT=3306;DATABASE=learn;USER=root;PASSWORD=Jinhao2019!;"
'con.open constr
%>


<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-info box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title"><%=pjtName%></h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
							
<!-- ��ʾ��ṹ -->

<%
if request("action") = "column" then
	recordSum = request("recordSum")
	tablename =request("tablename")
	no = request("no")
	set rs1 = Server.CreateObject("ADODB.recordset") 
	rs1.open "select column_name,column_type,column_comment from information_schema.`COLUMNS` where table_schema='"&pjtDBDatabase&"' and table_name='"&tablename&"'",con,3,3 
	%>
	
	
	<div class="row">
		<div class="col-xs-12">
			<%if request("recordSum") = 0 then%>
			<font color=green>�޼�¼<br /><br /></font>
			<%else%> 
			<a href="admDatebaseRecord-<%=pjtId%>-<%=pjtDBDatabase%>-<%=request("tablename")%>-<%=recordSum%>.html"> <button type="button" class="btn btn-info pull-left"  href="#"> �鿴��¼��<%=recordSum%>����</button></a>
			<%end if%>
		</div>
	</div>
	<br>
	
	<div class="col-xs-12">
		<label><%=no%> , <%=tablename%> ��ṹ</label>
	</div>
	
	<!-- ��ṹ���� -->
	<table id="example2" class="table table-bordered table-hover">
		<thead>
		<tr>
		<th>�ֶ�</th>
		<th>����</th>
		<th>�ֶ�˵��</th>
		</tr>
		</thead>
		<tbody>	
	<%do while not rs1.eof 
		response.write "<tr>"
		response.write "<td><font color=red>" +  rs1(0) +  "</font></td>"
		response.write "<td><font color=blue>" +  rs1(1) + "</font></td>"
		response.write  "<td>" + rs1(2) +  "</td>"
		response.write "</tr>"
	rs1.movenext
	loop 
	rs1.close
	set rs1 = nothing %>
	</tbody>
	<tfoot>
	</tfoot>
	</table>	
	<br><br>
<% 
end if 
%>



				
<!-- ��ʾ��¼ -->

<%
if request("action") = "record" then
	tablename = request("tablename")
	set rs7 = Server.CreateObject("ADODB.recordset")
	rs7.open "select column_name from information_schema.`COLUMNS` where table_schema='"&pjtDBDatabase&"' and table_name='"&tablename&"'",con,3,3 %>
	
	<!-- ��ṹ���� -->
	<table width="96%" align="center" ><tr><td><label><%=tablename%>��¼�б�</label></td></tr></table>
	
	<%
	response.write "<table width='96%' border='1' align='center' >"
	response.write "<tr bgcolor='#98FB98'>"
	do while not rs7.eof 	
		response.write "<td>" + rs7(0) + "</td>"
	rs7.movenext
	loop
	response.write "</tr>"
	' ��ȡ�����ֶθ���
	set rs = Server.CreateObject("ADODB.recordset") 
	rs.open "select count(*) from information_schema.`COLUMNS` where table_schema='"&pjtDBDatabase&"' and table_name='"&tablename&"'",con,3,3
	fieldSum =  rs(0)

	' ������¼
	set rs1 = Server.CreateObject("ADODB.recordset") 
	rs1.open "select * from "&tablename&"",con,3,3 
	do while not rs1.eof
		response.write "<tr>"
		for i=0 to cint(fieldSum)-1 
			response.write "<td>"
			if isnull(rs1(i)) then   '����ֶ���ֵ��null ����ʾnull
			   response.write "null"  
			else
			   response.write cstr(rs1(i)) 
			end if
			response.write "</td>"
		Next
		response.write "</tr>"
	rs1.movenext
	loop
	response.write "</table>"
	rs1.close
	set rs1 = nothing 
end if 
%>
<br>

<!-- ��ȡ���еı� -->

<%
set rs1 = Server.CreateObject("ADODB.recordset")
rs1.open "SELECT COUNT(*) TABLES, table_schema FROM information_schema.TABLES  WHERE table_schema = '"&pjtDBDatabase&"' GROUP BY table_schema",con,3,3 
set rs2 = Server.CreateObject("ADODB.recordset") 
rs2.open "select table_name,table_comment,table_rows from information_schema.`TABLES` where table_schema='"&pjtDBDatabase&"' order by table_rows desc",con,3,3 
varSequence = 1 %>
<label><%response.write "������IP��" + pjtDBServer + " &nbsp; ,&nbsp; ���ݿ⣺" + pjtDBDatabase +" &nbsp; ,&nbsp;  ���� " + cstr(rs1(0))  + " �ű� " %></label>
			<table id="example2" class="table table-bordered table-hover">
			<thead>
			<tr>
			<th>���</th>
			<th>�������鿴��ṹ��</th>
			<th>����Ϣ</th>
			<th>���������鿴�����ݣ�</th>
			</tr>
			</thead>
			<tbody>	
		<% do while not rs2.eof 
			response.write "<tr><td>" + cstr(varSequence) + "</td>" 
			response.write "<td>" 
			
			' �������鿴��ṹ��
			if isnull(rs2(2)) then %>
				<a href="admDatebaseColumn-<%=pjtId%>-<%=pjtDBDatabase%>-<%=rs2(0)%>-0-<%=cstr(varSequence)%>.html"> <% response.write rs2(0) + "null " %> </a>
			<%else%>
				<a href="admDatabaseColumn-<%=pjtId%>-<%=pjtDBDatabase%>-<%=rs2(0)%>-<%=rs2(2)%>-<%=cstr(varSequence)%>.html"> <% response.write rs2(0)  %> </a>
			<% end if 
			response.write "</td><td>"
			
			' ����Ϣ˵��
			if isnull(rs2(2)) then %>
				<a href="admDatabaseColumn-<%=pjtId%>-<%=pjtDBDatabase%>-<%=rs2(0)%>-0-<%=cstr(varSequence)%>.html"> <% response.write rs2(1) + "null " %> </a>
			<%else%>
				<a href="admDatabaseColumn-<%=pjtId%>-<%=pjtDBDatabase%>-<%=rs2(0)%>-<%=rs2(2)%>-<%=cstr(varSequence)%>.html"> <% response.write rs2(1)  %> </a>
			<% end if 
			response.write "</td><td>"
			
			'��¼�����鿴��¼��ϸ��
			if isnull(rs2(2)) then
				response.write "null <br>" 
			else
				 response.write  cstr(rs2(2)) + "<br>" 
			end if
			response.write "</td></tr>"
			
			varSequence = varSequence + 1
		rs2.movenext
		loop
	
	rs2.close   
	set rs2 = nothing 
	set con2 = nothing 
	
	%>
			
			</tbody>
			<tfoot>
			</tfoot>
			</table>		
	
				
				</div>
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
</section><!-- /.content -->


</div>
<!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="../plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="../plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="../plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="../plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>



<script>
  $(function () {
    $("#example1").DataTable();
    $('#example2').DataTable({
      "paging": true,
      "lengthChange": false,
      "searching": false,
      "ordering": true,
      "info": true,
      "autoWidth": false
    });
  });
</script>
</body>
</html>


