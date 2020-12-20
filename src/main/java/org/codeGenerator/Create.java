package org.codeGenerator;

public class Create {
	
	public static void main(String[] args) {
		Create ot=new Create();
		ot.test();
	}
	
	public void test(){
		
//		String db="oracle";  //数据库类型: mysql|oracle
//		String url = "jdbc:oracle:thin:@172.16.88.70:1521:orcl";
//		String MysqlUser = "wxxt";
//		String mysqlPassword = "erongdu";
//		String database = "WXXT"; //数据库
//		String table = "SYS_BANK"; //表名
//		String packageName ="com.rongdu.eloan.modules"; //模块名
//		String batisName = "config/mapping";
//		String moduleName = "channel";
//		String classAuthor = "wulb";
//		String functionName = "银行卡";
		String database = "mxc-finance";    // TODO:   数据库
		
		String url = "jdbc:mysql://47.101.60.233:3306/"+database+"?useUnicode=true&characterEncoding=utf8&useSSL=false";
		String MysqlUser = "root";
		String mysqlPassword = "mxc123";
		String table = "bank_record";	// TODO: 表名
		String moduleName = "user";	// TODO: 文件夹
		String packageName ="com.rongyu.demo2";
		String batisName = "config/mappers";
		String classAuthor = "mxc";
		String functionName = "后台用户表";    // TODO: 类注释
		String db="mysql";
		String batisPath="D:\\projects\\demo1";//文件生成地址

        String[] tables = table.split(",");
        for (String tableStr : tables) {
        	MybatisGenerate.FoundCode(db,url, MysqlUser, mysqlPassword, database, tableStr,packageName,batisName,moduleName,
                    classAuthor,functionName,batisPath);
		}
	}

}
