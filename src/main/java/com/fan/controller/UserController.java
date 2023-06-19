package com.fan.controller;

import com.fan.model.User;
import com.fan.service.UserService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @ClassName:com.fan.controller
 * @Description:
 * @Author:范
 **/
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;


    //用户注册
    @RequestMapping("toRegister")
    public String toRegister() {

        return "toRegister";

    }
    @RequestMapping("/registerUser")
    public String registerUser(User user, Model model) {

        List<User> users = userService.getUserListByParam(user.getUserName());
        if (users.size() == 0) {
            R result = userService.addUser(user);

            if (result.getCode() == 200) {
                //添加成功
                return "login";
            } else {
                //添加失败
                model.addAttribute("msg", result.getMsg());
                return "toRegister";
            }
        } else {
            model.addAttribute("msg", "用户名已存在");
            return "toRegister";
        }
    }

//    用户个人信息
    @RequestMapping("toUser")
    public String toUser(Model model, HttpServletRequest request) {

        User userInfo = (User) request.getSession().getAttribute("userInfo");

        User user = userService.getById(userInfo.getId());
        model.addAttribute("user", user);
        return "user";
    }

//    用户信息修改
    @RequestMapping("/userIndex")
    public String toUserInfo(User user, Model model) {

        R r = userService.update(user);
        if (r.getCode() != 200) {
            model.addAttribute("msg", r.getMsg());
        }
        return "user";
    }


    //加载用户信息表格
    @RequestMapping("/toUserTable")
    public String toUserTable(String userName, Model model) throws JsonProcessingException {
        User user = new User();
        user.setUserName(userName);
        List<User> users = userService.getAllUser(user);
        for (int i = 0; i < users.size(); i++) {
            users.get(i).setImg("http://localhost:8080/sale_war_exploded/img" + users.get(i).getImg());
        }
        System.out.println(users.toString());
        ObjectMapper objectMapper = new ObjectMapper();

        String jsonStr = objectMapper.writeValueAsString(users);
        System.out.println("jsonStr = "+ jsonStr);
        model.addAttribute("userName", userName);

        model.addAttribute("users", jsonStr);

        return "userMmt";
    }


//    删除用户信息
    @RequestMapping("/delUser")
    @ResponseBody
    public R delUser(Integer id) {

        R r = userService.delUser(id);
        if (r.getCode()==200){
            return new R(200, "删除成功");

        }
        return null;
    }


//    批量删除用户信息
    @RequestMapping("/delBatchUser")
    @ResponseBody
    public R delBatchUser(Integer[] id){
        R r = userService.delBatchUser(id);
        if (r.getCode()==200){
            //删除成功
            return new R(200,"删除成功");
        }
        return null;
    }



    //文件上传
    @RequestMapping("uploadImg")
    @ResponseBody
    public R uploadImg(@RequestParam("file") MultipartFile  file) throws IOException {

        String fileName = file.getOriginalFilename();

        String newFileName = System.currentTimeMillis() + fileName.substring(fileName.lastIndexOf("."));

        String path = "E:\\SpringSSM\\sale\\target\\ssm\\WEB-INF\\img";

        File file2 = new File(path);
        if (!file2.exists()) {
            file2.mkdir();
        }

        file.transferTo(new File(path + File.separator + newFileName));
        String imgName = File.separator + newFileName;
        return new R(200, imgName);

    }

}



