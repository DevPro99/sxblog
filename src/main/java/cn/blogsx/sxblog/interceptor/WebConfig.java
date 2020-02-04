package cn.blogsx.sxblog.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * @Description 配置登录过滤器规则
 * @author Alex
 * @create 2020-01-22 22:24
 **/
@Configuration
public class WebConfig extends WebMvcConfigurerAdapter {
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/admin/**").excludePathPatterns("/admin")
                .excludePathPatterns("/admin/login");
    }
}
