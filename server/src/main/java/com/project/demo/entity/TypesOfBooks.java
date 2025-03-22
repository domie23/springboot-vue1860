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
 * 书籍种类：(TypesOfBooks)表实体类
 *
 */
@TableName("`types_of_books`")
@Data
@EqualsAndHashCode(callSuper = false)
public class TypesOfBooks implements Serializable {

    // TypesOfBooks编号
    @TableId(value = "types_of_books_id", type = IdType.AUTO)
    private Integer types_of_books_id;

    // 书籍种类
    @TableField(value = "`types_of_books`")
    private String types_of_books;










    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
