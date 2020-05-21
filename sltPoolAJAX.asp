<%@ LANGUAGE="VBScript"%> 

<%
dim conn,connstr,i,sql,rs,str
'on error resume next
response.Charset = "utf-8"
Connstr="provider=microsoft.jet.oledb.4.0;data source=" & server.mappath("/database/testcase.mdb")
Set Conn=Server.CreateObject("ADODB.Connection") 
conn.Open connstr

strPoolId = request("poolId")
arr_str=split(strPoolId,",")
varSuccess = 0

if request("action") = "refuse" then

	for i=0 to ubound(arr_str)
		varSuccess = varSuccess + 1
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_casepool where poolId="&cint(arr_str(i))&" order by poolId DESC" ,conn,3,3
		rs("poolAudit") = "2"
		rs("poolSort") = "2"
		rs.update
		rs.close
	next

	' 返回
	if varSuccess = 0  then
		response.write "<img src='icon_fail.png' width='49' height='49' />"
		response.write "<h3>"
		response.write "未审核"
		response.write "</h3>"
		response.write " 请勾选用例复选框!"
	else
		response.write "<img src='icon_pass.png' width='49' height='49' />"
		response.write "<h3>"
		response.write "驳回成功"
		response.write "</h3>"
		response.write " 成功驳回 " + cstr(varSuccess) + " 条测试用例。"
	end if 

elseif request("action") = "audit" then
	for i=0 to ubound(arr_str)
		varSuccess = varSuccess + 1
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_casepool where poolId="&cint(arr_str(i))&" order by poolId DESC" ,conn,3,3
		rs("poolAudit") = "1"
		rs.update
		rs.close
	next

	' 返回
	if varSuccess = 0  then
		response.write "<img src='icon_fail.png' width='49' height='49' />"
		response.write "<h3>"
		response.write "未审核"
		response.write "</h3>"
		response.write " 请勾选用例复选框!"
	else
		response.write "<img src='icon_pass.png' width='49' height='49' />"
		response.write "<h3>"
		response.write "审核成功"
		response.write "</h3>"
		response.write " 成功审核 " + cstr(varSuccess) + " 条测试用例。"
	end if 
	
else


	pjtId = request("pjtId")
	lblId = request("lblId")
	platformId = request("platformId")
	
	
	set rs1 = server.createobject("adodb.recordset")
	rs1.open "select * from tbl_case",conn,3,3
	
	for i=0 to ubound(arr_str)
		varSuccess=varSuccess+1
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_casepool where poolId="&cint(arr_str(i))&" order by poolId DESC" ,conn,3,3
		rs1.addnew	
		'复制到case中 
		rs1("case_pjtId")= pjtId
		rs1("case_lblId") = lblId
		rs1("case_platformId") = platformId
		rs1("caseTitle") = rs("poolTitle")
		rs1("caseStep") = rs("poolStep")	
		rs1("caseWeb") = rs("poolWeb")	
		rs1("caseIos") = rs("poolIos")	
		rs1("caseAndroid") = rs("poolAndroid")	
		rs1("caseCS") =rs("poolCS")	
		rs1("caseDevice") = rs("poolDevice")	
		rs1("caseStage") = 1	
		rs1("caseCreateDate") = now
		rs1("caseUser") = session("userName")
		rs1("caseStatus") = 1		
		rs1.update
		rs.close
	next
	rs1.close
	set rs1 = nothing 
		
	' 返回
	if varSuccess = 0  then
		response.write "<img src='icon_fail.png' width='49' height='49' />"
		response.write "<h3>"
		response.write "导入失败"
		response.write "</h3>"
		response.write " 请勾选用例复选框!"
	else
		response.write "<img src='icon_pass.png' width='49' height='49' />"
		response.write "<h3>"
		response.write "导入成功"
		response.write "</h3>"
		response.write " 成功导入 " + cstr(varSuccess) + " 条测试用例。"
	end if 

end if 

%> 

