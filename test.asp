<!--#include file="md5.asp"-->
<!--#include file="conn.asp"-->
<!--#include file="common/constant.asp"-->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link rel="shortcut icon" href=" /favicon.ico" /> 
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<link rel="shortcut icon" href="/favicon.ico" /> 
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	
	<title><%=cstCompany%> | 登录</title>
	
    <!-- Compiled and minified CSS -->

	<link href="css/sideNav/materialize.min.css" type="text/css" rel="stylesheet" media="screen,projection">
	<style>
	.material-icons.md-14 { font-size: 14px; }
	</style>

	<!-- Compiled and minified CSS -->
	<link href="css/sideNav/ghpages-materialize123.css" type="text/css" rel="stylesheet" media="screen,projection">
    <link href="https://fonts.googleapis.com/css?family=Inconsolata" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

</head>

<!--  执行 测试用例	-->

<% 
if request("action")="submit" then  	
	dim caseId,case_lblId,caseStage,caseStatus,caseErrorType,caseProblem,caseMemo
	caseId = split(request("caseId"),",")
	case_lblId = split(request("case_lblId"),",")		
	caseStage = split(request("caseStage"),",")
	caseStatus = split(request("caseStatus"),",")
	caseErrorType = split(request("caseErrorType"),",")
	if request("caseProblem") = "" then
		caseProblemSign = "empty"
	else
		caseProblem = split(request("caseProblem"),",")
	end if 
	if request("caseMemo") = "" then
		caseMemoSign = "empty"
	else
		caseMemo = split(request("caseMemo"),",")
	end if 
		
	for i=0 to ubound(caseId)	
		set rs1 = server.CreateObject("ADODB.RecordSet")
		rs1.Open "select * from tbl_case where caseId="&int(caseId(i))&"",conn,3,3 
		response.write caseId(i) + "<br>"
		response.write case_lblId(i) + "<br>"
		rs1("case_lblId") = int(trim(case_lblId(i)))
		rs1("caseStage") = int(trim(caseStage(i)))
		rs1("caseStatus") = trim(caseStatus(i))
	
		caseObject = request("caseObject"&trim(caseId(i)))
		if instr(caseObject,",")>0 then	
			if caseObject = "1, 2" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = ""
			elseif caseObject= "1, 3" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = ""
				rs1("caseAndroid") = "on"
				rs1("caseCs") = ""
				rs1("caseDevice") = ""
			elseif caseObject= "1, 4" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = ""
				rs1("caseAndroid") = ""
				rs1("caseCs") = "on"
				rs1("caseDevice") = ""
			elseif caseObject= "1, 5" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = ""
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = "on"
			elseif caseObject= "2, 3" then
				rs1("caseWeb") = ""
				rs1("caseIos") = "on"
				rs1("caseAndroid") = "on"
				rs1("caseCs") = ""
				rs1("caseDevice") = ""
			elseif caseObject= "2, 4" then
				rs1("caseWeb") = ""
				rs1("caseIos") = "on"
				rs1("caseAndroid") = ""
				rs1("caseCs") = "on"
				rs1("caseDevice") = ""							
			elseif caseObject= "2, 5" then
				rs1("caseWeb") = ""
				rs1("caseIos") = "on"
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = "on"	
			elseif caseObject= "3, 4" then
				rs1("caseWeb") = ""
				rs1("caseIos") = ""
				rs1("caseAndroid") = "on"
				rs1("caseCs") = "on"
				rs1("caseDevice") = ""	
			elseif caseObject= "3, 5" then
				rs1("caseWeb") = ""
				rs1("caseIos") = ""
				rs1("caseAndroid") = "on"
				rs1("caseCs") = ""
				rs1("caseDevice") = "on"	
			elseif caseObject= "4, 5" then
				rs1("caseWeb") = ""
				rs1("caseIos") = ""
				rs1("caseAndroid") = ""
				rs1("caseCs") = "on"
				rs1("caseDevice") = "on"	
			elseif caseObject= "1, 2, 3" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = "on"
				rs1("caseCs") = ""
				rs1("caseDevice") = ""	
			elseif caseObject= "1, 2, 4" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = ""
				rs1("caseCs") = "on"
				rs1("caseDevice") = ""	
			elseif caseObject= "1, 2, 5" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = "on"	
			elseif caseObject= "1, 2, 3, 4" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = "on"
				rs1("caseCs") = "on"
				rs1("caseDevice") = ""	
			elseif caseObject= "1, 2, 3, 5" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = "on"
				rs1("caseCs") = ""
				rs1("caseDevice") = "on"	
			elseif caseObject= "1, 2, 3, 4, 5" then
				rs1("caseWeb") = "on"
				rs1("caseIos") = "on"
				rs1("caseAndroid") = "on"
				rs1("caseCs") = "on"
				rs1("caseDevice") = "on"																															
			end if 
		
		else
			if int(caseObject) = 1 then
				rs1("caseWeb") = "on"
				rs1("caseIos") = ""
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = ""
			elseif int(caseObject) = 2 then
				rs1("caseWeb") = ""
				rs1("caseIos") = "on"
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = ""
			elseif int(caseObject) = 3 then
				rs1("caseWeb") = ""
				rs1("caseIos") = ""
				rs1("caseAndroid") = "on"
				rs1("caseCs") = ""
				rs1("caseDevice") = ""
			elseif int(caseObject) = 4 then
				rs1("caseWeb") = ""
				rs1("caseIos") = ""
				rs1("caseAndroid") = ""
				rs1("caseCs") = "on"
				rs1("caseDevice") = ""
			elseif int(caseObject) = 5 then
				rs1("caseWeb") = ""
				rs1("caseIos") = ""
				rs1("caseAndroid") = ""
				rs1("caseCs") = ""
				rs1("caseDevice") = "on"
			end if 
		end if 
		
		rs1("caseStep") = request("caseStep"&trim(caseId(i)))
		rs1("caseWebResult") = request("caseWeb"&trim(caseId(i)))
		rs1("caseIosResult") = request("caseIos"&trim(caseId(i)))
		rs1("caseAndroidResult") = request("caseAndroid"&trim(caseId(i)))
		rs1("caseCSResult") = request("caseCS"&trim(caseId(i)))
		rs1("caseDeviceResult") = request("caseDevice"&trim(caseId(i)))
		rs1("caseErrorType") = caseErrorType(i)	
		if caseProblemSign = "empty" then
			rs1("caseProblem") = ""
		else
			rs1("caseProblem") = trim(caseProblem(i))
		end if 
		if caseMemoSign = "empty" then
			rs1("caseMemo") = ""
		else
			rs1("caseMemo") = trim(caseMemo(i))
		end if 
		rs1("caseExcDate") = now	
		rs1("caseExcUser") = session("userName")
		rs1.update
	
		pjtId = rs1("case_pjtId")
		platformId = rs1("case_platformId")
		lblId = rs1("case_lblId")
		caseStage123 = rs1("caseStage")
	
		rs1.close
		set rs1 = nothing  
	
	next 

	response.Redirect("test.asp?pjtId="&pjtId&"&platformId="&platformId&"&lblId="&lblId&"&caseStage="&caseStage123&"")
 end if %>
 
 
 

