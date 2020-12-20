package ${packageName}.${moduleName}.service.impl;

import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.rongdu.eloan.common.service.impl.BaseServiceImpl;
import com.rongdu.eloan.modules.common.exception.ServiceException;
import com.rongdu.eloan.common.context.Constant;
import com.rongdu.eloan.common.dao.BaseDao;
import ${packageName}.${moduleName}.dao.${ClassName}Dao;
import ${packageName}.${moduleName}.domain.${ClassName};
import ${packageName}.${moduleName}.service.${ClassName}Service;

/**
* User:    ${classAuthor}
* DateTime:${classDate}
* details: ${functionName},Service实现层
* source:  代码生成器
*/
@SuppressWarnings("rawtypes")
@Service(value = "${className}ServiceImpl")
public class ${ClassName}ServiceImpl extends BaseServiceImpl implements ${ClassName}Service {
	/**
	 * 日志操作
	 */
    private static final Logger log = LoggerFactory.getLogger(${ClassName}ServiceImpl.class);
    /**
	 * ${functionName}dao层
	 */
    @Autowired
    private ${ClassName}Dao ${className}Dao;

	/**
	 * ${functionName}表,插入数据
	 * @param collateral ${functionName}类
	 * @return          
	 * @throws Exception
	 */
	@Override
	public long insert(${ClassName} ${className}) throws Exception {
		try {
			return ${className}Dao.insert(${className});
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			throw new ServiceException(e.getMessage(),e,Constant.FAIL_CODE_VALUE);
		}
	}

	/**
	* ${functionName}表,修改数据
	* @param collateral ${functionName}类
	* @return
	* @throws Exception
	*/
	@Override
	public long update(${ClassName} ${className}) throws Exception {
		try {
			return ${className}Dao.update(${className});
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			throw new ServiceException(e.getMessage(),e,Constant.FAIL_CODE_VALUE);
		}
	}
	
	/**
	 * ${functionName}表,分页查询数据
	 * @param data
	 * @param pageBounds
	 * @return	List<${ClassName}>          
	 * @throws Exception
	 */
	@Override
	public List<${ClassName}> getPageListByMap(Map<String , Object> data, PageBounds pageBounds) throws Exception {
		try {
			return ${className}Dao.getPageListByMap(data, pageBounds);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			throw new ServiceException(e.getMessage(),e,Constant.FAIL_CODE_VALUE);
		}
	}
	
	/**
	 * ${functionName}表,查询数据记录数
	 * @param data
	 * @return	          
	 * @throws Exception
	 */
	@Override
	public int getPageCountByMap(Map<String , Object> data) throws Exception {
		try {
			return ${className}Dao.getPageCountByMap(data);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			throw new ServiceException(e.getMessage(),e,Constant.FAIL_CODE_VALUE);
		}
	}
	
	/**
	* ${functionName}表,删除数据
	* @param id 主键
	* @return   返回页面map
	* @throws Exception
	*/
	@Override
	public int deleteById(long id) throws Exception {
		try {
			return ${className}Dao.deleteById(id);
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			throw new ServiceException(e.getMessage(),e,Constant.FAIL_CODE_VALUE);
		}
	}
	
	@Override
	public BaseDao getMapper() {
		return ${className}Dao;
	}
}