package org.git.modules.doc.util;

import java.io.*;
import java.sql.*;


public class test {
	private static Connection con=null;
	private static PreparedStatement ps=null;
	public static void main(String[] args)  throws Exception{

		String driverclass="com.mysql.jdbc.Driver";
		String url="jdbc:mysql://localhost:3306/bladex-boot?useSSL=false&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&transformedBitIsBoolean=true&serverTimezone=GMT%2B8&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true";
		String username="root";
		String password="shc51888";
		Class.forName(driverclass) ;
		test.con = DriverManager.getConnection(url, username, password);
		duqu();
		System.out.println("执行完成");
		try {
			con.close();
			ps.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static int resultdata(String sql){
		int i =0;
		try {
			test.ps = test.con.prepareStatement(sql);
			i = test.ps.executeUpdate();
		}catch (Exception e){
			i=0;
		}
		return i;
	}


	public static void duqu() throws FileNotFoundException, UnsupportedEncodingException {
		BufferedReader reader=new BufferedReader(new InputStreamReader(new FileInputStream("D:\\aaa\\aa.txt"),"GBK"));
		String temp=null;
		int line=1;
		try{
			while((temp=reader.readLine())!=null){
				String sql=temp.substring(0,temp.length()-1);
				System.out.println(sql);
				int i=resultdata(sql);
				if(i==0){
					PrintWriter out=new PrintWriter("D:\\aaa\\失败.txt","GBK");
					out.println(sql);
					out.close();
				}else{
					PrintWriter out=new PrintWriter("D:\\aaa\\成功.txt","GBK");
					out.println(sql);
					out.close();
				}
				line++;
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(reader!=null){
				try{
					reader.close();
				}
				catch(Exception e){
					e.printStackTrace();
				}
			}
		}
	}
}
