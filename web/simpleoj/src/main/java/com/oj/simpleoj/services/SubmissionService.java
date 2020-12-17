package com.oj.simpleoj.services;

import com.oj.simpleoj.entity.Submission;
import com.oj.simpleoj.repository.SubmissionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class SubmissionService {

    @Autowired
    SubmissionRepository submissionRepository;


    /***
     * 创建新的提交记录
     */
    public void createSubmission(Integer titleId, String input, String language, Map<String, Object> resultMap) {

        System.out.println("#####resultMap：" + resultMap);
//        _this.problemDetail.output=res.data.output;
//        _this.problemDetail.errorInfo=res.data.errorInfo;
//        _this.problemDetail.compileTime=res.data.compileTime;
//        _this.problemDetail.runTime=res.data.runTime;
//        _this.problemDetail.submitStatus=res.data.submitResult;
//
//        _this.errorCode=res.data.errorCode;
//        _this.submitResult=res.data.submitResult;
//        Integer problemId,int usedTime, int usedMemory, String judgeResult, String judgeLog, String code, String language
        List<String> ketSet = new ArrayList<>(Arrays.asList("runTime","submitResult","usedMemory","errorInfo"));
        for (String key : ketSet){
            System.out.println("key,value:"+ key+"  "+ resultMap.get(key));
            resultMap.putIfAbsent(key, "");
        }

        Submission submission = new Submission(
                titleId,
                (String)resultMap.get("runTime"),
                (String)resultMap.get("VmRSS"),
                (String)resultMap.get("submitResult"),
                resultMap.get("errorInfoNobr").toString(),
                input,
                language
                );

        submissionRepository.save(submission);
    }

    public List<Submission> getSubmissionByProblemId(Integer titleId) {
        return submissionRepository.findByProblemId(titleId);
    }
}
