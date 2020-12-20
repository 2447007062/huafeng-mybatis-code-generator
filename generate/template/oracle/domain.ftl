package ${packageName}.${moduleName}.domain;

import java.io.Serializable;
import java.util.Date;

/**
 * ${functionName}实体
 * @author ${classAuthor}
 * @version 1.0
 * @since ${classDate}
 */
public class ${ClassName} implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	<#list list as item>
	<#if item.columnName == "id">
	/**
    * id
    */
    private long id;
    <#else >
    /**
    * ${item.columnComment}
    */
    private ${item.dataType} ${item.columnName};
    </#if >
    </#list>
    
    <#list list as item>
    <#if item.columnName == "id">
    /**
    * 获取id
    *
    * @return id
    */
    public long getId(){
        return id;
    }
    
    /**
     * 设置id
     * 
     * @param long 要设置的id
     */
    public void setId(long id){
        this.id = id;
    }
    
    <#else >
    /**
    * 获取${item.columnComment}
    *
    * @return ${item.columnComment}
    */
    public ${item.dataType} get${item.columnNameUpper}(){
        return ${item.columnName};
    }
    
    /**
     * 设置${item.columnComment}
     * 
     * @param ${item.columnName} 要设置的${item.columnComment}
     */
    public void set${item.columnNameUpper}(${item.dataType} ${item.columnName}){
        this.${item.columnName} = ${item.columnName};
    }

	</#if >
    </#list>
}