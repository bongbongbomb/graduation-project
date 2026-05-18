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


import com.dao.ShixipingjiaDao;
import com.entity.ShixipingjiaEntity;
import com.service.ShixipingjiaService;
import com.entity.vo.ShixipingjiaVO;
import com.entity.view.ShixipingjiaView;

@Service("shixipingjiaService")
public class ShixipingjiaServiceImpl extends ServiceImpl<ShixipingjiaDao, ShixipingjiaEntity> implements ShixipingjiaService {
	
	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ShixipingjiaEntity> page = this.selectPage(
                new Query<ShixipingjiaEntity>(params).getPage(),
                new EntityWrapper<ShixipingjiaEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ShixipingjiaEntity> wrapper) {
		  Page<ShixipingjiaView> page =new Query<ShixipingjiaView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}

    
    @Override
	public List<ShixipingjiaVO> selectListVO(Wrapper<ShixipingjiaEntity> wrapper) {
 		return baseMapper.selectListVO(wrapper);
	}
	
	@Override
	public ShixipingjiaVO selectVO(Wrapper<ShixipingjiaEntity> wrapper) {
 		return baseMapper.selectVO(wrapper);
	}
	
	@Override
	public List<ShixipingjiaView> selectListView(Wrapper<ShixipingjiaEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ShixipingjiaView selectView(Wrapper<ShixipingjiaEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}

    @Override
    public List<Map<String, Object>> selectValue(Map<String, Object> params, Wrapper<ShixipingjiaEntity> wrapper) {
        return baseMapper.selectValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectTimeStatValue(Map<String, Object> params, Wrapper<ShixipingjiaEntity> wrapper) {
        return baseMapper.selectTimeStatValue(params, wrapper);
    }

    @Override
    public List<Map<String, Object>> selectGroup(Map<String, Object> params, Wrapper<ShixipingjiaEntity> wrapper) {
        return baseMapper.selectGroup(params, wrapper);
    }




}
