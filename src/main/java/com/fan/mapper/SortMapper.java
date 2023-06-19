package com.fan.mapper;

import com.fan.model.Sort;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName:com.fan.mapper
 * @Description:
 * @Author:范
 **/
@Mapper
public interface SortMapper {
    List<Sort> getSortList();
}
