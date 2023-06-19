package com.fan.model;

import lombok.Data;

/**
 * @ClassName:com.fan.model
 * @Description:
 * @Author:范
 **/
@Data
public class Admin {
    private Integer id;
    private String img;
    private String adminName;
    private String adminPwd;
    private String adminTel;
    private String address;
}
