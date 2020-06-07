package com.tgb.util;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.SecureRandom;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;






import org.apache.commons.lang3.StringUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;
public class LockUserCode {
	public static String encrypt(String str, String key) {
		String encryptStr = null;
		if (StringUtils.isNotEmpty(str)) {
			byte[] res = null;
			try {
				byte[] input = str.getBytes();
				SecureRandom rad = new SecureRandom();
				DESKeySpec desKey = new DESKeySpec(key.getBytes());
				SecretKeyFactory keyFactory = SecretKeyFactory
						.getInstance("DES");
				SecretKey secretKey = keyFactory.generateSecret(desKey);
				Cipher cipher = Cipher.getInstance("DES");
				cipher.init(Cipher.ENCRYPT_MODE, secretKey, rad);
				res = cipher.doFinal(input);
				encryptStr = URLEncoder.encode(new BASE64Encoder().encode(res),
						"UTF-8");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return encryptStr;
	}

	public static String decrypt(String str, String key) {
		String decryptStr = null;
		if (StringUtils.isNotEmpty(str)) {
			byte[] res = null;
			try {
				str = URLDecoder.decode(str, "UTF-8");
				byte[] input = new BASE64Decoder().decodeBuffer(str);
				SecureRandom rad = new SecureRandom();
				DESKeySpec desKey = new DESKeySpec(key.getBytes());
				SecretKeyFactory keyFactory = SecretKeyFactory
						.getInstance("DES");
				SecretKey secretKey = keyFactory.generateSecret(desKey);
				Cipher cipher = Cipher.getInstance("DES");
				cipher.init(Cipher.DECRYPT_MODE, secretKey, rad);
				res = cipher.doFinal(input);
				decryptStr = new String(res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return decryptStr;
	}
  	public static void main(String[] args) {
		//String gh = "userid-24401840119";//gp7q5xYU%2F5en2m2X2Uz1hOo7jVHcVEJb
  		String gh = "userid-00001";//XkmQGmZllA%2BRD3Je5B5%2ByQ%3D%3D	
		String encrypt = LockUserCode.encrypt(gh, "24401830000");
		System.out.println(encrypt);
		String decrypt = LockUserCode.decrypt(encrypt, "24401830000");
		System.out.println(decrypt);
	}

}
