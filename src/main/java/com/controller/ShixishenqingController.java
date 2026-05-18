package com.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import java.lang.*;
import java.math.*;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import com.utils.ValidatorUtils;
import com.utils.DeSensUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.annotation.IgnoreAuth;
import com.annotation.SysLog;

import com.entity.ShixishenqingEntity;
import com.entity.view.ShixishenqingView;

import com.service.ShixishenqingService;
import com.service.TokenService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.utils.MapUtils;
import com.utils.CommonUtil;
import java.io.IOException;

/**
 * 实习申请
 * 后端接口
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
@RestController
@RequestMapping("/shixishenqing")
public class ShixishenqingController {
    @Autowired
    private ShixishenqingService shixishenqingService;






    



    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ShixishenqingEntity shixishenqing,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("qiye")) {
			shixishenqing.setQiyezhanghao((String)request.getSession().getAttribute("username"));
		}
		if(tableName.equals("xuesheng")) {
			shixishenqing.setXueshengzhanghao((String)request.getSession().getAttribute("username"));
		}
        //设置查询条件
        EntityWrapper<ShixishenqingEntity> ew = new EntityWrapper<ShixishenqingEntity>();


        //查询结果
		PageUtils page = shixishenqingService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixishenqing), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }
    
    /**
     * 前台列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,ShixishenqingEntity shixishenqing, 
		HttpServletRequest request){
        //设置查询条件
        EntityWrapper<ShixishenqingEntity> ew = new EntityWrapper<ShixishenqingEntity>();

        //查询结果
		PageUtils page = shixishenqingService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixishenqing), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }



	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ShixishenqingEntity shixishenqing){
       	EntityWrapper<ShixishenqingEntity> ew = new EntityWrapper<ShixishenqingEntity>();
      	ew.allEq(MPUtil.allEQMapPre( shixishenqing, "shixishenqing")); 
        return R.ok().put("data", shixishenqingService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ShixishenqingEntity shixishenqing){
        EntityWrapper< ShixishenqingEntity> ew = new EntityWrapper< ShixishenqingEntity>();
 		ew.allEq(MPUtil.allEQMapPre( shixishenqing, "shixishenqing")); 
		ShixishenqingView shixishenqingView =  shixishenqingService.selectView(ew);
		return R.ok("查询实习申请成功").put("data", shixishenqingView);
    }
	
    /**
     * 后台详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ShixishenqingEntity shixishenqing = shixishenqingService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shixishenqing,deSens);
        return R.ok().put("data", shixishenqing);
    }

    /**
     * 前台详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ShixishenqingEntity shixishenqing = shixishenqingService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shixishenqing,deSens);
        return R.ok().put("data", shixishenqing);
    }
    



    /**
     * 后台保存
     */
    @RequestMapping("/save")
    @SysLog("新增实习申请") 
    public R save(@RequestBody ShixishenqingEntity shixishenqing, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixishenqing);
        shixishenqingService.insert(shixishenqing);
        return R.ok().put("data",shixishenqing.getId());
    }
    
    /**
     * 前台保存
     */
    @SysLog("新增实习申请")
    @RequestMapping("/add")
    public R add(@RequestBody ShixishenqingEntity shixishenqing, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixishenqing);
        shixishenqingService.insert(shixishenqing);
        return R.ok().put("data",shixishenqing.getId());
    }





    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改实习申请")
    public R update(@RequestBody ShixishenqingEntity shixishenqing, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixishenqing);
        //全部更新
        shixishenqingService.updateById(shixishenqing);
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除实习申请")
    public R delete(@RequestBody Long[] ids){
        shixishenqingService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    








}
