功能：批量上传图片
流程：表单里先上传图片，然后将图片转换成时间戳文件名，将文件名写入数据库。
原理：如测试报告中上传附图功能，先新建一份测试报告记录，编辑时，上传图片文件名到对应的记录中的某个字段里，如tbl_report表中第一条记录的rptRedminePic。
文件：
plupload.full.min.js
uploadRedmine2.js
upload2.asp



sltReportEdit.asp   编辑
<!--  上传图片控件	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>


<!-- 上传图片，参数 pjtId, platformId -->
<div class="col-md-12">
<div id="container2">
<a id="pickfiles2" >请选择图片</a>														
<div id="filelist2"></div>				
<br>
<a id="uploadfiles2" href="javascript:;"><button type="submit" class="btn btn-success pull-left" href="#">上传</button></a> 
</div>	
<script id="testScript2" src="upload/js/uploadRedmine2.js" pjtId="<%=pjtId%>" platformId="<%=platformId%>"></script>						</div>
			
			
<!--  显示上传的图片 --> 
<div class="col-md-12">		
<%rptRedminePic = split(replace(rs("rptRedminePic"),"*",""),",")					
for i=1 to ubound(rptRedminePic)%>				
<p><img src=<%="upload\plupload\"+rptRedminePic(i)%>>					
<h3><% response.write "附图"&i %></h3><br>
</p>				
<%next%>
</div>


sltReportShow.asp  显示
<!--  上传图片控件	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<!--  显示图片 --> 
<% if rs("rptHardPic") <> "*" then  
rptHardPic = split(replace(rs("rptHardPic"),"*",""),",")					
for i=1 to ubound(rptHardPic)	%>				
<p><a href="sltReportShowDel-<%=pjtId%>-<%=platformId%>-<%=rptHardPic(i)%>.html" onClick="return confirm('是否要删除此图片？')" >
<img src=<%="upload\plupload\"+rptHardPic(i)%>> </a>
</p>
<%next%>
<% end if %>


