package cn.stylefeng.guns.sys.core.beetl;

import lombok.Data;
import org.beetl.core.GroupTemplate;
import org.beetl.core.Template;
import org.beetl.ext.web.WebRenderExt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@Data
public class MyBeetl implements WebRenderExt {

    private String name="sysadmin";//前端获取：alert("${shc.getName()}")

    /**
     * 这里可以配置模板 全局变量 如：template.binding("version","1.0");
     */
    @Override
    public void modify(Template template, GroupTemplate gtemplate, HttpServletRequest request,
                       HttpServletResponse response) {

        template.binding("shcbootName", "shcbootValue");
    }

    /**
     * beetl获取值
     * @return
     */
    public String getShc(){
        return "shcValue";
    }

    /**
     * beetl获取值
     * @return
     */
    public String getValue(String param){
        return "传入的值为："+param;
    }

}
