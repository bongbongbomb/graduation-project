package com.dao;

import com.entity.ShixipingjiaEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.ShixipingjiaVO;
import com.entity.view.ShixipingjiaView;


/**
 * 实习评价
 * 
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
public interface ShixipingjiaDao extends BaseMapper<ShixipingjiaEntity> {
	
	List<ShixipingjiaVO> selectListVO(@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);
	
	ShixipingjiaVO selectVO(@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);
	
	List<ShixipingjiaView> selectListView(@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);

	List<ShixipingjiaView> selectListView(Pagination page,@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);

	
	ShixipingjiaView selectView(@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);
	

    List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShixipingjiaEntity> wrapper);



}
