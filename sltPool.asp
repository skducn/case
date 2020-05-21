<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!--#include file="conn.asp"-->
<!--#include file="returnMain.asp"-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<link href="js/custom3pool1.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script src="js/custom.js?v=0.9.1"></script>

<!--  ajax-form	-->	
<script type="text/javascript" src="js/jo.ajax.js"></script>
<script type="text/javascript" src="js/ajax_form.js"></script>
<!--  ajax提示框效果	-->	
<link href="js/alertify.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery.alertify.js"></script>


<!--  按钮效果	-->	
<link rel="stylesheet" type="text/css" href="js/button/waves.min.css?v=0.7.2">
<script type="text/javascript" src="js/button/waves.min.js"></script>
<script type="text/javascript" src="js/button/jquery.js"></script>
<script type="text/javascript" src="js/button/button1.js"></script>

<!--  search	-->	
<link href="js/searchMeme.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.searchMeme.js" type="text/javascript"></script>

<!--  隐藏浮层效果，编辑项目说明	-->	
<link rel="stylesheet" type="text/css"  href="js/featherlight.min.css">
<script src="js/featherlight.min.js" ></script>

<!--  复选框样式	-->	
<link rel="stylesheet" type="text/css" href="js/641pool.css">


<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
-->
</style>

<title>用例池列表</title>
</head>



<%
pjtId = request("pjtId")
platformId = request("platformId")
lblId = request("lblId")

if platformId = "" then
response.end 
end if 

%>


<!--  获取项目平台标签名	-->	

<%
set rs8 = server.createobject("adodb.recordset")
rs8.open "select * from tbl_project where pjtId="&pjtId&"",conn,3,3 
pjtName = rs8("pjtName")
set rs9 = server.createobject("adodb.recordset")
rs9.open "select * from tbl_platform where platformId="&platformId&"",conn,3,3 
platformName = rs9("platformName")
set rs10 = server.createobject("adodb.recordset")
rs10.open "select * from tbl_label where lblId="&lblId&"",conn,3,3 
lblName = rs10("lblName") 
rs10.close
set rs10 = nothing 
rs9.close
set rs9 = nothing
rs8.close
set rs8 = nothing
%>


<!--  删除用例池记录	-->	

<% if request("action") = "del" then
' 1， 删除个人的用例，物理删除
' 2， 删除公共用例 ，非物理删除，修改用户账号
set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_casepool where poolId="&request("poolId")&"" ,conn,3,3
if rs1("poolSort") ="1" then
rs1("poolUser") = rs1("poolUser") + "(del me)"
elseif rs1("poolSort") = "2" then
rs1.delete
end if 
rs1.update
rs1.close
set rs1 = nothing 
response.Redirect("sltPool.asp?pjtId="&request("pjtId")&"&platformId="&request("platformId")&"&lblId="&request("lblId")&"")
end if 
%>



<body>

<div class="skin skin-square">
   

<!--  显示标题	-->	

<h3><a href="sltTestcase.asp?pjtId=<%=pjtId%>&platformId=<%=platformId%>"><img src="images/back2.jpg" alt="返回上一页" width="40" height="40" align="absmiddle" /></a>
用例池列表（<%=pjtName + " - " + platformName + " - " + lblName%>）</h3>


<table>
<tr>
<td width="12"><br />
<br /></td>
<td height="60"><form id="form6" name="form6" method="post" action="sltPool.asp?action=search">
<input type="text" id="search-orange" name="searchName" />
<input name="pjtId" type="hidden" value="<%=pjtId%>" />
<input name="lblId" type="hidden" value="<%=lblId%>" />
<input name="platformId" type="hidden" value="<%=platformId%>" />
</form></td>
</tr>
</table>


<dl class="clear">

<dd class="selected">

<br />
<form action="sltPoolAJAX.asp" method="post" onsubmit="return true;">

<table width="96%" border="0" align="center">
<tr>
  <td>
	<h3>我的用例池</h3>
	
 
</td></tr>	
<%
	' 搜索用例标题	
		set rs = server.createobject("adodb.recordset")
		rs.open "select * from tbl_casepool where  poolUser='"&session("userName")&"' order by poolId desc" ,conn,3,3
		varcount = 1 
		do while not rs.eof %>
		
