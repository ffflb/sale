package com.fan.service;

import com.fan.controller.R;
import com.fan.mapper.OrderMapper;
import com.fan.mapper.RecodeMapper;
import com.fan.model.Order;
import com.fan.model.Recode;
import com.fan.vo.EchartsData;
import com.fan.vo.OrderAndSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * @ClassName:com.fan.service
 * @Description:
 * @Author:范
 **/
@Service
public class OrderService {
    @Autowired
    private OrderMapper orderMapper;
    @Autowired
    private RecodeMapper recodeMapper;

    public List<OrderAndSort> getAllOrder(Order order) {
        return orderMapper.getAllOrder(order);
    }

    public R delOrder(Integer id) {
        int row = orderMapper.delOrder(id);
        if (row != 1 ){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }

    public Order getById(Integer id) {
        return orderMapper.getById(id);
    }

    public R addOrder(Order order) {
        if (StringUtils.isEmpty(order.getOrderName())){
            return new R(100, "故障名不能为空");
        }

        int row = orderMapper.insert(order);

        if (row !=1){
            return new R(100,"异常情况");
        }
        return new R(200,"成功");
    }

    public R editUser(Order order) {
        if (StringUtils.isEmpty(order.getOrderName())){
            return new R(100, "故障名称不能为空");
        }

        if (StringUtils.isEmpty(order.getSortId())){
            return new R(100, "故障类型不能为空");
        }
        int row = orderMapper.update(order);

        if (row !=1){
            return new R(100,"异常情况");
        }
        return new R(200,"修改成功");
    }


    public List<OrderAndSort> getAll(Order order) {
        return orderMapper.getAll(order);
    }


    @Transactional
    public R delAndIns(Order order, Recode recode) {
        int row = orderMapper.delOrderStatus(order);
        int row2 = recodeMapper.insert(recode);
        if (row != 1 && row2 != 1){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }


    public List<EchartsData> getEchartsDate() {
        return orderMapper.getEchartsDate();
    }


    public R delBatchOrder(Integer[] id) {

        int rows = orderMapper.delBatchOrder(id);
        if (rows != id.length ){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }


    @Transactional
    public R insAndDelBatch(Integer[] id, List<Recode> recodeList) {
        int rows = orderMapper.delBatchOrderStatus(id);
        
        int row = recodeMapper.insertBatch(recodeList);


        if (rows != id.length && row != 1){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }
}
