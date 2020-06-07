package TestJson;

public class 不定长参数 {

	public static void main(String[] args) {
		   test("aaa");  
           test("aaa", "bbb");  
           test("aaa", "bbb", "ccc");  
	}
	
	  public static void test(String... args) {  
          System.out.println("----------------");  
          for (String s : args) {  
              System.out.println(s);  
          }  
      }  
	  
	 /* 
	  js不定长参数：
	  
	  function isjson(){
	    	var lists=arguments;
	    	alert(lists.length);
	    	for (var int = 0; int < lists.length; int++) {
				alert(lists[int]);
			}
	    }




	  方案一： isjson("参数一","参数二",3);
方案二动态传参：
isjson.apply(null,["参数一","参数二",3]);
	   
	   */
	  
	  
	  
}
