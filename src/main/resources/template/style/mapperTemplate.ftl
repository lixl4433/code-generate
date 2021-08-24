package ${mapperPackage};

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Lang;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.zzlc.fqdoc.config.aspect.MethodAction;
import com.zzlc.fqdoc.service.lang.SimpleInsertLangDriver;
import com.zzlc.fqdoc.service.lang.SimpleSelectFuzzyLangDriver;
import com.zzlc.fqdoc.service.lang.SimpleSelectInLangDriver;
import com.zzlc.fqdoc.service.lang.SimpleSelectLangDriver;
import com.zzlc.fqdoc.service.lang.SimpleUpdateLangDriver;
import ${entityPackage}.${entity};

/**
 * @Description: ${entity} Mapper
 * @author: ${author}
 * @Date: ${date}
 */
public interface ${entity}Mapper {

    @Select("select * from ${table.name}") 
    @MethodAction(operationDesc = "查询所有${table.comment}", operationName = "查询")
    public List<${entity}> queryList();

    @Select("select * from ${table.name} where ${tbKey} = #<#noparse>{</#noparse>${tbKey}<#noparse>}</#noparse>")
    @MethodAction(operationDesc = "根据主键查询${table.comment}", operationName = "查询")
    public ${entity} querySingle(@Param("${tbKey}") Integer ${tbKey});

    @Select("select * from ${table.name} where id in (#<#noparse>{</#noparse>idList<#noparse>}</#noparse>)")
    @Lang(SimpleSelectInLangDriver.class)
    @MethodAction(operationDesc = "根据主键列表查询${table.comment}", operationName = "查询")
    public List<${entity}> queryListInIds(@Param("idList") List idList);

    @Select("select * from ${table.name} (#<#noparse>{</#noparse>${entity?uncap_first}<#noparse>}</#noparse>)")
    @Lang(SimpleSelectLangDriver.class)
    @MethodAction(operationDesc = "根据对象查询${table.comment}", operationName = "查询")
    public List<${entity}> queryListWithCondition(${entity} ${entity?uncap_first});

    @Select("select * from ${table.name} (#<#noparse>{</#noparse>${entity?uncap_first}<#noparse>}</#noparse>) order by id desc")
    @Lang(SimpleSelectLangDriver.class)
    @MethodAction(operationDesc = "根据对象倒序查询${table.comment}", operationName = "查询")
    public List<${entity}> queryListWithConditionOrderBy(${entity} ${entity?uncap_first});

    //性能比精确匹配慢一点，因为加了一层判断，没有模糊匹配需求的还是用精确匹配较好
    @Select("select * from ${table.name} (#<#noparse>{</#noparse>${entity?uncap_first}<#noparse>}</#noparse>)")
    @Lang(SimpleSelectFuzzyLangDriver.class)
    @MethodAction(operationDesc = "根据对象模糊查询${table.comment}", operationName = "查询")
    public List<${entity}> queryListWithConditionFuzzy(${entity} ${entity?uncap_first});

    @Insert("insert into ${table.name} (#<#noparse>{</#noparse>${entity?uncap_first}<#noparse>}</#noparse>)")
    @Lang(SimpleInsertLangDriver.class)
    @SelectKey(statement = "select last_insert_id()", keyProperty = "id", before = false, resultType = int.class)
    @MethodAction(operationDesc = "新增${table.comment}", operationName = "新增")
    public void insert${entity}(${entity} ${entity?uncap_first});

    @Update("update ${table.name} (#<#noparse>{</#noparse>${entity?uncap_first}<#noparse>}</#noparse>) where id = #<#noparse>{</#noparse>id<#noparse>}</#noparse>")
    @Lang(SimpleUpdateLangDriver.class)
    @MethodAction(operationDesc = "根据对象id更新对象${table.comment}", operationName = "更新")
    public void update${entity}(${entity} ${entity?uncap_first});

    @Delete("delete from ${table.name} where id = #<#noparse>{</#noparse>id<#noparse>}</#noparse>")
    @MethodAction(operationDesc = "根据id删除单个对象${table.comment}", operationName = "删除")
    public void delete${entity}(Integer id);
    
    @Delete("delete from ${table.name} (#<#noparse>{</#noparse>${entity?uncap_first}<#noparse>}</#noparse>)")
    @Lang(SimpleSelectLangDriver.class)
    @MethodAction(operationDesc = "根据对象删除${table.comment}", operationName = "删除")
    void deleteWithCondition(${entity} ${entity?uncap_first});

    @Delete("delete from ${table.name} where id in (#<#noparse>{</#noparse>idList<#noparse>}</#noparse>)")
    @Lang(SimpleSelectInLangDriver.class)
    @MethodAction(operationDesc = "根据id列表删除多个对象${table.comment}", operationName = "删除")
    public void deleteMutil(@Param("idList") List idList);
}