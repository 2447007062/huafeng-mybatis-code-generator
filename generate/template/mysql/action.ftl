package ${packageName}.${moduleName}.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.context.annotation.Scope;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.rongdu.eloan.modules.system.domain.SysUser;
import com.rongdu.eloan.common.context.Constant;
import com.rongdu.eloan.common.utils.JsonUtil;
import com.rongdu.eloan.common.utils.ServletUtils;
import com.rongdu.eloan.common.utils.validator.ValidatorUtil;
import com.rongdu.eloan.common.web.action.BaseAction;
import ${packageName}.${moduleName}.domain.${ClassName};
import com.rongdu.eloan.modules.common.exception.ServiceException;
import ${packageName}.${moduleName}.service.${ClassName}Service;

/**
 * User:    ${classAuthor}
 * DateTime:${classDate}
 * details: ${functionName},Action请求层
 */
@RequestMapping("/modules/${moduleName}/${className}")
@Controller
public class ${ClassName}Action extends BaseAction {

    /**
     * ${functionName}的Service
     */
	@Autowired
	private ${ClassName}Service ${className}Service;

    /**
     * ${functionName}表,插入数据
     * @param request	页面的request
     * @param response	页面的response
     * @param ${className}Bean	页面参数
     * @throws Exception
     */
    @RequestMapping("/saveOrUpdate.htm")
    public void saveOrUpdate(HttpServletRequest request, HttpServletResponse response, 
        ${ClassName} ${className}Bean) throws Exception {

		SysUser sysUser = this.getLoginUser(request);

		//校验注解规则
		ValidatorUtil.validateDomain(${className}Bean);

		${className}Service.saveOrUpdate(${className}Bean, sysUser);

		//返回成功
		ServletUtils.writeToSuccess(response);
    }

    /**
     * 分页查询数据
     * @param request      页面的request
     * @param response      页面的response
     * @param currentPage   当前页数
     * @param pageSize      每页限制
     * @param searchParams   查询条件
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/get${ClassName}List.htm")
    public void get${ClassName}List(HttpServletResponse response, HttpServletRequest request,
		@RequestParam(value = "currentPage") Integer currentPage,
		@RequestParam(value = "pageSize") Integer pageSize,
  		@RequestParam(value = "searchParams", required = false) String searchParams) throws Exception{
		Map<String, Object> paramap = new HashMap<>();
		//对json对象进行转换
		if (!StringUtils.isEmpty(searchParams)){
			paramap = JsonUtil.parse(searchParams, Map.class);
		}
		PageHelper.startPage(currentPage, pageSize);
		List<${ClassName}> list = ${className}Service.getPageListByMap(paramap);
		PageInfo<${ClassName}> page = new PageInfo<${ClassName}>(list);

		// 返回给页面
		ServletUtils.writeToResponse(response, page.getList(), page.getTotal());
    }
    
    /**
    * 根据id删除数据
    * @param response    页面的response
    * @param id          主键
    * @throws Exception
    */
    @RequestMapping("/get${ClassName}ById.htm")
    public void get${ClassName}ById(HttpServletResponse response ,  Long id) throws Exception{
        ${ClassName} ${className} = ${className}Service.get${ClassName}ById(id);
        Map<String, Object> data = new HashMap<>();
        data.put("${className}",${className});
        data.put(Constant.RESPONSE_CODE, Constant.SUCCEED_CODE_VALUE);
        ServletUtils.writeToResponse(response, data);
    }
    /**
    * 根据id删除数据
    * @param response    页面的response
    * @param id          主键
    * @throws Exception
    */
    @RequestMapping("/deleteById.htm")
    public void deleteById(HttpServletResponse response
    , @RequestParam(value = "id") long id) throws Exception{

		if(${className}Service.deleteById(id) != 1){
			throw new ServiceException("根据id删除错误");
		}

		//返回成功
		ServletUtils.writeToSuccess(response);
    }
}
