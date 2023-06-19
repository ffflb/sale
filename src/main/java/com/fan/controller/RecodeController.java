package com.fan.controller;

import com.fan.model.Recode;
import com.fan.service.RecodeService;
import com.fan.vo.RecodeAndSort;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName:com.fan.controller
 * @Description:
 * @Author:范
 **/
@Controller
@RequestMapping("recode")
public class RecodeController {


    @Autowired
    private RecodeService recodeService;

    //    管理员删除历史订单
    @RequestMapping("/delRecode")
    @ResponseBody
    public R delRecode(Integer id) {

        R r = recodeService.delRecode(id);
        if (r.getCode()==200){
            return new R(200, "删除成功");
        }
        return null;
    }

    //    管理员查看历史订单
    @RequestMapping("/toRecodeTable")
    public String toRecodeTable(String orderName, Model model) throws JsonProcessingException {

        Recode recode = new Recode();

        recode.setOrderName(orderName);

        List<RecodeAndSort> RecodeAndSort = recodeService.getAllRecode(recode);

        ObjectMapper objectMapper = new ObjectMapper();

        String jsonStr = objectMapper.writeValueAsString(RecodeAndSort);

        model.addAttribute("orderName", orderName);

        model.addAttribute("RecodeAndSort", jsonStr);

        return "recodeMmt";
    }

    //    管理员批量删除历史记录
    @RequestMapping("/delBatchRecode")
    @ResponseBody
    public R delBatchRecode(Integer[] id){
        R r = recodeService.delBatchRecode(id);
        if (r.getCode()==200){
            //删除成功
            return new R(200,"删除成功");
        }
        return null;
    }
}
