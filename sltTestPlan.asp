<!--#include file="admframe.asp"-->

<title><%=cstCompany%> | ���Լƻ�</title>
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<!--  �½����� -->	

<%
if request("action") = "submit" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	
	'����������Զ�ȥ����������
	rptAbug = replace(request("rptAbug"),"-","")
	rptIbug = replace(request("rptIbug"),"-","")
	rptSbug = replace(request("rptSbug"),"-","")
	rptPbug = replace(request("rptPbug"),"-","")
	rptJdegree = replace(request("rptJdegree"),"-","")
	rptGdegree = replace(request("rptGdegree"),"-","")
	rptPdegree = replace(request("rptPdegree"),"-","")
	rptDdegree = replace(request("rptDdegree"),"-","")
	rptWstatus = replace(request("rptWstatus"),"-","")
	rptCstatus = replace(request("rptCstatus"),"-","")
	rptJstatus = replace(request("rptJstatus"),"-","")
	rptFstatus = replace(request("rptFstatus"),"-","")

	if rptAbug = "" then 
		rptAbug = 0 
	end if 
	if rptIbug = "" then 
		rptIbug = 0 
	end if 
	if rptSbug = "" then
		rptSbug = 0
	end if 
	if rptPbug = "" then
		rptPbug = 0
	end if 
	if rptJdegree = "" then
		rptJdegree = 0
	end if 
	if rptGdegree = "" then
		rptGdegree = 0
	end if 
	if rptPdegree = "" then
		rptPdegree = 0
	end if 
	if rptDdegree = "" then
		rptDdegree = 0
	end if 	
	if rptWstatus = "" then
		rptWstatus = 0
	end if 
	if rptCstatus = "" then
		rptCstatus = 0
	end if 
	if rptJstatus = "" then
		rptJstatus = 0
	end if 
	if rptFstatus = "" then
		rptFstatus = 0
	end if

	'����Ƿ�������
	if not IsNumeric(rptAbug) or not IsNumeric(rptIbug) or not IsNumeric(rptSbug) or not IsNumeric(rptPbug) then
		response.Write("<script>;alert('ȱ��ƽ̨����ֻ������0-999����!');window.location.href='sltReportCreate.asp?pjtId="&pjtId&"&platformId="&platformId&"';</script>")
		response.end 
	end if
	if not IsNumeric(rptJdegree) or not IsNumeric(rptGdegree) or not IsNumeric(rptPdegree) or not IsNumeric(rptDdegree) then
		response.Write("<script>;alert('ȱ�����س̶�����ֻ������0-999����!');window.location.href='sltReportCreate.asp?pjtId="&pjtId&"&platformId="&platformId&"';</script>")
		response.end 
	end if
	if not IsNumeric(rptWstatus) or not IsNumeric(rptCstatus) or not IsNumeric(rptJstatus) or not IsNumeric(rptFstatus) then
		response.Write("<script>;alert('ȱ��״̬����ֻ������0-999����!');window.location.href='sltReportCreate.asp?pjtId="&pjtId&"&platformId="&platformId&"';</script>")
		response.end 
	end if

	rptBugQty = cstr(rptAbug) + "," + cstr(rptIbug) + "," + cstr(rptSbug) + "," + cstr(rptPbug)
	rptBugDegree = cstr(rptJdegree) + "," + cstr(rptGdegree) + "," + cstr(rptPdegree) + "," + cstr(rptDdegree)
	rptBugStatus = cstr(rptWstatus) + "," + cstr(rptCstatus) + "," + cstr(rptJstatus) + "," + cstr(rptFstatus)

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_report where rpt_pjtId="&pjtId&" and rpt_platformId="&platformId&" order by rptId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("rpt_pjtId") = pjtId
		rs("rpt_platformId") = platformId
		rs("rptStatus") = "undone"
		rs("rptTestResult") = request("rptTestResult")
		rs("rptOnlineResult") = request("rptOnlineResult")
		rs("rptNo") = request("rptNo")
		rs("rptMember") = request("rptMember")
		rs("rptPeriod") = request("rptPeriod")
		rs("rptTerminal") = request("rptTerminal")
		rs("rptBasis") = request("rptBasis")
		rs("rptRisk") = request("rptRisk")
		rs("rptGoal") = request("rptGoal")
		rs("rptScene") = request("rptScene")
		rs("rptSoft")= request("rptSoft")
		rs("rptHard")= request("rptHard")
		rs("rptStoryDate") = request("rptStoryDate")
		rs("rptStoryMemo") = request("rptStoryMemo")
		rs("rptDesignDate") = request("rptDesignDate")
		rs("rptDesignMemo") = request("rptDesignMemo")
		rs("rptExcDate") = request("rptExcDate")
		rs("rptExcMemo") = request("rptExcMemo")
		rs("rptBugDate") = request("rptBugDate")
		rs("rptBugMemo") = request("rptBugMemo")
		rs("rptCaption") = request("rptCaption")
		rs("rptRef") = request("rptRef")
		rs("rptBugQty") = rptBugQty
		rs("rptBugDegree") = rptBugDegree
		rs("rptBugStatus") = rptBugStatus 
		rs("rptFeedback") = request("rptFeedback")
		rs("rptDelivery") = request("rptDelivery")
		rs("rptAdvice") = request("rptAdvice")
		rs("rptConclusion") = request("rptConclusion")
		rs("rptVedioPrefix") = request("rptVedioPrefix")	
		currentPath = server.mappath(Request.ServerVariables("SCRIPT_NAME"))
        currentPath = split(currentPath,"sltReport")(0) + "mp4"
		rs("rptVedioPath") = "\mp4" 
		'rs("rptRedminePic") = request("rptRedminePic")
		rs("rptAuthor") = session("userName")
		rs("rptCreatedDate") = now()
	
		rs.update
	else
		response.Write("<script>;alert('���棡���Ա����Ѵ���������ϵ����Ա��');window.location.href='main.asp';</script>")
		response.end 
	end if 
	rs.close
	set rs = nothing
	
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
	rs("plat_rptStatus") = "undone"
	rs.update
	rs.close
	set rs = nothing
	response.Redirect("sltReportShow.asp?pjtId="&pjtId&"&platformId="&platformId&"")
