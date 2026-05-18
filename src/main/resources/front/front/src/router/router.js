import VueRouter from 'vue-router'
//引入组件
import Index from '../pages'
import Home from '../pages/home/home'
import Login from '../pages/login/login'
import Register from '../pages/register/register'
import Center from '../pages/center/center'
import Storeup from '../pages/storeup/list'
import News from '../pages/news/news-list'
import NewsDetail from '../pages/news/news-detail'
import payList from '../pages/pay'

import xueshengList from '../pages/xuesheng/list'
import xueshengDetail from '../pages/xuesheng/detail'
import xueshengAdd from '../pages/xuesheng/add'
import qiyeList from '../pages/qiye/list'
import qiyeDetail from '../pages/qiye/detail'
import qiyeAdd from '../pages/qiye/add'
import gangweileixingList from '../pages/gangweileixing/list'
import gangweileixingDetail from '../pages/gangweileixing/detail'
import gangweileixingAdd from '../pages/gangweileixing/add'
import shixigangweiList from '../pages/shixigangwei/list'
import shixigangweiDetail from '../pages/shixigangwei/detail'
import shixigangweiAdd from '../pages/shixigangwei/add'
import shixishenqingList from '../pages/shixishenqing/list'
import shixishenqingDetail from '../pages/shixishenqing/detail'
import shixishenqingAdd from '../pages/shixishenqing/add'
import luyongtongzhiList from '../pages/luyongtongzhi/list'
import luyongtongzhiDetail from '../pages/luyongtongzhi/detail'
import luyongtongzhiAdd from '../pages/luyongtongzhi/add'
import shixiqingkuangList from '../pages/shixiqingkuang/list'
import shixiqingkuangDetail from '../pages/shixiqingkuang/detail'
import shixiqingkuangAdd from '../pages/shixiqingkuang/add'
import shixipingjiaList from '../pages/shixipingjia/list'
import shixipingjiaDetail from '../pages/shixipingjia/detail'
import shixipingjiaAdd from '../pages/shixipingjia/add'
import chatmessageList from '../pages/chatmessage/list'
import chatmessageDetail from '../pages/chatmessage/detail'
import chatmessageAdd from '../pages/chatmessage/add'
import friendList from '../pages/friend/list'
import friendDetail from '../pages/friend/detail'
import friendAdd from '../pages/friend/add'
import syslogList from '../pages/syslog/list'
import syslogDetail from '../pages/syslog/detail'
import syslogAdd from '../pages/syslog/add'
import newstypeList from '../pages/newstype/list'
import newstypeDetail from '../pages/newstype/detail'
import newstypeAdd from '../pages/newstype/add'
import aboutusList from '../pages/aboutus/list'
import aboutusDetail from '../pages/aboutus/detail'
import aboutusAdd from '../pages/aboutus/add'

const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
	return originalPush.call(this, location).catch(err => err)
}

//配置路由
export default new VueRouter({
	routes:[
		{
      path: '/',
      redirect: '/index/home'
    },
		{
			path: '/index',
			component: Index,
			children:[
				{
					path: 'home',
					component: Home
				},
				{
					path: 'center',
					component: Center,
				},
				{
					path: 'pay',
					component: payList,
				},
				{
					path: 'storeup',
					component: Storeup
				},
				{
					path: 'news',
					component: News
				},
				{
					path: 'newsDetail',
					component: NewsDetail
				},
				{
					path: 'xuesheng',
					component: xueshengList
				},
				{
					path: 'xueshengDetail',
					component: xueshengDetail
				},
				{
					path: 'xueshengAdd',
					component: xueshengAdd
				},
				{
					path: 'qiye',
					component: qiyeList
				},
				{
					path: 'qiyeDetail',
					component: qiyeDetail
				},
				{
					path: 'qiyeAdd',
					component: qiyeAdd
				},
				{
					path: 'gangweileixing',
					component: gangweileixingList
				},
				{
					path: 'gangweileixingDetail',
					component: gangweileixingDetail
				},
				{
					path: 'gangweileixingAdd',
					component: gangweileixingAdd
				},
				{
					path: 'shixigangwei',
					component: shixigangweiList
				},
				{
					path: 'shixigangweiDetail',
					component: shixigangweiDetail
				},
				{
					path: 'shixigangweiAdd',
					component: shixigangweiAdd
				},
				{
					path: 'shixishenqing',
					component: shixishenqingList
				},
				{
					path: 'shixishenqingDetail',
					component: shixishenqingDetail
				},
				{
					path: 'shixishenqingAdd',
					component: shixishenqingAdd
				},
				{
					path: 'luyongtongzhi',
					component: luyongtongzhiList
				},
				{
					path: 'luyongtongzhiDetail',
					component: luyongtongzhiDetail
				},
				{
					path: 'luyongtongzhiAdd',
					component: luyongtongzhiAdd
				},
				{
					path: 'shixiqingkuang',
					component: shixiqingkuangList
				},
				{
					path: 'shixiqingkuangDetail',
					component: shixiqingkuangDetail
				},
				{
					path: 'shixiqingkuangAdd',
					component: shixiqingkuangAdd
				},
				{
					path: 'shixipingjia',
					component: shixipingjiaList
				},
				{
					path: 'shixipingjiaDetail',
					component: shixipingjiaDetail
				},
				{
					path: 'shixipingjiaAdd',
					component: shixipingjiaAdd
				},
				{
					path: 'chatmessage',
					component: chatmessageList
				},
				{
					path: 'chatmessageDetail',
					component: chatmessageDetail
				},
				{
					path: 'chatmessageAdd',
					component: chatmessageAdd
				},
				{
					path: 'friend',
					component: friendList
				},
				{
					path: 'friendDetail',
					component: friendDetail
				},
				{
					path: 'friendAdd',
					component: friendAdd
				},
				{
					path: 'syslog',
					component: syslogList
				},
				{
					path: 'syslogDetail',
					component: syslogDetail
				},
				{
					path: 'syslogAdd',
					component: syslogAdd
				},
				{
					path: 'newstype',
					component: newstypeList
				},
				{
					path: 'newstypeDetail',
					component: newstypeDetail
				},
				{
					path: 'newstypeAdd',
					component: newstypeAdd
				},
				{
					path: 'aboutus',
					component: aboutusList
				},
				{
					path: 'aboutusDetail',
					component: aboutusDetail
				},
				{
					path: 'aboutusAdd',
					component: aboutusAdd
				},
			]
		},
		{
			path: '/login',
			component: Login
		},
		{
			path: '/register',
			component: Register
		},
	]
})
