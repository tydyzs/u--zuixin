package org.springblade.doc.util;

import io.minio.MinioClient;
import io.minio.ObjectStat;
import io.minio.Result;
import io.minio.messages.Bucket;
import io.minio.messages.Item;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springblade.core.minio.model.MinioItem;
import org.springblade.doc.constant.DocConstant;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.*;
/**
 * minio工具类
 *
 * @author shenhuancheng
 */
@Slf4j
@Component
public class MinioClientUtils implements CommandLineRunner {
	@Override
	public void run(String... args) throws Exception {
		try{
			DocConstant.client = new MinioClient(DocConstant.ENDPOINT, DocConstant.ACCESSKEY, DocConstant.SECRETKEY);
			this.createBucket(DocConstant.TYSX_BUCKET_NAME);
			log.info("MinIo初始化成功！");
		}catch (Exception E){
			log.error(E.toString());
		}
	}
	public  MinioClientUtils(){
		try{
			DocConstant.client = new MinioClient(DocConstant.ENDPOINT, DocConstant.ACCESSKEY, DocConstant.SECRETKEY);
			this.createBucket(DocConstant.TYSX_BUCKET_NAME);
			log.info("MinIo初始化成功！");
		}catch (Exception E){
			log.error(E.toString());
		}
	}
	/**
	 * 创建bucket
	 *
	 * @param bucketName bucket名称
	 */
	@SneakyThrows
	public void createBucket(String bucketName) {
		if (!DocConstant.client.bucketExists(bucketName)) {
			DocConstant.client.makeBucket(bucketName);
		}
	}

	/**
	 * 获取全部bucket
	 * <p>
	 * https://docs.minio.io/cn/java-client-api-reference.html#listBuckets
	 */
	@SneakyThrows
	public List<Bucket> getAllBuckets() {
		return DocConstant.client.listBuckets();
	}

	/**
	 * 根据bucketName获取信息
	 *
	 * @param bucketName bucket名称
	 */
	@SneakyThrows
	public Optional<Bucket> getBucket(String bucketName) {
		return DocConstant.client.listBuckets().stream().filter(b -> b.name().equals(bucketName)).findFirst();
	}

	/**
	 * 根据bucketName删除信息
	 *
	 * @param bucketName bucket名称
	 */
	@SneakyThrows
	public void removeBucket(String bucketName) {
		DocConstant.client.removeBucket(bucketName);
	}

	/**
	 * 根据文件前置查询文件
	 *
	 * @param bucketName bucket名称
	 * @param prefix     前缀
	 * @param recursive  是否递归查询
	 * @return MinioItem 列表
	 */
	@SneakyThrows
	public List<MinioItem> getAllObjectsByPrefix(String bucketName, String prefix, boolean recursive) {
		List<MinioItem> objectList = new ArrayList<>();
		Iterable<Result<Item>> objectsIterator = DocConstant.client
			.listObjects(bucketName, prefix, recursive);

		while (objectsIterator.iterator().hasNext()) {
			objectList.add(new MinioItem(objectsIterator.iterator().next().get()));
		}
		return objectList;
	}

	/**
	 * 获取文件外链
	 *
	 * @param bucketName bucket名称
	 * @param objectName 文件名称
	 * @param expires    过期时间 <=7
	 * @return url
	 */
	@SneakyThrows
	public String getObjectURL(String bucketName, String objectName, Integer expires) {
		return DocConstant.client.presignedGetObject(bucketName, objectName, expires);
	}

	/**
	 * 获取文件
	 *
	 * @param bucketName bucket名称
	 * @param objectName 文件名称
	 * @return 二进制流
	 */
	@SneakyThrows
	public InputStream getObject(String bucketName, String objectName) {
		return DocConstant.client.getObject(bucketName, objectName);
	}

