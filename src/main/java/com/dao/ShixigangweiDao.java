package com.dao;

import com.entity.ShixigangweiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.ShixigangweiVO;
import com.entity.view.ShixigangweiView;


/**
 * 实习岗位
 * 
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
public interface ShixigangweiDao extends BaseMapper<ShixigangweiEntity> {
	
	List<ShixigangweiVO> selectListVO(@Param("ew") Wrapper<ShixigangweiEntity> wrapper);
	
	ShixigangweiVO selectVO(@Param("ew") Wrapper<ShixigangweiEntity> wrapper);
	
	List<ShixigangweiView> selectListView(@Param("ew") Wrapper<ShixigangweiEntity> wrapper);

	List<ShixigangweiView> selectListView(Pagination page,@Param("ew") Wrapper<ShixigangweiEntity> wrapper);

	
	ShixigangweiView selectView(@Param("ew") Wrapper<ShixigangweiEntity> wrapper);
	

    List<Map<String, Object>> selectValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShixigangweiEntity> wrapper);

    List<Map<String, Object>> selectTimeStatValue(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShixigangweiEntity> wrapper);

    List<Map<String, Object>> selectGroup(@Param("params") Map<String, Object> params,@Param("ew") Wrapper<ShixigangweiEntity> wrapper);



}
