/*
 Navicat Premium Data Transfer

 Source Server         : ojdb
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 106.55.166.98:3306
 Source Schema         : ojdb

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 27/11/2020 08:57:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for submission
-- ----------------------------
DROP TABLE IF EXISTS `submission`;
CREATE TABLE `submission` (
  `submission_id` varchar(8) NOT NULL,
  `problem_id` int(10) DEFAULT NULL,
  `submit_time` timestamp NULL DEFAULT NULL,
  `compile_time` varchar(20) DEFAULT NULL,
  `used_time` varchar(20) DEFAULT NULL,
  `used_memory` varchar(20) DEFAULT NULL,
  `judge_result` char(30) DEFAULT NULL,
  `judge_log` varchar(2000) DEFAULT NULL,
  `submit_code` varchar(5000) DEFAULT NULL,
  `language` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`submission_id`),
  UNIQUE KEY `submission_submission_id_uindex` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='提交记录';

-- ----------------------------
-- Records of submission
-- ----------------------------
BEGIN;
INSERT INTO `submission` VALUES ('0b87d90a', 1, '2020-11-26 14:14:19', NULL, '11', '	    5864 kB', '通过', '', '# -*- coding: UTF-8 -*-    \nclass Solution(object):\n    def twoSum(self, nums, target):\n        \"\"\"\n        :type nums: List[int]\n        :type target: int\n        :rtype: List[int]\n        \"\"\"\n 		#用len()方法取得nums列表的长度\n        n = len(nums)\n        #x取值从0一直到n（不包括n）\n        for x in range(n):\n            #y取值从x+1一直到n（不包括n）\n            #用x+1是减少不必要的循环,y的取值肯定是比x大\n            for y in range(x+1,n):\n                #假如 target-nums[x]的某个值存在于nums中\n                if nums[y] == target - nums[x]:\n                    #返回x和y\n                    return x,y\n                    break\n                else:\n                    continue \n 		', 'python');
INSERT INTO `submission` VALUES ('19f8ae81', 2, '2020-11-26 14:26:08', NULL, '12', '	    5616 kB', '通过', '', '# -*- coding: UTF-8 -*- \n# Definition for singly-linked list.\n# class ListNode(object):\n#     def __init__(self, val=0, next=None):\n#         self.val = val\n#         self.next = next\nclass Solution(object):\n    def addTwoNumbers(self, l1, l2):\n		\"\"\"\n		:type l1: ListNode\n		:type l2: ListNode\n		:rtype: ListNode\n		\"\"\"\n		if l1 is None:\n			return l2\n		if l2 is None:\n			return l1\n\n		tmp = ListNode(0)#ListNode()为LeetCode给出的函数,代码块顶部有详细定义\n		res = tmp\n		flag = 0\n		while l1 or l2:\n			tmpsum = 0\n			if l1:\n				tmpsum = l1.val\n				l1 = l1.next\n			if l2:\n				tmpsum += l2.val\n				l2 = l2.next\n			tmpres = ((tmpsum + flag) % 10)\n			flag = ((tmpsum + flag) // 10)\n			res.next = ListNode(tmpres)\n			res = res.next\n		if flag:\n			res.next = ListNode(1)\n		res = tmp.next\n		del tmp\n		return res\n\n		\n		', 'python');
INSERT INTO `submission` VALUES ('2e1f5171', 1, '2020-11-26 14:13:49', NULL, '46', '	   18576 kB', '通过', '', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n		int[] out=new int[2];\n        for(int i=0;i<nums.length;i++){\n            for(int j=i+1;j<nums.length;j++){\n                if(target==nums[i]+nums[j]){\n                    out[0]=i;\n                    out[1]=j;\n                    break;\n                }\n            }\n        }\n        return out;\n    }\n}', 'java');
INSERT INTO `submission` VALUES ('731de6bc', 3, '2020-11-26 14:27:13', NULL, '13', '	    6040 kB', '通过', '', '# -*- coding: UTF-8 -*-\nclass Solution(object):\n	def lengthOfLongestSubstring(self, s):\n		\"\"\"\n		:type s: str\n		:rtype: int\n		\"\"\"	\n		st = {}\n		i, ans = 0, 0\n		for j in range(len(s)):\n			if s[j] in st:\n				i = max(st[s[j]], i)\n			ans = max(ans, j - i + 1)\n			st[s[j]] = j + 1\n		return ans\n                \n        \n', 'python');
INSERT INTO `submission` VALUES ('8c57fa21', 3, '2020-11-26 14:26:39', NULL, '48', '	   18736 kB', '通过', '', 'import java.util.*;\nclass Solution {\n    public int lengthOfLongestSubstring(String s) {\n        int n = s.length();\n        int res = 0;\n        int end=0,start=0;\n        Set<Character> set=new HashSet<>();\n        while(start<n && end<n){\n           if(set.contains(s.charAt(end))){\n               set.remove(s.charAt(start++));\n           }else{\n               set.add(s.charAt(end++));\n               res=Math.max(res,end-start);\n           }\n            \n        }\n        return res;\n    }\n \n   \n}\n', 'java');
INSERT INTO `submission` VALUES ('974a98fd', 2, '2020-11-26 14:16:11', NULL, '', NULL, '编译错误', 'py\", line 14    if l1 is None:    ^IndentationError: unexpected indent', '# -*- coding: UTF-8 -*- \n# Definition for singly-linked list.\n# class ListNode(object):\n#     def __init__(self, val=0, next=None):\n#         self.val = val\n#         self.next = next\nclass Solution(object):\n    def addTwoNumbers(self, l1, l2):\n        \"\"\"\n        :type l1: ListNode\n        :type l2: ListNode\n        :rtype: ListNode\n        \"\"\"\n		if l1 is None:\n			return l2\n		if l2 is None:\n			return l1\n\n		tmp = ListNode(0)#ListNode()为LeetCode给出的函数,代码块顶部有详细定义\n		res = tmp\n		flag = 0\n		while l1 or l2:\n			tmpsum = 0\n			if l1:\n				tmpsum = l1.val\n				l1 = l1.next\n			if l2:\n				tmpsum += l2.val\n				l2 = l2.next\n			tmpres = ((tmpsum + flag) % 10)\n			flag = ((tmpsum + flag) // 10)\n			res.next = ListNode(tmpres)\n			res = res.next\n		if flag:\n			res.next = ListNode(1)\n		res = tmp.next\n		del tmp\n		return res\n		\n\n		\n		', 'python');
INSERT INTO `submission` VALUES ('a8f7d5c5', 2, '2020-11-26 14:15:37', NULL, '46', '	   18424 kB', '通过', '', '/* -----------------------------------\n *  WARNING:\n * -----------------------------------\n *  Your code may fail to compile\n *  because it contains public class\n *  declarations.\n *  To fix this, please remove the\n *  \"public\" keyword from your class\n *  declarations.\n */\n\n/**\n * Definition for singly-linked list.\n * public class ListNode {\n *     int val;\n *     ListNode next;\n *     ListNode() {}\n *     ListNode(int val) { this.val = val; }\n *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }\n * }\n */\nclass Solution {\n    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {\n        ListNode q = l1, p = l2;\n        ListNode dummyHead = new ListNode(0);\n        ListNode carr = dummyHead;\n        int carry = 0;\n        while (q != null || p != null) {\n            int x = q != null ? q.val : 0;\n            int y = p != null ? p.val : 0;\n            \n            int sum = x + y + carry;\n            \n            carry = sum / 10;\n            \n            carr.next = new ListNode(sum % 10);\n            carr = carr.next;\n            if (q != null) q = q.next;\n            if (p != null) p = p.next;\n        }\n        \n        if (carry > 0) {\n            carr.next = new ListNode(carry);\n        }\n        return dummyHead.next;\n    }\n}', 'java');
INSERT INTO `submission` VALUES ('b0b9351d', 1, '2020-11-26 14:13:47', NULL, '49', '	   18100 kB', '通过', '', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n		int[] out=new int[2];\n        for(int i=0;i<nums.length;i++){\n            for(int j=i+1;j<nums.length;j++){\n                if(target==nums[i]+nums[j]){\n                    out[0]=i;\n                    out[1]=j;\n                    break;\n                }\n            }\n        }\n        return out;\n    }\n}', 'java');
INSERT INTO `submission` VALUES ('b66f21d2', 1, '2020-11-26 14:13:44', NULL, '46', '	   18756 kB', '通过', '', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n		int[] out=new int[2];\n        for(int i=0;i<nums.length;i++){\n            for(int j=i+1;j<nums.length;j++){\n                if(target==nums[i]+nums[j]){\n                    out[0]=i;\n                    out[1]=j;\n                    break;\n                }\n            }\n        }\n        return out;\n    }\n}', 'java');
INSERT INTO `submission` VALUES ('e8317ce7', 1, '2020-11-26 14:13:54', NULL, '', NULL, '编译错误', 'java:11: error: not a statement              lkl              ^java:11: error: \';\' expected              lkl                 ^2 errors', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n		int[] out=new int[2];\n        for(int i=0;i<nums.length;i++){\n            for(int j=i+1;j<nums.length;j++){\n                if(target==nums[i]+nums[j]){\n                    out[0]=i;\n                    out[1]=j;\n                    break;\n                }\n              lkl\n            }\n        }\n        return out;\n    }\n}', 'java');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
