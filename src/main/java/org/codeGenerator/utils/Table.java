package org.codeGenerator.utils;

/**
 * Created with IntelliJ IDEA.
 * User:    孙凯伦
 * email:   skl@erongdu.com
 * Date:    2016/2/1
 * Time:    14:40
 * details: 数据库信息
 */
public class Table {
	/**
	 * 实体类名
	 */
	private String columnName;
	/**
	 * 数据库类型
	 */
	private String dataType;
	/**
	 * 数据库注释
	 */
	private String columnComment;
	/**
	 * 首字母大写列名
	 */
	private String columnNameUpper;
	/**
	 * 数据无转换列名
	 */
	private String typeName;
	/**
	 * 获取columnName
	 * 
	 * @return columnName
	 */
	public String getColumnName() {
		return columnName;
	}
	/**
	 * 设置columnName
	 * 
	 * @param columnName 要设置的columnName
	 */
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	/**
	 * 获取dataType
	 * 
	 * @return dataType
	 */
	public String getDataType() {
		return dataType;
	}
	/**
	 * 设置dataType
	 * 
	 * @param dataType 要设置的dataType
	 */
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	/**
	 * 获取columnComment
	 * 
	 * @return columnComment
	 */
	public String getColumnComment() {
		return columnComment;
	}
	/**
	 * 设置columnComment
	 * 
	 * @param columnComment 要设置的columnComment
	 */
	public void setColumnComment(String columnComment) {
		this.columnComment = columnComment;
	}
	/**
	 * 获取columnNameUpper
	 * 
	 * @return columnNameUpper
	 */
	public String getColumnNameUpper() {
		return columnNameUpper;
	}
	/**
	 * 设置columnNameUpper
	 * 
	 * @param columnNameUpper 要设置的columnNameUpper
	 */
	public void setColumnNameUpper(String columnNameUpper) {
		this.columnNameUpper = columnNameUpper;
	}

	/**
	 * 获取typeName
	 * @return typeName
	 */
	public String getTypeName() {
		return typeName;
	}

	/**
	 * 设置typeName
	 * @param typeName
	 */
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
}
