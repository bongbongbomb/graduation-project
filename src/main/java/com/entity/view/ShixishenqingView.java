package com.entity.view;

import com.entity.ShixishenqingEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.utils.EncryptUtil;
 

/**
 * 实习申请
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
@TableName("shixishenqing")
public class ShixishenqingView  extends ShixishenqingEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ShixishenqingView(){
	}
 
 	public ShixishenqingView(ShixishenqingEntity shixishenqingEntity){
 	try {
			BeanUtils.copyProperties(this, shixishenqingEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}


}
