���ܣ������ϴ�ͼƬ
���̣��������ϴ�ͼƬ��Ȼ��ͼƬת����ʱ����ļ��������ļ���д�����ݿ⡣
ԭ������Ա������ϴ���ͼ���ܣ����½�һ�ݲ��Ա����¼���༭ʱ���ϴ�ͼƬ�ļ�������Ӧ�ļ�¼�е�ĳ���ֶ����tbl_report���е�һ����¼��rptRedminePic��
�ļ���
plupload.full.min.js
uploadRedmine2.js
upload2.asp



sltReportEdit.asp   �༭
<!--  �ϴ�ͼƬ�ؼ�	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>


<!-- �ϴ�ͼƬ������ pjtId, platformId -->
<div class="col-md-12">
<div id="container2">
<a id="pickfiles2" >��ѡ��ͼƬ</a>														
<div id="filelist2"></div>				
<br>
<a id="uploadfiles2" href="javascript:;"><button type="submit" class="btn btn-success pull-left" href="#">�ϴ�</button></a> 
</div>	
<script id="testScript2" src="upload/js/uploadRedmine2.js" pjtId="<%=pjtId%>" platformId="<%=platformId%>"></script>						</div>
			
			
<!--  ��ʾ�ϴ���ͼƬ --> 
<div class="col-md-12">		
<%rptRedminePic = split(replace(rs("rptRedminePic"),"*",""),",")					
for i=1 to ubound(rptRedminePic)%>				
<p><img src=<%="upload\plupload\"+rptRedminePic(i)%>>					
<h3><% response.write "��ͼ"&i %></h3><br>
</p>				
<%next%>
</div>


sltReportShow.asp  ��ʾ
<!--  �ϴ�ͼƬ�ؼ�	-->	
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<!--  ��ʾͼƬ --> 
<% if rs("rptHardPic") <> "*" then  
rptHardPic = split(replace(rs("rptHardPic"),"*",""),",")					
for i=1 to ubound(rptHardPic)	%>				
<p><a href="sltReportShowDel-<%=pjtId%>-<%=platformId%>-<%=rptHardPic(i)%>.html" onClick="return confirm('�Ƿ�Ҫɾ����ͼƬ��')" >
<img src=<%="upload\plupload\"+rptHardPic(i)%>> </a>
</p>
<%next%>
<% end if %>