end if 
%>

  
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
		
		<% pjtId = request("pjtId")
		platformId = request("platformId")

		set rs = server.createobject("adodb.recordset")
		set rs2 = server.createobject("adodb.recordset")
		rs.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
		pjtName = rs("pjtName")

		rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
		pjtRedmine = rs2("platformRedmine")
		platformName = rs2("platformName")
		rs2.close
		rs.close
		set rs2 = nothing
		set rs = nothing
		
		set rs1 = server.createobject("adodb.recordset")
		rs1.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
		platformName = rs1("platformName")
		platformRedmine = rs1("platformRedmine")
		rs1.close
		%>

      <h1>
        <%=pjtName%> <%=platformName%>- ���Ա���
        <small>�½��� ...</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="main.asp"><i class="fa fa-align-justify"></i> Home</a></li>
      </ol>
    </section>


<form id="form1" name="form1" method="post" action="sltReportCreate.asp?action=submit">

<!-- Main content -->
<section class="content">
      
	  
	<!-- SELECT2 EXAMPLE -->
	<div class="box box-default">
		<div class="box-header with-border">
			<h3 class="box-title">���Ը�Ҫ</h3>
			<div class="box-tools pull-right">
			<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
			<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-remove"></i></button>
			</div>
		</div>
		
        <!-- /.box-header -->
        <div class="box-body">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
					<label>������</label>
					<input type="text" name="rptNo" class="form-control" placeholder="�磺dkzy_<%=pjtName%>_1_0">
					</div>				      
					<div class="form-group">
					<label>��������</label>
					<textarea  name="rptPeriod" class="form-control" rows="3" placeholder="Enter ..."></textarea>
					</div>				
					<div class="form-group">
					<label>���Ի���</label>
					<textarea name="rptBasis" class="form-control" rows="3" placeholder="Enter ..."></textarea>
					</div>
					
					<div class="row">
						<div class="col-md-6">
							<!-- radio -->
							<div class="form-group">
								<label>���Ի������</label>
								<div class="radio">
									<label>
									<input type="radio" name="rptTestResult"  value="pass" checked>
									<i class="fa fa-check text-green"></i> &nbsp;ͨ��
									</label>
								</div>
								<div class="radio">
									<label>
									<input type="radio" name="rptTestResult"  value="failed">
									<i class="fa fa-close (alias) text-red"></i>&nbsp;��ͨ��
									</label>
								</div>
							</div>
						</div><!-- /.col -->
						
						<div class="col-md-6">
							<!-- radio -->
							<div class="form-group">
								<label>�����������</label>
								<div class="radio">
									<label>
									<input type="radio" name="rptOnlineResult" value="pass" checked>
									<i class="fa fa-check text-green"></i> &nbsp;ͨ��
									</label>
								</div>
								<div class="radio">
									<label>
									<input type="radio" name="rptOnlineResult"  value="failed">
									<i class="fa fa-close (alias) text-red"></i>&nbsp;��ͨ��
									</label>
								</div> 
							</div>
						</div><!-- /.col -->
					</div> <!-- /.row -->
				</div>  <!-- /.col -->
          
				<div class="col-md-6">
                	<div class="form-group">
                  		<label>������Ա</label>
                 		<textarea  name="rptMember" class="form-control" rows="3" placeholder="Enter ..."></textarea>
                	</div>
            		<div class="form-group">
					  <label>���ƽ̨</label>
					  <textarea  name="rptTerminal" class="form-control" rows="3" placeholder="Enter ..."></textarea>
					</div>
					<div class="form-group">
					  <label>����</label>
					  <textarea  name="rptRisk" class="form-control" rows="6" placeholder="Enter ..."></textarea>
					</div>

				</div><!-- /.col -->
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

				<div class="form-group">
				<label>1.1 Ŀ��</label>
				<textarea  name="rptGoal" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
				<div class="form-group">
				<label>1.2 ����</label>
				<textarea  name="rptScene" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
				<div class="form-group">
				<label>1.3 �������</label>
				<textarea  name="rptSoft" class="form-control" rows="5" placeholder="Enter ...">1����˾���绷��Wifi
