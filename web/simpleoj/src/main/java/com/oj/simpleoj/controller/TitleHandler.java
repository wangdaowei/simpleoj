package com.oj.simpleoj.controller;


import com.oj.simpleoj.entity.Title;
import com.oj.simpleoj.repository.TitleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/title")
public class TitleHandler {
    @Autowired
    private TitleRepository titleRepository;

    @GetMapping("/findOne")
    public Optional<Title> findOne(Integer titleId){
        return titleRepository.findById(titleId);
    }

    @GetMapping("/findAll")
    public List<Title> findAll(Integer titleId){
        return titleRepository.findAll();
    }
}
