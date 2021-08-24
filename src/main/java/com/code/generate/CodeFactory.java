/**
 */
package com.code.generate;


import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import com.code.generate.config.GlobalConfig;

import java.io.*;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;


public class CodeFactory
{
  private ICallBack callBack;
  private GlobalConfig globalConfig;

  /**
   * 把配置数据注入模版，生成代码文件
   * @param templateFileName
   * @param type
   * @param data
   * @throws TemplateException
   * @throws IOException
   */
  public void generateFile(String templateFileName, String type, Map data) throws TemplateException,IOException
  {

      String entityName = data.get("entity").toString();
      String fileNamePath = getCodePath(type, entityName);//获取生成的文件路径
      System.out.println("fileNamePath:"+fileNamePath);
      String fileDir = StringUtils.substringBeforeLast(fileNamePath, "/");
      Template template = getConfiguration().getTemplate(templateFileName);//获取模版信息
      FileUtils.forceMkdir(new File(fileDir + "/"));
      Writer out = new OutputStreamWriter(
        new FileOutputStream(fileNamePath), globalConfig.getSystem_encoding());//生成的文件编码
      template.process(data, out);//结合模版生成代码文件
      out.close();
  }

  public Configuration getConfiguration()
          throws IOException
  {
    Configuration cfg = new Configuration();
    cfg.setClassForTemplateLoading(super.getClass(), globalConfig.getTemplatepath());
    cfg.setLocale(Locale.CHINA);
    cfg.setDefaultEncoding("UTF-8");
    return cfg;
  }

  public static String getProjectPath()
  {
    String path = System.getProperty("user.dir").replace("\\", "/") + "/";
    return path;
  }

  public String getClassPath()
  {
    String path = Thread.currentThread().getContextClassLoader().getResource("./").getPath();
    return path;
  }


  /**
   * 获取代码生成的文件路径
   * @param type
   * @param entityName
   * @return
   */
  public String getCodePath(String type, String entityName)
  {
    StringBuilder path = new StringBuilder();
    if (StringUtils.isNotBlank(type)) {
      String codeType = Enum.valueOf(CodeType.class, type).toString();

      //开头，项目路径
      if(StringUtils.isEmpty(this.globalConfig.getOutputDir())){
        String projectPath = getProjectPath();//没有设置outputDir的话默认用当前项目resources/code路径下
        path.append(projectPath+"src/main/resources/code");//项目名
      }else{
        path.append(this.globalConfig.getOutputDir());//项目名
      }
      if("entity".equals(codeType)){
        //包名 package.path
        path.append("/java/").append(globalConfig.getEntityPackage()).append("/");
        //文件名
        path.append(entityName).append(".java");
      }else if("mapper".equals(codeType)){
        //包名 package.path
        path.append("/java/").append(globalConfig.getMapperPackage()).append("/");
        //文件名
        path.append(entityName).append("Mapper").append(".java");
      }else if("mapperXml".equals(codeType)){
        //包名 package.path
        path.append("/resources/").append(globalConfig.getMapperXmlPath());
        path.append("/");
        //文件名
        path.append(entityName).append("Mapper").append(".xml");
      }else if("service".equals(codeType)){
        //包名 package.path
        path.append("/java/").append(globalConfig.getServicePackage()).append("/");
        //文件名
        path.append(entityName).append("Service").append(".java");
      }else if("serviceImpl".equals(codeType)){
        //包名 package.path
        path.append("/java/").append(globalConfig.getServiceImplPackage()).append("/");
        //文件名
        path.append(entityName).append("ServiceImpl").append(".java");
      }else if("controller".equals(codeType)){
        //包名 package.path
        path.append("/java/").append(globalConfig.getControllerPackage()).append("/");
        //文件名
        path.append(entityName).append("Controller").append(".java");
      }else{
        throw new IllegalArgumentException("type is not found");
        //其他类型文件生成
      }

    } else {
      throw new IllegalArgumentException("type is null");
    }
    return path.toString();
  }

  public void invoke(String templateFileName, String type) throws Exception{
    Map data = new HashMap();
    data = this.callBack.execute();
    generateFile(templateFileName, type, data);
  }

  public ICallBack getCallBack() {
    return this.callBack;
  }

  public void setCallBack(ICallBack callBack) {
    this.callBack = callBack;
  }

  public GlobalConfig getGlobalConfig() {
    return globalConfig;
  }

  public void setGlobalConfig(GlobalConfig globalConfig) {
    this.globalConfig = globalConfig;
  }

  public enum CodeType
  {
     controller,service,serviceImpl,mapper,mapperXml,entity;

    private String type;

    public String getValue()
    {
      return this.type;
    }

  }
}
