package com.fan.service;

import com.fan.controller.R;
import com.fan.mapper.AdminMapper;
import com.fan.model.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;

/**
 * @ClassName:com.fan.service
 * @Description:
 * @Author:范
 **/
@Service
public class AdminService {

    @Autowired
    private AdminMapper adminMapper;

    public R login(String userName, String userPwd, String VerifyCode, HttpSession session) {
        if (StringUtils.isEmpty(userName)){
            return new R(100, "用户名不能为空");
        }
        if (StringUtils.isEmpty(userPwd)){
            return new R(100, "密码不能为空");
        }
        if (StringUtils.isEmpty(VerifyCode)){
            return new R(100, "验证码不能为空");
        }
        String realCode = (String) session.getAttribute("VerifyCode");
        if (!VerifyCode.equalsIgnoreCase(realCode)){
            return new R(100,"账号或密码错误");
        }
        //登录
        Admin admin = adminMapper.login(userName, userPwd);
        if (admin==null){
            return new R(100,"登陆失败");
        }
        return new R(200, "登录成功",admin);
    }

    public Admin getById(Integer id) {
        return adminMapper.getById(id);
    }

    public R update(Admin admin) {
        int row = adminMapper.update(admin);
        if (row !=1){
            return new R(100,"异常情况");
        }
        return new R(200,"修改成功");
    }
}

