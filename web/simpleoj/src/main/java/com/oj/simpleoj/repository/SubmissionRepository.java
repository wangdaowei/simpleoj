package com.oj.simpleoj.repository;

import com.oj.simpleoj.entity.Submission;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubmissionRepository extends JpaRepository<Submission,Integer> {

    List<Submission> findByProblemId(Integer titleId);
}
