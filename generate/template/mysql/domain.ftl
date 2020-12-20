package ${packageName}.${moduleName}.domain;

import java.io.Serializable;
<#assign dataFlag="0"/>
<#assign decimalFlag="0"/>
<#list list as item>
<#if item.dataType == "Date" && dataFlag == "0" >
<#assign dataFlag="1"/>
import java.util.Date;
<#elseif item.dataType == "BigDecimal" && decimalFlag == "0">
<#assign decimalFlag="1"/>
import java.math.BigDecimal;
</#if>
</#list>

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
    private Long id;
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
    public Long getId(){
        return id;
    }
    
    /**
     * 设置id
     * 
     * @param id 要设置的id
     */
    public ${ClassName} setId(Long id){
        this.id = id;
        return this;
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
    public ${ClassName} set${item.columnNameUpper}(${item.dataType} ${item.columnName}){
        this.${item.columnName} = ${item.columnName};
	    return this;
    }

	</#if >
    </#list>
}