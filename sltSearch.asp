<!--#include file="frame.asp"-->

<title>�������� | <%=cstCompany%> </title>
<link href="bootstrap/css/custom.css" rel="stylesheet">

<% if request("action") = "save" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
	rs("userMemo") = request("userMemo")
	rs.update
	rs.close
	set rs = nothing
end if %>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-search"></i> ��������</h1><p>search testcase</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">��������</a></li></ul></div>
	</div>
	
	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">	
	
	<%if request("action")="search" then
		searchName=request("searchName")
		s_namex=LCase(searchName) '''����д��ĸת����Сд��ĸ
		s_named=UCase(s_namex)
		s_named=replace(s_named,"'","��")    'asp��access�в�֧��'��[ ����
		s_named=replace(s_named,"[","��")    'asp��access�в�֧��'��[ ����	
		if searchName = "" then	   
			response.Redirect("main.html")
		end if 
	
		'��������ID  ������������ǰ�˺ŵ�caseID��
		if IsNumeric (searchName) then
			varScene = "digit"
			set rs = server.createobject("adodb.recordset")
			rs.open "select * from tbl_case where caseId="&searchName&" and caseCreateUser='"&session("userName")&"' ",conn,3,3
			if not rs.eof then
				pjtId = rs("case_pjtId")
				platformId = rs("case_platformId")
				lblId = rs("case_lblId")
				caseId = rs("caseId")
				caseTitle = rs("caseTitle")
				caseStep = rs("caseStep")
				set rs1 = server.createobject("adodb.recordset")
				rs1.open "select * from tbl_project where pjtId ="&pjtId&" order by pjtId desc",conn,3,3
				set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_platform where platformId ="&platformId&" order by platformId desc",conn,3,3
				set rs3 = server.createobject("adodb.recordset")
				rs3.open "select * from tbl_label where lblId ="&lblId&" order by lblId desc",conn,3,3
				set rs4 = server.createobject("adodb.recordset")  
				rs4.open "select * from tbl_user where userName ='"&rs("caseCreateUser")&"'",conn,3,3
				%>
				<div class="row">
					<div class="col-xs-12">
					  <div class="box">
						<div class="box-header">
						  <h3 class="box-title">����ID��<%=caseId%></h3>
						</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-hover">
								<thead>
								<tr>
								<th width="25%" style="white-space: nowrap;">��Ŀ - �汾 - ��ǩ</th>
								<th>��������</th>
								</tr>
								</thead>
								<tbody>
								<tr>
								<td><% =rs1("pjtName")%> - <% =rs2("platformName")%>-<% =rs3("lblName")%></td>
								<td>
									<dl class="demo-methods"><dt1>
									<span class="code"><span class="self STYLE2">չ��</span>&nbsp;</span><%=caseId%> , 
									<%=caseTitle%>&nbsp;
									<a href="sltTestcaseEdit-<%=caseId%>.html" target="_blank"><i class="fa fa-wrench "></i>���</a>&nbsp;&nbsp;
									<a href="excTestcaseEdit-<%=caseId%>.html" target="_blank"><i class="fa fa-edit "></i>ִ��</a>
									</dt1>
									<dd><pre class="markup"><%=caseStep%></pre>
									</dd>
									</dl>	
								</td>
								</tr>
								</tbody>
								<tfoot>
								</tfoot>
								</table>
							</div><!-- /.box-body -->
						  </div><!-- /.box -->
						</div><!-- /.col -->
					  </div><!-- /.row -->
				<%	
				rs4.close
				set rs4 = nothing 
				rs3.close
				set rs3 = nothing 
				rs2.close
				set rs2 = nothing
				rs1.close
				set rs1 = nothing
			else %>
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
							
							<h1><i class="fa fa-exclamation-circle"></i> �ܱ�Ǹ��û���ҵ�&nbsp;��<%=searchName%>��</h1><br>
							<p>�������ؼ��ּ�����ѯ...</p>
				
							</div>
					
						</div>	
					</div>
				</div>
			<%end if 	
		
		' ������������	(����������ǰ�˺ţ�������Ŀ ��case)
		else
			
			set rs = server.createobject("adodb.recordset")
			rs.open "select * from tbl_case where caseTitle like '%"&s_named&"%' and caseCreateUser='"&session("userName")&"' order by case_pjtId DESC" ,conn,3,3
			varNoRecord = 0	
			if  rs.eof then
				varNoRecord = 1			
			end if 
			if varNoRecord = 1 then %>
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
							<h3 class="box-title">�������</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
							<%
							response.write "<h3><center>"
							response.write "��Ǹ��δ�ҵ��� """
							response.write "<font color='red'>"
							response.write searchname
							response.write "</font>"
							response.write """ ��ص��������⡣</h3>"
							response.write "<br><br>" %>
							</div>
						</div>	
					</div>
				</div>
				
			<%else%>
    		
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
							<h3 class="box-title">�����ؼ��֣�<%=searchname%></h3>
							</div>
						<!-- /.box-header -->
						<div class="box-body">
							<table id="example1" class="table table-bordered table-hover">
							<thead>
							<tr>
							<th width="10%" style="white-space: nowrap;">��Ŀ</th>
							<th width="10%" style="white-space: nowrap;">�汾</th>
							<th width="10%" style="white-space: nowrap;">��ǩ</th>		
							<th width="500" style="white-space: nowrap;">��������</th>
							<th width="10%" style="white-space: nowrap;">����</th>
							</tr>
							</thead>
							<tbody>
							
							<% 
							do while not rs.eof
								set rs5 = server.createobject("adodb.recordset")
								rs5.open "select * from tbl_project where pjtStatus='1' and pjtId="&rs("case_pjtId")&" order by pjtId DESC" ,conn,3,3
								do while not rs5.eof															
									name1=rs("caseTitle")
									name1=replace(name1,s_named,"<font color='#ff3399'>"&s_named&"</font>")
									name1=replace(name1,s_namex,"<font color='#ff3399'>"&s_namex&"</font>") %>
									<tr>	
									<% 
									set rs1 = server.createobject("adodb.recordset")
									rs1.open "select * from tbl_project where pjtId ="&rs("case_pjtId")&"  order by pjtId desc",conn,3,3
									set rs2 = server.createobject("adodb.recordset")
									rs2.open "select * from tbl_platform where platformId ="&rs("case_platformId")&" order by platformId desc",conn,3,3
									set rs3 = server.createobject("adodb.recordset")
									rs3.open "select * from tbl_label where lblId ="&rs("case_lblId")&" order by lblId desc",conn,3,3
									set rs4 = server.createobject("adodb.recordset")
									rs4.open "select * from tbl_user where userName ='"&rs("caseCreateUser")&"'",conn,3,3
									%>
									<td><% =rs1("pjtName")%></td>
									<td><% =rs2("platformName")%> </td>
									<td><% =rs3("lblName")%></td>																		
									<td><dl class="demo-methods"><dt1><span class="code"><span class="self STYLE1">չ��</span>&nbsp;</span> <%=rs("caseId")%> , 
									<%=name1%>&nbsp;							
									
									</dt1><dd><pre class="markup"><%=rs("CaseStep")%></pre></dd></dl>		</td>	
									<td style="white-space: nowrap;"><a class='btn btn-warning' href='sltTestcaseEdit-<%=rs("caseId")%>.html' data-toggle="tooltip" data-original-title="�������" target="_blank"><i class='fa fa-edit'></i></a>
									<a class='btn btn-primary' href='excTestcaseEdit-<%=rs("caseId")%>.html' data-toggle="tooltip" data-original-title="ִ������" target="_blank"><i class='fa fa-edit'></i></a>	
									</td>								
									<%
									rs4.close
									set rs4 = nothing 
									rs3.close
									set rs3 = nothing 
									rs2.close
									set rs2 = nothing
									rs1.close
									set rs1 = nothing
									%>
									</tr>
								<% 
								  rs5.movenext
								  loop
								  rs5.close
							rs.movenext
							loop
							rs.close %>
								</tbody>
								<tfoot>
								</tfoot>
								</table>		
							</div>
						</div>	
					</div>
				</div>
			<%end if 	
			
		end if 
	end if %>
			
  
<br>
	

</div> 
		  <div class="row">
			<div class="col-md-12" align="right">	
				<hr>
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>	
				<a id='DD'></a>		
			</div>
		</div>
</div>
</div>
</div>





</div>



<!-- ./wrapper -->
<script src="bootstrap/js/jquery.js"></script>  
<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- ��� չ�� ������� Bootstrap 3.3.5���� -->
<script src="bootstrap/js/custom.js?v=0.9.1"></script>
<!-- DataTables -->
<script src="plugins/datatables/jquery.dataTables.min.js"></script>
<script src="plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- page script -->
<script>
  $(function () {
    $("#example1").DataTable(	{
	  "language": {
		    "lengthMenu": "ÿҳ��ʾ _MENU_ ��",
            "zeroRecords": "û���ҵ���������������",
            "info": "��ǰ�� _START_ - _END_ �������� _TOTAL_ ��",
            "infoEmpty": "û�м�¼",
            "infoFiltered": "(�� _MAX_ ����¼�й���)",
            "search": "������",
            "paginate": {
                "first": "��ҳ",
                "previous": "��һҳ",
                "next": "��һҳ",
                "last": "βҳ"
            	}
 		 	}
  });
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


