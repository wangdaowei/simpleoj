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

 Date: 27/11/2020 08:56:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for title_tb
-- ----------------------------
DROP TABLE IF EXISTS `title_tb`;
CREATE TABLE `title_tb` (
  `title_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title_name` varchar(200) NOT NULL,
  `title_level` varchar(12) DEFAULT NULL,
  `title_describe` varchar(2000) DEFAULT NULL,
  `title_example` varchar(2000) NOT NULL,
  `title_example2` varchar(2000) DEFAULT NULL,
  `title_input` varchar(500) NOT NULL,
  `title_expect_output` varchar(500) NOT NULL,
  `title_code_pre_java` varchar(3000) DEFAULT NULL,
  `title_code_end_java` varchar(1500) DEFAULT NULL,
  `title_code_pre_python` varchar(3000) DEFAULT NULL,
  `title_code_end_python` varchar(1500) DEFAULT NULL,
  `add_time` date DEFAULT NULL,
  PRIMARY KEY (`title_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of title_tb
-- ----------------------------
BEGIN;
INSERT INTO `title_tb` VALUES (1, '两数之和', '简单', '给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。\n\n你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。\n', '给定 nums = [2, 7, 11, 15], target = 9\n\n因为 nums[0] + nums[1] = 2 + 7 = 9\n所以返回 [0, 1]', NULL, '[2,7,11,15]\n9', '[0, 1]', 'class MainClass {\n    public static int[] stringToIntegerArray(String input) {\n        input = input.trim();\n        input = input.substring(1, input.length() - 1);\n        if (input.length() == 0) {\n            return new int[0];\n        }\n\n        String[] parts = input.split(\",\");\n        int[] output = new int[parts.length];\n        for(int index = 0; index < parts.length; index++) {\n            String part = parts[index].trim();\n            output[index] = Integer.parseInt(part);\n        }\n        return output;\n    }\n\n    public static String integerArrayToString(int[] nums, int length) {\n        if (length == 0) {\n            return \"[]\";\n        }\n\n        String result = \"\";\n        for(int index = 0; index < length; index++) {\n            int number = nums[index];\n            result += Integer.toString(number) + \", \";\n        }\n        return \"[\" + result.substring(0, result.length() - 2) + \"]\";\n    }\n\n    public static String integerArrayToString(int[] nums) {\n        return integerArrayToString(nums, nums.length);\n    }\n\n    public static void main(String[] args)  {\n\n        int[] nums = stringToIntegerArray(args[0]);\n        int target = Integer.parseInt(args[1]);\n\n        int[] ret = new Solution().twoSum(nums, target);\n\n        String out = integerArrayToString(ret);\n\n        System.out.print(\"output:\"+out);\n    }\n}\n\n\n', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n		\n      \n      \n    }\n}', '# -*- coding: UTF-8 -*-          \nimport json\ndef stringToIntegerList(input):\n    return json.loads(input)\n\ndef stringToInt(input):\n    return int(input)\n\ndef integerListToString(nums, len_of_list=None):\n    if not len_of_list:\n        len_of_list = len(nums)\n    return json.dumps(nums[:len_of_list])\n\ndef main():\n	import sys\n	try:\n		line = sys.argv[1]\n		nums = stringToIntegerList(line)\n		line = sys.argv[2]\n		target = stringToInt(line)\n		\n		ret = Solution().twoSum(nums, target)\n\n		out = integerListToString(ret)\n		print \'output:\'+out\n	except StopIteration:\n		print \"error\"\n\nif __name__ == \'__main__\':\n    main()\n\n\n', '# -*- coding: UTF-8 -*-    \nclass Solution(object):\n    def twoSum(self, nums, target):\n        \"\"\"\n        :type nums: List[int]\n        :type target: int\n        :rtype: List[int]\n        \"\"\"\n 		\n 		', '2020-11-15');
INSERT INTO `title_tb` VALUES (2, '两数相加', '中等', '给出两个 非空 的链表用来表示两个非负的整数。其中，它们各自的位数是按照 逆序 的方式存储的，并且它们的每个节点只能存储 一位 数字。\n\n如果，我们将这两个数相加起来，则会返回一个新的链表来表示它们的和。\n\n您可以假设除了数字 0 之外，这两个数都不会以 0 开头。', '输入：(2 -> 4 -> 3) + (5 -> 6 -> 4)\n输出：7 -> 0 -> 8\n原因：342 + 465 = 807', NULL, '[2,4,3]\n[5,6,4]', '[7, 0, 8]', 'class MainClass {\n    public static int[] stringToIntegerArray(String input) {\n        input = input.trim();\n        input = input.substring(1, input.length() - 1);\n        if (input.length() == 0) {\n            return new int[0];\n        }\n\n        String[] parts = input.split(\",\");\n        int[] output = new int[parts.length];\n        for(int index = 0; index < parts.length; index++) {\n            String part = parts[index].trim();\n            output[index] = Integer.parseInt(part);\n        }\n        return output;\n    }\n\n    public static ListNode stringToListNode(String input) {\n        // Generate array from the input\n        int[] nodeValues = stringToIntegerArray(input);\n\n        // Now convert that list into linked list\n        ListNode dummyRoot = new ListNode(0);\n        ListNode ptr = dummyRoot;\n        for(int item : nodeValues) {\n            ptr.next = new ListNode(item);\n            ptr = ptr.next;\n        }\n        return dummyRoot.next;\n    }\n\n    public static String listNodeToString(ListNode node) {\n        if (node == null) {\n            return \"[]\";\n        }\n\n        String result = \"\";\n        while (node != null) {\n            result += Integer.toString(node.val) + \", \";\n            node = node.next;\n        }\n        return \"[\" + result.substring(0, result.length() - 2) + \"]\";\n    }\n\n    public static void main(String[] args){\n        ListNode l1 = stringToListNode(args[0]);\n\n        ListNode l2 = stringToListNode(args[1]);\n\n        ListNode ret = new Solution().addTwoNumbers(l1, l2);\n\n        String out = listNodeToString(ret);\n\n        System.out.print(\"output:\"+out);\n    }\n}\n\n\nclass ListNode {\n    int val;\n    ListNode next;\n    ListNode() {}\n    ListNode(int val) { this.val = val; }\n    ListNode(int val, ListNode next) { this.val = val; this.next = next; }\n}\n\n\n\n', '/* -----------------------------------\n *  WARNING:\n * -----------------------------------\n *  Your code may fail to compile\n *  because it contains public class\n *  declarations.\n *  To fix this, please remove the\n *  \"public\" keyword from your class\n *  declarations.\n */\n\n/**\n * Definition for singly-linked list.\n * public class ListNode {\n *     int val;\n *     ListNode next;\n *     ListNode() {}\n *     ListNode(int val) { this.val = val; }\n *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }\n * }\n */\nclass Solution {\n    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {\n	\n	\n	\n	\n    }\n}\n\n', '# -*- coding: UTF-8 -*- \nimport json \n\nclass ListNode(object):\n	def __init__(self, val=0, next=None):\n		self.val = val\n		self.next = next\n\ndef stringToListNode(input):\n    # Generate list from the input\n    numbers = json.loads(input)\n\n    # Now convert that list into linked list\n    dummyRoot = ListNode(0)\n    ptr = dummyRoot\n    for number in numbers:\n        ptr.next = ListNode(number)\n        ptr = ptr.next\n\n    ptr = dummyRoot.next\n    return ptr\n\ndef listNodeToString(node):\n    if not node:\n        return \"[]\"\n\n    result = \"\"\n    while node:\n        result += str(node.val) + \", \"\n        node = node.next\n    return \"[\" + result[:-2] + \"]\"\n\ndef main():\n	import sys\n	try:\n		line = sys.argv[1]\n		l1 = stringToListNode(line)\n		line = sys.argv[2]\n		l2 = stringToListNode(line)\n		\n		ret = Solution().addTwoNumbers(l1, l2)\n\n		out = listNodeToString(ret)\n		print \'output:\'+out\n	except StopIteration:\n		print \"error\"\n\nif __name__ == \'__main__\':\n    main()\n\n\n', '# -*- coding: UTF-8 -*- \n# Definition for singly-linked list.\n# class ListNode(object):\n#     def __init__(self, val=0, next=None):\n#         self.val = val\n#         self.next = next\nclass Solution(object):\n    def addTwoNumbers(self, l1, l2):\n		\"\"\"\n		:type l1: ListNode\n		:type l2: ListNode\n		:rtype: ListNode\n		\"\"\"\n		\n		\n		', '2020-11-15');
INSERT INTO `title_tb` VALUES (3, '无重复字符的最长子串', '中等', '给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。', '输入: \"abcabcbb\"\n输出: 3 \n解释: 因为无重复字符的最长子串是 \"abc\"，所以其长度为 3。', '输入: \"pwwkew\"\n输出: 3\n解释: 因为无重复字符的最长子串是 \"wke\"，所以其长度为 3。\n     请注意，你的答案必须是 子串 的长度，\"pwke\" 是一个子序列，不是子串。', 'abcabcbb', '3', 'class MainClass {\n    public static String stringToString(String input) {\n        if (input == null) {\n            return \"null\";\n        }\n        return input;\n    }\n    \n    public static void main(String[] args) {\n		String s = stringToString(args[0]);\n		\n		int ret = new Solution().lengthOfLongestSubstring(s);\n		\n		String out = String.valueOf(ret);\n		\n		System.out.print(\"output:\"+out);\n    }\n}\n\n\n', 'class Solution {\n    public int lengthOfLongestSubstring(String s) {\n        \n        \n        return 0;\n    }\n}\n\n', '# -*- coding: UTF-8 -*-\nimport json\ndef stringToString(input):\n    return input[1:-1].decode(\'string_escape\')\n\ndef intToString(input):\n    if input is None:\n        input = 0\n    return str(input)\n\ndef main():\n	import sys\n	try:\n		line = sys.argv[1]\n		s = stringToString(line)\n		\n		ret = Solution().lengthOfLongestSubstring(s)\n\n		out = intToString(ret)\n		print \'output:\'+out\n	except StopIteration:\n		print \'error\'\n\nif __name__ == \'__main__\':\n    main()\n\n\n', '# -*- coding: UTF-8 -*-\nclass Solution(object):\n	def lengthOfLongestSubstring(self, s):\n		\"\"\"\n		:type s: str\n		:rtype: int\n		\"\"\"\n        \n        ', '2020-11-15');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
