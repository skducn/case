<%
Set conn = Server.CreateObject("ADODB.Connection")
connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("/database/testcase.mdb")

'�����ķ��������ý��ϰ汾Access�����������������ӷ���:
'connstr="driver={Microsoft Access Driver (*.mdb)};dbq=" & Server.MapPath("/database/testcase.mdb")

conn.Open connstr
%>


