<!--#include file="frame.asp"-->
<!--#include file="upload_5xsoft.inc"--> 

<title><%=cstCompany%> | 导入Excel</title>

<!--  导入Excel	 ， 只能导入Sheet1表 -->	


<% if request("action") = "importExcel" then
	set upload = new upload_5xsoft
	set file = upload.file("excelfile")
	
	'格式化文件名 2017122819337.xlsx
	filename = year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)
	filename = filename+"."
	filenameend = file.filename
	filenameend = split(filenameend,".")

	'验证文件扩展名
	if filenameend(1)="xls" or filenameend(1)="xlsx" then
		filename=filename&filenameend(1)
	else
		response.Write("<script>;alert('文件类型不是EXCEL文件，请重试！');window.location.href='sltTestcaseList-"&pjtId&"-"&platformId&".html';</script>")
		response.end 
	end if 

	file.saveAs Server.mappath("uploadfile/"&filename)
	strAddr = server.MapPath("uploadfile/"&filename)  ' 获取服务端文件地址D:\51\test\DKZY2\uploadfile\2018410165912.xlsx
	
	'写入数据库
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_import",conn,3,3
	rs.addnew
	rs("importUserName") = session("userName")
	rs("importFile") = filename
	rs.update
	rs.close
		
		
	set ExcelApp=CreateObject("Excel.Application")
	ExcelApp.DisplayAlerts=false
	ExcelApp.Application.Visible=false
	set ExcelBook = ExcelApp.WorkBooks.Open(strAddr)
	set objExcelBook = ExcelApp.ActiveWorkBook    
	Set ExcelSheet = ExcelBook.Sheets.Item("testcase") 
	Set ExcelSheet3 = ExcelBook.Sheets.Item("fault") 
	ExcelSheet3.cells(1,1) = "项目名称"
	ExcelSheet3.cells(1,2) = "版本号"
	ExcelSheet3.cells(1,3) = "标签名称"
	ExcelSheet3.cells(1,4) = "用例标题"
	ExcelSheet3.cells(1,5) = "测试步骤"
	ExcelSheet3.cells(1,6) = "测试对象"
	ExcelSheet3.cells(1,7) = "测试阶段"	
		
	Dim dimMaxRecord,importRecordcount,i,j,errorFields
	
	'记录最大记录数
	set rs = server.CreateObject("ADODB.RecordSet")
	rs.Open "select * from tbl_case order by caseSort DESC",conn,2,3
	if not rs.eof then
	dimMaxRecord = rs("caseSort") + 1
	else
	dimMaxRecord = 1
	end if 

	j=2

	For i=2 to ExcelSheet.usedrange.rows.count
	
		' 判断项目名称，版本号，标签名称，项目名 是否为空及前三个字段是否关联
		if ExcelSheet.cells(i,1)="" or ExcelSheet.cells(i,2)="" or ExcelSheet.cells(i,3)="" or ExcelSheet.cells(i,4)="" then
			errorFields = 1
		else	
		
			'判断项目名称是否存在
			set rs7 = server.CreateObject("ADODB.RecordSet")
			rs7.Open "select * from tbl_project where pjtName='"&ExcelSheet.cells(i,1)&"' order by pjtId DESC",conn,3,3
			if rs7.recordcount = 0 then
				errorFields = 1
				'response.Write("<script>;alert('错误！成功导入" + cstr(varTable-2) + "条数据，但第" + cstr(varTable) + "行中项目名称 ‘"+ objRS0 + "’ 不存在！');window.location.href='sltExcelImport.asp';< /script>")
				'response.end 
			else
				rs7pjtId = rs7("pjtId")
				'判断版本号是否存在
				set rs8 = server.CreateObject("ADODB.RecordSet")
				rs8.Open "select * from tbl_platform where plat_pjtId="&rs7("pjtId")&" and platformName='"&cstr(ExcelSheet.cells(i,2))&"' order by platformId DESC",conn,3,3
				if rs8.recordcount = 0 then
					errorFields = 1
					'response.Write("<script>;alert('错误！成功导入" + cstr(varTable-2) + "条数据，但第" + cstr(varTable) + "行中版本号 ‘"+ objRS1 + "’ 不存在！');window.location.href='sltExcelImport.asp';< /script>")
					'response.end 
				else
					rs8platformId = rs8("platformId")
					'判断标签是否存在
					set rs9 = server.CreateObject("ADODB.RecordSet")
					rs9.Open "select * from tbl_label where lblName='"&cstr(ExcelSheet.cells(i,3))&"' and lbl_pjtId="&rs7("pjtId")&" and lbl_platformId="&rs8("platformId")&" order by lblId DESC",conn,3,3
					if rs9.recordcount = 0 then
						errorFields = 1
					else
						rs9recordcount = rs9.recordcount
						rs9lblId = rs9("lblId")
					end if 
					rs9.close
				end if
				rs8.close	
			end if	
			rs7.close
		end if
		
		if errorFields = 1 then
		  ' 将错误的记录导入 excel中
		    ExcelSheet3.cells(j,1)  = cstr(ExcelSheet.cells(i,1)) 
			ExcelSheet3.cells(j,2)  = cstr(ExcelSheet.cells(i,2))
			ExcelSheet3.cells(j,3)  = cstr(ExcelSheet.cells(i,3))
			ExcelSheet3.cells(j,4)  = cstr(ExcelSheet.cells(i,4))
			ExcelSheet3.cells(j,5)  = cstr(ExcelSheet.cells(i,5))
			ExcelSheet3.cells(j,6)  = cstr(ExcelSheet.cells(i,6))
			ExcelSheet3.cells(j,7)  = cstr(ExcelSheet.cells(i,7))	
			j = j + 1
			errorFields = 0
			errorFields2 = 1
		else
						
			'项目 - 版本 - 标签 同时存在，则将记录插入数据库
			
				importRecordcount = importRecordcount + 1 
				rs.addnew  
				rs("caseSort") = dimMaxRecord
				dimMaxRecord = dimMaxRecord + 1
				rs("case_pjtId") = rs7pjtId
				rs("case_platformId") = rs8platformId
				rs("case_lblId") = rs9lblId
				rs("caseTitle") = ExcelSheet.cells(i,4) 
				rs("caseStep") = ExcelSheet.cells(i,5)
			
				' 测试对象
				if isnull(ExcelSheet.cells(i,6)) then
				   rs("caseWeb") = "on"
				else
					field6 = cstr(ExcelSheet.cells(i,6))
					field6 = replace(field6,"，",",")
					If InStr(field6, ",") > 0 Then
						'包含,
						mystr=split(field6,",")
						for k=0 to ubound(mystr) 
							if mystr(k) = "b/s" or mystr(k) = "B/S" then	
							rs("caseWeb") = "on"
							elseif mystr(k) = "ios" or mystr(k) = "iOS" then
							rs("caseIos") = "on"
							elseif mystr(k) = "android" or mystr(k) = "Android" then	
							rs("caseAndroid") = "on"
							elseif mystr(k) = "c/s" or mystr(k) = "C/S" then	
							rs("caseCS") = "on"
							elseif mystr(k) = "device" or mystr(k) = "Device" then	
							rs("caseDevice") = "on"
							else
							rs("caseWeb") = "on"
							end if 
						next
					Else
						'不包含
						if field6 = "b/s" or field6 = "B/S" then	
						rs("caseWeb") = "on"
						elseif field6 = "ios" or field6 = "iOS" then
						rs("caseIos") = "on"
						elseif field6 = "android" or field6 = "Android" then	
						rs("caseAndroid") = "on"
						elseif field6 = "c/s" or field6 = "C/S" then	
						rs("caseCS") = "on"
						elseif field6 = "device" or field6 = "Device" then	
						rs("caseDevice") = "on"
						else
						rs("caseWeb") = "on"
						end if 
					End If
				end if 
				
				' 测试阶段,默认没有填写是冒烟
				if ExcelSheet.cells(i,7) = "冒烟" then
					rs("caseStage") = 1 	
				elseif ExcelSheet.cells(i,7) = "正式" then
					rs("caseStage") = 2 	
				elseif ExcelSheet.cells(i,7) = "回归" then
					rs("caseStage") = 3
				else
					rs("caseStage") = 1 	
				end if 
				rs("caseCreateDate") = now
				rs("caseUser") = session("userName")
				rs("caseStatus") = "1"
				rs("caseResult") = "empty"
		
		end if 	

	Next
	rs.update
	objExcelBook.Save      
	ExcelApp.Quit  
	set ExcelApp = Nothing  

	response.Redirect("sltExcelImportImport-"&importRecordcount&"-"&errorFields2&"-"&j-2&".html")
