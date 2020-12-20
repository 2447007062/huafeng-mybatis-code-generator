package ${packageName}.${moduleName}.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.rongdu.eloan.common.context.Constant;
import com.rongdu.eloan.common.utils.JsonUtil;
import com.rongdu.eloan.common.utils.ServletUtils;
import com.rongdu.eloan.common.web.action.BaseAction;
import ${packageName}.${moduleName}.domain.${ClassName};
import ${packageName}.${moduleName}.service.${ClassName}Service;

/**
 * User:    ${classAuthor}
 * DateTime:${classDate}
 * details: ${functionName},Action请求层
 * source:  代码生成器
 */
@RequestMapping("/modules/${moduleName}/${ClassName}Action")
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
     * @param ${className}	页面参数
     * @throws Exception
     */
    @RequestMapping("/saveOrUpdate${ClassName}.htm")
    public void saveOrUpdate${ClassName}(HttpServletRequest request, HttpServletResponse response, 
    	@RequestParam(value = "${className}", required = false) String ${className}, @RequestParam(value = "status", required = false) String status) throws Exception {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		long influence = 0;
		${ClassName} ${className}Info = new ${ClassName}();
		// 对json对象进行转换
		if (!StringUtils.isEmpty(${className})) {
			${className}Info = JsonUtil.parse(${className}, ${ClassName}.class);
		}
		if (status.equals("create")) {
			influence = ${className}Service.insert(${className}Info);
		} else {
			influence = ${className}Service.update(${className}Info);
		}
		if (influence > 0) {
			returnMap.put(Constant.RESPONSE_CODE, Constant.SUCCEED_CODE_VALUE);
			returnMap.put(Constant.RESPONSE_CODE_MSG, Constant.OPERATION_SUCCESS);
		} else {
			returnMap.put(Constant.RESPONSE_CODE, Constant.FAIL_CODE_VALUE);
			returnMap.put(Constant.RESPONSE_CODE_MSG, Constant.OPERATION_FAIL);
		}
		ServletUtils.writeToResponse(response, returnMap);
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
        // 返回给页面的Map
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String, Object> paramap = new HashMap<>();
		//对json对象进行转换
        if (!StringUtils.isEmpty(searchParams)){
         	paramap = JsonUtil.parse(searchParams, Map.class);
        }
        PageBounds pageBounds = new PageBounds(currentPage, pageSize);
		List<${ClassName}> ${className}s = ${className}Service.getPageListByMap(paramap, pageBounds);
		int totalCount = ${className}Service.getPageCountByMap(paramap);
		returnMap.put(Constant.RESPONSE_DATA, ${className}s);
		returnMap.put(Constant.RESPONSE_DATA_TOTALCOUNT, totalCount);
		returnMap.put(Constant.RESPONSE_CODE, Constant.SUCCEED_CODE_VALUE);
		returnMap.put(Constant.RESPONSE_CODE_MSG, Constant.OPERATION_SUCCESS);
		// 返回给页面
		ServletUtils.writeToResponse(response, returnMap);
    }
    
    /**
    * 根据id删除数据
    * @param response    页面的response
    * @param id          主键
    * @throws Exception
    */
    @RequestMapping("/deleteById.htm")
    public void deleteById(HttpServletResponse response, @RequestParam(value = "id") long id) throws Exception{
    	Map<String, Object> returnMap = new HashMap<String, Object>();
		long influence = ${className}Service.deleteById(id);
		if(influence > 0){
			returnMap.put(Constant.RESPONSE_CODE, Constant.SUCCEED_CODE_VALUE);
			returnMap.put(Constant.RESPONSE_CODE_MSG, Constant.OPERATION_SUCCESS);
		}else{
			returnMap.put(Constant.RESPONSE_CODE, Constant.FAIL_CODE_VALUE);
			returnMap.put(Constant.RESPONSE_CODE_MSG, Constant.OPERATION_FAIL);
		}
		//返回给页面
		ServletUtils.writeToResponse(response, returnMap);
    }
}
