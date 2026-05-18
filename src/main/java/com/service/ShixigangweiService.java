package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.ShixigangweiEntity;
import java.util.List;
import java.util.Map;
import com.entity.vo.ShixigangweiVO;
import org.apache.ibatis.annotations.Param;
import com.entity.view.ShixigangweiView;


/**
 * 实习岗位
 *
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
public interface ShixigangweiService extends IService<ShixigangweiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ShixigangweiVO> selectListVO(Wrapper<ShixigangweiEntity> wrapper);
   	
   	ShixigangweiVO selectVO(@Param("ew") Wrapper<ShixigangweiEntity> wrapper);
   	
   	List<ShixigangweiView> selectListView(Wrapper<ShixigangweiEntity> wrapper);
   	
   	ShixigangweiView selectView(@Param("ew") Wrapper<ShixigangweiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ShixigangweiEntity> wrapper);

   	

    List<Map<String, Object>> selectValue(Map<String, Object> params,Wrapper<ShixigangweiEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params,Wrapper<ShixigangweiEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params,Wrapper<ShixigangweiEntity> wrapper);



}