end if %>




<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
	<h1>
	测试用例导入
	<small>Testcase Import</small>
	</h1>
	<ol class="breadcrumb">
	<li><a href="main.html"><i class="fa fa-align-justify"></i> Home</a></li>
	</ol>
	</section>


<!-- Main content -->
<section class="content">
	<div class="row">
		<div class="col-xs-12">
			<div class="box box-info box-solid box-default">
				<div class="box-header with-border">
				<h3 class="box-title">导入Excel</h3>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<form id="form14" name="form14" method="post" enctype="multipart/form-data" action="sltExcelImportImportExcel.html">


					<div class="col-xs-12">
						<div class="form-group">
						<label>Excel示例</label>
						<p><img src="images/example.jpg" /> </p>
						</div>
					</div>
					
					<div class="col-xs-4">
						<div class="form-group">
						<label>Excel模板下载</label><br>
						 <a href="uploadfile/import.xlsx"> <button type="button" class="btn btn-primary pull-left" style="margin-right: 5px;"><i class="fa fa-download"></i> Download import.xlsx</button></a><br><br><br>
						</div>
					</div>
					
					
					<div class="col-xs-12">
						<div class="form-group">
							<label>Excel导入</label><br>
							<table>
							<tr>
							<td><input name="excelfile" type="file" id="excelfile" size="5" /></td>
							<td><input name="提交" type="" id="提交" value="提交" /></td>
							</tr>
							</table>
						</div>
					</div>
					
					<% if request("action")="import" then  %>
					 <div class="col-xs-12">
						<div class="form-group">
						<label>Excel导入结果</label><br>
							
							<% 
								response.write "<font color=blue>"
								response.write  "成功导入 " + request("importRecordcount") + " 条记录 , 未导入 " + request("errorNums") + " 条记录。"
								response.write "</font><br><br>"
							
							
							 if request("errorFields2") = "1" then
								set rs5= server.CreateObject("ADODB.RecordSet")
								rs5.Open "select * from tbl_import where importUserName='"&session("userName")&"' order by importId DESC",conn,3,3 %>
								<a href="uploadfile/<%=rs5("importFile")%>"> <button type="button" class="btn btn-danger pull-left" style="margin-right: 5px;"><i class="fa fa-download"></i> 查看未导入列表</button></a><br><br><br>
								<%rs5.close
							end if %>
						</div>
					</div>
					<% end if %>

					</form>
				</div>
			
			</div>	 
		</div> <!-- /.col -->
	</div><!-- /.row -->
</section><!-- /.content -->
<%rs.close
set rs = nothing
%>

</div>
<!-- ./wrapper -->

<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.5 -->
<script src="bootstrap/js/bootstrap.min.js"></script>
<!-- Slimscroll -->
<script src="plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/app.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- Morris.js charts -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
<script src="plugins/morris/morris.min.js"></script>
<!-- Sparkline -->
<script src="plugins/sparkline/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="plugins/knob/jquery.knob.js"></script>
<!-- daterangepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="plugins/daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="plugins/datepicker/bootstrap-datepicker.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>


</body>
</html>


