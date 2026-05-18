package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.ShixipingjiaEntity;
import java.util.List;
import java.util.Map;
import com.entity.vo.ShixipingjiaVO;
import org.apache.ibatis.annotations.Param;
import com.entity.view.ShixipingjiaView;


/**
 * 实习评价
 *
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
public interface ShixipingjiaService extends IService<ShixipingjiaEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ShixipingjiaVO> selectListVO(Wrapper<ShixipingjiaEntity> wrapper);
   	
   	ShixipingjiaVO selectVO(@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);
   	
   	List<ShixipingjiaView> selectListView(Wrapper<ShixipingjiaEntity> wrapper);
   	
   	ShixipingjiaView selectView(@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ShixipingjiaEntity> wrapper);

   	

    List<Map<String, Object>> selectValue(Map<String, Object> params,Wrapper<ShixipingjiaEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params,Wrapper<ShixipingjiaEntity> wrapper);

    List<Map<String, Object>> selectGroup(Map<String, Object> params,Wrapper<ShixipingjiaEntity> wrapper);



}

