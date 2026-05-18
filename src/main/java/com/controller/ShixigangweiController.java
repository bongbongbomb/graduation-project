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

import com.entity.ShixigangweiEntity;
import com.entity.ShixiqingkuangEntity;
import com.entity.view.ShixigangweiView;

import com.service.ShixigangweiService;
import com.service.ShixiqingkuangService;
import com.service.TokenService;
import com.utils.PageUtils;
import com.utils.R;
import com.utils.MPUtil;
import com.utils.MapUtils;
import com.utils.CommonUtil;
import java.io.IOException;

/**
 * 实习岗位
 * 后端接口
 * @author 
 * @email 
 * @date 2025-04-20 22:07:46
 */
@RestController
@RequestMapping("/shixigangwei")
public class ShixigangweiController {
    @Autowired
    private ShixigangweiService shixigangweiService;

    @Autowired
    private ShixiqingkuangService shixiqingkuangService;






    



    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ShixigangweiEntity shixigangwei,
		HttpServletRequest request){
		String tableName = request.getSession().getAttribute("tableName").toString();
		if(tableName.equals("qiye")) {
			shixigangwei.setQiyezhanghao((String)request.getSession().getAttribute("username"));
		}
        //设置查询条件
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();


        //查询结果
		PageUtils page = shixigangweiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixigangwei), params), params));
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
    public R list(@RequestParam Map<String, Object> params,ShixigangweiEntity shixigangwei, 
		HttpServletRequest request){
        //设置查询条件
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();

        //查询结果
		PageUtils page = shixigangweiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixigangwei), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }



	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ShixigangweiEntity shixigangwei){
       	EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( shixigangwei, "shixigangwei")); 
        return R.ok().put("data", shixigangweiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ShixigangweiEntity shixigangwei){
        EntityWrapper< ShixigangweiEntity> ew = new EntityWrapper< ShixigangweiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( shixigangwei, "shixigangwei")); 
		ShixigangweiView shixigangweiView =  shixigangweiService.selectView(ew);
		return R.ok("查询实习岗位成功").put("data", shixigangweiView);
    }
	
    /**
     * 后台详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ShixigangweiEntity shixigangwei = shixigangweiService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shixigangwei,deSens);
        return R.ok().put("data", shixigangwei);
    }

    /**
     * 前台详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ShixigangweiEntity shixigangwei = shixigangweiService.selectById(id);
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(shixigangwei,deSens);
        
        //根据企业名称查询实习情况表，返回该企业的所有实习情况数据
        List<ShixiqingkuangEntity> shixiqingkuangList = null;
        if (shixigangwei != null && shixigangwei.getQiyemingcheng() != null) {
            EntityWrapper<ShixiqingkuangEntity> ew = new EntityWrapper<ShixiqingkuangEntity>();
            ew.eq("qiyemingcheng", shixigangwei.getQiyemingcheng());
            shixiqingkuangList = shixiqingkuangService.selectList(ew);
        }
        
        //将实习情况数据添加到返回结果中
        Map<String, Object> result = new HashMap<>();
        result.put("shixigangwei", shixigangwei);
        result.put("shixiqingkuangList", shixiqingkuangList);
        
        return R.ok().put("data", result);
    }
    



    /**
     * 后台保存
     */
    @RequestMapping("/save")
    @SysLog("新增实习岗位") 
    public R save(@RequestBody ShixigangweiEntity shixigangwei, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixigangwei);
        shixigangweiService.insert(shixigangwei);
        return R.ok().put("data",shixigangwei.getId());
    }
    
    /**
     * 前台保存
     */
    @SysLog("新增实习岗位")
    @RequestMapping("/add")
    public R add(@RequestBody ShixigangweiEntity shixigangwei, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixigangwei);
        shixigangweiService.insert(shixigangwei);
        return R.ok().put("data",shixigangwei.getId());
    }





    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改实习岗位")
    public R update(@RequestBody ShixigangweiEntity shixigangwei, HttpServletRequest request){
        //ValidatorUtils.validateEntity(shixigangwei);
        //全部更新
        shixigangweiService.updateById(shixigangwei);
        return R.ok();
    }

    /**
     * 审核
     */
    @RequestMapping("/shBatch")
    @Transactional
    @SysLog("审核实习岗位")
    public R update(@RequestBody Long[] ids, @RequestParam String sfsh, @RequestParam String shhf){
        List<ShixigangweiEntity> list = new ArrayList<ShixigangweiEntity>();
        for(Long id : ids) {
            ShixigangweiEntity shixigangwei = shixigangweiService.selectById(id);
            shixigangwei.setSfsh(sfsh);
            shixigangwei.setShhf(shhf);
            list.add(shixigangwei);
        }
        shixigangweiService.updateBatchById(list);
        return R.ok();
    }


    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除实习岗位")
    public R delete(@RequestBody Long[] ids){
        shixigangweiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }
    






    /**
     * （按值统计）
     */
    @RequestMapping("/value/{xColumnName}/{yColumnName}")
    public R value(@PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName,HttpServletRequest request) throws IOException {
        //构建查询统计条件
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", xColumnName);
        params.put("yColumn", yColumnName);
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
                                                if(tableName.equals("qiye")) {
            ew.eq("qiyezhanghao", (String)request.getSession().getAttribute("username"));
        }
                            //获取结果
        List<Map<String, Object>> result = shixigangweiService.selectValue(params, ew);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }
        Collections.sort(result, (map1, map2) -> {
            // 假设 total 总是存在并且是数值类型
            Number total1 = (Number) map1.get("total");
            Number total2 = (Number) map2.get("total");
            if(total1==null)
            {
                total1 = 0;
            }
            if(total2==null)
            {
                total2 = 0;
            }
            return Double.compare(total2.doubleValue(), total1.doubleValue());
        });
        return R.ok().put("data", result);
    }
    
    /**
     * （按值统计(多)）
     */
    @RequestMapping("/valueMul/{xColumnName}")
    public R valueMul(@PathVariable("xColumnName") String xColumnName,@RequestParam String yColumnNameMul,HttpServletRequest request)  throws IOException {
        String[] yColumnNames = yColumnNameMul.split(",");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", xColumnName);
        List<List<Map<String, Object>>> result2 = new ArrayList<List<Map<String,Object>>>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //构建查询统计条件
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("qiye")) {
            ew.eq("qiyezhanghao", (String)request.getSession().getAttribute("username"));
        }
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = shixigangweiService.selectValue(params, ew);
            for(Map<String, Object> m : result) {
                for(String k : m.keySet()) {
                    if(m.get(k) instanceof Date) {
                        m.put(k, sdf.format((Date)m.get(k)));
                    }
                }
            }
            result2.add(result);
        }
        return R.ok().put("data", result2);
    }
    
    /**
     * （按值统计）时间统计类型
     */
    @RequestMapping("/value/{xColumnName}/{yColumnName}/{timeStatType}")
    public R valueDay(@PathVariable("yColumnName") String yColumnName, @PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType,HttpServletRequest request) throws IOException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", xColumnName);
        params.put("yColumn", yColumnName);
        params.put("timeStatType", timeStatType);
        //构建查询统计条件
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("qiye")) {
            ew.eq("qiyezhanghao", (String)request.getSession().getAttribute("username"));
        }
        List<Map<String, Object>> result = shixigangweiService.selectTimeStatValue(params, ew);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }
        return R.ok().put("data", result);
    }
    
    /**
     * （按值统计）时间统计类型(多)
     */
    @RequestMapping("/valueMul/{xColumnName}/{timeStatType}")
    public R valueMulDay(@PathVariable("xColumnName") String xColumnName, @PathVariable("timeStatType") String timeStatType,@RequestParam String yColumnNameMul,HttpServletRequest request) throws IOException
    {
        String[] yColumnNames = yColumnNameMul.split(",");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("xColumn", xColumnName);
        params.put("timeStatType", timeStatType);
        List<List<Map<String, Object>>> result2 = new ArrayList<List<Map<String,Object>>>();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //构建查询统计条件
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("qiye")) {
            ew.eq("qiyezhanghao", (String)request.getSession().getAttribute("username"));
        }
        for(int i=0;i<yColumnNames.length;i++) {
            params.put("yColumn", yColumnNames[i]);
            List<Map<String, Object>> result = shixigangweiService.selectTimeStatValue(params, ew);
            for(Map<String, Object> m : result) {
                for(String k : m.keySet()) {
                    if(m.get(k) instanceof Date) {
                        m.put(k, sdf.format((Date)m.get(k)));
                    }
                }
            }
            result2.add(result);
        }
        return R.ok().put("data", result2);
    }
    
    /**
     * 分组统计
     */
    @RequestMapping("/group/{columnName}")
    public R group(@PathVariable("columnName") String columnName,HttpServletRequest request) throws IOException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("column", columnName);
        //构建查询统计条件
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("qiye")) {
            ew.eq("qiyezhanghao", (String)request.getSession().getAttribute("username"));
        }
        List<Map<String, Object>> result = shixigangweiService.selectGroup(params, ew);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Map<String, Object> m : result) {
            for(String k : m.keySet()) {
                if(m.get(k) instanceof Date) {
                    m.put(k, sdf.format((Date)m.get(k)));
                }
            }
        }
        return R.ok().put("data", result);
    }    




    /**
     * 总数量
     */
    @RequestMapping("/count")
    public R count(@RequestParam Map<String, Object> params,ShixigangweiEntity shixigangwei, HttpServletRequest request){
        String tableName = request.getSession().getAttribute("tableName").toString();
        if(tableName.equals("qiye")) {
            shixigangwei.setQiyezhanghao((String)request.getSession().getAttribute("username"));
        }
        EntityWrapper<ShixigangweiEntity> ew = new EntityWrapper<ShixigangweiEntity>();
        int count = shixigangweiService.selectCount(MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, shixigangwei), params), params));
        return R.ok().put("data", count);
    }

}
