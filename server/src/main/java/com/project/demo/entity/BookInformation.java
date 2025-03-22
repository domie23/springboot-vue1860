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
 * 书籍信息：(BookInformation)表实体类
 *
 */
@TableName("`book_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class BookInformation implements Serializable {

    // BookInformation编号
    @TableId(value = "book_information_id", type = IdType.AUTO)
    private Integer book_information_id;

    // 书籍名称
    @TableField(value = "`book_name`")
    private String book_name;
    // 书籍种类
    @TableField(value = "`types_of_books`")
    private String types_of_books;
    // 书籍价格
    @TableField(value = "`book_prices`")
    private String book_prices;
    // 库存数量
    @TableField(value = "`inventory_quantity`")
    private String inventory_quantity;
    // 备注详情
    @TableField(value = "`notes_details`")
    private String notes_details;
    // 书籍图片
    @TableField(value = "`book_images`")
    private String book_images;










    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
