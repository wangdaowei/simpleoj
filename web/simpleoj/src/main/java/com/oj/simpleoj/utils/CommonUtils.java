package com.oj.simpleoj.utils;


import org.apache.log4j.Logger;

import java.io.Closeable;
import java.io.IOException;

public class CommonUtils {
    private static final Logger LOGGER = Logger.getLogger(CommonUtils.class);

    /**
     * 提供统一关闭流的方法
     *
     * @param stream 待关闭的流
     */
    public static void closeStream(Closeable stream) {
        if (stream == null) {
            return;
        }

        try {
            stream.close();
        } catch (IOException e) {
            LOGGER.error("Close stream failed!");
        }
    }
}