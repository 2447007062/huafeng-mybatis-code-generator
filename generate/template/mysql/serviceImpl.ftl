package ${packageName}.${moduleName}.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Date;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.stereotype.Service;
import com.rongdu.eloan.common.service.impl.BaseServiceImpl;
import com.rongdu.eloan.modules.common.exception.ServiceException;
import com.rongdu.eloan.common.dao.BaseDao;
import ${packageName}.${moduleName}.dao.${ClassName}Dao;
import ${packageName}.${moduleName}.domain.${ClassName};
import com.rongdu.eloan.common.service.impl.BaseServiceImpl;
import com.rongdu.eloan.modules.system.domain.SysUser;
import ${packageName}.${moduleName}.service.${ClassName}Service;

/**
* User:    ${classAuthor}
* DateTime:${classDate}
* details: ${functionName},Service实现层
*/
@Service(value = "${className}ServiceImpl")
@Transactional(rollbackFor=Exception.class)
public class ${ClassName}ServiceImpl extends BaseServiceImpl<${ClassName},Long> implements ${ClassName}Service {
	/**
	 * 日志操作
	 */
	private static final Logger log = LoggerFactory.getLogger(${ClassName}ServiceImpl.class);
	/**
	 * ${functionName}dao层
	 */
	@Autowired
	private ${ClassName}Dao ${className}Dao;

	@Override
	public BaseDao getMapper() {
		return ${className}Dao;
	}
	
	/**
	 * ${functionName}表,查询列表数据
	 * @param data
	 * @return 返回页面map
	 * @throws Exception
	 */
	@Override
	public List<${ClassName}> getPageListByMap(Map<String , Object> data) throws Exception {
		return ${className}Dao.getPageListByMap(data);
	}
	
	/**
	 * 更新或者保存
	 * @param ${className}Bean ${className}Bean
	 * @param sysUser
	 * @throws Exception
	 */
	@Override
	public void saveOrUpdate(${ClassName} ${className}Bean,SysUser sysUser) throws Exception{
		if (${className}Bean.getId() == null ) {
			//没有主键,保存数据
<#--			${className}Bean.setCreator(sysUser.getId());-->
			${className}Bean.setCreateTime(new Date());
			if(super.insert(${className}Bean) != 1){
				throw new ServiceException("保存错误");
			}
		} else {
			//包含主键,更新数据
<#--			${className}Bean.setModifier(sysUser.getId());-->
<#--			${className}Bean.setModifyTime(new Date());-->
			
			if(super.update(${className}Bean) != 1){
				throw new ServiceException("更新错误");
			}
		}
	}
	/**
	* 查找单个id
	*/
	@Override
	public ${ClassName} get${ClassName}ById(Long id) throws Exception{
		${ClassName}  ${className} = ${className}Dao.getByPrimary(id);
		return ${className};
	}

}