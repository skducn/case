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
<!--  ajax��ʾ��Ч��	-->	
<link href="js/alertify.css" media="screen" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="js/jquery.alertify.js"></script>


<!--  ��ťЧ��	-->	
<link rel="stylesheet" type="text/css" href="js/button/waves.min.css?v=0.7.2">
<script type="text/javascript" src="js/button/waves.min.js"></script>
<script type="text/javascript" src="js/button/jquery.js"></script>
<script type="text/javascript" src="js/button/button1.js"></script>

<!--  search	-->	
<link href="js/searchMeme.css" rel="stylesheet" type="text/css" />
<script src="js/jquery.searchMeme.js" type="text/javascript"></script>

<!--  ���ظ���Ч�����༭��Ŀ˵��	-->	
<link rel="stylesheet" type="text/css"  href="js/featherlight.min.css">
<script src="js/featherlight.min.js" ></script>

<!--  ��ѡ����ʽ	-->	
<link rel="stylesheet" type="text/css" href="js/641pool.css">


<style type="text/css">
<!--
.STYLE1 {color: #FF0000}
.STYLE2 {color: #0000FF}
-->
</style>

<title>�������б�</title>
</head>

<body>

<div class="skin skin-square">
<dd class="selected">
<br />

<table width="96%" border="0" align="center">
<tr>
  <td>
	<h3>�����������</h3>
	<br /><br /><br /><br /><br />
</td></tr>	


<form action="sltPoolAJAX.asp?action=audit" method="post" onsubmit="return true;">
<%
' poolSort ���ͣ�1=���������أ�2=����������  ; 
' poolAudit ���״̬��0=δ��� , 1=���ͨ����2 = ���ʧ��
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_casepool where poolSort='1' and poolAudit='0' order by poolId desc" ,conn,3,3
varcount = 1 
do while not rs.eof %>	
	<tr><td  nowrap="nowrap">		
	<dl class="demo-methods"><dt1>
	<span class="code"><span class="self STYLE1">չ��</span>&nbsp;</span>
	<input class="magic-checkbox" name="poolId" type="checkbox" value="<%=rs("poolId")%>" id="c6(<%=varcount%>)" /><label for="c6(<%=varcount%>)"><%=rs("poolTitle")%></label> <font color=red>(���� <%=rs("poolUser")%> - <%=rs("poolCreateDate")%>��</font>
	</dt1>
	<dd >
	<pre class="markup"><%=rs("poolStep")%></pre>
	</dd>
	</dl>
	</td></tr>
	<tr><td height="8" nowrap="nowrap" ></td></tr>
<% varcount = varcount + 1
rs.movenext
loop
%>

<tr>
<td height="88" nowrap="nowrap">
<% if varcount > 1 then%>
	<br />
	<i class="btn float-buttons waves-input-wrapper waves-effect waves-button waves-float" style="color: rgb(255, 255, 255);"><input name="button3" type="button" class="alert waves-button-input" style="background-color:<%=btnColor("GemBlue")%>;" onclick="postFrom(this.form);" href="#" value="���ͨ��" ></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br /><br /><br /><br />

<%else
    response.write "����"
end if %>
</td>
</tr>	
</form>


<form action="sltPoolAJAX.asp?action=refuse" method="post" onsubmit="return true;">
<%
' poolSort ���ͣ�1=���������أ�2=����������  ; 
' poolAudit ���״̬��0=δ��� , 1=���ͨ����2 = ���ʧ��
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_casepool where poolSort='1' and poolAudit='0' order by poolId desc" ,conn,3,3
varcount = 1 
do while not rs.eof %>	
	<tr><td  nowrap="nowrap">		
	<dl class="demo-methods"><dt1>
	<span class="code"><span class="self STYLE1">չ��</span>&nbsp;</span>
	<input class="magic-checkbox" name="poolId" type="checkbox" value="<%=rs("poolId")%>" id="c67(<%=varcount%>)" /><label for="c67(<%=varcount%>)"><%=rs("poolTitle")%></label> <font color=red>(���� <%=rs("poolUser")%> - <%=rs("poolCreateDate")%>��</font>
	</dt1>
	<dd >
	<pre class="markup"><%=rs("poolStep")%></pre>
	</dd>
	</dl>
	</td></tr>
	<tr><td height="8" nowrap="nowrap" ></td></tr>
<% varcount = varcount + 1
rs.movenext
loop
%>

<tr>
<td height="88" nowrap="nowrap">
<% if varcount > 1 then%>

	<i class="btn float-buttons waves-input-wrapper waves-effect waves-button waves-float" style="color: rgb(255, 255, 255);"><input name="button3" type="button" class="alert waves-button-input" style="background-color:<%=btnColor("CherryRed")%>;" onclick="postFrom(this.form);" href="#" value="����" ></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%end if %>
</td>
</tr>	
</form>

</table>




</dd>		  
</dl> 
</div>
</body>
</html>