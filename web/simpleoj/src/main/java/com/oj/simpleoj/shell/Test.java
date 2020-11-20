package com.oj.simpleoj.shell;

import java.io.IOException;

public class Test {

        public static void main(String[] args) {
            String cmd = "sh /Users/wangwei/test/javaShell/java.sh";
            if (args.length == 1) {
                cmd = args[0];
            }
            ShellUtils.runShell(cmd);


        }
}
