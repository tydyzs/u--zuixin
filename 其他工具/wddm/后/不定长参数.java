package TestJson;

public class ���������� {

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
	  js������������
	  
	  function isjson(){
	    	var lists=arguments;
	    	alert(lists.length);
	    	for (var int = 0; int < lists.length; int++) {
				alert(lists[int]);
			}
	    }




	  ����һ�� isjson("����һ","������",3);
��������̬���Σ�
isjson.apply(null,["����һ","������",3]);
	   
	   */
	  
	  
	  
}
