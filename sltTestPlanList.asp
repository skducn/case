<!--#include file="frame.asp"-->


<% 
set rs5 = server.createobject("adodb.recordset")
rs5.open "select * from tbl_plan where planId="&request("planId")&"",conn,3,3
if rs5.recordcount =0 then
	response.Redirect("index.html")
else
	pjtId = rs5("plan_pjtId")
	platformId = rs5("plan_platformId")
end if 

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

<title><%=pjtName%>_<%=platformName%>_测试计划_<%=year(now)%><%=month(now)%><%=day(now)%></title>
			
<div class="content-wrapper">
	
	
	<div class="card">				
		
		
		<div class="row">
			<div class="col-md-12">
				<h1>
				<div align="center"><%=pjtName%> <%=platformName%> 测试计划</div>				
				</h1>		
			</div>		
			
		</div>				
		
		<hr>
		
		<h2>一、概述 </h2>
													
		<div class="col-md-12">	
			<h3 class="box-title"> 1.1 目的</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planGoal"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 1.2 背景</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planScene"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 1.3 术语与参考</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planInfo"),chr(13),"<BR>")%></p>				
		</div>	
				
						
		<div class="row"></div>
		<br>
		
		
		<h2>二、约定 </h2>
													
		<div class="col-md-12">	
			<h3 class="box-title"> 2.1 测试任务</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planTask"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 2.2 人员和设备</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planSource"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 2.3 条件（输入、输出）</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planInOut"),chr(13),"<BR>")%></p>				
		</div>	
	
		
		<div class="col-md-12">
			<div class="form-group">
				<h3>2.4 测试进度</h3>
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
							
		<div class="row"></div>
		<br>
		
		
		<h2>三、测试种类及测试标准 </h2>
													
		<div class="col-md-12">	
			<h3 class="box-title"> 3.1 接口测试阶段</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planInterface"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.2 功能测试阶段</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planFunc"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.3 系统测试阶段</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planSystem"),chr(13),"<BR>")%></p>				
		</div>		
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.4 性能测试阶段</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planPerformance"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.5 兼容测试阶段</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planCompatible"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 3.6 自动化测试</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planAuto"),chr(13),"<BR>")%></p>				
		</div>					
				
		
		<div class="row"></div>
		<br>
		
		
		<h2>四、测试方案 </h2>
													
		<div class="col-md-12">	
			<h3 class="box-title"> 4.1 缺陷优先级</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planDefect"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 4.2 测试方法、策略</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planWay"),chr(13),"<BR>")%></p>				
		</div>	
		
		<div class="col-md-12">	
			<h3 class="box-title"> 4.3 测试约束条件</h3>						
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planLimit"),chr(13),"<BR>")%></p>				
		</div>	
		
					

		<div class="row"></div>
		<br>
		
		
		<h2>五、风险估算 </h2>
													
		<div class="col-md-12">	
								
			<p style="font-size:18px;line-height:160%;letter-spacing:1px;"><%=replace(rs3("planRisk"),chr(13),"<BR>")%></p>				
		</div>	
		
					
					
			
			<div class="row">
			<div class="col-md-12" align="right">	
			<hr>
			<%if rs3("planAuthor") = session("userName") then%>
				<a class='btn btn-warning' href='sltPlanEdit-<%=rs3("plan_pjtId")%>-<%=rs3("plan_platformId")%>.html' data-toggle="tooltip" data-original-title="编辑"><i class='fa fa-edit'></i></a>		
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





</body>
</html>

 <!-- Javascripts-->
<script src="731/dist/js/jquery-2.1.4.min.js"></script>
<script src="731/dist/js/bootstrap.min.js"></script>
<script src="731/dist/js/plugins/pace.min.js"></script>
<script src="731/dist/js/main.js"></script>
	