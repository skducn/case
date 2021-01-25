<!--#include file="admFrame.asp"-->

<title><%=admMessageList%> | <%=admProject%></title>


<!-- 表格 展开 -->
<link href="../bootstrap/css/custom.css" rel="stylesheet">


<!--  新建信息	-->

<% 
if request("action") = "submit" then    
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_task",conn,3,3
	rs.addnew
	rs("taskName") = request("taskName")
	rs("taskContent") = request("taskContent")
	rs("taskTo") = request("taskTo")
	rs("taskFrom") = session("userName")
	rs("taskCreatedDate") = now
	rs.update
	rs.close
	set rs = nothing 
	response.Write("<script>;alert('新增成功');window.location.href='admTaskList.html';</script>")
end if 
%>



<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">filter_1</span> <%=admMessagePanel%> - <%=admMessageList%> </h1>
			<p class="text-muted m-0 desc">Message Panel</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

<div class="content">
<div class="card mb-4">				
<div class="card-body">											
 &nbsp; >> &nbsp;<a href="admTaskAdd.html">新建列表</a>


<table id="example2" class="table table-bordered table-hover">
<thead><tr></tr></thead>
<tbody>
<% 
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_task order by taskId DESC" ,conn,3,3
	do while not rs.eof%>
	<tr>	
	<td>		
	<dl class="demo-methods">
		<dt1>
		<% if rs("taskTo") = "all" then%>
			<span class="self STYLE1">展开</span>&nbsp;<%=rs("taskId")%> , <%=rs("taskName")%> <font color="red">(to <%=rs("taskTo")%>)</font>
		<%else%>
			<span class="self STYLE1">展开</span>&nbsp;<%=rs("taskId")%> , <%=rs("taskName")%> <font color="blue">(to <%=rs("taskTo")%>)</font>
		<%end if %>
		<a href="admTaskEditDel-<%=rs("taskId")%>.html" onClick="return confirm('是否删除此消息？')" >删除?</a> 
		</dt1>
		<dd>
			<pre class="markup"><%=rs("taskContent")%></pre>
		</dd>
	</dl>		
	</td>								
	</tr>
	<% 
	rs.movenext
	loop
	rs.close
	set rs = nothing
	%>
</tbody>
<tfoot></tfoot>
</table>	

	 
</div> <!-- /.card-body -->
</div><!-- /.card mb-4 -->
</div><!-- /.content -->





<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="../bootstrap/js/jquery.js"></script>  
<script src="../bootstrap/js/custom.js?v=0.9.1"></script>



</body>
</html>








