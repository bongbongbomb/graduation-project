package com.entity.model;

import com.entity.LuyongtongzhiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.io.Serializable;
 

/**
 * 录用通知
 * 接收传参的实体类  
 *（实际开发中配合移动端接口开发手动去掉些没用的字段， 后端一般用entity就够用了） 
 * 取自ModelAndView 的model名称
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
public class LuyongtongzhiModel  implements Serializable {
	private static final long serialVersionUID = 1L;

	 			
	/**
	 * 学生姓名
	 */
	
	private String xueshengxingming;
		
	/**
	 * 企业名称
	 */
	
	private String qiyemingcheng;
		
	/**
	 * 实习名称
	 */
	
	private String shiximingcheng;
		
	/**
	 * 岗位类型
	 */
	
	private String gangweileixing;
		
	/**
	 * 封面
	 */
	
	private String fengmian;
		
	/**
	 * 工作地点
	 */
	
	private String gongzuodidian;
		
	/**
	 * 上班时间
	 */
		
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 
	private Date shangbanshijian;
		
	/**
	 * 录用状态
	 */
	
	private String luyongzhuangtai;
		
	/**
	 * 录用时间
	 */
		
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 
	private Date luyongshijian;
		
	/**
	 * 录用详情
	 */
	
	private String luyongxiangqing;
		
	/**
	 * 企业账号
	 */
	
	private String qiyezhanghao;
		
	/**
	 * 负责人
	 */
	
	private String fuzeren;
				
	
	/**
	 * 设置：学生姓名
	 */
	 
	public void setXueshengxingming(String xueshengxingming) {
		this.xueshengxingming = xueshengxingming;
	}
	
	/**
	 * 获取：学生姓名
	 */
	public String getXueshengxingming() {
		return xueshengxingming;
	}
				
	
	/**
	 * 设置：企业名称
	 */
	 
	public void setQiyemingcheng(String qiyemingcheng) {
		this.qiyemingcheng = qiyemingcheng;
	}
	
	/**
	 * 获取：企业名称
	 */
	public String getQiyemingcheng() {
		return qiyemingcheng;
	}
				
	
	/**
	 * 设置：实习名称
	 */
	 
	public void setShiximingcheng(String shiximingcheng) {
		this.shiximingcheng = shiximingcheng;
	}
	
	/**
	 * 获取：实习名称
	 */
	public String getShiximingcheng() {
		return shiximingcheng;
	}
				
	
	/**
	 * 设置：岗位类型
	 */
	 
	public void setGangweileixing(String gangweileixing) {
		this.gangweileixing = gangweileixing;
	}
	
	/**
	 * 获取：岗位类型
	 */
	public String getGangweileixing() {
		return gangweileixing;
	}
				
	
	/**
	 * 设置：封面
	 */
	 
	public void setFengmian(String fengmian) {
		this.fengmian = fengmian;
	}
	
	/**
	 * 获取：封面
	 */
	public String getFengmian() {
		return fengmian;
	}
				
	
	/**
	 * 设置：工作地点
	 */
	 
	public void setGongzuodidian(String gongzuodidian) {
		this.gongzuodidian = gongzuodidian;
	}
	
	/**
	 * 获取：工作地点
	 */
	public String getGongzuodidian() {
		return gongzuodidian;
	}
				
	
	/**
	 * 设置：上班时间
	 */
	 
	public void setShangbanshijian(Date shangbanshijian) {
		this.shangbanshijian = shangbanshijian;
	}
	
	/**
	 * 获取：上班时间
	 */
	public Date getShangbanshijian() {
		return shangbanshijian;
	}
				
	
	/**
	 * 设置：录用状态
	 */
	 
	public void setLuyongzhuangtai(String luyongzhuangtai) {
		this.luyongzhuangtai = luyongzhuangtai;
	}
	
	/**
	 * 获取：录用状态
	 */
	public String getLuyongzhuangtai() {
		return luyongzhuangtai;
	}
				
	
	/**
	 * 设置：录用时间
	 */
	 
	public void setLuyongshijian(Date luyongshijian) {
		this.luyongshijian = luyongshijian;
	}
	
	/**
	 * 获取：录用时间
	 */
	public Date getLuyongshijian() {
		return luyongshijian;
	}
				
	
	/**
	 * 设置：录用详情
	 */
	 
	public void setLuyongxiangqing(String luyongxiangqing) {
		this.luyongxiangqing = luyongxiangqing;
	}
	
	/**
	 * 获取：录用详情
	 */
	public String getLuyongxiangqing() {
		return luyongxiangqing;
	}
				
	
	/**
	 * 设置：企业账号
	 */
	 
	public void setQiyezhanghao(String qiyezhanghao) {
		this.qiyezhanghao = qiyezhanghao;
	}
	
	/**
	 * 获取：企业账号
	 */
	public String getQiyezhanghao() {
		return qiyezhanghao;
	}
				
	
	/**
	 * 设置：负责人
	 */
	 
	public void setFuzeren(String fuzeren) {
		this.fuzeren = fuzeren;
	}
	
	/**
	 * 获取：负责人
	 */
	public String getFuzeren() {
		return fuzeren;
	}
			
}
