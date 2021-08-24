package ${entityPackage};

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Description: ${table.comment}
 * @author: ${author}
 * @Date: ${date}
 */
@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
@Data
@ApiModel(value="${table.comment}")
public class ${entity} {
<#-- 循环属性名称 -->
<#list table.fields as field>
    <#if field.comment??>
    /**
     * <#if field.comment!="">${field.comment}<#else >主键</#if>
     */
    </#if>
    <#if field.propertyName =="updateDt" || field.propertyName =="createDt" >
    @ApiModelProperty(value="${field.comment}")
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
    private ${field.propertyType} ${field.propertyName};
    <#else>
    @ApiModelProperty(value="${field.comment}")
    private ${field.propertyType} ${field.propertyName};
	</#if>
</#list>
}
