package com.entity.view;

import com.entity.ShixipingjiaEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.utils.EncryptUtil;
 

/**
 * 实习评价
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
@TableName("shixipingjia")
public class ShixipingjiaView  extends ShixipingjiaEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ShixipingjiaView(){
	}
 
 	public ShixipingjiaView(ShixipingjiaEntity shixipingjiaEntity){
 	try {
			BeanUtils.copyProperties(this, shixipingjiaEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}


}
