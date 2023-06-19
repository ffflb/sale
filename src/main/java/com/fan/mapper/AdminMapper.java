package com.fan.mapper;

import com.fan.model.Admin;
import com.fan.model.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @ClassName:com.fan.mapper
 * @Description:
 * @Author:范
 **/
@Mapper
public interface AdminMapper {
    Admin login(@Param("adminName") String userName, @Param("adminPwd") String userPwd);

    Admin getById(Integer id);

    int update(Admin admin);
}
