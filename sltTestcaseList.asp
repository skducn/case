<!--#include file="frame.asp"-->

<title>������� | <%=cstCompany%></title>
<link href="bootstrap/css/custom.css" rel="stylesheet">


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit text-warning">&nbsp;<%=cstChangeCase%></i></h1><p>change testcase</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#"><%=cstChangeCase%></a></li></ul></div>
	</div>
	
	<div class="box box-danger box-solid box-default">
		
							
<div class="card">
	<div class="row">
		<div class="col-md-12">
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
			  
			 ' response.write rs3("lblId")
			 ' response.write lblId
			 ' response.End()
			  varLebelTotal = rs3.recordcount
			  reDim lblId_array(varLebelTotal)  
				
			  ' �����ǩ
			  if varLebelTotal > 1 then  
				do while not rs3.eof 		
					lblId_array(counts) = rs3("lblId")
					' rs66.recordcount ��ȡ��ǰ��ǩ ��ǰ�����µ���������
					set rs66 = server.createobject("adodb.recordset")
					rs66.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(counts)&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
					
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
					rs66.close
					counts = counts + 1 
				rs3.movenext
				loop  
			  '1����ǩ	 
			  elseif varLebelTotal = 1 then
			     set rs77 = server.createobject("adodb.recordset")
				 rs77.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
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
	
			  
	<!-- ִ�� �ҵĲ�������  ��ɫɫ�ָ��� -->
	<div class="box box-success">
		<div class="box-header with-border">	
			<h3 class="box-title">	
					  <!-- ��ʾ��Ŀ�� - ƽ̨�� -->
			  <% Set rs4 = Server.CreateObject("Adodb.Recordset")
				 rs4.Open "select * from tbl_project where pjtId="&request("pjtId")&" ",conn,3,3
			     Set rs5 = Server.CreateObject("Adodb.Recordset")
  				 rs5.Open "select * from tbl_platform where plat_pjtId="&request("pjtId")&" and platformId="&request("platformId")&" ",conn,3,3
				 Set rs6 = Server.CreateObject("Adodb.Recordset")
 				 rs6.Open "select * from tbl_case where case_pjtId="&request("pjtId")&" and case_platformId="&request("platformId")&" and caseCreateUser='"&session("userName")&"' ",conn,3,3%>
          		<%=rs4("pjtName")%>&nbsp;<%=rs5("platformName")%> <span class="label label-warning"><%=rs6.recordcount%></span>
				<%
				rs6.close
				rs5.close
				rs4.close%></h1><hr></h3>
				
			<div class="row">	
				<h4>
					<% if request("caseStage") = 1 then
						response.write "&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-fire'></i>&nbsp;ð�̲��� "
					elseif request("caseStage") = 2 then
						response.write "&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-ellipsis-h'></i>&nbsp;��ʽ����"
					else
						response.write "&nbsp;&nbsp;&nbsp;&nbsp;<i class='fa fa-chrome'></i>&nbsp;�ع����"
					end if  
					%>
				</h4>
					
					<!-- �л����� -->	

			<div class="col-md-10">
				<div class="bs-component">
					<ul class="nav nav-pills">  					
						<li class="active"><a class="dropdown-toggle" data-toggle="dropdown" href="#">�л�����<span class="caret"></span></a>
						<ul class="dropdown-menu">
						<li role="presentation"><a role="menuitem" tabindex="-1" href="sltTestcaseList-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-1.html">ð�̲���</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="sltTestcaseList-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-2.html">��ʽ����</a></li>
						<li role="presentation"><a role="menuitem" tabindex="-1" href="sltTestcaseList-<%=pjtId%>-<%=platformId%>-<%=lblId_array(varcount)%>-3.html">�ع����</a></li>
						</ul>
						</li>
					</ul>
				</div>																							
			</div>	
			
			
				
			</div>
		</div>
		<!-- /.box-header -->
		<div class="box-body">
		
		<br />
		<% 
		set rs6 = server.createobject("adodb.recordset")
		rs6.open "select * from tbl_case where caseStage="&request("caseStage")&" and case_lblId="&lblId_array(varcount)&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
		if not rs6.eof then 					
			do while not rs6.eof%>
				<div class="layout clear">
					<dl class="demo-methods">
					<dt1> 
					<span class="code"><span class="self">չ��</span>&nbsp;</span>	
					<%=rs6("caseId")%> , &nbsp;<a href="sltTestcaseEdit-<%=rs6("caseId")%>.html"><%=rs6("caseTitle")%></a>
				
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
	<!-- top��ť -->
	<div class="col-md-12" align="right">	
	<hr>
	<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="��ҳ��"><i class="fa fa-arrow-circle-up"></i></button></a>			
	</div>
</div>
</div>
</div>
</section>
</div>




<script src="bootstrap/js/custom.js?v=0.9.1"></script>





</body>
</html>
