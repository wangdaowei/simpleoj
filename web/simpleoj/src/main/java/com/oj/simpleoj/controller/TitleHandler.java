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
        System.out.println("题号："+dataMap.get("titleId"));

        System.out.println("输入："+dataMap.get("input"));

        Integer titleId= (Integer) dataMap.get("titleId");

        String input= (String) dataMap.get("input");

        String language= (String) dataMap.get("language");

        String languageShell=absoluteDir+"/common/"+language+"/"+language+".sh";
        System.out.println("shell:"+languageShell);

        //输出换成map
        HashMap<String,Object> resultMap=new HashMap<String,Object>();
        String absoluteDirName="/test/test/test/test"; //担心未赋值删错文件

//        selectedTitle: {
//            titleId: '',
//                    titleName: '',
//                    titleLevel: '',
//                    titleDescribe: '',
//                    titleExample: '',
//                    titleExample2: '',
//                    --submitStatus:'',
//                    input:'',
//                    output:'',
//                    rightOutput:'',
//                    --compileTime:'',
//                    --runTime:'',
//                    errorInfo:''
//        },

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
            fos.write(input.getBytes());
            fos.close();

            //执行shell脚本
            String  cmd="sh "+languageShell+" "+absoluteDirName;
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
                    errorInfo.append(tmp+"\n");
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
