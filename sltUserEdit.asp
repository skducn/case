<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<%Session.CodePage = 936
Response.Charset = "GB2312"%>
<!--#include file="frame.asp"-->
<!--#include file="md5.asp"-->
<!--#include file="upload_5xsoft.inc"-->


<title>个人设置 | <%=cstCompany%></title>


<script language="javascript">  

function CheckPost()
{   	
	$.notify({
		title: "&nbsp;&nbsp;",
		message: "保存成功",
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
		alert("温馨提示：密码长度 6 - 15个字符！", function () {}, {type: 'warning', confirmButtonText: '确定'});
		addForm.userPass.focus();
		return false;}
		
		
  if (addForm.userNickname.value == "")
  {
	  alert("温馨提示：昵称不能为空！");
	  addForm.userNickname.focus();
	  return false;
  }

		//提交前弹框确认		
	var gnl=confirm("确定要保存?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
 
}
</script>




<!--  编辑我的账号	-->

<% if request("action")="save" then 

' 上传图片
dim upload,file,formName,iCount,FolderNameNew
dim GuFolderPath,fso,GuFolder0,GuFileSize0,GuFileExt0,GuAutoName
set upload=new upload_5xsoft  '建立上传对象
	GuFolder0="/images/"  '设定默认上传的目录，必须以“/”结束，可以为空
	GuFileSize0=2048  '设定默认允许上传的最大文件，单位:K，1024K=1M
	GuFileExt0="bmp|gif|jpg|jpeg|png|swf|rar|zip|txt"  '设定默认允许上传的文件类型
	GuAutoName="1"  '设定上传成功后的文件名是否自动重新命名或是使用原来的名称，1为是，0为否
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
	'for each formName in upload.objForm  '列出所有form数据
		'Response.write formName&"="&upload.form(formName)&"<br>"
	'next
	for each formName in upload.objFile  '列出所有上传了的文件
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
				Htmend "上传失败，不允许上传的文件类型"
			elseif file.FileSize>GuFileSize0*1024 then
				Htmend "上传失败，单个文件大小超过限制，最大"&GuFileSize0&"*1024 字节，1K=1024字节"
			else
				dim FileNameOK
				if GuAutoName="1" then
					FileNameOK=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&iCount&"."&FileExtF(jj-1)
				else
					FileNameOK=file.FileName
				end if
				file.SaveAs Server.mappath(GuFolderPath&FileNameOK)  '保存文件
				'Response.write file.FilePath&file.FileName&"(大小:"&file.FileSize&" 字节) => "&GuFolderPath&FileNameOK&" 成功! <br>"
				iCount=iCount+1
			end if
		else
			Htmend "上传失败，请选择要上传的文件"
	
		end if
		set file=nothing
	next

'set upload=nothing
'Htmend iCount&" 个文件上传成功!"
Sub FolderNameCheck(FolderNameNew)
	dim Letters,i,c
	Letters="+=:;,[]<>\|*?"
	for i=1 to len(FolderNameNew)
		c=mid(FolderNameNew,i,1)
		if inStr(Letters,c)<>0 then
		Htmend "上传失败，文件夹名称含有特殊字符"
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
		response.Write("<script>;alert('编辑失败，昵称已存在！');window.location.href='sltUserEdit.html';</script>")
	end if 	
	rs.close
	set rs = nothing 
end if 
%>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-user"></i> 个人设置</h1><p>my panel</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">个人设置</a></li></ul></div>
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
						<label>用户名 </label>
						<input type="text" name="userName" maxlength="15" class="form-control" value="<%=rs("userName")%>" disabled>
						</div>
					</div>
					
					<div class="col-md-4">
						<div class="form-group">
						<label>职称</label>
						<input type="text" name="userTitle"  maxlength="10" class="form-control" value="<%=rs("userTitle")%>" disabled>
						</div>
					</div>

					<div class="col-md-4">
						<div class="form-group">
						<label>邮箱</label> <a href="mailto:h.jin@zy-healthtech.com">（不是我的邮箱？通知管理员）</a>
						<input type="text" name="userEmail"  maxlength="32" class="form-control" value="<%=rs("userEmail")%>" disabled>
						</div>
					</div>
					
					
					<div class="col-md-3">
						<div class="form-group">
						<label>密码 (6-15)</label>						
						<input name="userPass" type="password"  maxlength="15" class="form-control"  placeholder="******" >
						</div>
					</div>
							
					<div class="col-md-3">
						<div class="form-group">
						<label>昵称 (1-6)</label>
						<input type="text" name="userNickname" maxlength="6" class="form-control" value="<%=rs("userNickname")%>" >
						</div>
					</div>
									
					
					<div class="col-md-3">
						<div class="form-group">
						<label>手机号</label>
						<input type="text" name="userPhone"  maxlength="11" class="form-control" value="<%=rs("userPhone")%>">
						</div>
					</div>
					
					<div class="col-md-3" align="center">
						<div class="form-group">
							<label>上传头像</label>
							<input class="form-control" type="FILE" name="file1" size="23"  accept="image/*" title="点击上传头像"/>
						</div>																						
					</div>
					
					<div class="col-md-12">
						<div class="form-group">
							<label>个人信息</label>
							<textarea class="form-control" name="userInfo" rows="15" required><%=rs("userInfo")%></textarea>						
						</div>
					</div>
					
				
							
					<input name="userId" type="hidden" value="<%=userId%>" />
				
					
					<div class="col-md-12">			
						<hr>  
						<div align="center"><button type="submit" class="btn btn-primary" href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button></div>
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
<!-- 表格 展开 必须放在 Bootstrap 3.3.5后面 -->
<script src="bootstrap/js/jquery.js"></script>  
<script src="bootstrap/js/custom.js?v=0.9.1"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>

</body>
</html>
