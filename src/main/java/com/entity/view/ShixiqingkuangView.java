package com.entity.view;

import com.entity.ShixiqingkuangEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.utils.EncryptUtil;
 

/**
 * 实习情况
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
@TableName("shixiqingkuang")
public class ShixiqingkuangView  extends ShixiqingkuangEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ShixiqingkuangView(){
	}
 
 	public ShixiqingkuangView(ShixiqingkuangEntity shixiqingkuangEntity){
 	try {
			BeanUtils.copyProperties(this, shixiqingkuangEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}


}
