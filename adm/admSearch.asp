<!--#include file="admFrame.asp"-->

<title>case | 搜索用例</title>
<!-- 表格 展开 -->
<link href="../bootstrap/css/custom.css" rel="stylesheet">


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>
	我的面板
	<small>Control panel</small>
	</h1>
	<ol class="breadcrumb">
    <li><a href="admMain.html"><i class="fa fa-align-justify"></i> Home</a></li>
	
	</ol>
	</section>

	<% if request("action") = "save" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_user where userName='"&session("userName")&"'",conn,3,3
	rs("userMemo") = request("userMemo")
	rs.update
	rs.close
	set rs = nothing
	end if %>


	<!-- Main content -->
    <section class="content">
	
	<%if request("action")="search" then
		
		searchName=request("searchName")
		s_namex=LCase(searchName) '''仅大写字母转换成小写字母
		s_named=UCase(s_namex)
		s_named=replace(s_named,"'","’")    'asp在access中不支持'和[ 符号
		s_named=replace(s_named,"[","’")    'asp在access中不支持'和[ 符号	
		if searchName = "" then	   
			response.Redirect("admMain.html")
		end if 
	
		'搜索用例ID  （规则：搜索所有ID的case）
		if IsNumeric (searchName) then
			varScene = "digit"
			set rs = server.createobject("adodb.recordset")
			rs.open "select * from tbl_case where caseId="&searchName&" ",conn,3,3
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
				if session("userPower") = 1 then
					rs4.open "select * from tbl_user",conn,3,3
				else
					rs4.open "select * from tbl_user where userName ='"&rs("caseUser")&"'",conn,3,3
				end if 
				%>
				<div class="row">
					<div class="col-xs-12">
					  <div class="box">
						<div class="box-header">
						  <h3 class="box-title">搜索ID：<%=caseId%></h3>
						</div>
							<!-- /.box-header -->
							<div class="box-body">
								<table id="example1" class="table table-bordered table-hover">
								<thead>
								<tr>
								<th width="25%">项目-版本-标签</th>
								<th>用例标题</th>
								</tr>
								</thead>
								<tbody>
								<tr>
								<td><% =rs1("pjtName")%> - <% =rs2("platformName")%>-<% =rs3("lblName")%></td>
								<td>
									<dl class="demo-methods"><dt1>
									<span class="code"><span class="self STYLE2">展开</span>&nbsp;</span><%=caseId%> , 
									<%=caseTitle%>&nbsp;( 
									<a href="../sltTestcaseEdit-<%=caseId%>.html" target="_blank"><i class="fa fa-edit text-yellow"></i></a>
									<a href="../excTestcaseEdit-<%=caseId%>.html" target="_blank"><i class="fa fa-edit text-green"></i></a> , <%=rs("caseCreateUser")%>)<br>
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
							<h3 class="box-title">搜索结果</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
							<%response.write "<center>"
							response.write "抱歉！未找到您的ID（<font color='red'>"
							response.write searchName
							response.write "</font>）用例。"
							response.write "<br><br>"
							response.end %>
							</div>
						</div>	
					</div>
				</div>
			<%end if 	
		
		' 搜索用例标题	(规则：搜索所有开启项目 的case)
		else
			set rs = server.createobject("adodb.recordset")
			rs.open "select * from tbl_case where caseTitle like '%"&s_named&"%' order by case_pjtId DESC" ,conn,3,3
			varNoRecord = 0
			
			if  rs.eof then
				varNoRecord = 1			
			
			end if 
		
			if varNoRecord = 1 then %>
				<div class="row">
					<div class="col-xs-12">
						<div class="box">
							<div class="box-header">
							<h3 class="box-title">搜索结果</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
							<%
							response.write "<center>"
							response.write "很抱歉，未找到和 """
							response.write "<font color='red'>"
							response.write searchname
							response.write "</font>"
							response.write """ 相关的用例标题。"
							response.write "<br>"
							response.write "建议：简化查询词或尝试其他相关词"
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
							<h3 class="box-title">搜索关键字：<font color='#ff3399'><%=searchname%></font></h3>
							</div>
						<!-- /.box-header -->
						<div class="box-body">
							<table id="example1" class="table table-bordered table-hover">
							<thead>
							<tr>
							<th width="25%" style="white-space: nowrap;">项目 - 版本 - 标签</th>
							<th>用例标题</th>
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
								name1=replace(name1,s_namex,"<font color='#ff3399'>"&s_namex&"</font>")
							 %>
								<tr>	
								<% 
								set rs1 = server.createobject("adodb.recordset")
								rs1.open "select * from tbl_project where pjtId ="&rs("case_pjtId")&"  order by pjtId desc",conn,3,3
								set rs2 = server.createobject("adodb.recordset")
								rs2.open "select * from tbl_platform where platformId ="&rs("case_platformId")&" order by platformId desc",conn,3,3
								set rs3 = server.createobject("adodb.recordset")
								rs3.open "select * from tbl_label where lblId ="&rs("case_lblId")&" order by lblId desc",conn,3,3
								set rs4 = server.createobject("adodb.recordset")
								if session("userPower") = 1 then
									rs4.open "select * from tbl_user",conn,3,3
								else
									rs4.open "select * from tbl_user where userName ='"&rs("caseUser")&"'",conn,3,3
								end if 
								%>
								<td><% =rs1("pjtName")%> - <% =rs2("platformName")%> - <% =rs3("lblName")%></td>
								<td>		
								<dl class="demo-methods"><dt1>
								<span class="code"><span class="self STYLE1">展开</span>&nbsp;</span> <%=rs("caseId")%> , 
								<%=name1%>
								(
								<a href="../sltTestcaseEdit-<%=rs("caseId")%>.html" target="_blank"><i class="fa fa-edit text-yellow"></i></a>
								<a href="../excTestcaseEdit-<%=rs("caseId")%>.html" target="_blank"><i class="fa fa-edit text-green"></i></a> , <%=rs("caseCreateUser")%>)<br>
								</dt1>
								<dd><pre class="markup"><%=rs("CaseStep")%></pre>
								</dd>
								</dl>		
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
							  set rs5 = nothing
							 rs.movenext
							 loop
							 rs.close
							 set rs = nothing %>
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
	
</section>  <!-- /.content -->
	
</form>

</div>
<!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="../bootstrap/js/custom.js?v=0.9.1"></script>

<!-- Slimscroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>



<!-- page script -->
<script>
  $(function () {
      $("#example1").DataTable(	{
	  "language": {
		    "lengthMenu": "每页显示 _MENU_ 条",
            "zeroRecords": "没有找到符合条件的数据",
            "info": "当前第 _START_ - _END_ 条　共计 _TOTAL_ 条",
            "infoEmpty": "没有记录",
            "infoFiltered": "(从 _MAX_ 条记录中过滤)",
            "search": "搜索：",
            "paginate": {
                "first": "首页",
                "previous": "上一页",
                "next": "下一页",
                "last": "尾页"
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


