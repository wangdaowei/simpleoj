package com.oj.simpleoj.utils;

import java.io.File;
import org.apache.log4j.Logger;


public class FiledirUtils {
    private static final Logger LOGGER = Logger.getLogger(FiledirUtils.class);


    //新建文件夹
    public static void createFile(String fileObsoluteName){
        File file=new File(fileObsoluteName);
        if(!file.exists() && !file.isDirectory()){
            file.mkdir();
        }
    }

    //删除文件夹 及其内容
    public static void deleteFile(File file){
        if(file.exists()){
            if(file.isFile()){ //是文件直接删除
                file.delete();
            }else if(file.isDirectory()){ //是文件夹的话递归删除
                File[] files=file.listFiles();
                for(int i=0;i<files.length;i++){
                    FiledirUtils.deleteFile(files[i]);
                }
                file.delete();
            }
        }else{
            LOGGER.info("所删除的文件不存在");
        }
    }

    public static String getHouZhui(String language) {
        String out="noSupport";
        if("java".equals(language)){
            out="java";
        }

        return  out;
    }
}
