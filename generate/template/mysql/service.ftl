package ${packageName}.${moduleName}.service;

import java.util.Map;
import java.util.List;
import com.rongdu.eloan.common.service.BaseService;
import com.rongdu.eloan.modules.system.domain.SysUser;
import  ${packageName}.${moduleName}.domain.${ClassName};

/**
* User:    ${classAuthor}
* DateTime:${classDate}
* details: ${functionName},Service接口层
*/
public interface ${ClassName}Service extends BaseService<${ClassName}, Long> {

	/**
     * ${functionName}表,查询列表数据
     * @param data
     * @return
     * @throws Exception
     */
    List<${ClassName}> getPageListByMap(Map<String , Object> data) throws Exception;
    
	/**
	 * 更新或者保存
	 * @param ${className}Bean
	 * @param sysUser
	 * @throws Exception
	 */
	void saveOrUpdate(${ClassName} ${className}Bean, SysUser sysUser) throws Exception;
	/**
	 * 查找单个id
	 */
	${ClassName} get${ClassName}ById(Long id) throws Exception;

}
