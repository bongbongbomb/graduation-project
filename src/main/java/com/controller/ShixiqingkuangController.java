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

import com.entity.ShixiqingkuangEntity;
import com.entity.view.ShixiqingkuangView;

import com.service.ShixiqingkuangService;
import com.service.TokenService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.utils.MapUtils;
import com.utils.CommonUtil;
import java.io.IOException;

/**
 * 实习情况
 * 后端接口
 * @author 
 * @email 
 * @date 2025-04-20 22:07:47
 */
@RestController
@RequestMapping("/shixiqingkuang")
public class ShixiqingkuangController {
    @Autowired
    private ShixiqingkuangService shixiqingkuangService;






    



    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ShixiqingkuangEntity shixiqingkuang,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("qiye")) {
			shixiqingkuang.setQiyezhanghao((String)request.getSession().getAttribute("username"));
		}
		if(tableName.equals("xuesheng")) {
			shixiqingkuang.setXueshengzhanghao((String)request.getSession().getAttribute("username"));
		}
        //设置查询条件
        EntityWrapper<ShixiqingkuangEntity> ew = new EntityWrapper<ShixiqingkuangEntity>();


        //查询结果
		PageUtils page = shixiqingkuangService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixiqingkuang), params), params));
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
    public R list(@RequestParam Map<String, Object> params,ShixiqingkuangEntity shixiqingkuang, 
		HttpServletRequest request){
        //设置查询条件
        EntityWrapper<ShixiqingkuangEntity> ew = new EntityWrapper<ShixiqingkuangEntity>();

        //查询结果
		PageUtils page = shixiqingkuangService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixiqingkuang), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }



	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ShixiqingkuangEntity shixiqingkuang){
       	EntityWrapper<ShixiqingkuangEntity> ew = new EntityWrapper<ShixiqingkuangEntity>();
      	ew.allEq(MPUtil.allEQMapPre( shixiqingkuang, "shixiqingkuang")); 
        return R.ok().put("data", shixiqingkuangService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ShixiqingkuangEntity shixiqingkuang){
        EntityWrapper< ShixiqingkuangEntity> ew = new EntityWrapper< ShixiqingkuangEntity>();
 		ew.allEq(MPUtil.allEQMapPre( shixiqingkuang, "shixiqingkuang")); 
		ShixiqingkuangView shixiqingkuangView =  shixiqingkuangService.selectView(ew);
		return R.ok("查询实习情况成功").put("data", shixiqingkuangView);
    }
	
    /**
     * 后台详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ShixiqingkuangEntity shixiqingkuang = shixiqingkuangService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shixiqingkuang,deSens);
        return R.ok().put("data", shixiqingkuang);
    }

    /**
     * 前台详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ShixiqingkuangEntity shixiqingkuang = shixiqingkuangService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shixiqingkuang,deSens);
        return R.ok().put("data", shixiqingkuang);
    }
    



    /**
     * 后台保存
     */
    @RequestMapping("/save")
    @SysLog("新增实习情况") 
    public R save(@RequestBody ShixiqingkuangEntity shixiqingkuang, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixiqingkuang);
        shixiqingkuangService.insert(shixiqingkuang);
        return R.ok().put("data",shixiqingkuang.getId());
    }
    
    /**
     * 前台保存
     */
    @SysLog("新增实习情况")
    @RequestMapping("/add")
    public R add(@RequestBody ShixiqingkuangEntity shixiqingkuang, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixiqingkuang);
        shixiqingkuangService.insert(shixiqingkuang);
        return R.ok().put("data",shixiqingkuang.getId());
    }





    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改实习情况")
    public R update(@RequestBody ShixiqingkuangEntity shixiqingkuang, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixiqingkuang);
        //全部更新
        shixiqingkuangService.updateById(shixiqingkuang);
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除实习情况")
    public R delete(@RequestBody Long[] ids){
        shixiqingkuangService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    








}
