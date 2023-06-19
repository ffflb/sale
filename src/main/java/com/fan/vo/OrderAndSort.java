package com.fan.vo;

import lombok.Data;

/**
 * @ClassName:com.fan.vo
 * @Description:
 * @Author:范
 **/
@Data
public class OrderAndSort {

    private Integer id;

    private String sortName;

    private String orderName;
    private String orderDesc;
    private Integer orderStatus;

    private String apple;

    public String getOrderStatus() {
        if (orderStatus == 1){
            return "待受理";
        }
        return "已受理";
    }
}
