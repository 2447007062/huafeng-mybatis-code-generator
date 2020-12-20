package ${packageName}.${moduleName}.dao;

import com.rongdu.eloan.common.dao.BaseDao;
import java.util.List;
import java.util.Map;
import com.rongdu.eloan.common.utils.annotation.RDBatisDao;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import ${packageName}.${moduleName}.domain.${ClassName};

/**
* User:    ${classAuthor}
* DateTime:${classDate}
* details: ${functionName},Dao接口层
* source:  代码生成器
*/
@RDBatisDao
public interface ${ClassName}Dao extends BaseDao<${ClassName},Long> {

    /**
     * ${functionName}表,分页查询数据
     * @param map
     * @return List<${ClassName}>
     */
    public List<${ClassName}> getPageListByMap(Map<String, Object> map, PageBounds pageBounds);
    
    /**
     * ${functionName}表,查询数据记录数
     * @param data
     * @return int
     */
    public int getPageCountByMap(Map<String, Object> data);
    
    /**
    * ${functionName}表,删除数据
    * @param id 主键
    * @return
    */
    public int deleteById(long id);
}