	/**
	 * 上传文件
	 *
	 * @param bucketName bucket名称
	 * @param objectName 文件名称
	 * @param stream     文件流
	 * @throws Exception https://docs.minio.io/cn/java-client-api-reference.html#putObject
	 */
	public void putObject(String bucketName, String objectName, InputStream stream) throws Exception {
		DocConstant.client.putObject(bucketName, objectName, stream, stream.available(), "application/octet-stream");
	}

	/**
	 * 上传文件
	 *
	 * @param bucketName  bucket名称
	 * @param objectName  文件名称
	 * @param stream      文件流
	 * @param size        大小
	 * @param contextType 类型
	 * @throws Exception https://docs.minio.io/cn/java-DocConstant.client-api-reference.html#putObject
	 */
	public void putObject(String bucketName, String objectName, InputStream stream, long size, String contextType) throws Exception {
		DocConstant.client.putObject(bucketName, objectName, stream, size, contextType);
	}

	/**
	 * 获取文件信息
	 *
	 * @param bucketName bucket名称
	 * @param objectName 文件名称
	 * @throws Exception https://docs.minio.io/cn/java-DocConstant.client-api-reference.html#statObject
	 */
	public ObjectStat getObjectInfo(String bucketName, String objectName) throws Exception {
		return DocConstant.client.statObject(bucketName, objectName);
	}

	/**
	 * 删除文件
	 *
	 * @param bucketName bucket名称
	 * @param objectName 文件名称
	 * @throws Exception https://docs.minio.io/cn/java-DocConstant.client-api-reference.html#removeObject
	 */
	@SneakyThrows
	public void removeObject(String bucketName, String objectName) throws Exception {
		DocConstant.client.removeObject(bucketName, objectName);
	}

	/**
	 * 上传
	 *
	 * 文件上传(bucketName:根；file_path_name：目录及名称）
	 *
	 *
	 */

	public String upload(@RequestParam("file") MultipartFile file,String bucketName,String file_path_name) {
		try {
			putObject(bucketName, file_path_name, file.getInputStream());
        } catch (Exception e) {
			String str=e.toString();
			log.error(str);
			return "str";
		}
		return "上传成功";
	}

	/**
	 * 上传文件
	 *
	 * 文件上传(bucketName:根；file_path_name：目录及名称）
	 *
	 *
	 */
	public String upload(InputStream io,String bucketName,String file_path_name) {
		try {
			putObject(bucketName, file_path_name, io);
		} catch (Exception e) {
			String str=e.toString();
			log.error(str);
			return "str";
		}
		return "上传成功";
	}


    /**
    * 下载
	 */
	public InputStream download(String bucketName, String fileName) {
		InputStream inputStream=null;
		try{
			 inputStream = getObject(bucketName,fileName);
		} catch (Exception e) {
			log.error("文件读取异常", e);
		}
		return inputStream;
	}

	public  void up() throws IOException {
		MinioClientUtils mi=new MinioClientUtils();
		System.out.println("开始上传");
		String bucketName="home";
		String file_path_name="abc/aa.png";
		FileInputStream in=new FileInputStream("d:/aaa/aa.png");
		mi.upload(in, bucketName,file_path_name);
		System.out.println("上传完成！");
		in.close();
	}
	public void down() throws IOException {
		String bucketName="home";
		String file_path_name="aa/aa.png";
		MinioClientUtils mi=new MinioClientUtils();
		log.info("开始下载");
		InputStream io=mi.download(bucketName,file_path_name);
		FileOutputStream out=new FileOutputStream("d:/aaa/bb.png");
		//批量写入
		int b;
		byte[] by=new byte[1024];
		while((b=io.read(by))!=-1){
			out.write(by,0,b);
		}
		io.close();
		out.close();
		System.out.println("下载完毕");
	}
	public static void main(String[] args) throws IOException {
		MinioClientUtils mi=new MinioClientUtils();
		mi.createBucket("home");//创建bucketname
		//mi.removeBucket("home");//删除bucketname(空目录）
		try {
			mi.removeObject("home", "aa/aa.png");
		}catch (Exception e){

		}
		//mi.up();
		//mi.down();
	}
}
