package com.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.ShixiqingkuangEntity;
import java.util.List;
import java.util.Map;
import com.entity.vo.ShixiqingkuangVO;
import org.apache.ibatis.annotations.Param;
import com.entity.view.ShixiqingkuangView;


/**
 * 实习情况
 *
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
public interface ShixiqingkuangService extends IService<ShixiqingkuangEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ShixiqingkuangVO> selectListVO(Wrapper<ShixiqingkuangEntity> wrapper);
   	
   	ShixiqingkuangVO selectVO(@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);
   	
   	List<ShixiqingkuangView> selectListView(Wrapper<ShixiqingkuangEntity> wrapper);
   	
   	ShixiqingkuangView selectView(@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ShixiqingkuangEntity> wrapper);

   	

}

