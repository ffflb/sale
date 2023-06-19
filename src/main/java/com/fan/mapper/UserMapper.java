package com.fan.mapper;

import com.fan.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @ClassName:com.fan.mapper
 * @Description:
 * @Author:范
 **/
@Mapper
public interface UserMapper {
    User login(@Param("userName") String userName, @Param("userPwd") String userPwd);

    List<User> getUserListByParam(String userName);

    int insert(User user);

    User getById(Integer id);

    int update(User user);

    int delUser(Integer id);

    List<User> getAllUser(User user);

    int delBatchUser(Integer[] id);
}
