package com.fan.mapper;

import com.fan.controller.R;
import com.fan.model.Recode;
import com.fan.vo.RecodeAndSort;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * @ClassName:com.fan.mapper
 * @Description:
 * @Author:范
 **/
@Mapper
public interface RecodeMapper {

    int delRecode(Integer id);

    int insert(Recode recode);

    int insertBatch(List<Recode> recodeList);

    List<RecodeAndSort> getAllRecode(Recode recode);

    int delBatchRecode(Integer[] id);
}
