package com.project.demo.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * 普通管理者：(OrdinaryManager)表实体类
 *
 */
@TableName("`ordinary_manager`")
@Data
@EqualsAndHashCode(callSuper = false)
public class OrdinaryManager implements Serializable {

    // OrdinaryManager编号
    @TableId(value = "ordinary_manager_id", type = IdType.AUTO)
    private Integer ordinary_manager_id;

    // 工号
    @TableField(value = "`job_no`")
    private String job_no;
    // 姓名
    @TableField(value = "`full_name`")
    private String full_name;
    // 性别
    @TableField(value = "`gender`")
    private String gender;







    // 用户编号
    @TableField(value = "user_id")
    private Integer userId;



    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