2��firefox�����
3��Win7 ϵͳ
4��mysql���ݿ�
				</textarea>
				</div>
				<div class="form-group">
				<label>1.4 Ӳ����Դ</label>
				<textarea  name="rptHard" class="form-control" rows="5" placeholder="Enter ...">1��android����ΪP7�����ǡ�С�ס�����
2��iOS��iPhone 6 plus��iphone 6
3��PC��E470�ʼǱ�
				</textarea>
				</div>
	
				
				
				<div class="form-group">
					<label>1.5 ���Խ���</label>
					<table class="table table-bordered">
					<tr>               
					<th style="width: 20%">������Ŀ</th>
					<th style="width: 30%">��ʼ - ��������</th>
				
					<th style="width: 40%">��ע</th>
					</tr>
					
					<tr>
					<td>�����ĵ�����</td>
					<td>
					 
					 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptStoryDate" class="form-control pull-right" id="reservation">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					
					</td>
								  
	  
					<td>
					<div class="form-group">						 
					<textarea  name="rptStoryMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea>
					</div>
					</td>
					</tr>
				
					<tr>
					<td>��Ʊ�д����</td>
					<td> 
					
					 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptDesignDate" class="form-control pull-right" id="reservation1">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				
					
					<td>
					<div class="form-group">
					<textarea  name="rptDesignMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea> 
					</div>
					</td>
					</tr>
					
					<tr>
					<td>ִ�в�������</td>
					<td> 
					
					 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptExcDate" class="form-control pull-right" id="reservation2">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				

					<td>
					<div class="form-group">
					<textarea  name="rptExcMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea>
					</div>
					</td>
					</tr>
					
					<tr>
					<td>bug��֤�ع�</td>
					<td> 
					
				 <!-- Date range -->
					<div class="form-group">
						<label>Date range:</label>
						<div class="input-group">
							<div class="input-group-addon">
							<i class="fa fa-calendar"></i>
							</div>
							<input type="text" name="rptBugDate" class="form-control pull-right" id="reservation3">
						</div>
						<!-- /.input group -->
					</div> <!-- /.form group -->
					</td>
				
					
					<td>
					<div class="form-group"> 
					<textarea  name="rptBugMemo" class="form-control" rows="5" placeholder="Enter ..."></textarea>
					</div>
					</td>
					</tr>
					</table>
				</div>
			
				<div class="form-group">
				<label>1.6 ����</label>
				<textarea  name="rptCaption" class="form-control" rows="5" placeholder="Enter ...">���β������������Ҫ���úںв��Է��������ܲ��Բ��õ�������Ʒ����еȼ��໮�ַ����߽�ֵ���ַ�������²⡢ģ����ʵҵ�񳡾��ȡ�������������ֹ����ӿڡ����ɡ�ϵͳ���ԡ�</textarea>
				</div>
				
				<div class="form-group">
				<label>1.7 �ο�����</label>
				<textarea  name="rptRef" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
			</div> <!-- .col --> 	 
			</div>  <!-- .row -->    
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
        	<div class="col-xs-12">
			<% set rs1 = server.createobject("adodb.recordset")
			rs1.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
			do while not rs1.eof %>
				<div class="box-header">
				  <h3 class="box-title"><%=rs1("platformName")%></h3>
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th>����ID</th>
				<th>��ǩ</th>
				<th>��������</th>
				<th>���Զ���</th>
				<th>���Խ׶�</th>
				<th>���Խ��</th>
				</tr>
				</thead>
				<tbody>	  
				<% set rs2 = server.createobject("adodb.recordset")
				rs2.open "select * from tbl_case where case_pjtId="&pjtId&" and case_platformId="&platformId&" order by caseStage ,caseId asc",conn,3,3 
				do while not rs2.eof %>
					<tr>
					<td><a href="excTestcaseEdit.asp?caseId=<%=rs2("caseId")%>" target="_blank"><%=rs2("caseId")%></td>
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
			<div class="col-xs-12">
				<div class="box-header">
				<h3 class="box-title">3.1  ���Ը�����</h3>
				</div>
				<table id="example2" class="table table-bordered table-hover">
				<thead>
				<tr>
				<th>ƽ̨-��ǩ</th>
				<th>��������</th>
				<th>��ͨ����(s)</th>
				<th>δͨ����</th>
				<th>δ������(���ã�</th>
				<th>����ִ�и�����</th>
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
						<td><% if rs6.recordcount <> 0 then
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
						if varOkSum3 <> 0 then
						response.write varOkSum3
						end if %></td>
						<td><% if varErrorSum3 <> 0 then
						response.write varErrorSum3
						end if %></td>
						<td><% if varEmptySum3 <> 0 then
						response.write varEmptySum3
						end if %></td>
						<td><% 
						if rs6.recordcount <> 0 then
						response.write cstr(int((varOkSum3+varErrorSum3)/rs6.recordcount*100)) + "%"
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
			
			<div class="col-xs-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.2 ȱ��ƽ̨ͳ��</h3> <a href="<%=platformRedmine%>" target="_blank"> Redmine</i></a>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>ϵͳƽ̨</th>
					<th>Bug��</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>iOS</td>
					<td><div class="form-group">
					<input type="text" name="rptIbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>android</td>
					<td><div class="form-group">
					<input type="text" name="rptAbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>���ݿ�/�ӿ���</td>
					<td><div class="form-group">
					<input type="text" name="rptSbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>web php C/S</td>
					<td><div class="form-group">
					<input type="text" name="rptPbug" class="form-control" placeholder="����">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-xs-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.3 ȱ�����س̶�</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>���س̶�</th>
					<th>Bug��</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>����</td>
					<td><div class="form-group">
					<input type="text" name="rptJdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group">
					<input type="text" name="rptGdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>��ͨ</td>
					<td><div class="form-group">
					<input type="text" name="rptPdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>��</td>
					<td><div class="form-group">
					<input type="text" name="rptDdegree" class="form-control" placeholder="����">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->
			</div><!-- /.col -->
			
			<div class="col-xs-4">
          		<div class="box">
					<div class="box-header">
					<h3 class="box-title">3.4 ȱ��״̬ͳ��</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
					<table id="example2" class="table table-bordered table-hover">
					<thead>
					<tr>
					<th>ȱ��״̬</th>
					<th>Bug��</th>
					</tr>
					</thead>
					<tbody>
					<tr>
					<td>δ����(�½�)</td>
					<td><div class="form-group">
					<input type="text" name="rptWstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>������</td>
					<td><div class="form-group">
					<input type="text" name="rptCstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>�ѽ��</td>
					<td><div class="form-group">
					<input type="text" name="rptJstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					<tr>
					<td>�ѷ���</td>
					<td><div class="form-group">
					<input type="text" name="rptFstatus" class="form-control" placeholder="����">
					</div></td>
					</tr>
					</tbody>
					<tfoot>
					</tfoot>
					</table>
					</div> <!-- /.box-body -->
				</div><!-- /.box -->					
			</div><!-- /.col -->
			
			
			
			<div class="col-xs-12">
				<div class="form-group">
					<label>3.5 ����/����</label>
					<textarea  name="rptFeedback" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
				
				<div class="form-group">
					<label>3.6 ���Խ�����</label>
					<textarea  name="rptDelivery" class="form-control" rows="5" placeholder="Enter ...">1����������
2��Redmineȱ��
3�����Ա���
4�����Ի���ҵ�񳡾�¼���ļ������Ҳ���ʾ��</textarea>

				</div>
				
				<div class="form-group">
					<label>3.7 ����</label>
					<textarea  name="rptAdvice" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				</div>
			</div><!-- /.col -->
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
					<label>���Խ���</label>
					<textarea  name="rptConclusion" class="form-control" rows="6" placeholder="Enter ..."></textarea>
					</div>				
				</div>  <!-- /.col -->
			</div><!-- /.row -->
		</div> <!-- /.body -->
	</div><!-- /.box-default -->     
     
<button type="submit" class="btn btn-primary pull-right" style="margin-right: 5px;"  href="#"><i class="fa fa-angellist"></i> &nbsp;�ύ</button>
<br><br><br>
<input name="pjtId" type="hidden" value="<%=pjtId%>" />
<input name="platformId" type="hidden" value="<%=platformId%>" />
<input name="rptCreatedDate" type="hidden" value="<%=now%>" />


   
	</section><!-- ./col -->
	</form>
	
</div><!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Select2 -->
<script src="plugins/select2/select2.full.min.js"></script>
<!-- InputMask -->
<script src="plugins/input-mask/jquery.inputmask.js"></script>
<script src="plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="plugins/input-mask/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="plugins/iCheck/icheck.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>


<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();

  

    //Date range picker
    $('#reservation').daterangepicker();
	$('#reservation1').daterangepicker();
	$('#reservation2').daterangepicker();
	$('#reservation3').daterangepicker();
   
  });
</script>
</body>
</html>
