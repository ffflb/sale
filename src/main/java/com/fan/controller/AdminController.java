package com.fan.controller;

import com.fan.model.Admin;
import com.fan.model.User;
import com.fan.service.AdminService;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName:com.fan.controller
 * @Description:
 * @Author:范
 **/
@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    private AdminService adminService;


    //管理员信息首页
    @RequestMapping("toAdmin")
    public String declare(Model model, HttpServletRequest request) {

        Admin adminInfo = (Admin) request.getSession().getAttribute("adminInfo");

        Admin admin = adminService.getById(adminInfo.getId());
        model.addAttribute("admin", admin);
        return "admin";
    }
    //修改管理员信息
    @RequestMapping("/adminIndex")
    public String toAdminInfo(Admin admin, Model model) {

        R r = adminService.update(admin);
        if (r.getCode() != 200) {
            model.addAttribute("msg", r.getMsg());
        }
        return "admin";
    }
}
