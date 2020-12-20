package ${packageName}.${moduleName}.dao;

import com.rongdu.eloan.common.dao.BaseDao;
import java.util.List;
import java.util.Map;
import com.rongdu.eloan.common.utils.annotation.RDBatisDao;
import ${packageName}.${moduleName}.domain.${ClassName};

/**
* User:    ${classAuthor}
* DateTime:${classDate}
* details: ${functionName},Dao接口层
*/
@RDBatisDao
public interface ${ClassName}Dao extends BaseDao<${ClassName},Long> {

    /**
     * ${functionName}表,分页查询数据
     * @param map
     * @return List<${ClassName}>
     */
    List<${ClassName}> getPageListByMap(Map<String, Object> map);
    

}
