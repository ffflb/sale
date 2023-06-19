package com.fan.service;

import com.fan.controller.R;
import com.fan.mapper.UserMapper;
import com.fan.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ClassName:com.fan.service
 * @Description:
 * @Author:范
 **/
@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

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
        User user = userMapper.login(userName, userPwd);
        if (user==null){
            return new R(100,"登陆失败");
        }
        return new R(200, "登录成功",user);
    }

    public List<User> getUserListByParam(String userName) {
        return userMapper.getUserListByParam(userName);
    }

    public R addUser(User user) {
        if (StringUtils.isEmpty(user.getUserName())){
            return new R(100, "用户名不能为空");
        }

        if (StringUtils.isEmpty(user.getUserPwd())){
            return new R(100, "密码不能为空");
        }
        int row = userMapper.insert(user);

        if (row !=1){
            return new R(100,"异常情况");
        }
        return new R(200,"异常情况");
    }

    public User getById(Integer id) {
        return userMapper.getById(id);
    }

    public R update(User user) {
        int row =  userMapper.update(user);
        if (row !=1){
            return new R(100,"异常情况");
        }
        return new R(200,"修改成功");
    }

    public List<User> getAllUser(User user) {
        return userMapper.getAllUser(user);
    }

    public R delUser(Integer id) {
        int row = userMapper.delUser(id);
        if (row != 1 ){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }

    public R delBatchUser(Integer[] id) {
        int rows = userMapper.delBatchUser(id);
        if (rows != id.length ){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }
}
