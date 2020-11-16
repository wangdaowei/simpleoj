package com.oj.simpleoj.entity;


import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity(name="title_tb")
@Data
public class Title {
    @Id
    @Column(name="title_id")
    private Integer titleId;

    @Column(name="title_name")
    private String titleName;

    @Column(name="title_level")
    private String titleLevel;

    @Column(name="title_describe")
    private String titleDescribe;

    @Column(name="title_example")
    private String titleExample;

    @Column(name="title_example2")
    private String titleExample2;

    @Column(name="add_time")
    private Date addTime;

}
