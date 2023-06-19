package com.fan.service;

import com.fan.mapper.SortMapper;
import com.fan.model.Sort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ClassName:com.fan.service
 * @Description:
 * @Author:范
 **/
@Service
public class SortService {
    @Autowired
    private SortMapper sortMapper;

    public List<Sort> getSortList() {
        return sortMapper.getSortList();
    }
}
