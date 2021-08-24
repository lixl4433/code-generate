package com.code;

import com.code.generate.CodeGenerate;
import com.code.generate.config.DataSourceConfig;
import com.code.generate.config.GlobalConfig;

/**
 */
public class Demo {
    public static void main(String[] args) {
        //全局配置
        GlobalConfig globalConfig = new GlobalConfig();
        //自定义模板路径
        globalConfig.setTemplatepath("/template/style");
        globalConfig.setAuthor("test");
        globalConfig.setProjectName("test");
        //实体包名
        globalConfig.setEntityPackage("com.zzlc.fqdoc.domain");
        //mapper包名
        globalConfig.setMapperPackage("com.zzlc.fqdoc.dao");
        //mapper的xml路径
        globalConfig.setMapperXmlPath("mapper");
        //service包名
        globalConfig.setControllerPackage("com.zzlc.fqdoc.controller");
        //需要生成的实体
        globalConfig.setTableNames(new String[]{""});
        //生成的实体移除前缀
        globalConfig.setPrefix(new String[]{""});
        //数据库配置
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setDriverName("com.mysql.jdbc.Driver");
        dsc.setUrl("jdbc:mysql://hzzzlc.tpddns.net:13306/fqdoc?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance&useSSL=false");
        //填写自己的数据库账号
        dsc.setUsername("passis");
        //填写自己的数据库密码
        dsc.setPassword("Zzlc_1qaz789");
        CodeGenerate codeGenerate = new CodeGenerate(globalConfig, dsc);
        //生成代码
        codeGenerate.generateToFile();
    }
}
