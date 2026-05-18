package com.dao;

import com.entity.ShixiqingkuangEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.vo.ShixiqingkuangVO;
import com.entity.view.ShixiqingkuangView;


/**
 * 实习情况
 * 
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
public interface ShixiqingkuangDao extends BaseMapper<ShixiqingkuangEntity> {
	
	List<ShixiqingkuangVO> selectListVO(@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);
	
	ShixiqingkuangVO selectVO(@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);
	
	List<ShixiqingkuangView> selectListView(@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);

	List<ShixiqingkuangView> selectListView(Pagination page,@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);

	
	ShixiqingkuangView selectView(@Param("ew") Wrapper<ShixiqingkuangEntity> wrapper);
	

}
