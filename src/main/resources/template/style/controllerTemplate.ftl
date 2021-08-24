package ${controllerPackage};


import java.util.Arrays;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zzlc.fqdoc.controller.response.RestResponse;
import ${entityPackage}.${entity};
import ${mapperPackage}.${entity}Mapper;

import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;

/**
 * @Program: ${projectName}
 * @Description: 描述
 * @Author: ${author}
 * @Date: ${date}
 **/
@RestController
@RequestMapping(value="/${entity?uncap_first}")
public class ${entity}Controller {

    @Autowired
    private ${entity}Mapper ${entity?uncap_first}Mapper;

    /**
     * 列表
     * @param json
     * @return
     */
    @ApiOperation(value = "列表查询", notes = "获取数据列表")
    @RequiresPermissions("/${entity?uncap_first}/list")
    @RequestMapping(value = "list")
    public RestResponse<Object> list() {
        List<${entity}> list = ${entity?uncap_first}Mapper.queryList();
        return new RestResponse<Object>(list);
    }

	
	    /**
     * 列表分页
     * @param json
     * @return
     */
    @ApiOperation(value = "分页查询", notes = "获取分页数据列表")
    @RequiresPermissions("/${entity?uncap_first}/listByPage")
    @ApiImplicitParam(name = "currentPage", value = "页数", required = true, dataType = "int")
    @RequestMapping(value = "listByPage", method = RequestMethod.POST)
    public RestResponse<Object> listByPage(Integer currentPage,Integer pageSize) {
        pageSize = pageSize==null?15:pageSize;
        PageInfo<${entity}> pageinfo = PageHelper.startPage(currentPage, pageSize).doSelectPageInfo(() -> ${entity?uncap_first}Mapper.queryList());
        return new RestResponse<Object>(pageinfo);
    }
    
     @ApiOperation(value = "根据非空字段列表查询", notes = "非空字段作为条件进行等值查询")
    @RequiresPermissions("/${entity?uncap_first}/listByCondition")
    @RequestMapping(value = "listByCondition", method = RequestMethod.POST)
    public RestResponse<Object> listByCondition(${entity} ${entity?uncap_first}) {
        List<${entity}> list = ${entity?uncap_first}Mapper.queryListWithCondition(${entity?uncap_first});
        return new RestResponse<Object>(list);
    }

    @ApiOperation(value = "根据非空字段模糊列表查询", notes = "非空字段作为条件进行模糊查询")
    @RequiresPermissions("/${entity?uncap_first}/listByConditionFuzzy")
    @RequestMapping(value = "listByConditionFuzzy", method = RequestMethod.POST)
    public RestResponse<Object> listByConditionFuzzy(${entity} ${entity?uncap_first}) {
        List<${entity}> list = ${entity?uncap_first}Mapper.queryListWithConditionFuzzy(${entity?uncap_first});
        return new RestResponse<Object>(list);
    }

    @ApiOperation(value = "更新记录", notes = "根据对象的id更新记录")
    @RequestMapping(value = "update")
    public RestResponse<Object> update(${entity} ${entity?uncap_first}) {
        ${entity?uncap_first}Mapper.update${entity}(${entity?uncap_first});
        return new RestResponse<Object>(1);
    }

    @ApiOperation(value = "删除记录", notes = "根据单个id删除记录")
    @RequestMapping(value = "delete")
    public RestResponse<Object> delete(Integer id) {
        ${entity?uncap_first}Mapper.delete${entity}(id);
        return new RestResponse<Object>(1);
    }

    @ApiOperation(value = "删除记录", notes = "根据多个id删除记录,以逗号分隔")
    @RequiresPermissions("/${entity?uncap_first}/deleteMutil")
    @RequestMapping(value = "deleteMutil", method = RequestMethod.POST)
    public RestResponse<Object> deleteMutil(String ids) {
        List idList = Arrays.asList(ids.split(","));
        ${entity?uncap_first}Mapper.deleteMutil(idList);
        return new RestResponse<Object>(1);
    }

    @ApiOperation(value = "创建实体类", notes = "根据${entity}对象创建用户")
    @RequestMapping(value = "insert")
    public RestResponse<Object> insert(${entity} ${entity?uncap_first}) {
        ${entity?uncap_first}Mapper.insert${entity}(${entity?uncap_first});
        return new RestResponse<Object>(1);
    }

}
