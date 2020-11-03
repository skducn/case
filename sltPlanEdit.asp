<!--#include file="frame.asp"-->

<title><%=cstEditPlan%> | <%=cstCompany%></title>

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

<!--  编辑测试计划 -->	

<%
if request("action") = "submit" then
	pjtId = request("pjtId")
	platformId = request("platformId")

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("plan_pjtId") = pjtId
		rs("plan_platformId") = platformId
	end if 
	rs("planGoal") = request("planGoal")
	rs("planScene") = request("planScene")
	rs("planInfo") = request("planInfo")
	rs("planTask") = request("planTask")
	rs("planSource") = request("planSource")
	rs("planInOut") = request("planInOut")
	rs("plan1Task") = request("plan1Task")
	rs("plan1Work") = request("plan1Work")
	rs("plan1Date") = request("plan1Date")
	rs("plan2Task") = request("plan2Task")
	rs("plan2Work") = request("plan2Work")
	rs("plan2Date") = request("plan2Date")
	rs("plan3Task") = request("plan3Task")
	rs("plan3Work") = request("plan3Work")
	rs("plan3Date") = request("plan3Date")
	rs("plan4Task") = request("plan4Task")
	rs("plan4Work") = request("plan4Work")
	rs("plan4Date") = request("plan4Date")
	rs("plan5Task") = request("plan5Task")
	rs("plan5Work") = request("plan5Work")
	rs("plan5Date") = request("plan5Date")
	rs("plan6Task") = request("plan6Task")
	rs("plan6Work") = request("plan6Work")
	rs("plan6Date") = request("plan6Date")
	rs("plan7Task") = request("plan7Task")
	rs("plan7Work") = request("plan7Work")
	rs("plan7Date") = request("plan7Date")
	rs("plan8Task") = request("plan8Task")
	rs("plan8Work") = request("plan8Work")
	rs("plan8Date") = request("plan8Date")
	rs("plan9Task") = request("plan9Task")
	rs("plan9Work") = request("plan9Work")
	rs("plan9Date") = request("plan9Date")
	rs("plan10Task") = request("plan10Task")
	rs("plan10Work") = request("plan10Work")
	rs("plan10Date") = request("plan10Date")
	rs("planInterface") = request("planInterface")
	rs("planFunc") = request("planFunc")
	rs("planSystem")= request("planSystem")
	rs("planPerformance")= request("planPerformance")
	rs("planCompatible") = request("planCompatible")
	rs("planAuto") = request("planAuto")
	rs("planDefect") = request("planDefect")	
	rs("planWay") = request("planWay")	
	rs("planLimit") = request("planLimit")	
	rs("planRisk") = request("planRisk")	
	rs("planAuthor") = session("userName")
	rs("planLatestDate") = now()	
	rs.update
	planId = rs("planId")
	rs.close
	set rs = nothing	
	response.Redirect("sltTestPlanList-"&planId&".html")
end if 

%>

<% 
'set rs5 = server.createobject("adodb.recordset")
'rs5.open "select * from tbl_plan where planId="&request("planId")&"",conn,3,3
'if rs5("planAuthor") <> session("userName") then
'	response.Redirect("index.html")
'end if 
pjtId = request("pjtId")
platformId = request("platformId")

set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtId="&int(pjtId)&" order by pjtId desc",conn,3,3
pjtName = rs("pjtName")
set rs2 = server.createobject("adodb.recordset")
rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
if rs2.eof then
	response.Redirect("index.html")
else
pjtRedmine = rs2("platformRedmine")
platformName = rs2("platformName")
end if 
rs2.close
rs.close
set rs2 = nothing
set rs = nothing

set rs3 = server.createobject("adodb.recordset")
rs3.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
x = rs3.recordcount
%>


