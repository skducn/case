<!--#include file="admframe.asp"-->

<title><%=admPlanEdit%> | <%=admProject%></title>
<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<script language="javascript">     
function CheckPost()
{			
	//提交前弹框确认		
	var gnl=confirm("确定要保存?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}

</script>

<!--  新建测试计划 -->	

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
	rs("planCreatedDate") = now()	
	rs.update
	rs.close
	set rs = nothing	
	response.Redirect("admTestPlan-"&pjtId&"-"&platformId&".html")
end if 


 pjtId = request("pjtId")
platformId = request("platformId")

set rs = server.createobject("adodb.recordset")
rs.open "select * from tbl_project where pjtId="&pjtId&" order by pjtId desc",conn,3,3
pjtName = rs("pjtName")
set rs2 = server.createobject("adodb.recordset")
rs2.open "select * from tbl_platform where plat_pjtId="&pjtId&" and platformId="&platformId&" order by platformId desc",conn,3,3
pjtRedmine = rs2("platformRedmine")
platformName = rs2("platformName")
rs2.close
rs.close
set rs2 = nothing
set rs = nothing

set rs3 = server.createobject("adodb.recordset")
rs3.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
x = rs3.recordcount
%>


<form role="form" action="admPlanAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >	
	

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title">计划管理</h1>
			<p class="text-muted m-0 desc">Project management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-12">
				<div class="card mb-4">
					<div class="card-header">编辑计划 - <%=pjtName%> - <%=platformName%></div>
					<div class="card-body">	
						<div class="row">	
							
	
							
			<div class="col-md-12">	
			
				<h3 class="box-title">一、概述</h3>
				<br>				
		
									
				<label>1.1 目的</label>
				<textarea  name="planGoal" class="form-control" rows="5" placeholder="描述编写的目的、约定和文档的编排方式"><%if x<>0 then response.write rs3("planGoal") end if %></textarea>						
				<label>1.2 背景</label>
				<textarea  name="planScene" class="form-control" rows="5" placeholder="描述项目背景"><%if x<>0 then response.write rs3("planScene") end if %></textarea>						
				<label>1.3 术语与参考</label>
				<textarea  name="planInfo" class="form-control" rows="5" placeholder="请填写参考资料与术语解释"><%if x<>0 then response.write rs3("planInfo") end if %></textarea>			
			
							
			<p></p>			
			<h3 class="box-title">二、约定</h3>
			<br>
		

			<label>2.1 测试任务</label>
			<textarea  name="planTask" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planTask") end if %></textarea>
			<label>2.2 人员和设备</label>
			<textarea  name="planSource" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planSource") end if %></textarea>
			<label>2.3 条件（输入、输出）</label>
			<textarea  name="planInOut" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planInOut") end if %></textarea>
					
				
			<label>2.4 测试进度</label>
			<table class="table table-bordered">
			<tr>               
			<th style="width: 20%">测试阶段</th>
			<th style="width: 40%">测试任务</th>
			<th style="width: 15%">工作量/人员</th>
			<th style="width: 25%">起止时间</th>
			</tr>
			
			<tr>
			<td>阶段1、需求分析<br>（产品、开发的文档等）</td>
			<td>
			<textarea  name="plan1Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan1Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan1Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan1Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">			
				<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
				<input type="text" name="plan1Date" class="form-control pull-right" id="reservation1" value=<%if x<>0 then response.write rs3("plan1Date") end if %>>
			</div>
	
			</td>
			</tr>			

			<tr>			
			<td>阶段2、设计编写用例</td>
			<td>
			<textarea  name="plan2Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan2Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan2Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan2Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan2Date" class="form-control pull-right" id="reservation2" value=<%if x<>0 then response.write rs3("plan2Date") end if %>>
			</div>
		
			</td>
			</tr>
			
			<tr>
			<td>阶段3、接口测试</td>
			<td>
			<textarea  name="plan3Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan3Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan3Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan3Work") end if %></textarea>
			</td>
			<td>
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan3Date" class="form-control pull-right" id="reservation3" value=<%if x<>0 then response.write rs3("plan3Date") end if %>>
			</div>
	
			</td>
			</tr>
					
			<tr>
			<td>阶段4、功能测试</td>
			<td>
			<textarea  name="plan4Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan4Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan4Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan4Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan4Date" class="form-control pull-right" id="reservation4" value=<%if x<>0 then response.write rs3("plan4Date") end if %>>
			</div>
	
			</td>
			</tr>
					
			<tr>
			<td>阶段5、系统测试</td>
			<td>
			<textarea  name="plan5Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan5Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan5Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan5Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan5Date" class="form-control pull-right" id="reservation5" value=<%if x<>0 then response.write rs3("plan5Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>阶段6、性能测试</td>
			<td>
			<textarea  name="plan6Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan6Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan6Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan6Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan6Date" class="form-control pull-right" id="reservation6" value=<%if x<>0 then response.write rs3("plan6Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>阶段7、兼容测试</td>
			<td>
			<textarea  name="plan7Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan7Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan7Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan7Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan7Date" class="form-control pull-right" id="reservation7" value=<%if x<>0 then response.write rs3("plan7Date") end if %>>
			</div>
	
			</td>
			</tr>
					
			<tr>
			<td>阶段8、回归测试</td>
			<td>
			<textarea  name="plan8Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan8Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan8Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan8Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan8Date" class="form-control pull-right" id="reservation8" value=<%if x<>0 then response.write rs3("plan8Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>阶段9、自动化测试</td>
			<td>
			<textarea  name="plan9Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan9Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan9Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan9Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan9Date" class="form-control pull-right" id="reservation9" value=<%if x<>0 then response.write rs3("plan9Date") end if %>>
			</div>
		
			</td>
			</tr>
					
			<tr>
			<td>阶段10、其他测试</td>
			<td>
			<textarea  name="plan10Task" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan10Task") end if %></textarea>
			</td>
			<td>
			<textarea  name="plan10Work" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("plan10Work") end if %></textarea>
			</td>
			<td>
			<!-- Date range -->
			<div class="input-group">
			<div class="input-group-addon"><i class="fa fa-calendar"></i></div>
			<input type="text" name="plan10Date" class="form-control pull-right" id="reservation10" value=<%if x<>0 then response.write rs3("plan10Date") end if %>>
			</div>
	
			</td>
			</tr>
					
			</table>
		
					
			
							<h3 class="box-title">三、测试种类及测试标准</h3>
							<br>
							<div class="row">
							<div class="col-md-12">
								<label>3.1 接口测试阶段</label>
								<textarea  name="planInterface" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planInterface") end if %></textarea>
								<label>3.2 功能测试阶段</label>
								<textarea  name="planFunc" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planFunc") end if %></textarea>
								<label>3.3 系统测试阶段</label>
								<textarea  name="planSystem" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planSystem") end if %></textarea>
								<label>3.4 性能测试阶段</label>
								<textarea  name="planPerformance" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planPerformance") end if %></textarea>
								<label>3.5 兼容测试阶段</label>
								<textarea  name="planCompatible" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planCompatible") end if %></textarea>		
								<label>3.6 自动化测试</label>
								<textarea  name="planAuto" class="form-control" rows="5" placeholder="Enter ..."><%if x<>0 then response.write rs3("planAuto") end if %></textarea>		
								</div>
							</div>
	
							<p></p>
							<h3 class="box-title">四、测试方案</h3>
							<br>
							<div class="row">
								<div class="col-md-12">
								<label>缺陷优先级</label>
								<textarea  name="planDefect" class="form-control" rows="12" placeholder="Enter ..."><%if x<>0 then response.write rs3("planDefect") end if %></textarea>					
								<label>测试方法、策略</label>
								<textarea  name="planWay" class="form-control" rows="6" placeholder="Enter ..."><%if x<>0 then response.write rs3("planWay") end if %></textarea>					
								<label>测试约束条件</label>
								<textarea  name="planLimit" class="form-control" rows="6" placeholder="Enter ..."><%if x<>0 then response.write rs3("planLimit") end if %></textarea>					
								</div>
							</div> 
		
							<p></p>
							<h3 class="box-title">五、风险估算</h3>
							<br>
							<div class="row">
								<div class="col-md-12">			
								<textarea  name="planRisk" class="form-control" rows="8" placeholder="Enter ..."><%if x<>0 then response.write rs3("planRisk") end if %></textarea>
								</div> 						
							</div>
				
						
							<div class="col-md-12">		
								<br />  
								<input name="pjtId" type="hidden" value="<%=pjtId%>" />
								<input name="platformId" type="hidden" value="<%=platformId%>" />
								<input name="planCreatedDate" type="hidden" value="<%=now%>" />						
								
								<div align="center"><button type="submit" class="btn btn-primary"  href="#">保存</button></div>
								<br>
							</div>
							
						</div><!-- /.row -->					
					</div>
				</div>	 
			</div> <!-- /.col -->
		</div><!-- /.row -->
	</div><!-- /.content -->
</div>
</form>



<!-- jQuery 2.1.4 -->
<script src="../plugins/jQuery/jQuery-2.1.4.min.js"></script>
<!-- Bootstrap 3.3.5 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>

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
