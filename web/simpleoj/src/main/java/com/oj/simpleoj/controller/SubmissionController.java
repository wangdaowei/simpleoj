package com.oj.simpleoj.controller;

import com.oj.simpleoj.entity.Submission;
import com.oj.simpleoj.repository.SubmissionRepository;
import com.oj.simpleoj.services.SubmissionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/***
 * @Author CCW
 */
@RestController
@RequestMapping(value = "/submission")
public class SubmissionController {
    @Autowired
    SubmissionService submissionService;

    Logger logger = LoggerFactory.getLogger(SubmissionController.class);

    /***
     * 获取用户对某道题的提交结果列表
     */
    @GetMapping(value = "/getSubmissionByProblem")
    public List<Submission> getSubmissionByProblem(Integer titleId){
//        return submissionService.getSubmissionByProblemId(titleId);
        List result = submissionService.getSubmissionByProblemId(titleId);
        logger.info("############,titleId is {},result is : {}" ,titleId, result);
        return result;
    }

}
