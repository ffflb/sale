package com.fan.controller;

import lombok.Data;

@Data
public class R {
    private Integer code;
    private Object data;
    private String msg;

    public R() {
    }

    public R(Integer code, String msg, Object data) {
        this.code = code;
        this.data = data;
        this.msg = msg;
    }

    public R(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }


}
