<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<!--#include file="conn.asp"-->
<!--#include file="returnMain.asp"-->

<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<link href="js/custom2.css?v=0.9.1" rel="stylesheet">

<script src="jquery.js"></script>
<script src="custom.js?v=0.9.1"></script>
<script src="js/jquery-1.9.1.min.js"></script>

<script type="text/javascript" charset="gbk" src="../ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="gbk" src="../ueditor/ueditor.all.min.js"> </script>	
<script type="text/javascript" charset="gbk" src="../ueditor/lang/zh-cn/zh-cn.js"></script>

<!--  641 ��ɫcheckbox��ѡ��	-->	
<link rel="stylesheet" type="text/css" href="js/641.css">

<link rel="stylesheet" type="text/css" href="js/button/waves.min.css?v=0.7.2">
<script type="text/javascript" src="js/button/waves.min.js"></script>
<script type="text/javascript" src="js/button/jquery.js"></script>
<script type="text/javascript" src="js/button/button1.js"></script>


<title>�༭������</title>

</head>

<!--  �༭ ����������	-->

<% if request("action")="save" then  
	poolId = request("poolId")
	pjtId = request("pjtId")
	platformId = request("platformId")
	lblId = request("lblId")

	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_casepool where poolId="&poolId&"",conn,3,3
	rs1("poolTitle") = request("poolTitle")
	rs1("poolStep") = request("poolStep")
	rs1("poolWeb") = request("poolWeb")
	rs1("poolIos") = request("poolIos")
	rs1("poolAndroid") = request("poolAndroid")
	rs1("poolCS") = request("poolCS")
	rs1("poolDevice") = request("poolDevice")
	rs1("poolLatestDate") = now
	rs1("poolAudit") = 0
	rs1.update
	rs1.close
	set rs1 = nothing
	response.Redirect("sltPool.asp?pjtId="&pjtId&"&platformId="&platformId&"&lblId="&lblId&"")
end if 
%>


<%
poolId = request("poolId")
	pjtId = request("pjtId")
	platformId = request("platformId")
	lblId = request("lblId")

%>

<body>
<div class="skin skin-square">
   
<!--  ��ʾ����	-->	
<h3><a href="sltPool.asp?pjtId=<%=pjtId%>&platformId=<%=platformId%>&lblId=<%=lblId%>"><img src="images/back2.jpg" alt="������һҳ" width="40" height="40" align="absmiddle" /></a>���������� (�༭)</h3>
  


 

<dl class="clear">
<dd class="selected">
<br />

 
 
<!--  �༭��������	-->
<%
set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_casepool where poolId="&poolId&" order by poolId DESC",conn,3,3 
%>

<form id="form1" name="form1" method="post" action="sltPoolEdit.asp?action=save">
  <table width="96%" align="center">
    <tr>
      <td align="center" valign="top">
        <table align="left">
          <tr>
            <td colspan="2" nowrap="nowrap">

</td>
            </tr>
          <tr>
            <td width="55" nowrap="nowrap">�������⣺</td>
            <td>
			<input name="poolTitle" type="text" value="<%=rs("poolTitle")%>" size="100" maxlength="50" />
			&nbsp;(<%=poolId%>) </td>
          </tr>
          <tr>
            <td nowrap="nowrap">�������裺</td>
            <td>
			
<script type="text/plain" id="myEditor" style="width:855px; height:400px" name="poolStep"><%=rs("poolStep")%></script>	
<script type="text/javascript">var editor_a = UE.getEditor('myEditor');</script></td>
            </tr>
          <tr>
            <td nowrap="nowrap">���Զ���</td>
            <td>
            
			 
                <% if rs("poolWeb") = "on" then%>
                <input class="magic-checkbox" name="poolWeb" type="checkbox" id="square-checkbox-1" checked="checked" />
                <%else%>
                <input class="magic-checkbox" name="poolWeb" type="checkbox"  id="square-checkbox-1" />
                <%end if %>
                <label for="square-checkbox-1">B/S(webƽ̨) </label>
                            
				
              <br>
                <% if rs("poolIos") = "on" then%>
                <input class="magic-checkbox" name="poolIos" type="checkbox" id="square-checkbox-2" checked="checked" />
                <%else%>
                <input class="magic-checkbox" type="checkbox" name="poolIos" id="square-checkbox-2" />
                <%end if %>
                <label for="square-checkbox-2">iOS �ͻ���</label>
              <br>
                <% if rs("poolAndroid") = "on" then%>
                <input class="magic-checkbox" name="poolAndroid" type="checkbox" id="square-checkbox-3" checked="checked" />
                <%else%>
                <input class="magic-checkbox" type="checkbox" name="poolAndroid" id="square-checkbox-3" />
                <%end if %>
                <label for="square-checkbox-3">Android �ͻ���</label>
             
			   <br>
                <% if rs("poolCS") = "on" then%>
                <input class="magic-checkbox" name="poolCS" type="checkbox" id="square-checkbox-4" checked="checked" />
                <%else%>
                <input class="magic-checkbox" type="checkbox" name="poolCS" id="square-checkbox-4" />
                <%end if %>
                <label for="square-checkbox-4">C/S(webӦ��)</label>
              <br>
                <% if rs("poolDevice") = "on" then%>
                <input class="magic-checkbox" name="poolDevice" type="checkbox" id="square-checkbox-5" checked="checked" />
                <%else%>
                <input class="magic-checkbox" type="checkbox" name="poolDevice" id="square-checkbox-5" />
                <%end if %>
                <label for="square-checkbox-5">�����豸 (�磺������)</label>                    </td>
            </tr>
          <tr>
            <td nowrap="nowrap">&nbsp;</td>
            <td height="55">
              
              <div align="center">
        
                
                <i class="btn float-buttons waves-input-wrapper waves-effect waves-button waves-float" style="color: rgb(255, 255, 255); background: rgb(255, 79, 115)">
                  <input name="submit" type="submit" class="waves-button-input" style="background-color: rgba(0,0,0,0);" value="��������" />
                  </i>                </div></td></tr>
        </table>        </td>
      </tr>
  </table>
  			<input name="poolId" type="hidden" value=<%=rs("poolId")%> />
			<input name="pjtId" type="hidden" value=<%=request("pjtId")%> />
			<input name="platformId" type="hidden" value=<%=request("platformId")%> />
			<input name="lblId" type="hidden" value=<%=request("lblId")%> />

  </form>


<br>
</dd>		  
</dl>
</div>


</body>
</html>