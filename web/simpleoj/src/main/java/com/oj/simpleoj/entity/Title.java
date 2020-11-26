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


    @Column(name="title_input")
    private String titleInput;

    @Column(name="title_expect_output")
    private String titleExpectOutput;

    @Column(name="title_code_pre_java")
    private String titleCodePreJava;

    @Column(name="title_code_end_java")
    private String titleCodeEndJava;

    ////////////////////
    @Column(name="title_code_pre_python")
    private String titleCodePrePython;

    @Column(name="title_code_end_python")
    private String titleCodeEndPython;
    ////////////////////

    @Column(name="add_time")
    private Date addTime;

}
