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


import com.dao.ShixigangweiDao;
import com.entity.ShixigangweiEntity;
import com.service.ShixigangweiService;
import com.entity.vo.ShixigangweiVO;
import com.entity.view.ShixigangweiView;

@Service("shixigangweiService")
public class ShixigangweiServiceImpl extends ServiceImpl<ShixigangweiDao, ShixigangweiEntity> implements ShixigangweiService {
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ShixigangweiEntity> page = this.selectPage(
                new Query<ShixigangweiEntity>(params).getPage(),
                new EntityWrapper<ShixigangweiEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ShixigangweiEntity> wrapper) {
		  Page<ShixigangweiView> page =new Query<ShixigangweiView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}

    
    @Override
	public List<ShixigangweiVO> selectListVO(Wrapper<ShixigangweiEntity> wrapper) {
 		return baseMapper.selectListVO(wrapper);
	}
	
	@Override
	public ShixigangweiVO selectVO(Wrapper<ShixigangweiEntity> wrapper) {
 		return baseMapper.selectVO(wrapper);
	}
	
	@Override
	public List<ShixigangweiView> selectListView(Wrapper<ShixigangweiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ShixigangweiView selectView(Wrapper<ShixigangweiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, Wrapper<ShixigangweiEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, Wrapper<ShixigangweiEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, Wrapper<ShixigangweiEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }




}
