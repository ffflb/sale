package com.fan.model;

import lombok.Data;

/**
 * @ClassName:com.fan.model
 * @Description:
 * @Author:范
 **/
@Data
public class User {

    private Integer id;
    private String img;
    private String userName;
    private String userPwd;
    private String userTel;
    private String address;
}
