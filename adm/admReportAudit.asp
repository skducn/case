<!--#include file="admFrame.asp"-->

<title><%=cstCompany%> | ��˱���</title>

<script language="javascript">     
function CheckPost()
{		
	
	//�ύǰ����ȷ��		
	var gnl=confirm("�Ƿ���˲�ͨ����ȷ����");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}
</script>

<%
pjtId = request("pjtId")
platformId = request("platformId")
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId desc",conn,3,3
if rs.recordcount = 0 then
	response.Redirect("../index.html")
end if 
%>



<!--  ���ͨ�� -->	

<% 
if request("action") = "audit" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
	rs("rptStatus") = "done"
	rs("rptDoneDate") = now()
	rs.update
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId DESC",conn,3,3
	rs("verIsReport") = "done"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admMain.html")
end if %>


<!--  ��˲�ͨ�� -->	

<% 
if request("action") = "noAudit" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId DESC",conn,3,3
	rs("rptStatus") = "reject"
	rs("rptRejectReason") = request("rejectReason")
	rs("rptDoneDate") = now()
	rs.update
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId DESC",conn,3,3
	rs("verIsReport") = "reject"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("admMain.html")
end if %>



<% 

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs1("pjtName")
rs1.close

set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
platformRedmine = rs1("platformRedmine")
platformName = rs1("platformName")
rs1.close


%>

  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">	
      <h1>
		<small>
	
		</small>
      </h1>
 
    </section>


