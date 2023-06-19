package com.fan.controller;

import com.fan.model.Sort;
import com.fan.service.SortService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName:com.fan.controller
 * @Description:
 * @Author:范
 **/
@Controller
@RequestMapping("/sort")
public class SortController {

    @Autowired
    private SortService sortService;


//    获取故障种类
    @RequestMapping("/getSortList")
    @ResponseBody
    public List<Sort> getSortList() throws JsonProcessingException {

        return sortService.getSortList();
    }
}
