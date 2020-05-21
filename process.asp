<% 
x = request("id")

response.buffer=true 
formsize=request.totalbytes 
formdata=request.binaryread(formsize) 
bncrlf=chrB(13) & chrB(10) 
divider=leftB(formdata,clng(instrb(formdata,bncrlf))-1) 
datastart=instrb(formdata,bncrlf & bncrlf)+4 
dataend=instrb(datastart+1,formdata,divider)-datastart 
mydata=midb(formdata,datastart,dataend) 


set connGraph=server.CreateObject("ADODB.connection") 
connGraph.ConnectionString="driver={Microsoft access Driver (*.mdb)};DBQ="&server.MapPath("database/testcase.mdb") & ";uid=;PWD=;" 
connGraph.Open 

set rec=server.createobject("ADODB.recordset") 
rec.Open "select * from img where ID="&x&"",connGraph,3,3 


rec("img").appendchunk mydata 
rec.update 
rec.close 
set rec=nothing 
set connGraph=nothing 
response.redirect("upload.asp")
%>