<!-- Main content -->
<section class="content">     
	<form role="form" action="admReportAuditNoaudit-<%=pjtId%>-<%=platformId%>.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
			<% if rs("rptStatus") <> "done" then%>
			<div class="row">
				<div class="col-md-12" align="center">
					<a href="admReportAuditAudit-<%=pjtId%>-<%=platformId%>.html" onClick="return confirm('�Ƿ����ͨ����ȷ����')">
					<button type="button" class="btn btn-info pull-left" style="margin-right: 5px;"  href="#" >���ͨ��</button></a>						
					<button type="submit" class="btn btn-danger"  href="#">��˲�ͨ��</button> 
			
				</div>

				<div class="col-md-12" align="center">
				<br>
				<textarea name="rejectReason" cols="100" rows="5"  placeholder="����д������Ϣ"><%=rs("rptRejectReason")%></textarea>
				</div>
			</div>		
						
				
			<% end if %>
		</form>

 
		<% if rs("rptStatus") = "undone" then%>
		    <h1 align="center"><%=pjtName%> <%=platformName%> ���Ա���(δ���)</h1>	
		<% elseif rs("rptStatus") = "reject" then%>		
		    <h1 align="center"><%=pjtName%> <%=platformName%> ���Ա���(�Ѿܾ�)</h1>	
		<% else %>
			<h1 align="center"><%=pjtName%> <%=platformName%> ���Ա���(�����)</h1>
		<%end if %>
	 
	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">��Ҫ</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
		</div>
		
        <!-- /.box-header -->
        <div class="box-body">
		
				<div class="row">
					<div class="col-md-12">							
						<table id="example2" class="table table-bordered table-hover">
						<thead>
						<tr>
						<th style="width: 33%">ģ������</th>
						<th style="width: 33%">��������</th>
						<th style="width: 33%">������Ա</th>						
						</tr>
						</thead>
						<tbody>	  
						<tr>
						<td><textarea  name="rptNo" class="form-control" rows="3"  disabled><%=rs("rptNo")%></textarea></td>
						<td><textarea  name="rptPeriod" class="form-control" rows="3" disabled><%=rs("rptPeriod")%></textarea></td>
						<td><textarea  name="rptMember" class="form-control" rows="3" disabled><%=rs("rptMember")%></textarea></td>													
						</tr>
						</tbody>					
						</table>
					</div>	
					
					<div class="col-md-12">							
						<table id="example2" class="table table-bordered table-hover">
						<thead>
						<tr>
						<th style="width: 33%">��������</th>
						<th style="width: 33%">���ƽ̨</th>	
						<th style="width: 33%">����</th>
						</tr>
						</thead>
						<tbody>	  
						<tr>
						<td><textarea name="rptBasis" class="form-control" rows="5" disabled><%=rs("rptBasis")%></textarea></td>
						<td><textarea  name="rptTerminal" class="form-control" rows="5" disabled><%=rs("rptTerminal")%></textarea></td>	
						<td> <textarea  name="rptRisk" class="form-control" rows="5" disabled><%=rs("rptRisk")%></textarea></td>
						
						</tr>
						</tbody>					
						</table>
					</div>	
					
					<div class="col-md-12">	
					<label>���Ի��������</label>
					<% if rs("rptTestResult") = "pass" then %>
							&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;ͨ��</font>
						<%else%>							
							&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;��ͨ��</font>
						<%end if %> 
					<br>
					<label>�������������</label>
						<% if rs("rptOnlineResult") = "pass" then %>
							&nbsp;&nbsp;<font color="green"><i class="fa fa-check"></i>&nbsp;ͨ��</font>
						<%else%>
							&nbsp;&nbsp;<font color="red"><i class="fa fa-close (alias)"></i>&nbsp;��ͨ��</font>
						<%end if %>  
					</div>
												        
				</div><!-- /.row -->
				
				
				
	
		</div> <!-- /.body -->
	</div><!-- /.box-default -->
  
         
	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">1������</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
        </div>
		
        <!-- /.box-header -->
        <div class="box-body">
		
			<div class="row">			
				<div class="col-md-12">							
						<table id="example2" class="table table-bordered table-hover">
						<thead>
						<tr>
						<th style="width: 25%">1.1 Ŀ��</th>
						<th style="width: 25%">1.2 ����</th>
						<th style="width: 25%">1.3 ������</th>
						<th style="width: 25%">1.4 Ӳ����Դ</th>
						</tr>
						</thead>
						<tbody>	  
						<tr>
						<td><% if rs("rptGoal") = "" then
						response.write "��"
			  		else%>
						<textarea  name="rptPurpose" class="form-control" rows="5" disabled><%=rs("rptGoal")%></textarea>
					<%end if %></td>
						<td>	<% if rs("rptScene") = "" then
							response.write "��"
					   else %> 
							<textarea  name="rptScene" class="form-control" rows="5" disabled><%=rs("rptScene")%></textarea>
					<%end if %></td>
						<td><textarea  name="rptSoft" class="form-control" rows="5" disabled><%=rs("rptSoft")%></textarea></td>
						<td><textarea  name="rptHard" class="form-control" rows="5" disabled><%=rs("rptHard")%></textarea></td>
						</tr>
						</tbody>					
						</table>
				</div>		
			</div>	
			
			<div class="row">
            <div class="col-md-12">

			
	
				
				
				<div class="form-group">
					<label>1.5 ���Խ���</label>
					<table class="table table-bordered">
					<tr>               
					<th style="width: 15%">������Ŀ</th>
					<th style="width: 15%">��ʼ��������</th>
					<th style="width: 70%">��ע</th>
					</tr>
					
					<tr>
					<td>�����ĵ�����</td>
					<td>					
		
					 <!-- Date start -->
					<div class="form-group">
						<div class="input-group">
						<%=rs("rptStoryDate")%> 
						</div><!-- /.input group -->
					</div><!-- /.form group -->
					</td>
	
					<td>
					<div class="form-group">						 
					<textarea  name="rptStoryMemo" class="form-control" rows="5" disabled><%=rs("rptStoryMemo")%></textarea>
					</div>
					</td>
					</tr>
				
					<tr>
					<td>��Ʊ�д����</td>
					<td> 
					
					<!-- Date start -->
					<div class="form-group">
					<div class="input-group">
					<%=rs("rptDesignDate")%>
					</div><!-- /.input group -->
					</div><!-- /.form group -->
					</td>
				
					
					<td>
					<div class="form-group">
					<textarea  name="rptDesignMemo" class="form-control" rows="5" disabled><%=rs("rptDesignMemo")%></textarea> 
					</div>
					</td>
					</tr>
					
					<tr>
					<td>ִ�в�������</td>
					<td> 
					
					<!-- Date start -->
					<div class="form-group">
					<div class="input-group">
					<%=rs("rptExcDate")%>
					</div><!-- /.input group -->
					</div><!-- /.form group -->
					</td>
				

					<td>
					<div class="form-group">
					<textarea  name="rptExcMemo" class="form-control" rows="5" disabled><%=rs("rptExcMemo")%></textarea>
					</div>
					</td>
					</tr>
					
					<tr>
					<td>bug��֤�ع�</td>
					<td> 
					
					<!-- Date start -->
					<div class="form-group">
					<div class="input-group">
					<%=rs("rptBugDate")%>
					</div><!-- /.input group -->
					</div><!-- /.form group -->
					</td>
									
					<td>
					<div class="form-group"> 
					<textarea  name="rptBugMemo" class="form-control" rows="5" disabled><%=rs("rptBugMemo")%></textarea>
					</div>
					</td>
					</tr>
					</table>
				</div>
			
			
			</div> <!-- .col --> 	 
			</div>  <!-- .row -->    
			
						<div class="row">			
				<div class="col-md-12">							
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%">1.6 ����</th>
					<th style="width: 50%">1.7 �ο�����</th>
		
					</tr>
					</thead>
					<tbody>	  
					<tr>
					<td>	<% if rs("rptCaption") = "" then
						  response.write "��"
					   else%>
						  <textarea  name="rptCaption" class="form-control" rows="5" disabled><%=rs("rptCaption")%></textarea>
					  <%end if %></td>
					<td>	<% if rs("rptRef") = "" then
						  response.write "��"
					   else%>
						  <textarea  name="rptRef" class="form-control" rows="5" disabled><%=rs("rptRef")%></textarea>
					 <%end if %></td>
		
					</tr>
					</tbody>					
					</table>
				</div>	
			</div>	
		</div> <!-- .body -->
	</div><!-- .body default -->


	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">2����������</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
        </div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
        	<div class="col-md-12">
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>
			
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 5%">����Id</th>
				<th style="width: 15%">��ǩ</th>
				<th style="width: 45%">��������</th>
				<th style="width: 15%">���Զ���</th>
				<th style="width: 15%">���Խ׶�</th>
				<th style="width: 5%">���Խ��</th>
				</tr>
				</thead>
				<tbody>	  
				<% set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseStage ,caseId asc",conn,3,3 
				do while not rs2.eof %>
					<tr>
					<td><a href="../excTestcaseEdit-<%=rs2("caseId")%>-<%=rs2("case_pjtId")%>.html" target="_blank"><%=rs2("caseId")%></td>
					<td>
					<% set rs3 = server.createobject("adodb.recordset")
					rs3.open "select * from tbl_label where lblId="&rs2("case_lblId")&"  order by lblId asc",conn,3,3 
					response.write rs3("lblName")
					rs3.close
					%>
					</td>
					<td><%=rs2("caseTitle")%></td>
					<td> 
					<% varSum2 = ""
					if rs2("caseWeb") = "on" then
					varSum2 =  "B/S &nbsp;" + varSum2  
					end if
					if rs2("caseIos") = "on" then
					varSum2 =  "iOS &nbsp;" + varSum2  
					end if
					if rs2("caseAndroid") = "on" then
					varSum2 =  "android &nbsp;" + varSum2  
					end if
					if rs2("caseCS") = "on" then
					varSum2 =  "C/S &nbsp;" + varSum2  
					end if
					if rs2("caseDevice") = "on" then
					varSum2 =  "���� &nbsp;" + varSum2  
					end if
					response.write varSum2 %>		
					</td>
					<td>
					<% if rs2("caseStage") =1 then
					response.write "ð��"
					elseif rs2("caseStage") =2 then
					response.write "��ʽ"
					elseif rs2("caseStage") =3 then
					response.write "�ع�"
					end if %>
					</td>
				    <td>
					<% if rs2("caseResult") ="error" then
					response.write "<font color=red>error</font>"
					elseif rs2("caseResult") = "ok" then
					response.write "<font color=blue>ok</font>"
					elseif rs2("caseStatus") = "3" then
					response.write "<font color=blue>hang-up</font>"
					elseif rs2("caseStatus") = "2" then
					response.write "<font color=red>pause</font>"
					end if %>
					</td>
					</tr>
				<%rs2.movenext
				loop
				rs2.close %>   
				</tbody>
				<tfoot>
				
				</tfoot>
				</table>
			<% rs1.movenext
			loop
			rs1.close %> 
			</div><!-- /.col -->
			</div><!-- /.row -->	  
		</div><!-- /.body -->
	</div><!-- /.body default-->



	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">3�����Է���</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
        </div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
			<div class="col-md-12">
				<div class="box-header">
				<h3 class="box-title">3.1  ���Ը�����</h3>
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 25%">�汾 - ��ǩ</th>
				<th style="width: 15%">��������</th>
				<th style="width: 15%">��ͨ����(s)</th>
				<th style="width: 15%">δͨ����</th>
				<th style="width: 15%">δ������(���ã�</th>
				<th style="width: 15%">����ִ�и�����</th>
				</tr>
				</thead>
				<tbody>
				<% set rs4 = server.createobject("adodb.recordset")
				rs4.open "select * from tbl_platform where platformId="&platformId&" order by platformId asc",conn,3,3 
				do while not rs4.eof 
					set rs5 = server.createobject("adodb.recordset")
					rs5.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3 
					do while not rs5.eof
						set rs6 = server.createobject("adodb.recordset")
						rs6.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" and case_lblId="&rs5("lblId")&" order by caseId asc",conn,3,3 %>
						<tr>
						<td><% response.write rs4("platformName") + " - " + rs5("lblName")%></td>
					
						<td><% if rs("rptCaseTotal") <>"" then
								response.write rs("rptCaseTotal")
							else
								response.write rs6.recordcount
							end if %>
					
						</td>
						<td><%
						varOkSum3 = 0
						varErrorSum3 = 0
						varEmptySum3 = 0
							do while not rs6.eof
								if rs6("caseResult") = "ok" then
								   varOkSum3 = varOkSum3 + 1
								end if 
								if rs6("caseResult") = "error" then
								   varErrorSum3 = varErrorSum3 + 1
								end if 
								if isnull(rs6("caseResult")) then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
									if rs6("caseStatus") = "3" then
								   varEmptySum3 = varEmptySum3 + 1
								end if 
							rs6.movenext
							loop
							
						if rs("rptCasePass") <>"" then
							response.write rs("rptCasePass")
						else
							response.write varOkSum3
						end if %>							
						</td>
						<td>
						<% if rs("rptNoPass") <>"" then
							response.write rs("rptNoPass")
						else
							response.write varErrorSum3
						end if %>
						
						</td>
						<td>
						<%  if rs("rptNoTest") <>"" then
							response.write rs("rptNoTest")
						else
							response.write varEmptySum3
						end if %>
						
						</td>
						<td>
							<%  if rs("rptCaseCoverage") <>"" then
							response.write rs("rptCaseCoverage")
						else
							varFGL = int((varOkSum3+varErrorSum3)/rs6.recordcount*100)
							response.write cstr(varFGL) + "%"
						end if  
						
				
						rs6.close%>
						</td>
						</tr>
					<% rs5.movenext
					loop
					rs5.close
				rs4.movenext
				loop
				rs4.close %>	       
                </tbody>
                <tfoot>            
                </tfoot>
                </table>
			</div><!-- /.col -->
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.2 ȱ��ƽ̨ͳ��</h3> 
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%">ϵͳƽ̨</th>
					<th style="width: 50%">Bug����</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>iOS</td>
					<td><div class="form-group">
					<input type="text" name="rptIbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(0)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<input type="text" name="rptAbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(1)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>���ݿ�/�ӿ���</td>
					<td><div class="form-group">
					<input type="text" name="rptSbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(2)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<input type="text" name="rptPbug" class="form-control" value="<%=split(rs("rptBugQty"),",")(3)%>" disabled>
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.3 ȱ�����س̶�</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%">���س̶�</th>
					<th style="width: 50%">Bug����</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>����</td>
					<td><div class="form-group">
					<input type="text" name="rptJdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(0)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group"> 
					<input type="text" name="rptGdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(1)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>��ͨ</td>
					<td><div class="form-group">
					<input type="text" name="rptPdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(2)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group">
					<input type="text" name="rptDdegree" class="form-control" value="<%=split(rs("rptBugDegree"),",")(3)%>" disabled>
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-md-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.4 ȱ��״̬ͳ��</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th style="width: 50%">ȱ��״̬</th>
					<th style="width: 50%">Bug����</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>δ����(�½�)</td>
					<td><div class="form-group">
					<input type="text" name="rptWstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(0)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>������</td>
					<td><div class="form-group">
					<input type="text" name="rptCstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(1)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>�ѽ��</td>
					<td><div class="form-group">
					<input type="text" name="rptJstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(2)%>" disabled>
					</div></td>
					</tr>
					<tr>
					<td>�ѷ���</td>
					<td><div class="form-group">
					<input type="text" name="rptFstatus" class="form-control" value="<%=split(rs("rptBugStatus"),",")(3)%>" disabled>
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->					
			</div><!-- /.col -->
			
			<div class="col-md-12">
				<a href="<%=platformRedmine%>" target="_blank">buglist</i></a>
			</div>
			
				<!--  �ϴ�redmine��ͼ --> 
				<% if  instr(rs("rptRedminePic"),"upload") then%>						
						<img src=<%="../"&rs("rptRedminePic")%> /><br><br>			
				<% end if %>
			
			<div class="col-md-12">							
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th style="width: 33%">3.5 ����/����</th>
				<th style="width: 33%">3.6 ���Խ�����</th>
				<th style="width: 33%">3.7 ����</th>		
				</tr>
				</thead>
				<tbody>	  
				<tr>
				<td><textarea  name="rptFeedback" class="form-control" rows="5" disabled><%=rs("rptFeedback")%></textarea></td>
				<td><textarea  name="rptDelivery" class="form-control" rows="5" disabled><%=rs("rptDelivery")%></textarea></td>
				<td><textarea  name="rptAdvice" class="form-control" rows="5" disabled><%=rs("rptAdvice")%></textarea></td>		
				</tr>
				</tbody>					
				</table>
			</div>
				

			</div><!-- /.row -->	  
		</div><!-- /.body -->
	</div><!-- /.body default-->
  

 	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">4�����Խ���</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
		</div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
				<div class="col-md-12">
					<div class="form-group">				
						<% if rs("rptConclusion")="" then
							response.write "<br>�ݲ����ۣ��������"
						else%>
							<textarea  name="rptConclusion" class="form-control" rows="6" disabled><%=rs("rptConclusion")%></textarea>
						<%end if %>
					</div>				
				</div>  <!-- /.col -->
			</div><!-- /.row -->
		</div> <!-- /.body -->
	</div><!-- /.box-default -->     
     

   
	</section><!-- ./col -->

	
</div><!-- ./wrapper -->

<%
rs.close
set rs = nothing
%>

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

</body>
</html>

