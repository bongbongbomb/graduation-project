package com.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.utils.PageUtils;
import com.utils.Query;


import com.dao.ShixiqingkuangDao;
import com.entity.ShixiqingkuangEntity;
import com.service.ShixiqingkuangService;
import com.entity.vo.ShixiqingkuangVO;
import com.entity.view.ShixiqingkuangView;

@Service("shixiqingkuangService")
public class ShixiqingkuangServiceImpl extends ServiceImpl<ShixiqingkuangDao, ShixiqingkuangEntity> implements ShixiqingkuangService {
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ShixiqingkuangEntity> page = this.selectPage(
                new Query<ShixiqingkuangEntity>(params).getPage(),
                new EntityWrapper<ShixiqingkuangEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ShixiqingkuangEntity> wrapper) {
		  Page<ShixiqingkuangView> page =new Query<ShixiqingkuangView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}

    
    @Override
	public List<ShixiqingkuangVO> selectListVO(Wrapper<ShixiqingkuangEntity> wrapper) {
 		return baseMapper.selectListVO(wrapper);
	}
	
	@Override
	public ShixiqingkuangVO selectVO(Wrapper<ShixiqingkuangEntity> wrapper) {
 		return baseMapper.selectVO(wrapper);
	}
	
	@Override
	public List<ShixiqingkuangView> selectListView(Wrapper<ShixiqingkuangEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ShixiqingkuangView selectView(Wrapper<ShixiqingkuangEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}


}