<tr><td  nowrap="nowrap">		
		<dl class="demo-methods"><dt1>
		<span class="code"><span class="self STYLE1">展开</span>&nbsp;</span>
		
		<input class="magic-checkbox" name="poolId" type="checkbox" value="<%=rs("poolId")%>" id="c6(<%=varcount%>)" /><label for="c6(<%=varcount%>)"><%=rs("poolTitle")%></label>
		 <a href="sltPoolEdit.asp?poolId=<%=rs("poolId")%>&pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId%>"><font color=blue>(编辑)</font></a>
		 <a href="sltPool.asp?action=del&poolId=<%=rs("poolId")%>&pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId%>" onclick="return confirm('是否要删除此测试用例？')" ><font color="red">(删除)</font></a>

		</dt1>
		  <dd >
		  <pre class="markup"><%=rs("poolStep")%></pre>
		</dd>
		</dl>		</td></tr>
<tr>
  <td nowrap="nowrap"></td>
</tr>
<%
		varcount = varcount + 1
		rs.movenext
		loop
	 %>

<tr>
  <td height="88" nowrap="nowrap">
 
  
  <i class="btn float-buttons waves-input-wrapper waves-effect waves-button waves-float" style="color: rgb(255, 255, 255); background: rgb(255, 79, 115)">
      <input name="button3" type="button" class="alert waves-button-input" style="background-color: rgba(0,0,0,0);" onclick="postFrom(this.form);" value="从我的用例池 导入" href="#"  />
    </i>
	
    <input name="pjtId" type="hidden" value="<%=request("pjtId")%>" />
    <input name="lblId" type="hidden" value="<%=request("lblId")%>" />
    <input name="platformId" type="hidden" value="<%=request("platformId")%>" /></td>
</tr>	

</table>

</form>

<hr />
<br />
<form action="sltPoolAJAX.asp" method="post" onsubmit="return true;">

<% if request("action")="search" then
	searchName = request("searchName")
	if searchName = "" then	   
	   response.end 
	end if 
%>
<table width="96%" border="0" align="center">
<tr><td>
	<h3>公共用例池</h3>
	 
</td></tr>	
<%
' 搜索用例标题	poolSort 1=公共用例 ， poolaudit 1=已审核
if searchName = "all" then
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_casepool where poolSort='1' and poolAudit='1' order by poolId desc" ,conn,3,3
	tmp1 = 1000 
	do while not rs.eof %>
	<tr><td  nowrap="nowrap">		
	<dl class="demo-methods"><dt1>
	<span class="code"><span class="self STYLE1">展开</span>&nbsp;</span>
	<input class="magic-checkbox" name="poolId" type="checkbox" value="<%=rs("poolId")%>" id="c6(<%=tmp1%>)" /><label for="c6(<%=tmp1%>)"><%=rs("poolTitle")%></label>
	</dt1>
	<dd >
	<pre class="markup"><%=rs("poolStep")%></pre>
	</dd>
	</dl>		
	</td></tr>
	<tr>
	<td nowrap="nowrap"></td>
	</tr>
	<%
	tmp1 = tmp1 + 1
	rs.movenext
	loop
else

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_casepool where poolTitle like '%"&searchName&"%' and poolSort='1' and poolAudit='1' order by poolId desc" ,conn,3,3
	varPublic = 1000 
	do while not rs.eof %>
	<tr><td  nowrap="nowrap">		
	<dl class="demo-methods"><dt1>
	<span class="code"><span class="self STYLE1">展开</span>&nbsp;</span>
	<input class="magic-checkbox" name="poolId" type="checkbox" value="<%=rs("poolId")%>" id="c6(<%=varPublic%>)" /><label for="c6(<%=varPublic%>)"><%=rs("poolTitle")%></label>
	</dt1>
	<dd >
	<pre class="markup"><%=rs("poolStep")%></pre>
	</dd>
	</dl>		
	</td></tr>
	<tr>
	<td nowrap="nowrap"></td>
	</tr>
	<%
	varPublic = varPublic + 1
	rs.movenext
	loop

end if %>

<tr>
  <td height="88" nowrap="nowrap">
  
   <i class="btn float-buttons waves-input-wrapper waves-effect waves-button waves-float" style="color: rgb(255, 255, 255); background: rgb(255, 79, 115)">
      <input name="button3" type="button" class="alert waves-button-input" style="background-color:<%=btnColor("SpringGreen")%>;" onclick="postFrom(this.form);" value="从公共用例池 导入" href="#"  />
    </i>
    <input name="pjtId" type="hidden" value="<%=request("pjtId")%>" />
    <input name="lblId" type="hidden" value="<%=request("lblId")%>" />
    <input name="platformId" type="hidden" value="<%=request("platformId")%>" /></td>
</tr>	

		
</table>

    <%end if %>

</form>
</dd>		  
</dl> 
</div>
</body>
</html>