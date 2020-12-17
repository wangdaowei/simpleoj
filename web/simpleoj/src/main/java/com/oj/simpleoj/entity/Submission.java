package com.oj.simpleoj.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import lombok.*;

/**
 * @Description  
 * @Author  ccw
 * @Date 2020-11-18 
 */

@Getter
@Setter
@ToString
@Entity ( name ="submission" )
@Data
public class Submission  implements Serializable {
	private static final long serialVersionUID =  688400329487509064L;

	@Id
   	@Column(name = "submission_id" )
	private String submissionId;

   	@Column(name = "problem_id" )
	private Integer problemId;

   	@Column(name = "submit_time" )
	private Timestamp submitTime;


	@Column(name = "compile_time" )
	private String compile_time;

   	@Column(name = "used_time" )
	private String usedTime;

   	@Column(name = "used_memory" )
	private String usedMemory;

   	@Column(name = "judge_result" )
	private String judgeResult;

   	@Column(name = "judge_log" )
	private String judgeLog;

   	@Column(name = "submit_code")
	private String code;

   	@Column(name = "language")
	private String language;

   	Submission(){

	}

   	public Submission(Integer problemId, String usedTime, String usedMemory, String judgeResult, String judgeLog, String code, String language){
		this.problemId = problemId;
		this.usedTime = usedTime;
		this.usedMemory = usedMemory;
		this.judgeResult = judgeResult;
		this.judgeLog = judgeLog;
		this.code = code;
		this.language = language;
		this.submitTime = new Timestamp(System.currentTimeMillis());
		this.submissionId = UUID.randomUUID().toString().substring(0,8);
	}

	public String getSubmissionId() {
		return this.submissionId;
	}

	public void setSubmissionId(String submissionId) {
		this.submissionId = submissionId;
	}

	public Integer getProblemId() {
		return this.problemId;
	}

	public void setProblemId(Integer problemId) {
		this.problemId = problemId;
	}

	public Timestamp getSubmitTime() {
		return this.submitTime;
	}

	public void setSubmitTime(Timestamp submitTime) {
		this.submitTime = submitTime;
	}

	public String getUsedTime() {
		return this.usedTime;
	}

	public void setUsedTime(String usedTime) {
		this.usedTime = usedTime;
	}

	public String getUsedMemory() {
		return this.usedMemory;
	}

	public void setUsedMemory(String usedMemory) {
		this.usedMemory = usedMemory;
	}

	public String getJudgeResult() {
		return this.judgeResult;
	}

	public void setJudgeResult(String judgeResult) {
		this.judgeResult = judgeResult;
	}

	public String getJudgeLog() {
		return this.judgeLog;
	}

	public void setJudgeLog(String judgeLog) {
		this.judgeLog = judgeLog;
	}

	public String getCode(){
		return this.code;
	}

	public void setCode(String code){this.code = code;}

}
