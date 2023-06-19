package com.fan.interceptor;

import com.fan.model.Admin;
import com.fan.model.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName:com.qst.intercepter
 * @Description:
 * @Author:范
 **/
public class LoginInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();
        if (uri.indexOf("toLogin") != -1 || uri.indexOf("login") != -1 || uri.indexOf("getVerifyCode") != -1 || uri.indexOf("img") != -1 || uri.indexOf("toRegister.jsp") != -1 || uri.indexOf("registerUser") != -1 || uri.indexOf("toRegister") != -1 || uri.indexOf("jquery") != -1) {
            return true;
        }
        User userInfo = (User) request.getSession().getAttribute("userInfo");
        Admin adminInfo = (Admin) request.getSession().getAttribute("adminInfo");
        if (userInfo == null && adminInfo == null) {
            //请求转发
            request.getRequestDispatcher("toLogin/login").forward(request, response);
            return false;
        } else {
            return true;
        }
    }

}