<%
pjtId = request("pjtId")
platformId = request("platformId")
lblId = request("lblId")
caseStage = request("caseStage")

Set rs = Server.CreateObject("Adodb.Recordset")
rs.Open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3 
%>

<body>

<ul id="slide-out" class="sidenav">	
	<div class="col s12 m8 offset-m1 xl7 offset-xl1">
		<ul class="tabs tabs-fixed-width tab-demo z-depth-1">
		
		<!-- 遍历标签（默认定位到最近一次编辑过的标签） -->
			<%Set rs3 = Server.CreateObject("Adodb.Recordset")
			rs3.Open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3
			do while not rs3.eof
				if rs3("lblId") = int(lblId) then%>			
					<li class="tab"><a class="active" href="#test<%=rs3("lblId")%>"><%=rs3("lblName")%></a></li>
				<%else%>
					<li class="tab"><a href="#test<%=rs3("lblId")%>"><%=rs3("lblName")%></a></li>					
				<%end if %>
			<%rs3.movenext
			loop
			rs3.close
			%>
		</ul>


		<!-- 遍历标签下3个测试环境 -->
    	<%Set rs3 = Server.CreateObject("Adodb.Recordset")
		rs3.Open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&" order by lblId asc",conn,3,3
		do while not rs3.eof %>
			<div id="test<%=rs3("lblId")%>" class="col s12 m8 offset-m1 xl7 offset-xl1">
				<ul class="tabs tabs-fixed-width tab-demo z-depth-1">
				<li class="tab"><a class="active" href="#test<%=rs3("lblId")%>1">冒烟测试</a></li>
				<li class="tab"><a href="#test<%=rs3("lblId")%>2">正式测试</a></li>
				<li class="tab"><a href="#test<%=rs3("lblId")%>3">回归测试</a></li>
				</ul>
				
      
				<!-- 遍历冒烟测试下用例 -->
				<form role="form" action="test.asp?action=submit" method="post">
				<div id="test<%=rs3("lblId")%>1" class="col s12">
					<ul class="collapsible" data-collapsible="accordion">						
						<%set rs6 = server.createobject("adodb.recordset")
						rs6.open "select * from tbl_case where caseStage=1 and case_lblId="&rs3("lblId")&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3						
						if not rs6.eof then 					
							do while not rs6.eof%>
								<li>
							    <div class="collapsible-header">
									<%if rs6("caseStatus")=2 then
											response.write "<i class='material-icons md-light'>pause_circle_outline</i>"
										elseif rs6("caseStatus")=3 then
											response.write "<i class='material-icons md-light'>cancel</i>"
										else
											response.write "<i class='material-icons md-light green-text'>check_circle</i>"  
										end if 	
									%>
									<%=rs6("caseId")%>，<%=rs6("caseTitle")%>
									<%
									
										if rs6("caseWebResult") = "ng" then 
											response.write "<i class='material-icons red-text'>format_bold</i>"
										elseif rs6("caseWebResult") = "pass" then 
											response.write "<i class='material-icons green-text'>format_bold</i>"
										end if 
										
										if rs6("caseIosResult") = "ng" then 
											response.write "<i class='material-icons red-text'>phone_iphone</i>"
										elseif rs6("caseIosResult") = "pass" then 
											response.write "<i class='material-icons green-text'>phone_iphone</i>"
										end if 
										
										if rs6("caseAndroidResult") = "ng" then
											response.write "<i class='material-icons red-text'>android</i>"
										elseif rs6("caseAndroidResult") = "pass" then 
										  response.write "<i class='material-icons green-text'>android</i>"
										end if
										
										if rs6("caseCSResult") = "ng" then 
											response.write "<i class='material-icons red-text'>copyright</i>"
										elseif rs6("caseCSResult") = "pass" then 
											response.write "<i class='material-icons green-text'>copyright</i>"
										end if
										
										if rs6("caseDeviceResult") = "ng" then 
											response.write "<i class='material-icons red-text'>devices_other</i>"
										elseif rs6("caseDeviceResult") = "pass" then 
											response.write "<i class='material-icons green-text'>devices_other</i>"
										end if
									%>	
								</div>
								<div class="collapsible-body">
								<%								
									pjtId = rs6("case_pjtId")
									platformId = rs6("case_platformId")
									lblId = rs6("case_lblId")
								%>							    																								  				 		 	 
								<div class="row">
									<!-- 用例标签 -->
									 <div class="input-field col s4">
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&"",conn,3,3 %>
										<select name="case_lblId" id="case_lblId" class="form-control select2">
										<% do while not rs66.eof
											if rs66("lblId") = lblId then%>
											<option value="<%=rs66("lblId")%>" selected><%=rs66("lblName")%></option>
											<%else%>
											<option value="<%=rs66("lblId")%>" ><%=rs66("lblName")%></option>
											<%end if 
										rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>
										<label>用例标签</label>										
									</div>								
									
									<!-- 测试阶段 -->
									 <div class="input-field col s4">
										<select name="caseStage">
										  <option value=1 selected>冒烟测试</option>
										  <option value=2>正式测试</option>
										  <option value=3>回归测试</option>
										</select>
										<label>测试阶段</label>
									</div>
								
									<!-- 用例状态 -->
									 <div class="input-field col s4">
										<select name="caseStatus">									
										   <%if rs6("caseStatus") = "1" then%>
											<option value="1" selected="selected">正常</option>
											<option value="2">暂停</option>
											<option value="3">搁置（长期）</option>
										  <% elseif rs6("caseStatus") = "2" then%>
											 <option value="2" selected="selected">暂停</option>
											<option value="1">正常</option>
											<option value="3">搁置（长期）</option>
										  <% else%>
											<option value="3" selected="selected">搁置</option>
											<option value="1">正常</option>
											<option value="2">暂停</option>	
											<%end if %>
										</select>
										<label>用例状态</label>
									</div>
									
																								
								</div>  <!-- row.end-->
							  
  								<!-- 用例步骤 + 附图 -->  
								<div class="row">
								<div class="input-field col s12">								
									<textarea id="caseStep" class="materialize-textarea" name="caseStep<%=rs6("caseId")%>"><%=rs6("caseStep")%></textarea>
									<label>用例步骤</label>
								</div>
								</div>
								<div class="row">								
									<%if rs6("caseImg") <> "" then
										 if instr(rs6("caseImg"),",") > 0 then
											mystr = split(rs6("caseImg"),",")																				
											for i=0 to ubound(mystr)%>
												<div class="col s6">
												图<%=i+1%>：<img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" width="150" src="/images/case/<%=mystr(i)%>">										
												</div>
											<%next
										 else%>
											 <div class="col s12">
												图1：<img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" width="150" src="/images/case/<%=rs6("caseImg")%>">									
											</div>
										<%end if 
									end if %>
								</div>
								
															
   							    <div class="row">
									<!-- 需求问题类型 -->
									<div class="input-field col s6">
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_errortype ",conn,3,3 %>
										<select name="caseErrorType" id="caseErrorType" class="form-control select2">
										<option value=0  selected="selected">无</option>
										<% do while not rs66.eof%>
											<% if rs6("caseErrorType") = rs66("errorId") then %>
												<option value=<%=rs66("errorId")%> selected="selected"><%=rs66("errorName")%></option>
											<%else%>
												<option value="<%=rs66("errorId")%>" ><%=rs66("errorName")%></option>
											<%end if %>
										<%rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>
										<label>需求问题类型</label>
									</div>
									
									<!-- 需求问题 -->		
									<div class="input-field col s6">
										<textarea id="caseProblem" class="materialize-textarea" name="caseProblem"><%=rs6("caseProblem")%></textarea>
										<label for="caseProblem">需求问题描述</label>
									</div>																		 
							    </div>	  <!-- row.end-->
								 
								<!-- 缺陷描述 -->								
								<div class="row">
								<!-- 测试对象 -->	
								    <div class="input-field col s6">
										<select multiple name="caseObject<%=rs6("caseId")%>">
										  <option value="" disabled >Choose</option>
										  <%if rs6("caseWeb") = "on" then%>
											  <option value="1" selected>B/S</option>
										  <%else%>
	  										  <option value="1">B/S</option>
										  <%end if%>
										   <%if rs6("caseIos") = "on" then%>
											  <option value="2" selected>iOS</option>
										  <%else%>
	  										  <option value="2">iOS</option>
										  <%end if%>
										   <%if rs6("caseAndroid") = "on" then%>
											  <option value="3" selected>android</option>
										  <%else%>
	  										  <option value="3">android</option>
										  <%end if%>
										   <%if rs6("caseCS") = "on" then%>
											  <option value="4" selected>C/S</option>
										  <%else%>
	  										  <option value="4">C/S</option>
										  <%end if%>
										   <%if rs6("caseDevice") = "on" then%>
											  <option value="5" selected>其他</option>
										  <%else%>
	  										  <option value="5">其他</option>
										  <%end if%>
									
										</select>
										<label>测试对象</label>
								    </div>	
									
									<div class="input-field col s6">
										<textarea id="caseMemo" class="materialize-textarea" name="caseMemo"><%=rs6("caseMemo")%></textarea>
									    <label for="caseMemo">缺陷描述</label>
									</div>
								</div>
  
						
	  							<!-- 测试结果 -->	
								<label>测试结果</label>
								<table><thead><tr>
								<% if rs6("caseWeb") = "on" then%>
									<th>B/S</th>
								<%end if %>
								<% if rs6("caseIos") = "on" then%>
									<th>iOS</th>
								<%end if %>
								<% if rs6("caseAndroid") = "on" then%>
									<th>android</th>
								<%end if %>
								<% if rs6("caseCS") = "on" then%>
									<th>C/S</th>
								<%end if %>
								<% if rs6("caseDevice") = "on" then%>
									<th>其他</th>
								<%end if %>
								</tr></thead><tbody>
								<tr>
								
								<% if rs6("caseWeb") = "on" then%>
								<td><%if rs6("caseWebResult") = "" then%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseWebResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="" /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
								</td>
								<%end if %>
	
								
								<% if rs6("caseIos") = "on" then%>
								<td><%if rs6("caseIosResult") = "" then%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseIosResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
								
								
								<% if rs6("caseAndroid") = "on" then%>
								<td><%if rs6("caseAndroidResult") = "" then%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseAndroidResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>

								<% if rs6("caseCS") = "on" then%>
								<td><%if rs6("caseCSResult") = "" then%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseCSResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
							

								<% if rs6("caseDevice") = "on" then%>
								<td><%if rs6("caseDeviceResult") = "" then%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseDeviceResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
								
								</tr>						
								</tbody></table>
								
								<input name="caseId" type="hidden" value="<%=rs6("caseId")%>" />

								<!-- 提交 -->
								<br>
								<div align="center">
									<button class="btn" type="submit" name="action">提交

									</button>		
								</div>
								
						   		</div> <!-- collapsible-body .end-->
								</li>					
							<%rs6.movenext
							loop
						end if 
						rs6.close%>
				  </ul>				
			  </div>
			  </form>
			
			  
			  
			  
			  
			  <!-- 遍历正式测试下用例 -->	
			  		<form role="form2" action="test.asp?action=submit" method="post">			
				<div id="test<%=rs3("lblId")%>2" class="col s12">
					<ul class="collapsible" data-collapsible="accordion">						
						<%set rs6 = server.createobject("adodb.recordset")
						rs6.open "select * from tbl_case where caseStage=2 and case_lblId="&rs3("lblId")&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
						if not rs6.eof then 					
							do while not rs6.eof%>
							<li>
							    <div class="collapsible-header">
									<%if rs6("caseStatus")=2 then
											response.write "<i class='material-icons md-light'>pause_circle_outline</i>"
										elseif rs6("caseStatus")=3 then
											response.write "<i class='material-icons md-light'>cancel</i>"
										else
											response.write "<i class='material-icons md-light green-text'>check_circle</i>"  
										end if 	
									%>
									<%=rs6("caseId")%>，<%=rs6("caseTitle")%>
									<%
									
										if rs6("caseWebResult") = "ng" then 
											response.write "<i class='material-icons red-text'>format_bold</i>"
										elseif rs6("caseWebResult") = "pass" then 
											response.write "<i class='material-icons green-text'>format_bold</i>"
										end if 
										
										if rs6("caseIosResult") = "ng" then 
											response.write "<i class='material-icons red-text'>phone_iphone</i>"
										elseif rs6("caseIosResult") = "pass" then 
											response.write "<i class='material-icons green-text'>phone_iphone</i>"
										end if 
										
										if rs6("caseAndroidResult") = "ng" then
											response.write "<i class='material-icons red-text'>android</i>"
										elseif rs6("caseAndroidResult") = "pass" then 
										  response.write "<i class='material-icons green-text'>android</i>"
										end if
										
										if rs6("caseCSResult") = "ng" then 
											response.write "<i class='material-icons red-text'>copyright</i>"
										elseif rs6("caseCSResult") = "pass" then 
											response.write "<i class='material-icons green-text'>copyright</i>"
										end if
										
										if rs6("caseDeviceResult") = "ng" then 
											response.write "<i class='material-icons red-text'>devices_other</i>"
										elseif rs6("caseDeviceResult") = "pass" then 
											response.write "<i class='material-icons green-text'>devices_other</i>"
										end if
									%>
									</div>
								<div class="collapsible-body">
								<%								
									pjtId = rs6("case_pjtId")
									platformId = rs6("case_platformId")
									lblId = rs6("case_lblId")
								%>							    																								  				 		 	 
								<div class="row">
									<!-- 用例标签 -->
									 <div class="input-field col s4">
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&"",conn,3,3 %>
										<select name="case_lblId" id="case_lblId" class="form-control select2">
										<% do while not rs66.eof
											if rs66("lblId") = lblId then%>
											<option value="<%=rs66("lblId")%>" selected><%=rs66("lblName")%></option>
											<%else%>
											<option value="<%=rs66("lblId")%>" ><%=rs66("lblName")%></option>
											<%end if 
										rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>
										<label>用例标签</label>										
									</div>								
									
									<!-- 测试阶段 -->
									 <div class="input-field col s4">
										<select name="caseStage">
										  <option value=1>冒烟测试</option>
										  <option value=2 selected>正式测试</option>
										  <option value=3>回归测试</option>
										</select>
										<label>测试阶段</label>
									</div>
								
									<!-- 用例状态 -->
									 <div class="input-field col s4">
										<select name="caseStatus">									
										   <%if rs6("caseStatus") = "1" then%>
											<option value="1" selected="selected">正常</option>
											<option value="2">暂停</option>
											<option value="3">搁置（长期）</option>
										  <% elseif rs6("caseStatus") = "2" then%>
											 <option value="2" selected="selected">暂停</option>
											<option value="1">正常</option>
											<option value="3">搁置（长期）</option>
										  <% else%>
											<option value="3" selected="selected">搁置</option>
											<option value="1">正常</option>
											<option value="2">暂停</option>	
											<%end if %>
										</select>
										<label>用例状态</label>
									</div>
									
																								
								</div>  <!-- row.end-->
							  
  								<!-- 用例步骤 + 附图 -->  
								<div class="row">
								<div class="input-field col s12">								
									<textarea id="caseStep" class="materialize-textarea" name="caseStep<%=rs6("caseId")%>"><%=rs6("caseStep")%></textarea>
									<label>用例步骤</label>
								</div>
								</div>
								<div class="row">								
									<%if rs6("caseImg") <> "" then
										 if instr(rs6("caseImg"),",") > 0 then
											mystr = split(rs6("caseImg"),",")																				
											for i=0 to ubound(mystr)%>
												<div class="col s6">
												图<%=i+1%>：<img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" width="150" src="/images/case/<%=mystr(i)%>">										
												</div>
											<%next
										 else%>
											 <div class="col s12">
												图1：<img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" width="150" src="/images/case/<%=rs6("caseImg")%>">									
											</div>
										<%end if 
									end if %>
								</div>
								
															
   							    <div class="row">
									<!-- 需求问题类型 -->
									<div class="input-field col s6">
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_errortype ",conn,3,3 %>
										<select name="caseErrorType" id="caseErrorType" class="form-control select2">
										<option value=0  selected="selected">无</option>
										<% do while not rs66.eof%>
											<% if rs6("caseErrorType") = rs66("errorId") then %>
												<option value=<%=rs66("errorId")%> selected="selected"><%=rs66("errorName")%></option>
											<%else%>
												<option value="<%=rs66("errorId")%>" ><%=rs66("errorName")%></option>
											<%end if %>
										<%rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>
										<label>需求问题类型</label>
									</div>
									
									<!-- 需求问题 -->		
									<div class="input-field col s6">
										<textarea id="caseProblem" class="materialize-textarea" name="caseProblem"><%=rs6("caseProblem")%></textarea>
										<label for="caseProblem">需求问题描述</label>
									</div>																		 
							    </div>	  <!-- row.end-->
								 
								<!-- 缺陷描述 -->								
								<div class="row">
								<!-- 测试对象 -->	
								    <div class="input-field col s6">
										<select multiple name="caseObject<%=rs6("caseId")%>">
										  <option value="" disabled >Choose</option>
										  <%if rs6("caseWeb") = "on" then%>
											  <option value="1" selected>B/S</option>
										  <%else%>
	  										  <option value="1">B/S</option>
										  <%end if%>
										   <%if rs6("caseIos") = "on" then%>
											  <option value="2" selected>iOS</option>
										  <%else%>
	  										  <option value="2">iOS</option>
										  <%end if%>
										   <%if rs6("caseAndroid") = "on" then%>
											  <option value="3" selected>android</option>
										  <%else%>
	  										  <option value="3">android</option>
										  <%end if%>
										   <%if rs6("caseCS") = "on" then%>
											  <option value="4" selected>C/S</option>
										  <%else%>
	  										  <option value="4">C/S</option>
										  <%end if%>
										   <%if rs6("caseDevice") = "on" then%>
											  <option value="5" selected>其他</option>
										  <%else%>
	  										  <option value="5">其他</option>
										  <%end if%>
									
										</select>
										<label>测试对象</label>
								    </div>	
									
									<div class="input-field col s6">
										<textarea id="caseMemo" class="materialize-textarea" name="caseMemo"><%=rs6("caseMemo")%></textarea>
									    <label for="caseMemo">缺陷描述</label>
									</div>
								</div>
  
						
	  							<!-- 测试结果 -->	
								<label>测试结果</label>
								<table><thead><tr>
								<% if rs6("caseWeb") = "on" then%>
									<th>B/S</th>
								<%end if %>
								<% if rs6("caseIos") = "on" then%>
									<th>iOS</th>
								<%end if %>
								<% if rs6("caseAndroid") = "on" then%>
									<th>android</th>
								<%end if %>
								<% if rs6("caseCS") = "on" then%>
									<th>C/S</th>
								<%end if %>
								<% if rs6("caseDevice") = "on" then%>
									<th>其他</th>
								<%end if %>
								</tr></thead><tbody>
								<tr>
								
								<% if rs6("caseWeb") = "on" then%>
								<td><%if rs6("caseWebResult") = "" then%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseWebResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="" /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
								</td>
								<%end if %>
	
								
								<% if rs6("caseIos") = "on" then%>
								<td><%if rs6("caseIosResult") = "" then%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseIosResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
								
								
								<% if rs6("caseAndroid") = "on" then%>
								<td><%if rs6("caseAndroidResult") = "" then%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseAndroidResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>

								<% if rs6("caseCS") = "on" then%>
								<td><%if rs6("caseCSResult") = "" then%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseCSResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
							

								<% if rs6("caseDevice") = "on" then%>
								<td><%if rs6("caseDeviceResult") = "" then%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseDeviceResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
								
								</tr>						
								</tbody></table>
								
								<input name="caseId" type="hidden" value="<%=rs6("caseId")%>" />

								<!-- 提交 -->
								<br>
								<div align="center">
									<button class="btn" type="submit" name="action">提交

									</button>		
								</div>
								
						   		</div> <!-- collapsible-body .end-->
								</li>										
							<%rs6.movenext
							loop
						end if 
						rs6.close%>
					</ul>			
				</div>
				</form>
				
				
				<!-- 遍历回归测试下用例 -->		
		  		<form role="form3" action="test.asp?action=submit" method="post">			
		
				<div id="test<%=rs3("lblId")%>3" class="col s12">
					<ul class="collapsible" data-collapsible="accordion">						
						<%set rs6 = server.createobject("adodb.recordset")
						rs6.open "select * from tbl_case where caseStage=3 and case_lblId="&rs3("lblId")&" and caseCreateUser='"&session("userName")&"' order by caseId desc",conn,3,3
						if not rs6.eof then 					
							do while not rs6.eof%>
								<li>
							    <div class="collapsible-header">
									<%if rs6("caseStatus")=2 then
											response.write "<i class='material-icons md-light'>pause_circle_outline</i>"
										elseif rs6("caseStatus")=3 then
											response.write "<i class='material-icons md-light'>cancel</i>"
										else
											response.write "<i class='material-icons md-light green-text'>check_circle</i>"  
										end if 	
									%>
									<%=rs6("caseId")%>，<%=rs6("caseTitle")%>
									<%
									
										if rs6("caseWebResult") = "ng" then 
											response.write "<i class='material-icons red-text'>format_bold</i>"
										elseif rs6("caseWebResult") = "pass" then 
											response.write "<i class='material-icons green-text'>format_bold</i>"
										end if 
										
										if rs6("caseIosResult") = "ng" then 
											response.write "<i class='material-icons red-text'>phone_iphone</i>"
										elseif rs6("caseIosResult") = "pass" then 
											response.write "<i class='material-icons green-text'>phone_iphone</i>"
										end if 
										
										if rs6("caseAndroidResult") = "ng" then
											response.write "<i class='material-icons red-text'>android</i>"
										elseif rs6("caseAndroidResult") = "pass" then 
										  response.write "<i class='material-icons green-text'>android</i>"
										end if
										
										if rs6("caseCSResult") = "ng" then 
											response.write "<i class='material-icons red-text'>copyright</i>"
										elseif rs6("caseCSResult") = "pass" then 
											response.write "<i class='material-icons green-text'>copyright</i>"
										end if
										
										if rs6("caseDeviceResult") = "ng" then 
											response.write "<i class='material-icons red-text'>devices_other</i>"
										elseif rs6("caseDeviceResult") = "pass" then 
											response.write "<i class='material-icons green-text'>devices_other</i>"
										end if
									%>
								</div>
								<div class="collapsible-body">
								<%								
									pjtId = rs6("case_pjtId")
									platformId = rs6("case_platformId")
									lblId = rs6("case_lblId")
								%>							    																								  				 		 	 
								<div class="row">
									<!-- 用例标签 -->
									 <div class="input-field col s4">
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_label where lbl_pjtId="&pjtId&" and lbl_platformId="&platformId&"",conn,3,3 %>
										<select name="case_lblId" id="case_lblId" class="form-control select2">
										<% do while not rs66.eof
											if rs66("lblId") = lblId then%>
											<option value="<%=rs66("lblId")%>" selected><%=rs66("lblName")%></option>
											<%else%>
											<option value="<%=rs66("lblId")%>" ><%=rs66("lblName")%></option>
											<%end if 
										rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>
										<label>用例标签</label>										
									</div>								
									
									<!-- 测试阶段 -->
									 <div class="input-field col s4">
										<select name="caseStage">
										  <option value=1>冒烟测试</option>
										  <option value=2 >正式测试</option>
										  <option value=3 selected>回归测试</option>
										</select>
										<label>测试阶段</label>
									</div>
								
									<!-- 用例状态 -->
									 <div class="input-field col s4">
										<select name="caseStatus">									
										   <%if rs6("caseStatus") = "1" then%>
											<option value="1" selected="selected">正常</option>
											<option value="2">暂停</option>
											<option value="3">搁置（长期）</option>
										  <% elseif rs6("caseStatus") = "2" then%>
											 <option value="2" selected="selected">暂停</option>
											<option value="1">正常</option>
											<option value="3">搁置（长期）</option>
										  <% else%>
											<option value="3" selected="selected">搁置</option>
											<option value="1">正常</option>
											<option value="2">暂停</option>	
											<%end if %>
										</select>
										<label>用例状态</label>
									</div>
									
																								
								</div>  <!-- row.end-->
							  
  								<!-- 用例步骤 + 附图 -->  
								<div class="row">
								<div class="input-field col s12">								
									<textarea id="caseStep" class="materialize-textarea" name="caseStep<%=rs6("caseId")%>"><%=rs6("caseStep")%></textarea>
									<label>用例步骤</label>
								</div>
								</div>
								<div class="row">								
									<%if rs6("caseImg") <> "" then
										 if instr(rs6("caseImg"),",") > 0 then
											mystr = split(rs6("caseImg"),",")																				
											for i=0 to ubound(mystr)%>
												<div class="col s6">
												图<%=i+1%>：<img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" width="150" src="/images/case/<%=mystr(i)%>">										
												</div>
											<%next
										 else%>
											 <div class="col s12">
												图1：<img class="materialboxed" data-caption="A picture of a way with a group of trees in a park" width="150" src="/images/case/<%=rs6("caseImg")%>">									
											</div>
										<%end if 
									end if %>
								</div>
								
															
   							    <div class="row">
									<!-- 需求问题类型 -->
									<div class="input-field col s6">
										<% set rs66 = server.createobject("adodb.recordset")
										rs66.open "select * from tbl_errortype ",conn,3,3 %>
										<select name="caseErrorType" id="caseErrorType" class="form-control select2">
										<option value=0  selected="selected">无</option>
										<% do while not rs66.eof%>
											<% if rs6("caseErrorType") = rs66("errorId") then %>
												<option value=<%=rs66("errorId")%> selected="selected"><%=rs66("errorName")%></option>
											<%else%>
												<option value="<%=rs66("errorId")%>" ><%=rs66("errorName")%></option>
											<%end if %>
										<%rs66.movenext
										loop
										rs66.close
										set rs66 = nothing %>
										</select>
										<label>需求问题类型</label>
									</div>
									
									<!-- 需求问题 -->		
									<div class="input-field col s6">
										<textarea id="caseProblem" class="materialize-textarea" name="caseProblem"><%=rs6("caseProblem")%></textarea>
										<label for="caseProblem">需求问题描述</label>
									</div>																		 
							    </div>	  <!-- row.end-->
								 
								<!-- 缺陷描述 -->								
								<div class="row">
								<!-- 测试对象 -->	
								    <div class="input-field col s6">
										<select multiple name="caseObject<%=rs6("caseId")%>">
										  <option value="" disabled >Choose</option>
										  <%if rs6("caseWeb") = "on" then%>
											  <option value="1" selected>B/S</option>
										  <%else%>
	  										  <option value="1">B/S</option>
										  <%end if%>
										   <%if rs6("caseIos") = "on" then%>
											  <option value="2" selected>iOS</option>
										  <%else%>
	  										  <option value="2">iOS</option>
										  <%end if%>
										   <%if rs6("caseAndroid") = "on" then%>
											  <option value="3" selected>android</option>
										  <%else%>
	  										  <option value="3">android</option>
										  <%end if%>
										   <%if rs6("caseCS") = "on" then%>
											  <option value="4" selected>C/S</option>
										  <%else%>
	  										  <option value="4">C/S</option>
										  <%end if%>
										   <%if rs6("caseDevice") = "on" then%>
											  <option value="5" selected>其他</option>
										  <%else%>
	  										  <option value="5">其他</option>
										  <%end if%>
									
										</select>
										<label>测试对象</label>
								    </div>	
									
									<div class="input-field col s6">
										<textarea id="caseMemo" class="materialize-textarea" name="caseMemo"><%=rs6("caseMemo")%></textarea>
									    <label for="caseMemo">缺陷描述</label>
									</div>
								</div>
  
						
	  							<!-- 测试结果 -->	
								<label>测试结果</label>
								<table><thead><tr>
								<% if rs6("caseWeb") = "on" then%>
									<th>B/S</th>
								<%end if %>
								<% if rs6("caseIos") = "on" then%>
									<th>iOS</th>
								<%end if %>
								<% if rs6("caseAndroid") = "on" then%>
									<th>android</th>
								<%end if %>
								<% if rs6("caseCS") = "on" then%>
									<th>C/S</th>
								<%end if %>
								<% if rs6("caseDevice") = "on" then%>
									<th>其他</th>
								<%end if %>
								</tr></thead><tbody>
								<tr>
								
								<% if rs6("caseWeb") = "on" then%>
								<td><%if rs6("caseWebResult") = "" then%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseWebResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="" /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseWeb<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
								</td>
								<%end if %>
	
								
								<% if rs6("caseIos") = "on" then%>
								<td><%if rs6("caseIosResult") = "" then%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseIosResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseIos<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
								
								
								<% if rs6("caseAndroid") = "on" then%>
								<td><%if rs6("caseAndroidResult") = "" then%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseAndroidResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseAndroid<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>

								<% if rs6("caseCS") = "on" then%>
								<td><%if rs6("caseCSResult") = "" then%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseCSResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseCS<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
							

								<% if rs6("caseDevice") = "on" then%>
								<td><%if rs6("caseDeviceResult") = "" then%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value="" checked /><span>无</span></label></p>
									<%elseif rs6("caseDeviceResult") = "pass" then%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" checked /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value=""  /><span>无</span></label></p>
									<%else%>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="pass" /><span>OK</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio"  value="ng" checked /><span>N/G</span></label></p>
										<p><label><input class="with-gap" name="caseDevice<%=rs6("caseId")%>" type="radio" value="" /><span>无</span></label></p>
									<%end if %>
 								</td>
								<%end if %>
								
								</tr>						
								</tbody></table>
								
								<input name="caseId" type="hidden" value="<%=rs6("caseId")%>" />

								<!-- 提交 -->
								<br>
								<div align="center">
									<button class="btn" type="submit" name="action">提交

									</button>		
								</div>
								
						   		</div> <!-- collapsible-body .end-->
								</li>					
							<%rs6.movenext
							loop
						end if 
						rs6.close%>
					</ul>
				</div>
			</div>
			</form>
			
		<%rs3.movenext
		loop
		rs3.close
		%>
		

	</div>
