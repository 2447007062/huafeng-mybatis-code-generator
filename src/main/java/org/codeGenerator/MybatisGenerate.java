package org.codeGenerator;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.codeGenerator.utils.FreeMarkers;
import org.codeGenerator.utils.GenerateUtils;
import org.springframework.core.io.DefaultResourceLoader;

import com.google.common.collect.Maps;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.utility.Execute;

/**
 * mybatis映射代码生成器
 *
 * @author Administrator
 */
public class MybatisGenerate {
    /**
     * @Description: 生成方法 @param @param db @param @param url @param @param
     * MysqlUser @param @param mysqlPassword @param @param
     * database @param @param table @param @param packageName @param @param
     * batisName @param @param moduleName @param @param
     * classAuthor @param @param functionName 设定文件 @author wangmc @return void
     * 返回类型 @throws
     */
    public static void FoundCode(String db, String url, String MysqlUser, String mysqlPassword, String database,
                                 String table, String packageName, String batisName, String moduleName, String classAuthor,
                                 String functionName, String projectPath) {
        Boolean needsDomain = true; // 是否生成实体类
        Boolean needsDao = true; // 是否生成Dao
        Boolean needsService = true; // 是否生成Service和ServiceImpl
        Boolean needsAction = true; // 是否生成Action
        try {
            String dbClass = null;
            String sql = null;
            String showTables = null;
            String getTable = null;
            String executeSql = null;
            String templateNmae = null;
            String table_name = "";
            // 链接数据库操作
            switch (db) {
                case "mysql":
                    dbClass = "com.mysql.jdbc.Driver";
                    showTables = "show tables";
                    getTable = "Tables_in_" + database;
                    executeSql = "SELECT COLUMN_NAME, DATA_TYPE, COLUMN_COMMENT FROM INFORMATION_SCHEMA.`COLUMNS` WHERE table_name = '"
                            + table + "'  AND table_schema = '" + database + "'";
                    break;
                case "oracle":

                    dbClass = "oracle.jdbc.driver.OracleDriver";
                    showTables = "SELECT TABLE_NAME FROM USER_ALL_TABLES";
                    getTable = "TABLE_NAME";
                    executeSql = "select column_name,data_type,"
                            + "(select t_s.comments  from all_col_comments t_s where t_s.column_name=t.column_name and t_s.table_name='"
                            + table + "' and t_s.owner='" + database + "') column_comment "
                            + "from all_tab_columns t  where  table_name =upper('" + table + "' ) and owner='" + database
                            + "' order by column_id ";
                    break;
                default:
                    System.err.println("---暂不支持该类型数据库----");
                    break;
            }
            Connection connection = GenerateUtils.getDblink(dbClass, url, MysqlUser, mysqlPassword);
            // 返回链接的Statement
            Statement stateMent_table = (Statement) connection.createStatement();
            // 查询该数据库所有的表名
            ResultSet tables = stateMent_table.executeQuery(showTables);
            // 循环
            while (tables.next()) {
                // 查询出列名为Tables_in_good_loan_dev,所有数据库表名
                table_name = tables.getString(getTable);
                // 判断执行那个表的,生成代码操作
                if (!table_name.equals(table)) {
                    continue;
                }
//				if (table_name.indexOf(table) == -1) {
//					continue;
//				}
                String cn = StringUtils.lowerCase(table_name); // 全部转换为小写

                // 获得,类名
                String className = "";
                if (cn.startsWith("rd") || cn.startsWith("edu") || cn.startsWith("sys") || cn.startsWith("xc") || cn.startsWith("rp") || cn.startsWith("cl") || cn.startsWith("cms")) {
                    className = GenerateUtils.toUpper(cn.substring(3));
                } else {
                    className = GenerateUtils.toUpper(cn.substring(0));
                }
                // 获取分隔符/
                String separator = File.separator;
                File projectPathFile = new DefaultResourceLoader().getResource("").getFile();
                while (!new File(projectPathFile.getPath() + separator + "src").exists()) {
                    projectPathFile = projectPathFile.getParentFile();
                }
                // 获取工程路径
                if (StringUtils.isEmpty(projectPath)) {

                    projectPath = projectPathFile.toString();
                }
                // 模板文件路径
                String tplPath = "";
                if (db.equals("mysql")) {
                    tplPath = StringUtils.replace(projectPathFile + "/generate/template/mysql", "/", separator);
                } else if (db.equals("oracle")) {
                    tplPath = StringUtils.replace(projectPathFile + "/generate/template/oracle", "/", separator);
                }
                // Java文件路径,使用
                String javaPath = StringUtils.replaceEach(
                        projectPath + "/src/main/java/" + StringUtils.lowerCase(packageName), new String[]{"/", "."},
                        new String[]{separator, separator});

                // ibatis文件生成地址
                String batisPath = StringUtils.replace(projectPath + "/src/main/resources/" + batisName + "/" + moduleName, "/", separator);

                // 代码模板配置
                Configuration cfg = new Configuration();
                cfg.setDirectoryForTemplateLoading(new File(tplPath));
                // 定义模板变量
                Map<String, Object> model = Maps.newHashMap();
                // 包地址,全部转换为小写
                model.put("packageName", StringUtils.lowerCase(packageName));
                // 模块名,全部转换为小写
                model.put("moduleName", StringUtils.lowerCase(moduleName));
                // 小写类名,全部转为首字母小写
                model.put("className", StringUtils.uncapitalize(className));
                // 大写类名,全部转为首字母大写
                model.put("ClassName", className);
                // 作者,判断字段是否为空
                model.put("classAuthor", classAuthor);
                // 获得当前时间
                model.put("classDate", GenerateUtils.getDate());
                // 模块名称
                model.put("functionName", functionName);
                // 数据库表名
                model.put("tableName", StringUtils.lowerCase(table_name));
                // 路径地址
                model.put("urlPrefix", model.get("moduleName") + " /" + model.get("className"));
                // 路径地址
                model.put("permissionPrefix", model.get("moduleName") + " :" + model.get("className"));
                // 表数据取得list
                model.put("list", GenerateUtils.getList(dbClass, table_name, url, MysqlUser, mysqlPassword, database,
                        executeSql));
                model.put("listSize", GenerateUtils
                        .getList(dbClass, table_name, url, MysqlUser, mysqlPassword, database, executeSql).size());
                // mybatis {替代单词
                model.put("leftBraces", "{");
                // mybatis }替代单词
                model.put("rightBraces", "}");
                // mybatis $替代单词
                model.put("dollarSign", "$");
                /**
                 * 生成 ibatis文件
                 */
                Template ibatisTemplate = cfg.getTemplate("dbmap.ftl");
                // 渲染生成模板
                String ibatisContent = FreeMarkers.renderTemplate(ibatisTemplate, model);
                // 生成的文件地址
                String batisSql = batisPath + separator + model.get("ClassName") + "Mapper.xml";
                // 将内容写入文件
                GenerateUtils.writeFile(ibatisContent, batisSql);

                /**
                 * 生成实体类
                 */
                if (needsDomain) {
                    // FreeMarkers模板地址
                    Template beanTemplate = cfg.getTemplate("domain.ftl");
                    // 渲染生成模板
                    String beanContent = FreeMarkers.renderTemplate(beanTemplate, model);
                    // 生成的文件地址
                    String beanFile = javaPath + separator + model.get("moduleName") + separator + "domain" + separator
                            + model.get("ClassName") + ".java";
                    // 将内容写入文件
                    GenerateUtils.writeFile(beanContent, beanFile);
                }
                /**
                 * 生成 Dao
                 */
                if (needsDao) {
                    // FreeMarkers模板地址
                    Template daoTemplate = cfg.getTemplate("dao.ftl");
                    // 渲染生成模板
                    String daoContent = FreeMarkers.renderTemplate(daoTemplate, model);
                    // 生成的文件名称
                    String daoFile = javaPath + separator + model.get("moduleName") + separator + "dao" + separator
                            + model.get("ClassName") + "Dao.java";
                    // 将内容写入文件
                    GenerateUtils.writeFile(daoContent, daoFile);
                }
                /**
                 * 生成 Service
                 */
                if (needsService) {
                    // FreeMarkers模板地址
                    Template serviceTemplate = cfg.getTemplate("service.ftl");
                    // 渲染生成模板
                    String serviceContent = FreeMarkers.renderTemplate(serviceTemplate, model);
                    // 生成的文件名称
                    String serviceFile = javaPath + separator + model.get("moduleName") + separator + "service"
                            + separator + model.get("ClassName") + "Service.java";
                    // 将内容写入文件
                    GenerateUtils.writeFile(serviceContent, serviceFile);
                    /**
                     * 生成 ServiceImpl 代码
                     */
                    // FreeMarkers模板地址
                    Template serviceI_Template = cfg.getTemplate("serviceImpl.ftl");
                    // 渲染生成模板
                    String serviceI_Content = FreeMarkers.renderTemplate(serviceI_Template, model);
                    // 生成的文件名称
                    String serviceI_File = javaPath + separator + model.get("moduleName") + separator + "service"
                            + separator + "impl" + separator + model.get("ClassName") + "ServiceImpl.java";
                    // 将内容写入文件
                    GenerateUtils.writeFile(serviceI_Content, serviceI_File);
                }
                /**
                 * 生成 Action代码
                 */
                if (needsAction) {
                    // FreeMarkers模板地址
                    Template actionTemplate = cfg.getTemplate("action.ftl");
                    // 渲染生成模板
                    String actionContent = FreeMarkers.renderTemplate(actionTemplate, model);
                    // 生成的文件名称
                    String actionFile = javaPath + separator + model.get("moduleName") + separator + "action"
                            + separator + model.get("ClassName") + "Action.java";
                    // 将内容写入文件
                    GenerateUtils.writeFile(actionContent, actionFile);
                }
                /**
                 * 提示信息
                 */
                System.err.println("代码生成成功");
            }
            tables.close();
            stateMent_table.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
