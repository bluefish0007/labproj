package com.test.dao;

import com.codetrans.latintoun.biz.LatinToUnicodeRuleList;

/*
 * 拉丁转蒙文
 * */

public class LatoM {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String a="TIYAN";
		String b =LatinToUnicodeRuleList.getUtf8String(a);
		System.out.println(b);
	}
}
