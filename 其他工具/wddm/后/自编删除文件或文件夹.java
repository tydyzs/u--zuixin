package a;

import java.io.File;
import java.lang.reflect.Array;
import java.util.Arrays;

/*
 * 删除给定的文件或则文件夹（文件夹可删除里面所有内容）
 *--沈焕成
 */
public class q {

	
	public static void main(String[] args) {
		abc("D:\\aaaa");
		
	}
	
	
	//删除文件和文件夹（文件夹包括里面所有内容）
	public static void abc(String str){
		File file=new File(str);
		
		while(file.exists()){//存在
			
			
		if(file.isFile()){//文件
			System.out.println("sssssss");
			file.delete();
			return;
		}
		
		String [] s=file.list();//获取文件夹中的内容，文件夹名数组
		
		if(s.length==0){//空文件夹
			//file.delete();
			return;
		}
		
		for(int i=0;i<s.length;i++){
			System.out.println(i+"");
			s[i]=str+"\\"+s[i];
			abc(s[i]);
		}
		
		
		
		}

	}
}
