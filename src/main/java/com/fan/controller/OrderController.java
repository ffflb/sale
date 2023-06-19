package com.fan.controller;

import com.fan.model.Admin;
import com.fan.model.Order;
import com.fan.model.Recode;
import com.fan.model.User;
import com.fan.service.OrderService;
import com.fan.service.RecodeService;
import com.fan.service.UserService;
import com.fan.vo.EchartsData;
import com.fan.vo.OrderAndSort;
import com.fan.vo.RecodeAndSort;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName:com.fan.controller
 * @Description:
 * @Author:范
 **/
@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private UserService userService;

    @Autowired
    private RecodeService recodeService;


    //用户查看申报订单
    @RequestMapping("/toOrder")
    public String toOrder(String orderName, Model model, HttpServletRequest request) throws JsonProcessingException {

        User userInfo = (User) request.getSession().getAttribute("userInfo");
        User user = userService.getById(userInfo.getId());
        Order order = new Order();

        order.setApple(user.getUserName());
        order.setOrderName(orderName);
        List<OrderAndSort> orderAndSorts = orderService.getAllOrder(order);

        ObjectMapper objectMapper = new ObjectMapper();

        String jsonStr = objectMapper.writeValueAsString(orderAndSorts);

        model.addAttribute("orderName", orderName);

        model.addAttribute("orderAndSorts", jsonStr);

        return "order";
    }

    //管理员查看所有申报订单
    @RequestMapping("/toOrderTable")
    public String toOrderTable(String orderName, Model model) throws JsonProcessingException {

        Order order = new Order();

        order.setOrderName(orderName);

        List<OrderAndSort> orderAndSorts = orderService.getAll(order);

        ObjectMapper objectMapper = new ObjectMapper();

        String jsonStr = objectMapper.writeValueAsString(orderAndSorts);

        model.addAttribute("orderName", orderName);

        model.addAttribute("orderAndSorts", jsonStr);

        return "orderMmt";
    }



//    /订单添加删除
    @RequestMapping("declare")
    public String declare(Integer id,Model model) {

        Order order = orderService.getById(id);
        model.addAttribute("order", order);
        return "declare";
    }

    @RequestMapping("/addDeclare")

        public String addDeclare(Order order, Model model, HttpServletRequest request) {

        order.setOrderStatus(1);
        User userInfo = (User) request.getSession().getAttribute("userInfo");
        order.setApple(userInfo.getUserName());

        Order orders = orderService.getById(order.getId());

        if (orders == null) {
            R result = orderService.addOrder(order);
            if (result.getCode() == 200) {
                //添加成功

                return "order";
            } else {
                //添加失败
                model.addAttribute("msg", result.getMsg());
                return "declare";
            }
        } else  {
            R result = orderService.editUser(order);
            if (result.getCode() == 200) {

                return "order";
            } else {

                model.addAttribute("msg", result.getMsg());
                return "declare";
            }

        }
    }

    //用户删除订单
    @RequestMapping("/delOrder")
    @ResponseBody
    public R delOrder(Integer id) {

        R r = orderService.delOrder(id);
        if (r.getCode()==200){
            return new R(200, "删除成功");
        }
        return null;
    }


//    管理员处理订单
    @RequestMapping("/delOrderStatus")
    @ResponseBody
    public R delOrderStatus(Integer id, HttpServletRequest request) {
        Admin admin = (Admin) request.getSession().getAttribute("adminInfo");
        Order order = orderService.getById(id);

        Recode recode = new Recode();

        recode.setOrderName(order.getOrderName());
        recode.setOrderDesc(order.getOrderDesc());
        recode.setSortId(order.getSortId());
        recode.setApple(order.getApple());
        recode.setOperation(admin.getAdminName());

            R r = orderService.delAndIns(order,recode);
            if (r.getCode() == 200){
                return new R(200, "删除成功");
            }
        return null;
    }

//    故障类型饼状图
    @RequestMapping("/toEcharts")
    public String toEcharts(){
        return "echarts";
    }

    @RequestMapping("/getEchartsDate")
    @ResponseBody
    public List<EchartsData> getEchartsDate(){

        return orderService.getEchartsDate();
    }

//    用户批量删除订单
    @RequestMapping("/delBatchOrder")
    @ResponseBody
    public R delBatchOrder(Integer[] id){
        R r = orderService.delBatchOrder(id);
        if (r.getCode()==200){
            //删除成功
           return new R(200,"删除成功");
        }
        return null;
    }

//    管理员批量处理订单
    @RequestMapping("/delBatchOrderStatus")
    @ResponseBody
    public R delBatchOrderStatus(Integer[] id, HttpServletRequest request){

        Admin admin = (Admin) request.getSession().getAttribute("adminInfo");

        Order order;
        List<Recode> recodeList = new ArrayList<Recode>();
        Recode recode = new Recode();
        for (Integer i : id){
            order = orderService.getById(i);
            recode.setOrderName(order.getOrderName());
            recode.setOrderDesc(order.getOrderDesc());
            recode.setSortId(order.getSortId());
            recode.setApple(order.getApple());
            recode.setOperation(admin.getAdminName());

            recodeList.add(recode);
        }

            R r = orderService.insAndDelBatch(id,recodeList);
            if (r.getCode() == 200){
                return new R(200,"删除成功");
            }
        return null;
    }
}
