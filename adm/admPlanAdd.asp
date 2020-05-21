<!--#include file="admframe.asp"-->

<title>后台-新建计划 | <%=cstCompany%></title>


<script type="text/javascript" src="upload/js/plupload.full.min.js"></script>

<script language="javascript">     
function CheckPost()
{			
	//提交前弹框确认		
	var gnl=confirm("确定要提交?");
	if (gnl==true){
		return true;
	}else{
		return false;
	}
}

function CheckPostCopy()
{			
	//提交前弹框确认		
	var gnl=confirm("导入模块后自动提交，确定要导入模板?");
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

	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_platform where platformId="&platformId&" order by platformId desc",conn,3,3
	rs("verIsPlan") = "on"
	rs.update
	rs.close
	set rs = nothing
	
	response.Redirect("admTestPlanList-"&pjtId&"-"&platformId&".html")
end if 


'导入模板'

if request("action") = "copy" then
	pjtId = request("pjtId")
	platformId = request("platformId")
	set rs = server.createobject("adodb.recordset")
	rs.open "select * from tbl_plan where plan_pjtId="&pjtId&" and plan_platformId="&platformId&" order by planId desc",conn,3,3
	if rs.eof then
		rs.addnew
		rs("plan_pjtId") = pjtId
		rs("plan_platformId") = platformId
	end if 
	
	rs("planGoal") = "完成整个系统的测试及验证软件的基本可用性，功能的完整性，数据的准确性等。"
	
	rs("planInfo") = "冒烟测试：本次需求中主业务流程测试要求通过<br>" &chr(13)&chr(10) & _
"正常测试：本次需求功能测试要求通过<br>" &chr(13)&chr(10) & _
"回归测试：预发布环境主业务流程测试要求通过"
		
	rs("planTask") = "A．与《XXX系统需求分析说明书》比较，检查此软件所完成的功能，是否与上面两个说明书相符合；<br>"&chr(13)&chr(10) & _
"B．数据业务是否能够正确完成；<br>"&chr(13)&chr(10) & _
"C．整个系统是否能够稳定的运行；<br>"&chr(13)&chr(10) & _
"D．帮助等其他安装说明文件是否表达准确。"

	rs("planSource") = request("planSource")
	
	rs("planInOut") = "1、需求业务描述的完整性、正确性，且评审通过。（如产品线框图、设计图）<br>" &chr(13)&chr(10) & _
"2、开发交付物质量评估，通过冒烟测试判断是否可继续测试，如缺陷a,b类累计超过测试用例30%或堵塞主业务流程的测试用例而无法继续冒烟测试，则暂停测试，退回开发。"

	rs("planInterface") = "A. 依据接口文档，测试验证正确及异常参数的返回结果；<br>" &chr(13)&chr(10) & _
"B. 依据时间进度，部署接口自动化方案，验证接口返回值及数据库值。<br>"&chr(13)&chr(10) & _
"通过标准：正确及异常参数都通过。"

	rs("planFunc") = "A．依据测试用例进行测试；<br>"&chr(13)&chr(10) & _
"B．第一轮冒烟测试通过标准：主业务流程及主要功能测试通过；<br>"&chr(13)&chr(10) & _
"C．第二轮正常测试通过标准：所有功能测试通过；"&chr(13)&chr(10) & _
"D．第三轮回归测试通过标准：各业务场景主流程及主要功能回归通过；<br>"&chr(13)&chr(10) & _
"通过标准：三轮都测试通过。"

	rs("planSystem")= "A．依据需求规格说明书中的业务场景或流程；<br>"&chr(13)&chr(10) & _
"B．场景测试：检查系统所完成的各业务场景流程是否正确。<br>"&chr(13)&chr(10) & _
"C．数据流测试：本系统所涉及的相关数据，是否按照正确的业务流程流动，每个阶段所反映的数据结果是否正确。<br>"&chr(13)&chr(10) & _
"通过标准：主业务场景通过。"

	rs("planPerformance") = request("planPerformance")
	
	rs("planCompatible")= "A．依据时间进度，遍历各操作系统常用的浏览器或客户端手机等，并检查其他软件并行时是否运行正确；<br>"&chr(13)&chr(10) & _
"B．平台：windows、mac系统 ；<br> "&chr(13)&chr(10) & _
"C．浏览器：google、firefox、360浏览器双核、safari；<br>"&chr(13)&chr(10) & _
"D．客户端：android\iOS等。<br>"&chr(13)&chr(10) & _
"E．第三方平台兼容性测试等。"
	

	rs("planAuto") = "A．依据项目时间进度，部署自动化回归测试。<br>"&chr(13)&chr(10) & _
"B．功能、系统、回归测试通过，且稳定的主要功能（譬如：涉及金额、数量、权限、注册、状态等）或主业务场景才可接入自动化。<br>"&chr(13)&chr(10) & _
"C．依据项目的需要及时间进度，部署自动化定时执行。<br>"&chr(13)&chr(10) & _
"通过标准：半自动化测试通过。"

	rs("planDefect") = request("planDefect")

	rs("planWay") = "测试方法采用手工与自动化相结合"
	
	rs("planLimit") = "测试边界的定义，当测试的软件需要有一定的网络环境，但本次测试只测试软件功能，默认网络环境为正常。<br>"&chr(13)&chr(10) & _
"本次测试暂不考虑用户体验。"

	rs("planRisk") = "在测试过程中，可能会遇到产品、开发、测试人员由于出差、请假等原因造成沟通确认延迟，从而影响项目进度。<br>"&chr(13)&chr(10) & _
"软硬件资源限制会造成遍历无法全覆盖，譬如客户端app测试等。<br>"&chr(13)&chr(10) & _
"测试人员使用的工具与方法可能导致测试不充分。<br>"&chr(13)&chr(10) & _
"需求优先级发生变化或变更等原因而造成业务逻辑的改变，从而影响产品的质量。<br>"&chr(13)&chr(10) & _
"项目出于某种原因被暂停，如服务器硬件、人员等。<br>"&chr(13)&chr(10) & _
"项目暂停后重启该项目测试的条件需要明确。"
	rs("planCreatedDate") = now()	
	rs.update
	rs.close
	set rs = nothing	
	response.Redirect("admPlanAdd-"&pjtId&"-"&platformId&".html")
end if 
%>

<% pjtId = request("pjtId")
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

<form role="form2" action="admPlanAddCopy.html" method="post" name="addForm" onSubmit="return CheckPostCopy()">			
<input name="pjtId" type="hidden" value="<%=pjtId%>" />
<input name="platformId" type="hidden" value="<%=platformId%>" />
<input name="planCreatedDate" type="hidden" value="<%=now%>" />		
<button type="submit" class="btn btn-danger" href="#">导入模板</button>
</form>

	<form role="form" action="admPlanAddSubmit.html" method="post" name="addForm" onSubmit="return CheckPost()" >		

<div class="content-wrapper">
	<div class="row page-tilte align-items-center">
		<div class="col-md-auto">
			<a href="#" class="mt-3 d-md-none float-right toggle-controls"><span class="material-icons">keyboard_arrow_down</span></a>
			<h1 class="weight-300 h3 title"><span class="nav-icon material-icons ">date_range</span>计划管理 - 新建计划</h1>
			<p class="text-muted m-0 desc">Plan management</p>
		</div> 
		<div class="col controls-wrapper mt-3 mt-md-0 d-none d-md-block ">
			<div class="controls d-flex justify-content-center justify-content-md-end"></div>
		</div>
	</div> 

	<div class="content">
		<div class="row">
			<div class="col-lg-12">
				<div class="card mb-4">
					<div class="card-body">	
						<div class="row">		
							<div class="col-md-12">	
								<h3 class="box-title" align="center"><%=pjtName%> - <%=platformName%></h3>															
							</div>
							<div class="col-md-12">	
								<h3 class="box-title">一、概述</h3>					
								<label>1.1 编写目的</label>
								<textarea  name="planGoal" class="form-control" rows="5" placeholder="描述编写的目的、约定和文档的编排方式"><%if x<>0 then response.write rs3("planGoal") end if %></textarea>						
								<label>1.2 背景</label>
								<textarea  name="planScene" class="form-control" rows="5" placeholder="描述项目背景"><%if x<>0 then response.write rs3("planScene") end if %></textarea>						
								<label>1.3 术语与参考</label>
								<textarea  name="planInfo" class="form-control" rows="5" placeholder="请填写参考资料与术语解释"><%if x<>0 then response.write rs3("planInfo") end if %></textarea>			
												
								<p></p>											
								<h3 class="box-title">二、约定</h3>
									   
								<label>2.1 测试目的与任务</label>
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
			<td>阶段1、需求分析（产品、开发的文档等）</td>
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
				<textarea  name="planInterface" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.2 功能测试阶段</label>
				<textarea  name="planFunc" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.3 系统测试阶段</label>
				<textarea  name="planSystem" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.4 性能测试阶段</label>
				<textarea  name="planPerformance" class="form-control" rows="5" placeholder="Enter ..."></textarea>
				<label>3.5 兼容测试阶段</label>
				<textarea  name="planCompatible" class="form-control" rows="5" placeholder="Enter ..."></textarea>			
				<label>3.6 自动化测试</label>
				<textarea  name="planAuto" class="form-control" rows="5" placeholder="Enter ..."></textarea>			
				</div>
			</div>
	
			<p></p>
			<h3 class="box-title">四、测试方案</h3>
			<br>
			<div class="row">
				<div class="col-md-12">
				<label>4.1 缺陷优先级</label>
				<textarea  name="planDefect" class="form-control" rows="6" placeholder="Enter ..."></textarea>						
				<label>4.2 测试方法、策略</label>
				<textarea  name="planWay" class="form-control" rows="6" placeholder="Enter ..."></textarea>						
				<label>4.3 测试约束条件</label>
				<textarea  name="planLimit" class="form-control" rows="6" placeholder="Enter ..."></textarea>						
				</div>
			</div> 
		
			<p></p>
			<h3 class="box-title">五、风险估算</h3>
			<br>
			<div class="row">
				<div class="col-md-12">			
				<textarea  name="planRisk" class="form-control" rows="6" placeholder="Enter ..."><%if x<>0 then response.write rs3("planRisk") end if %></textarea>
				</div> 						
			</div>
						
			
		
					
							<div class="col-md-12">		
								<br />  			
								<input name="pjtId" type="hidden" value="<%=pjtId%>" />
								<input name="platformId" type="hidden" value="<%=platformId%>" />
								<input name="planCreatedDate" type="hidden" value="<%=now%>" />
							<div align="center"><button type="submit" class="btn btn-primary"  href="#">提交</button></div>									
				
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
<!-- Select2 -->
<script src="../plugins/select2/select2.full.min.js"></script>
<!-- InputMask -->
<script src="../plugins/input-mask/jquery.inputmask.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min.js"></script>
<script src="../plugins/daterangepicker/daterangepicker.js"></script>
<!-- bootstrap color picker -->
<script src="../plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="../plugins/timepicker/bootstrap-timepicker.min.js"></script>
<!-- SlimScroll 1.3.0 -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- iCheck 1.0.1 -->
<script src="../plugins/iCheck/icheck.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>


<script>
  $(function () {
    //Initialize Select2 Elements
    $(".select2").select2();
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
