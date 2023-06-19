package com.fan.controller;

import com.fan.model.Admin;
import com.fan.model.User;
import com.fan.service.AdminService;
import com.fan.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ClassName:com.fan.controller
 * @Description:
 * @Author:范
 **/
@Controller
@RequestMapping("toLogin")
public class LoginController {

    @Autowired
    private UserService userService;

    @Autowired
    private AdminService adminService;

    //登录
    @RequestMapping("login")
    public String login(String userName, String userPwd, String VerifyCode, HttpSession session, Model model) {

        R result1 = userService.login(userName, userPwd, VerifyCode, session);

        R result2 = adminService.login(userName, userPwd, VerifyCode, session);
        if (result1.getCode() == 200) {
            //登录成功
            User userInfo = (User) result1.getData();
            session.setAttribute("userInfo", userInfo);

            return "userIndex";

        }
        else if (result2.getCode() == 200) {
            //登录成功
            Admin adminInfo = (Admin) result2.getData();

            session.setAttribute("adminInfo", adminInfo);

            return "adminIndex";
           }
        else {
            //登录失败
            model.addAttribute("msg", result2.getMsg());
            return "login";
        }
    }
}
