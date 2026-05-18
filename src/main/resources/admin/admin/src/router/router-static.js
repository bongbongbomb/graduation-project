import Vue from 'vue';
//配置路由
import VueRouter from 'vue-router'
Vue.use(VueRouter);
//1.创建组件
import Index from '@/views/index'
import Home from '@/views/home'
import Login from '@/views/login'
import NotFound from '@/views/404'
import UpdatePassword from '@/views/update-password'
import pay from '@/views/pay'
import register from '@/views/register'
import center from '@/views/center'
    import news from '@/views/modules/news/list'
    import gangweileixing from '@/views/modules/gangweileixing/list'
    import shixipingjia from '@/views/modules/shixipingjia/list'
    import aboutus from '@/views/modules/aboutus/list'
    import xuesheng from '@/views/modules/xuesheng/list'
    import shixigangwei from '@/views/modules/shixigangwei/list'
    import shixishenqing from '@/views/modules/shixishenqing/list'
    import luyongtongzhi from '@/views/modules/luyongtongzhi/list'
    import syslog from '@/views/modules/syslog/list'
    import qiye from '@/views/modules/qiye/list'
    import shixiqingkuang from '@/views/modules/shixiqingkuang/list'
    import config from '@/views/modules/config/list'
    import newstype from '@/views/modules/newstype/list'


//2.配置路由   注意：名字
export const routes = [{
    path: '/',
    name: '系统首页',
    component: Index,
    children: [{
      // 这里不设置值，是把main作为默认页面
      path: '/',
      name: '系统首页',
      component: Home,
      meta: {icon:'', title:'center', affix: true}
    }, {
      path: '/updatePassword',
      name: '修改密码',
      component: UpdatePassword,
      meta: {icon:'', title:'updatePassword'}
    }, {
      path: '/pay',
      name: '支付',
      component: pay,
      meta: {icon:'', title:'pay'}
    }, {
      path: '/center',
      name: '个人信息',
      component: center,
      meta: {icon:'', title:'center'}
    }
      ,{
	path: '/news',
        name: '公告资讯',
        component: news
      }
      ,{
	path: '/gangweileixing',
        name: '岗位类型',
        component: gangweileixing
      }
      ,{
	path: '/shixipingjia',
        name: '实习报告',
        component: shixipingjia
      }
      ,{
	path: '/aboutus',
        name: '关于我们',
        component: aboutus
      }
      ,{
	path: '/xuesheng',
        name: '学生',
        component: xuesheng
      }
      ,{
	path: '/shixigangwei',
        name: '实习岗位',
        component: shixigangwei
      }
      ,{
	path: '/shixishenqing',
        name: '实习申请',
        component: shixishenqing
      }
      ,{
	path: '/luyongtongzhi',
        name: '录用通知',
        component: luyongtongzhi
      }
      ,{
	path: '/syslog',
        name: '系统日志',
        component: syslog
      }
      ,{
	path: '/qiye',
        name: '企业',
        component: qiye
      }
      ,{
	path: '/shixiqingkuang',
        name: '实习情况',
        component: shixiqingkuang
      }
      ,{
	path: '/config',
        name: '轮播图管理',
        component: config
      }
      ,{
	path: '/newstype',
        name: '公告资讯分类',
        component: newstype
      }
    ]
  },
  {
    path: '/login',
    name: 'login',
    component: Login,
    meta: {icon:'', title:'login'}
  },
  {
    path: '/register',
    name: 'register',
    component: register,
    meta: {icon:'', title:'register'}
  },
  {
    path: '*',
    component: NotFound
  }
]
//3.实例化VueRouter  注意：名字
const router = new VueRouter({
  mode: 'hash',
  /*hash模式改为history*/
  routes // （缩写）相当于 routes: routes
})
const originalPush = VueRouter.prototype.push
//修改原型对象中的push方法
VueRouter.prototype.push = function push(location) {
   return originalPush.call(this, location).catch(err => err)
}
export default router;
