package com.fan.mapper;

import com.fan.model.Admin;
import com.fan.model.Order;
import com.fan.model.Recode;
import com.fan.vo.EchartsData;
import com.fan.vo.OrderAndSort;
import com.fan.vo.RecodeAndSort;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName:com.fan.mapper
 * @Description:
 * @Author:范
 **/
@Mapper
public interface OrderMapper {

    List<OrderAndSort> getAllOrder(Order order);


    int delOrder(Integer id);

    Order getById(Integer id);

    int insert(Order order);

    int update(Order order);


    List<OrderAndSort> getAll(Order order);

    int delOrderStatus(Order order);


    List<EchartsData> getEchartsDate();

    int delBatchOrder(Integer[] id);

    int delBatchOrderStatus(Integer[] id);


}
