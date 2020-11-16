package com.oj.simpleoj.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.oj.simpleoj.entity.Title;

public interface TitleRepository extends JpaRepository<Title,Integer> {
}
