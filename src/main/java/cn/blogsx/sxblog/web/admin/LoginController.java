package cn.blogsx.sxblog.web.admin;

import cn.blogsx.sxblog.po.User;
import cn.blogsx.sxblog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

/**
 * @author Alex
 * @create 2020-01-22 20:56
 **/
@Controller
@RequestMapping("/admin")
public class LoginController{
    @Autowired
    private UserService userService;

    @GetMapping
    public String loginPage() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username,
                        @RequestParam String password,
                        HttpSession session,
                        RedirectAttributes attributes) {
        User user = userService.checkUser(username, password);
        System.out.println(user.toString());
        if (user != null) {
            user.setPassword(null);
            session.setAttribute("user", user);
            return "admin/index";
        } else {
            attributes.addFlashAttribute("message","用户名或密码错误");

            return "redirect:/admin";
        }
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.removeAttribute("user");
        return "redirect:/";
    }

}
