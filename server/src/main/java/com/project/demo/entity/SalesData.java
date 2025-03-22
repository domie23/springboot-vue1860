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
 * 销售数据：(SalesData)表实体类
 *
 */
@TableName("`sales_data`")
@Data
@EqualsAndHashCode(callSuper = false)
public class SalesData implements Serializable {

    // SalesData编号
    @TableId(value = "sales_data_id", type = IdType.AUTO)
    private Integer sales_data_id;

    // 统计日期
    @TableField(value = "`statistical_date`")
    private Timestamp statistical_date;
    // 售卖数量
    @TableField(value = "`sales_quantity`")
    private String sales_quantity;
    // 利润金额
    @TableField(value = "`profit_amount`")
    private String profit_amount;
    // 备注详情
    @TableField(value = "`notes_details`")
    private String notes_details;










    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
