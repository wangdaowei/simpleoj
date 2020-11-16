package com.oj.simpleoj.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import com.oj.simpleoj.repository.TitleRepository;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class TitleRepositoryTest {
    @Autowired
    private  TitleRepository titleRepository;

    @Test
    void findAll(){
        System.out.println(titleRepository.findById(1));
    }
}