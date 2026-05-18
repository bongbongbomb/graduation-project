package com.dao;

import com.entity.ShixishenqingEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.ShixishenqingVO;
import com.entity.view.ShixishenqingView;


/**
 * 实习申请
 * 
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
public interface ShixishenqingDao extends BaseMapper<ShixishenqingEntity> {
	
	List<ShixishenqingVO> selectListVO(@Param("ew") Wrapper<ShixishenqingEntity> wrapper);
	
	ShixishenqingVO selectVO(@Param("ew") Wrapper<ShixishenqingEntity> wrapper);
	
	List<ShixishenqingView> selectListView(@Param("ew") Wrapper<ShixishenqingEntity> wrapper);

	List<ShixishenqingView> selectListView(Pagination page,@Param("ew") Wrapper<ShixishenqingEntity> wrapper);

	
	ShixishenqingView selectView(@Param("ew") Wrapper<ShixishenqingEntity> wrapper);
	

}
