<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- ${tableName}表:${functionName}模块 -->
<mapper namespace="${packageName}.${moduleName}.dao.${ClassName}Dao">
	<!--返回MAP-->		
	<resultMap id="${ClassName}Result" type="${ClassName}">
	<#list list as column>
	<#if column.columnName == "id">
		<id column="${column.typeName}" property="${column.columnName}" />
	<#else >
		<result column="${column.typeName}" property="${column.columnName}" />
	</#if>
	</#list>
	</resultMap>
	
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
		<#elseif column.columnName == "modifyTime">
	        modify_time = sysdate,
		<#else >
	    	<if test="${column.columnName} != '' and ${column.columnName} != null">		
	    		${column.typeName} = #${leftBraces}${column.columnName}${rightBraces},		
	    	</if>
	    </#if >
		</#list>
	    </trim>
    </sql>
	
	<!-- 动态的插入,必须要创建时间 -->
	<insert id="insert" parameterType="${ClassName}">
		insert into ${tableName}(
	    <#list list as column>
		<#if column.columnName == "id">
		<#elseif column.columnName == "createTime">
			create_time,
		<#else >
        	${column.typeName},		
	    </#if >
		</#list>
			id
        )values(
        <#list list as column>
		<#if column.columnName == "id">
		<#elseif column.columnName == "createTime">
			sysdate,
		<#else >
        	#${leftBraces}${column.columnName}${rightBraces},
        </#if >
		</#list>
        	#${leftBraces}id${rightBraces}
        )
     <!-- 重新返回给实体类,插入的id值 -->
     <selectKey keyProperty="id" resultType="long" order="BEFORE">
        select ${tableName}_seq.nextval as id from dual
     </selectKey>
	 </insert>
	
    <!-- 动态更新 -->
    <update id="update" parameterType="${ClassName}">
        update ${tableName}
        <include refid="updateByPo"/>
        where id = #${leftBraces}id${rightBraces}
    </update>

	<!--分页列表查询-->
	<select id="getPageListByMap" resultMap="${ClassName}Result" parameterType="java.util.HashMap" >
		select * from ${tableName}
		<include refid="searchByPo"/>	
		order by id desc
	</select>
    
    <!--分页记录数-->
	<select id="getPageCountByMap" resultType="java.lang.Integer" parameterType="java.util.HashMap" >
		select count(*)	from ${tableName}
		<include refid="searchByPo"/>
	</select>

    <!--根据ID删除-->
    <delete id="deleteById">
        delete from ${tableName}
        where
        id  = #${leftBraces}id${rightBraces}
    </delete>
</mapper>