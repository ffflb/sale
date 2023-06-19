package com.fan.model;

import lombok.Data;

/**
 * @ClassName:com.fan.model
 * @Description:
 * @Author:范
 **/
@Data
public class Order {

    private Integer id;


    private Integer sortId;

    private String orderName;

    private String orderDesc;

    private Integer orderStatus;

    private String apple;

}
