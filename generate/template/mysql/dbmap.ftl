<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- ${tableName}表:${functionName}模块 -->
<mapper namespace="${packageName}.${moduleName}.dao.${ClassName}Dao">
	<!--返回MAP-->		
	<resultMap id="${ClassName}Result" type="${packageName}.${moduleName}.domain.${ClassName}">
	<#list list as column>
	<#if column.columnName == "id">
		<id column="${column.typeName}" property="${column.columnName}" />
	<#else >
		<result column="${column.typeName}" property="${column.columnName}" />
	</#if>
	</#list>
	</resultMap>
	
	<!--基本的sql查询字段 公共引用...-->
	<sql id="searchSql">
		<#list list as column>
			${column.typeName}<#if column_index+1 != listSize>,
			<#else>
			
			</#if>
		</#list>
	</sql>
	
	<!-- 基本的sql查询条件公共引用 -->
	<sql id="searchByPo">
		<trim prefix="where" prefixOverrides="and|or">
	<#list list as column>
		<#if column.columnName == "id">
			<if test="id !='' and id !=null">
                id  = #${leftBraces}id${rightBraces}
            </if>
		<#else >
            <if test="${column.columnName} !='' and ${column.columnName} !=null">
            	and ${column.typeName} = #${leftBraces}${column.columnName}${rightBraces}
            </if>
        </#if >
	</#list>
		</trim>
	</sql>
	
	<!-- 动态更新 -->
    <sql id="updateByPo">
       	<trim prefix="set" suffixOverrides=",">
		<#list list as column>
		<#if column.columnName == "id">
		<#elseif column.columnName == "creator">
		<#elseif column.columnName == "createTime">
		<#else >
	    	<if test="${column.columnName} != null">		
	    		${column.typeName} = #${leftBraces}${column.columnName}${rightBraces},		
	    	</if>
	    </#if >
		</#list>
	    </trim>
    </sql>
	
	<!-- 动态的插入,必须要创建时间 -->
	<insert id="insert" parameterType="${packageName}.${moduleName}.domain.${ClassName}">
		insert into ${tableName}(
		<trim suffixOverrides=",">
	    <#list list as column>
	    <#if column.columnName == "id">
	    <#else>
		<if test="${column.columnName} != null">
        		${column.typeName},
		
		</if>
		</#if>
		</#list>
		</trim>
        )values(
	<trim suffixOverrides=",">
        <#list list as column>
        <#if column.columnName == "id">
	    <#else>
		<if test="${column.columnName} != null">
        	#${leftBraces}${column.columnName}${rightBraces},
		</if>
		</#if>
		</#list>
		</trim>
        )
     <!-- 重新返回给实体类,插入的id值 -->
     <selectKey resultType="long" keyProperty="id">
		SELECT LAST_INSERT_ID() AS ID
	 </selectKey>
	 </insert>

    <!-- 动态更新 -->
    <update id="update" parameterType="${packageName}.${moduleName}.domain.${ClassName}">
        update ${tableName}
        <include refid="updateByPo"/>
        where id = #${leftBraces}id${rightBraces}
    </update>

    <select id="getByPrimary" resultMap="${ClassName}Result" parameterType="long" >
        select
        <include refid="searchSql"/>
        from ${tableName}
        where id = #${leftBraces}id${rightBraces}
    </select>
	
	<!--分页列表查询-->
	<select id="getPageListByMap" resultMap="${ClassName}Result" parameterType="java.util.HashMap" >
		select 
		<include refid="searchSql"/>
		from ${tableName}
		<include refid="searchByPo"/>	
		order by id desc
	</select>

	<!-- 查找单个 -->
    <select id="getOne" resultMap="${ClassName}Result" parameterType="java.util.HashMap" >
        select
        <include refid="searchSql"/>
        from ${tableName}
        <include refid="searchByPo"/>
    </select>

    <!--根据ID删除-->
    <delete id="deleteByPrimary">
        delete from ${tableName}
        where
        id  = #${leftBraces}id${rightBraces}
    </delete>
</mapper>