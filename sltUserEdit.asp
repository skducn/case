<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Session.CodePage = 936
Response.Charset = "GB2312"%>
<!--#include file="frame.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="upload_5xsoft.inc"-->


<title>�������� | <%=cstCompany%></title>


<script language="javascript">  

function CheckPost()
{   	
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "����ɹ�",
		icon: 'fa fa-check' 
	},{
		type: "success"
	});
}
</script>
<script language="javascript">
function CheckPost()
{
	if (addForm.userPass.value.length > 0 && addForm.userPass.value.length < 6){
		alert("��ܰ��ʾ�����볤�� 6 - 15���ַ���", function () {}, {type: 'warning', confirmButtonText: 'ȷ��'});
		addForm.userPass.focus();
		return false;}
		
		
  if (addForm.userNickname.value == "")
  {
	  alert("��ܰ��ʾ���ǳƲ���Ϊ�գ�");
	  addForm.userNickname.focus();
	  return false;
  }

		//�ύǰ����ȷ��		
	var gnl=confirm("ȷ��Ҫ����?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
 
}
</script>




<!--  �༭�ҵ��˺�	-->

<% if request("action")="save" then 

' �ϴ�ͼƬ
dim upload,file,formName,iCount,FolderNameNew
dim GuFolderPath,fso,GuFolder0,GuFileSize0,GuFileExt0,GuAutoName
set upload=new upload_5xsoft  '�����ϴ�����
	GuFolder0="/images/"  '�趨Ĭ���ϴ���Ŀ¼�������ԡ�/������������Ϊ��
	GuFileSize0=2048  '�趨Ĭ�������ϴ�������ļ�����λ:K��1024K=1M
	GuFileExt0="bmp|gif|jpg|jpeg|png|swf|rar|zip|txt"  '�趨Ĭ�������ϴ����ļ�����
	GuAutoName="1"  '�趨�ϴ��ɹ�����ļ����Ƿ��Զ�������������ʹ��ԭ�������ƣ�1Ϊ�ǣ�0Ϊ��
if upload.form("GuFolderPath")<>"" then
	GuFolderPath=upload.form("GuFolderPath")
	call FolderNameCheck(GuFolderPath)
	GuFolderPath=upload.form("GuFolderPath")
	if right(GuFolderPath,1)<>"/" then GuFolderPath=GuFolderPath&"/"
	elseif upload.form("GuFolderPath")="" and GuFolder0<>"" then
		GuFolderPath=GuFolder0
		call FolderNameCheck(GuFolderPath)
		GuFolderPath=GuFolder0
		if right(GuFolderPath,1)<>"/" then GuFolderPath=GuFolderPath&"/"
else
	GuFolderPath=""
end if
	iCount=0	
	'for each formName in upload.objForm  '�г�����form����
		'Response.write formName&"="&upload.form(formName)&"<br>"
	'next
	for each formName in upload.objFile  '�г������ϴ��˵��ļ�
		set file=upload.file(formName)
		if file.FileSize>0 then
			dim FileExtF,FileExtY,FileExtOK,ii,jj
			FileExtF=split(File.FileName,".")
			for jj=0 to ubound(FileExtF)
			next
			FileExtY=0
			FileExtOK=split(GuFileExt0,"|")		
			for ii=0 to ubound(FileExtOK)
				if FileExtOK(ii)=FileExtF(jj-1) then
					FileExtY=1
					exit for
				end if
			next
			if FileExtY=0 then
				Htmend "�ϴ�ʧ�ܣ��������ϴ����ļ�����"
			elseif file.FileSize>GuFileSize0*1024 then
				Htmend "�ϴ�ʧ�ܣ������ļ���С�������ƣ����"&GuFileSize0&"*1024 �ֽڣ�1K=1024�ֽ�"
			else
				dim FileNameOK
				if GuAutoName="1" then
					FileNameOK=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&iCount&"."&FileExtF(jj-1)
				else
					FileNameOK=file.FileName
				end if
				file.SaveAs Server.mappath(GuFolderPath&FileNameOK)  '�����ļ�
				'Response.write file.FilePath&file.FileName&"(��С:"&file.FileSize&" �ֽ�) => "&GuFolderPath&FileNameOK&" �ɹ�! <br>"
				iCount=iCount+1
			end if
		else
			Htmend "�ϴ�ʧ�ܣ���ѡ��Ҫ�ϴ����ļ�"
	
		end if
		set file=nothing
	next

'set upload=nothing
'Htmend iCount&" ���ļ��ϴ��ɹ�!"
Sub FolderNameCheck(FolderNameNew)
	dim Letters,i,c
	Letters="+=:;,[]<>\|*?"
	for i=1 to len(FolderNameNew)
		c=mid(FolderNameNew,i,1)
		if inStr(Letters,c)<>0 then
		Htmend "�ϴ�ʧ�ܣ��ļ������ƺ��������ַ�"
	end if
	next
	GuFolderPath=server.MapPath(GuFolderPath)
	Set fso=Server.CreateObject("Scripting.FileSystemObject")
	if fso.FolderExists(GuFolderPath)=false then
		fso.CreateFolder(GuFolderPath)
	end if
	Set fso=nothing
End sub

Sub HtmEnd(Msg)
 'set upload=nothing
End sub


	userName = upload.form("userName")
	userPass = upload.form("userPass")
	userPhone = upload.form("userPhone")
	userInfo = upload.form("userInfo")
	userNickname = upload.form("userNickname")
	dim isRepeat
	isRepeat = 0
	set rs1 = server.CreateObject("ADODB.RecordSet")
	rs1.Open "select * from tbl_user where userId<>"&session("userId")&" ",conn,3,3
	do while not rs1.eof
		if rs1("userNickname") = userNickname then
		   isRepeat = 1
		end if 
	rs1.movenext
	loop

	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_user where userId="&session("userId")&"",conn,3,3
	if isRepeat = 0  then
		if userNickname = "" then
			rs("userNickname") = userName
		else
			rs("userNickname") = userNickname
		end if 
		if userPass <> "" then
			rs("userPass") = md5(userPass)
		end if 
		if FileNameOk <> "" then
			rs("userImg") = "images\" + FileNameOK
		end if 
		rs("userPhone") = userPhone
		rs("userInfo") = userInfo
		rs.update
		response.Redirect("sltUserEdit.html")
	else
		response.Write("<script>;alert('�༭ʧ�ܣ��ǳ��Ѵ��ڣ�');window.location.href='sltUserEdit.html';</script>")
	end if 	
	rs.close
	set rs = nothing 
end if 
%>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-user"></i> ��������</h1><p>my panel</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">��������</a></li></ul></div>
	</div>
	
	<div class="card">	
		<div class="row">
			<div class="col-md-12">
				<div class="nav-tabs-custom">	
	
		<form role="form" action="sltUserEditSave.html" method="post" name="addForm" onSubmit="return CheckPost()" enctype="multipart/form-data">



		<div class="col-md-12">
			<div class="box box-warning box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title"></h3>
				</div>
				<%
				userId = session("userId")
				set rs = server.CreateObject("ADODB.RecordSet")
				rs.Open "select * from tbl_user where userId="&userId&"",conn,3,3
				%>
				<!-- /.box-header -->
				<div class="box-body">
					
			
					<div class="col-md-12" align="center">
						<div class="form-group">						
							<img class="img-circle" src="<%=rs("userImg")%>" width="100">
						</div>	
						<br><br>											
					</div>								

					
					<div class="col-md-4">
						<div class="form-group">
						<label>�û��� </label>
						<input type="text" name="userName" maxlength="15" class="form-control" value="<%=rs("userName")%>" disabled>
						</div>
					</div>
					
					<div class="col-md-4">
						<div class="form-group">
						<label>ְ��</label>
						<input type="text" name="userTitle"  maxlength="10" class="form-control" value="<%=rs("userTitle")%>" disabled>
						</div>
					</div>

					<div class="col-md-4">
						<div class="form-group">
						<label>����</label> <a href="mailto:h.jin@zy-healthtech.com">�������ҵ����䣿֪ͨ����Ա��</a>
						<input type="text" name="userEmail"  maxlength="32" class="form-control" value="<%=rs("userEmail")%>" disabled>
						</div>
					</div>
					
					
					<div class="col-md-3">
						<div class="form-group">
						<label>���� (6-15)</label>						
						<input name="userPass" type="password"  maxlength="15" class="form-control"  placeholder="******" >
						</div>
					</div>
							
					<div class="col-md-3">
						<div class="form-group">
						<label>�ǳ� (1-6)</label>
						<input type="text" name="userNickname" maxlength="6" class="form-control" value="<%=rs("userNickname")%>" >
						</div>
					</div>
									
					
					<div class="col-md-3">
						<div class="form-group">
						<label>�ֻ���</label>
						<input type="text" name="userPhone"  maxlength="11" class="form-control" value="<%=rs("userPhone")%>">
						</div>
					</div>
					
					<div class="col-md-3" align="center">
						<div class="form-group">
							<label>�ϴ�ͷ��</label>
							<input class="form-control" type="FILE" name="file1" size="23"  accept="image/*" title="����ϴ�ͷ��"/>
						</div>																						
					</div>
					
					<div class="col-md-12">
						<div class="form-group">
							<label>������Ϣ</label>
							<textarea class="form-control" name="userInfo" rows="15" required><%=rs("userInfo")%></textarea>						
						</div>
					</div>
					
				
							
					<input name="userId" type="hidden" value="<%=userId%>" />
				
					
					<div class="col-md-12">			
						<hr>  
						<div align="center"><button type="submit" class="btn btn-primary" href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;����</button></div>
						<br>			
					</div>
						
				</div>
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
	

					

</form>

</div>   



<!-- jQuery 2.1.4 -->
<script src="plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- ��� չ�� ������� Bootstrap 3.3.5���� -->
<script src="bootstrap/js/jquery.js"></script>  
<script src="bootstrap/js/custom.js?v=0.9.1"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

</body>
</html>
