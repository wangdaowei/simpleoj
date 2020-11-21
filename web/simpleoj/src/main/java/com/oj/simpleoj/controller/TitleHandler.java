package com.oj.simpleoj.controller;

import com.oj.simpleoj.shell.ShellResult;
import org.apache.log4j.Logger;
import com.oj.simpleoj.entity.Title;
import com.oj.simpleoj.repository.TitleRepository;
import com.oj.simpleoj.shell.ShellUtils;
import com.oj.simpleoj.utils.FiledirUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.FileOutputStream;
import java.util.*;

@RestController
@RequestMapping("/title")
public class TitleHandler {
    private static final Logger LOGGER = Logger.getLogger(TitleHandler.class);

    private static String absoluteDir;

    @Value("${spring.userparam.absoluteDir}")
    public void setAbsoluteDir(String absoluteDir){
        this.absoluteDir=absoluteDir;
    }


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


    @PostMapping("/submit")
    public HashMap<String, Object> submit(@RequestBody Map<String,Object> dataMap){
        System.out.println("requestMap："+dataMap.toString());
        //题号
        String titleId= (String) dataMap.get("titleId");
        //期望输出
        String titleExpectOutput= (String) dataMap.get("titleExpectOutput");
        //预设输入
        String titleInput= (String) dataMap.get("titleInput");
        //用户编辑内容
        String input= (String) dataMap.get("input");

        String language= (String) dataMap.get("language");

        //题设外置代码
        String titleCodePre="";
        if("java".equals(language)){
            titleCodePre= (String) dataMap.get("titleCodePreJava");
        }


        //titleInput以换行分割，每一行对应一个 String args[] 参数： java  "args[0]" "[1]"
        String[] titleInputParam=titleInput.split("\n");
        String args0=null;
        String args1=null;
        String args2=null;
        for (int i=0;i<titleInputParam.length;i++){
            if(i==0){
                args0=titleInputParam[i];
            }else if(i==1){
                args1=titleInputParam[i];
            }else if(i==2){
                args2=titleInputParam[i];
            }
        }
        System.out.println("args0:"+args0+" args1:"+args1+"args2: "+args2);
        String languageShell=absoluteDir+"/common/"+language+"/"+language+".sh";
        System.out.println("shell:"+languageShell);

        //输出换成map
        HashMap<String,Object> resultMap=new HashMap<String,Object>();
        String absoluteDirName="/test/test/test/test"; //担心未赋值删错文件


        try{
            //创建临时目录
            String dirName= UUID.randomUUID().toString();
            absoluteDirName=absoluteDir+"/"+dirName;
            //LOGGER.info("目录："+absoluteDirName);
            System.out.println("临时文件路径"+absoluteDirName);
            FiledirUtils.createFile(absoluteDirName);

            //将输入String 生成执行文件
            String houZhui=FiledirUtils.getHouZhui(language);
            String runFilePath=absoluteDirName+"/t."+houZhui;

            FileOutputStream  fos=new FileOutputStream(runFilePath);
            //MainClass 文件前部分
            fos.write(titleCodePre.getBytes());
            //文件后部分
            fos.write(input.getBytes());
            fos.close();

            //执行shell脚本
            String  cmd="sh "+languageShell
                    +" "+absoluteDirName
                    +" "+args0
                    +" "+args1
                    +" "+args2;

            ShellResult result=ShellUtils.runShell(cmd);
            List<String> description=result.getDescription();
            int errorCode=result.getErrorCode();

            resultMap.put("errorCode",errorCode);
            if(errorCode==0){ //执行成功
                //执行成功的话，把结果转成Map
                for (String tmp: description) {
                    String[] tmpspilt=tmp.split(":");
                    resultMap.put(tmpspilt[0],tmpspilt[1]);
                }
            }else{ //执行失败
                StringBuffer errorInfo=new StringBuffer();
                //执行失败的话，组装errorInfo
                for (String tmp: description) {
                    String tmpShort=tmp.substring(tmp.indexOf('.')+1);
                    errorInfo.append(tmpShort+" <br/>");
                }
                resultMap.put("errorInfo",errorInfo);
            }

        }catch (Exception e){


        }finally {
            File file =new File(absoluteDirName);
            FiledirUtils.deleteFile(file);
        }


        return resultMap;
    }
}
