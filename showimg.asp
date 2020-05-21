<% 
set connGraph=server.CreateObject("ADODB.connection") 
connGraph.ConnectionString="driver={Microsoft Access Driver (*.mdb)};DBQ="&server.MapPath("database/testcase.mdb") & ";uid=;PWD=;" 
connGraph.Open 
set rec=server.createobject("ADODB.recordset") 
strsql="select img from img where id=" & trim(request("id")) 
rec.open strsql,connGraph,1,1 
Response.ContentType = "image/*" 
Response.BinaryWrite rec("img").getChunk(rec("img").ActualSize) 
rec.close 
set rec=nothing 
set connGraph=nothing 
%> 