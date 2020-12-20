package ${packageName}.${moduleName}.service;

import java.util.Map;
import java.util.List;
import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import  ${packageName}.${moduleName}.domain.${ClassName};

/**
* User:    ${classAuthor}
* DateTime:${classDate}
* details: ${functionName},Service接口层
* source:  代码生成器
*/
public interface ${ClassName}Service {

    /**
     * ${functionName}表,插入数据
     * @param ${className} ${functionName}类
     * @return
     * @throws Exception
     */
    public long insert(${ClassName} ${className}) throws Exception;

    /**
     * ${functionName}表,修改数据
     * @param ${className} ${functionName}类
     * @return
     * @throws Exception
     */
    public long update(${ClassName} ${className}) throws Exception;

	/**
     * ${functionName}表,分页查询数据
     * @param data
     * @param pageBounds
     * @return
     * @throws Exception
     */
    public List<${ClassName}> getPageListByMap(Map<String , Object> data, PageBounds pageBounds) throws Exception;
    
    /**
     * ${functionName}表,查询数据记录数
     * @param data
     * @return
     * @throws Exception
     */
    public int getPageCountByMap(Map<String, Object> data) throws Exception;

    /**
    * ${functionName}表,删除数据
    * @param id 主键
    * @return
    * @throws Exception
    */
    public int deleteById(long id) throws Exception;
}