</ul>


<div class="content">
	<div class="row">
<form action="test.asp?action=url" method="post" >	

		<div class="col-lg-6">	
		
			<input name="url" type="text" class="form-control" id="url" aria-describedby="url" placeholder="http://" value="<%=rs("pjtURL")%>">
			<input type="hidden" name="pjtId" value="<%=pjtId%>">
		
		</div>


    

<% if request("action")="url" then %>
	<div class="col-lg-3">
		<a href="#" data-target="slide-out" class="sidenav-trigger btn" >测试用例</a>
	</div>
	<%
		url = request("url")
		if instr(url,"http://")>0 or instr(url,"https://")>0 then %>
			<iframe src="<%=url%>" frameborder="0" width="100%" height="100%"></iframe>		
		<%else%>
			<iframe src="http://<%=url%>" frameborder="0" width="100%" height="100%"></iframe>		
		<%end if %>


<%else%>
	<div class="col-md-3">
		<a href="#" data-target="slide-out" class="sidenav-trigger btn" >测试用例</a>
	</div>
	<iframe src="<%=rs("pjtURL")%>" frameborder="0" width="100%" height="100%"></iframe>

<%end if%>
	</form>		
	</div>
</div>

<%rs.close
set rs = nothing%>
			
<!--  side nav-->
<script src="css/sideNav/jquery-3.2.1.min.js"></script>
<script src="css/sideNav/materialize.js"></script>
<script src="css/sideNav/init.js"></script>


</body>
</html>
