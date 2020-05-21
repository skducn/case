<!DOCTYPE html>
<html>

<!--#include file="conn.asp"-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<link href="js/custom2.css?v=0.9.1" rel="stylesheet">

<title><% = request("videoName")%></title>
</head>
<body>

<div class="skin skin-square">
<dl class="clear">
<dd class="selected">

<%
set rs1 = server.createobject("adodb.recordset")
rs1.open "select * from tbl_project where pjtId="&request("pjtId")&"",conn,3,3 
%>
<h3><% = rs1("pjtName")%> - 业务场景录屏</h3>

<table width="96%" border="0" align="center" cellpadding="1" cellspacing="1">
<tr>
  <td width="25%" nowrap="nowrap">
  
  
  
  </td>
<td nowrap="nowrap">


  <% 'Response.write Showmediacontent("D:\51\test\DKZY2\mp4\50\66\" + request("videoName") ,800,600) '调用例子	
  Response.write Showmediacontent("D:\51\test\DKZY2\mp4\50\66\6.mp4",800,600) '调用例子	
  %>
  <br />  <br />  </td>
</tr>
</table>
	<%rs1.close
set rs1 = nothing %>  
</dd>
</dl>
</div>

</body>
</html>