<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> 计划管理 - 编辑计划</h1><p>Testplan panel</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">计划管理</a></li></ul></div>
	</div>
	
	<div class="card">	
		<form role="form" action="sltPlanEditSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
		<div class="row">
			<div class="col-md-6" align="left">
				<h3 class="box-title"><%=pjtName%> - <%=platformName%></h3>	
			</div>
			<div class="col-md-6" align="right">	
				<button type="submit" class="btn btn-primary " href="#"><i class="fa fa-fw  fa-check-circle"></i>保存</button>				
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>
			</div>	
		</div>
	
		<hr>																					
		
		<h3 class="box-title">一、概述</h3>
						
		<div class="row">
			<div class="col-md-4">						
				<h4>1.1 编写目的</h4>
				<textarea  name="planGoal" class="form-control" rows="5" placeholder="描述编写的目的、约定和文档的编排方式"><%=rs3("planGoal")%></textarea>						
			</div>			
			<div class="col-md-4">	
				<h4>1.2 背景</h4>
				<textarea  name="planScene" class="form-control" rows="5" placeholder="描述项目背景"><%=rs3("planScene")%></textarea>						
			</div>		
			<div class="col-md-4">	
				<h4>1.3 术语与参考</h4>
				<textarea  name="planInfo" class="form-control" rows="5" placeholder="请填写参考资料与术语解释"><%=rs3("planInfo")  %></textarea>			
			</div>	
		</div>
						
								
		<h3 class="box-title">二、约定</h3>

		<div class="row">
			<div class="col-md-4">	
				<h4>2.1 测试目的与任务</h4>
				<textarea  name="planTask" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planTask")%></textarea>
			</div>
			<div class="col-md-4">	
				<h4>2.2 人员和设备</h4>
				<textarea  name="planSource" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planSource") %></textarea>
			</div>
			<div class="col-md-4">	
				<h4>2.3 条件（输入、输出）</h4>
				<textarea  name="planInOut" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planInOut")  %></textarea>
			</div>
					
			<div class="col-md-12"><br>		
			<h4>2.4 测试进度</h4>
			<table class="table table-bordered">
			<tr>               
			<th style="width: 20%" bgcolor="#f1f1f1">测试阶段</th>
			<th style="width: 30%" bgcolor="#f1f1f1">测试任务</th>
			<th style="width: 30%" bgcolor="#f1f1f1">工作量/人员</th>
			<th style="width: 20%" bgcolor="#f1f1f1">起止时间</th>
			</tr>			
			<tr>
			<td>阶段1、需求分析<br>（产品、开发的文档等）</td>
			<td>
			<textarea  name="plan1Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan1Task")  %></textarea>
			</td>
			<td>
			<textarea  name="plan1Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan1Work") %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">			
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>				
				<input type="text" name="plan1Date" class="form-control pull-right" id="reservation1" value="<%=rs3("plan1Date")  %>">
			</div>
			</td>
			</tr>			
			<tr>			
			<td>阶段2、设计编写用例</td>
			<td>
			<textarea  name="plan2Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan2Task")  %></textarea>
			</td>
			<td>
			<textarea  name="plan2Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan2Work")  %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan2Date" class="form-control pull-right" id="reservation2" value="<%=rs3("plan2Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>阶段3、接口测试</td>
			<td>
			<textarea  name="plan3Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan3Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan3Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan3Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan3Date" class="form-control pull-right" id="reservation3" value="<%=rs3("plan3Date") %>">
			</div>
			</td>
			</tr>				
			<tr>
			<td>阶段4、功能测试</td>
			<td>
			<textarea  name="plan4Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan4Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan4Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan4Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan4Date" class="form-control pull-right" id="reservation4" value="<%=rs3("plan4Date") %>">
			</div>
			</td>
			</tr>			
			<tr>
			<td>阶段5、系统测试</td>
			<td>
			<textarea  name="plan5Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan5Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan5Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan5Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan5Date" class="form-control pull-right" id="reservation5" value="<%=rs3("plan5Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>阶段6、性能测试</td>
			<td>
			<textarea  name="plan6Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan6Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan6Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan6Work") %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan6Date" class="form-control pull-right" id="reservation6" value="<%=rs3("plan6Date") %>">
			</div>
			</td>
			</tr>	
			<tr>
			<td>阶段7、兼容测试</td>
			<td>
			<textarea  name="plan7Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan7Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan7Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan7Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan7Date" class="form-control pull-right" id="reservation7" value="<%=rs3("plan7Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>阶段8、回归测试</td>
			<td>
			<textarea  name="plan8Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan8Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan8Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan8Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan8Date" class="form-control pull-right" id="reservation8" value="<%=rs3("plan8Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>阶段9、自动化测试</td>
			<td>
			<textarea  name="plan9Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan9Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan9Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan9Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan9Date" class="form-control pull-right" id="reservation9" value="<%=rs3("plan9Date") %>">
			</div>
			</td>
			</tr>
			<tr>
			<td>阶段10、其他测试</td>
			<td>
			<textarea  name="plan10Task" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan10Task") %></textarea>
			</td>
			<td>
			<textarea  name="plan10Work" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("plan10Work") %></textarea>
			</td>
			<td>
			<div class="input-group">
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan10Date" class="form-control pull-right" id="reservation10" value="<%=rs3("plan10Date") %>">
			</div>
			</td>
			</tr>		
			</table>
			</div>
		</div> 
					
			
		<h3 class="box-title">三、测试种类及测试标准</h3>

		<div class="row">
			<div class="col-md-4">
				<h4>3.1 接口测试阶段</h4>
				<textarea  name="planInterface" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planInterface") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.2 功能测试阶段</h4>
				<textarea  name="planFunc" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planFunc") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.3 系统测试阶段</h4>
				<textarea  name="planSystem" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planSystem") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.4 性能测试阶段</h4>
				<textarea  name="planPerformance" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planPerformance") %></textarea>
			</div>
			<div class="col-md-4">
				<h4>3.5 兼容测试阶段</h4>
				<textarea  name="planCompatible" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planCompatible") %></textarea>		
			</div>
			<div class="col-md-4">
				<h4>3.6 自动化测试</h4>
				<textarea  name="planAuto" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planAuto") %></textarea>		
			</div>
		</div>
	
			
		<h3 class="box-title">四、测试方案</h3>

		<div class="row">
			<div class="col-md-4">
				<h4>4.1 缺陷优先级</h4>
				<textarea  name="planDefect" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planDefect") %></textarea>		
			</div>
			<div class="col-md-4">			
				<h4>4.2 测试方法、策略</h4>
				<textarea  name="planWay" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planWay") %></textarea>					
			</div>
			<div class="col-md-4">
				<h4>4.3 测试约束条件</h4>
				<textarea  name="planLimit" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planLimit") %></textarea>					
			</div>
		</div> 
	
		<h3 class="box-title">五、风险估算</h3>

		<div class="row">
			<div class="col-md-12">			
				<textarea  name="planRisk" class="form-control" rows="5" placeholder="Enter ..."><%=rs3("planRisk") %></textarea>
			</div> 						
		</div>				
						
		<input name="pjtId" type="hidden" value="<%=pjtId%>" />
		<input name="platformId" type="hidden" value="<%=platformId%>" />
		<input name="planCreatedDate" type="hidden" value="<%=now%>" />											
				
		<div class="row">
			<div class="col-md-12">		
				<br>  
				<hr>
				<div align="center"><button type="submit" class="btn btn-primary"  href="#"><i class="fa fa-fw  fa-check-circle"></i>&nbsp;保存</button></div>
			</div>
		</div>
			
		</form>

		<div class="row">
			<div class="col-md-12" align="right">	
				
				<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
				<a id='DD'></a>		
			</div>
		</div>

</div>
</div>	







<script src="731/dist/js/plugins/pace.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/bootstrap-notify.min.js"></script>
<script type="text/javascript" src="731/dist/js/plugins/sweetalert.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="/plugins/daterangepicker/daterangepicker.js"></script>
<!-- AdminLTE App -->
<script src="/dist/js/app.min.js"></script>
<script>
$(function () {
//Date range picker
$('#reservation1').daterangepicker();
$('#reservation2').daterangepicker();
$('#reservation3').daterangepicker();
$('#reservation4').daterangepicker();  
$('#reservation5').daterangepicker();  
$('#reservation6').daterangepicker();  
$('#reservation7').daterangepicker();  
$('#reservation8').daterangepicker();  
$('#reservation9').daterangepicker();  
$('#reservation10').daterangepicker();  
});

</script>

</body>
</html>
