<!--#include file="frame.asp"-->

<title>测试计划列表 | <%=cstCompany%></title>

<% 
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

%>


			
<div class="content-wrapper">
	<div class="page-title">
		<div><h1><i class="fa fa-edit"></i> 计划管理 - 计划列表</h1><p>Testplan List</p></div>
		<div><ul class="breadcrumb"><li><i class="fa fa-home fa-lg"></i></li><li><a href="#">计划管理</a></li></ul></div>
	</div>
	
	<div class="card">				
		<div class="row">
			<div class="col-md-6" align="left">
				<h3 class="box-title"><%=pjtName%> <%=platformName%></h3>						
			</div>				
			<div class="col-md-6" align="right">
			<%if rs3("planAuthor") = session("userName") then%>
					
			<%end if %>	
				<a href="#DD" class="btn btn-primary" data-toggle="tooltip" data-original-title="到页底"><i class="fa fa-arrow-circle-down"></i></a>		
			</div>	
		</div>

		<hr>

		<div class="row">
			<div class="col-md-12">
				<div class="box-body">	
						
						<!-- 一、概述  -->		
							
						<h3 class="box-title">一、概述</h3>	
						<div class="row">
							<div class="col-md-4">							
								<h4 class="box-title">1.1 目的</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planGoal")%></textarea></td></tr>
								</table>																	
							</div>
							
							<div class="col-md-4">							
								<h4 class="box-title">1.2 背景</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planScene")%></textarea></td></tr>
								</table>																	
							</div>
							
								<div class="col-md-4">							
								<h4 class="box-title">1.3 术语与参考</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planInfo")%></textarea></td></tr>
								</table>																	
							</div>
						</div>
						<!-- 一、概述 over -->		
			       
	   
						<!-- 二、约定 -->
				
						<h3 class="box-title">二、约定</h3>		
						<div class="row">
							<div class="col-md-4">							
								<h4 class="box-title">2.1 测试任务</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planTask")%></textarea></td></tr>
								</table>																	
							</div>
							
							<div class="col-md-4">
								<h4 class="box-title">2.2 人员和设备</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planSource")%></textarea></td></tr>					
								</table>							
							</div>
							
							<div class="col-md-4">
								<h4 class="box-title">2.3 条件（输入、输出）</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planInOut")%></textarea></td></tr>					
								</table>
							</div>
							
							<div class="col-md-12">
								<div class="form-group">
									<h4 class="box-title">2.4 测试进度</h4>
									<table class="table table-bordered">
									<tr>               
										<th style="width: 20%" bgcolor="f1f1f1">测试阶段</th>
										<th style="width: 30%" bgcolor="f1f1f1">测试任务</th>
										<th style="width: 30%" bgcolor="f1f1f1">工作量/人员</th>
										<th style="width: 20%" bgcolor="f1f1f1">起止时间</th>
									</tr>					
									<tr>
									<td>阶段1：需求分析</td>
									<td><%=replace(rs3("plan1Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan1Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan1Date")%></td>
									</tr>
									
									<tr>
									<td>阶段2：设计编写用例</td>
									<td><%=replace(rs3("plan2Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan2Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan2Date")%></td>
									</tr>
									
									<tr>
									<td>阶段3：接口测试</td>
									<td><%=replace(rs3("plan3Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan3Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan3Date")%></td>
									</tr>
									
									<tr>
									<td>阶段4：功能测试</td>
									<td><%=replace(rs3("plan4Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan4Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan4Date")%></td>
									</tr>
									
									<tr>
									<td>阶段5：系统集成测试</td>
									<td><%=replace(rs3("plan5Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan5Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan5Date")%></td>
									</tr>
									
									<tr>
									<td>阶段6：性能测试</td>
									<td><%=replace(rs3("plan6Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan6Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan6Date")%></td>
									</tr>
									
									<tr>
									<td>阶段7：兼容性测试</td>
									<td><%=replace(rs3("plan7Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan7Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan7Date")%></td>
									</tr>
									
									<tr>
									<td>阶段8：回归测试</td>
									<td><%=replace(rs3("plan8Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan8Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan8Date")%></td>
									</tr>
									
									<tr>
									<td>阶段9：自动化测试</td>
									<td><%=replace(rs3("plan9Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan9Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan9Date")%></td>
									</tr>
									
									<tr>
									<td>阶段10：其他测试</td>
									<td><%=replace(rs3("plan10Task"),chr(13),"<BR>")%></td>
									<td><%=replace(rs3("plan10Work"),chr(13),"<BR>")%></td>
									<td><%=rs3("plan10Date")%></td>
									</tr>
													
									</table>
								</div>							
							</div> <!-- .col --> 	
						</div>  <!-- .row -->    
	
						<!-- 二、约定 -->

	
						<!-- 三、测试种类及测试标准 -->
			
						<h3 class="box-title">三、测试种类及测试标准</h3>
						
						<div class="row">
							<div class="col-md-4">							
								<h4 class="box-title">3.1 接口测试阶段</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planInterface")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">3.2 功能测试阶段</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planFunc")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">3.3 系统测试阶段</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planSystem")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">3.4 性能测试阶段</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planPerformance")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">3.5 兼容测试阶段</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planCompatible")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">3.6 自动化测试</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planAuto")%></textarea></td></tr>
								</table>																	
							</div>
						</div>
			
						<!-- 三、测试种类及测试标准 over -->	
	
	
						<h3 class="box-title">四、测试方案</h3>
				
						<div class="row">
							<div class="col-md-4">							
								<h4 class="box-title">4.1 缺陷优先级</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planDefect")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">4.2 测试方法、策略</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planWay")%></textarea></td></tr>
								</table>																	
							</div>
							<div class="col-md-4">							
								<h4 class="box-title">4.3 测试约束条件</h4>
								<table class="table table-bordered">												
								<tr><td><textarea class="form-control" rows="5" placeholder="无" disabled="disabled"><%=rs3("planLimit")%></textarea></td></tr>
								</table>																	
							</div>			
						</div><!-- /.row -->
		  
	
	
			<h3 class="box-title">五、风险估算</h3>
		
			<div class="row">
				<div class="col-md-12">
					<table class="table table-bordered">												
					<tr><td><textarea class="form-control" rows="8" placeholder="无" disabled="disabled"><%=rs3("planRisk")%></textarea></td></tr>
					</table>		
				</div>  <!-- /.col -->
			</div><!-- /.row -->
			
			<div class="row">
			<div class="col-md-12" align="right">	
			<hr>
			<%if rs3("planAuthor") = session("userName") then%>
					
			<%end if %>	
			<a href="#top"><button type="text" class="btn btn-primary"  href="#" data-toggle="tooltip" data-original-title="回页顶"><i class="fa fa-arrow-circle-up"></i></button></a>	
			<a id='DD'></a>		
			</div>
			</div>
			<%rs3.close%>

</div>
</div>
</div>
</div>  
</div>
</div>
</div>



<script src="/dist/js/app.min.js"></script>
</body>
</html>

 <!-- Javascripts-->
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>
	