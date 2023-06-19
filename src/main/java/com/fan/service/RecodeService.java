package com.fan.service;

import com.fan.controller.R;
import com.fan.mapper.RecodeMapper;
import com.fan.model.Order;
import com.fan.model.Recode;
import com.fan.vo.RecodeAndSort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @ClassName:com.fan.service
 * @Description:
 * @Author:范
 **/
@Service
public class RecodeService {
    @Autowired
    private RecodeMapper recodeMapper;

    public R delRecode(Integer id) {
        int row = recodeMapper.delRecode(id);
        if (row != 1 ){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }


    public R insert(Recode recode) {
        int row = recodeMapper.insert(recode);

        if (row !=1){
            return new R(100,"异常情况");
        }
        return new R(200,"成功");
    }


    public List<RecodeAndSort> getAllRecode(Recode recode) {
        return recodeMapper.getAllRecode(recode);
    }

    public R delBatchRecode(Integer[] id) {
        int rows = recodeMapper.delBatchRecode(id);
        if (rows != id.length ){
            return new R(100,"异常情况");
        }else {
            return new R(200,"删除成功");
        }
    }

}
