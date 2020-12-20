package org.codeGenerator.utils;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

/**
 * Created with IntelliJ IDEA.
 * User:    孙凯伦
 * email:   skl@erongdu.com
 * Date:    2016/2/1
 * Time:    17:55
 * details: 代码生成工具类
 */
public class GenerateUtils {
    /**
     * 获取表信息
     *
     * @param table_name
     * @return
     */
    public static List<Table> getList(String dbClass,String table_name,String url,String MysqlUser,String mysqlPassword,String database,String sql) {
        //赋值的list
        List<Table> list = new ArrayList<Table>();
        //数据库链接
        Connection conn = getDblink(dbClass,url,MysqlUser,mysqlPassword);
        Statement stmt = null;
        try {
            stmt = (Statement) conn.createStatement();
            
            //执行sql
            ResultSet rs = stmt.executeQuery(sql);
            //循环
            while (rs.next()) {
                //赋值
                Table table = new Table();
                //数据库无转换列名
                table.setTypeName(StringUtils.lowerCase(rs.getString("COLUMN_NAME")));
                //将列名全部改为小写,凡是加_首字母大写
                table.setColumnName(StringUtils.uncapitalize(toUpper(StringUtils.lowerCase(rs.getString("COLUMN_NAME")))));  //将所有的字段名改为小写方便命名
                //将类名改为首字母大写
                table.setColumnNameUpper(StringUtils.capitalize(table.getColumnName()));
                //设置sql的类型
                table.setDataType(sqlType2JavaType(rs.getString("DATA_TYPE")));
                //设置注释
                if(rs.getString("COLUMN_COMMENT")!=null&&rs.getString("COLUMN_COMMENT")!=""){  //判断注释是否为空
                table.setColumnComment(rs.getString("COLUMN_COMMENT"));
                }else{
                	 table.setColumnComment("");
                }
                list.add(table);
            }
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }

        return list;
    }


    /**
     * 数据库链接
     *        String MysqlUser = "root";
        String password = "mysql";
        String url = "jdbc:mysql://127.0.0.1:3306/eabs?useUnicode=true&characterEncoding=utf8";
     * @return
     */
    
    public static Connection getDblink(String dbClass,String url,String MysqlUser,String mysqlPassword) {
        Connection conn = null;
        //数据库连接
        try {
            Class.forName(dbClass); //加载mysq驱动
            conn = DriverManager.getConnection(url, MysqlUser, mysqlPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    /**
     * “_”+小写 转成大写字母
     *
     * @param str
     * @return
     */
    public static String toUpper(String str) {
    	String name = null;
    	String [] split =StringUtils.split(str,"_");
    	for (String string : split) {
    		if(name == null)
    			name = StringUtils.capitalize(string);
    		else
    			name += StringUtils.capitalize(string);
		}
    	return name;
    }

    /**
     * 功能：获得列的数据类型
     *
     * @param sqlType
     * @return
     */
    private static String sqlType2JavaType(String sqlType) {

        if (sqlType.equalsIgnoreCase("bit")) {
            return "Boolean";
        } else if (sqlType.equalsIgnoreCase("tinyint")) {
            return "Byte";
        } else if (sqlType.equalsIgnoreCase("char")) {
            return "Integer";
        } else if (sqlType.equalsIgnoreCase("binary_double")) {
            return "BigDecimal";
        } else if (sqlType.equalsIgnoreCase("number")) {
            return "int";
        } else if (sqlType.equalsIgnoreCase("smallint")) {
            return "Short";
        } else if (sqlType.equalsIgnoreCase("int")) {
            return "Integer";
        } else if (sqlType.equalsIgnoreCase("Integer")) {
            return "Integer";
        } else if (sqlType.equalsIgnoreCase("bigint")) {
            return "Long";
        } else if (sqlType.equalsIgnoreCase("float")) {
            return "Float";
        } else if (sqlType.equalsIgnoreCase("double")) {
            return "Double";
        } else if (sqlType.equalsIgnoreCase("decimal") || sqlType.equalsIgnoreCase("numeric")
                || sqlType.equalsIgnoreCase("real") || sqlType.equalsIgnoreCase("money")
                || sqlType.equalsIgnoreCase("smallmoney") || sqlType.equalsIgnoreCase("double")) {
            return "BigDecimal";
        } else if (sqlType.equalsIgnoreCase("varchar") || sqlType.equalsIgnoreCase("char")
                || sqlType.equalsIgnoreCase("nvarchar") || sqlType.equalsIgnoreCase("nchar")
                || sqlType.equalsIgnoreCase("text")) {
            return "String";
        } else if (sqlType.equalsIgnoreCase("datetime") || sqlType.equalsIgnoreCase("date")) {
            return "Date";
        } else if (sqlType.equalsIgnoreCase("image")) {
            return "Blod";
        }

        return "String";
    }

    /**
     * 将内容写入文件
     *
     * @param content
     * @param filePath
     */
    public static void writeFile(String content, String filePath) {
        try {
            if (createFile(filePath)) {
                FileWriter fileWriter = new FileWriter(filePath, true);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
                bufferedWriter.write(content);
                bufferedWriter.close();
                fileWriter.close();
            } else {
            	System.err.println("生成失败，文件已存在！");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 创建单个文件
     *
     * @param descFileName 文件名，包含路径
     * @return 如果创建成功，则返回true，否则返回false
     */
    public static boolean createFile(String descFileName) {
        File file = new File(descFileName);
        if (file.exists()) {
        	System.err.println("文件 " + descFileName + " 已存在!");
            return false;
        }
        if (descFileName.endsWith(File.separator)) {
        	System.err.println(descFileName + " 为目录，不能创建目录!");
            return false;
        }
        if (!file.getParentFile().exists()) {
            // 如果文件所在的目录不存在，则创建目录
            if (!file.getParentFile().mkdirs()) {
            	System.err.println("创建文件所在的目录失败!");
                return false;
            }
        }

        // 创建文件
        try {
            if (file.createNewFile()) {
            	System.err.println(descFileName + " 文件创建成功!");
                return true;
            } else {
            	System.err.println(descFileName + " 文件创建失败!");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println(descFileName + " 文件创建失败!");
            return false;
        }
    }

    public static String getDate() {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return format.format(new java.util.Date());
    }
}
