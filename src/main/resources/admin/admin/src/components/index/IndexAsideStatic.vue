<template>
	<div class="app-sidebar" :class="{ 'is-collapsed': isCollapse }">
		<el-scrollbar :wrap-class="`app-sidebar__scroll ${isCollapse ? 'is-collapsed' : ''}`">
			<el-button class="app-sidebar__toggle" type="primary" @click="collapse">
				<i :class="isCollapse ? 'el-icon-s-unfold' : 'el-icon-s-fold'"></i>
				<span v-show="!isCollapse">收起</span>
			</el-button>

			<el-menu class="app-sidebar__menu" :default-active="activeMenu" :unique-opened="true" :collapse-transition="false" :collapse="isCollapse">
				<el-menu-item index="/" @click.native="menuHandler('')">
					<i class="icon iconfont icon-shouye-zhihui"></i>
					<span>首页</span>
				</el-menu-item>

				<el-submenu index="1">
					<template slot="title">
						<i class="icon iconfont icon-kuaijiezhifu"></i>
						<span>个人中心</span>
					</template>
					<el-menu-item index="/updatePassword" @click="menuHandler('updatePassword')">修改密码</el-menu-item>
					<el-menu-item index="/center" @click="menuHandler('center')">个人信息</el-menu-item>
				</el-submenu>

			<template v-for="(menu,index) in menuList.backMenu">
				<el-submenu v-if="menu.child.length > 1 || !verticalIsMultiple" :key="'submenu-'+index" :index="index+2+''">
					<template slot="title">
						<i class="el-icon-menu" :class="icons[index]"></i>
						<span>{{menu.menu + (verticalFlag ? '管理' : '')}}</span>
					</template>
					<el-menu-item v-for="(child,sort) in menu.child" :key="sort" :index="'/'+child.tableName" @click="menuHandler(child.tableName)">{{ child.menu }}</el-menu-item>
				</el-submenu>
				<el-menu-item v-if="menu.child.length <= 1 && verticalIsMultiple" :key="'menuitem-'+index" @click="menuHandler(menu.child[0].tableName)" :index="'/'+menu.child[0].tableName">
					<i class="el-icon-menu" :class="icons[index]"></i>
					<span>{{menu.child[0].menu + (verticalFlag ? '管理' : '')}}</span>
				</el-menu-item>
			</template>
		  </el-menu>
		</el-scrollbar>


	</div>
</template>

<script>
import menu from '@/utils/menu'
export default {
	data() {
		return {
			menuList: [],
			dynamicMenuRoutes: [],
			role: '',
			user: null,
			avatar:'',
			icons: [
				'el-icon-s-cooperation',
				'el-icon-s-order',
				'el-icon-s-platform',
				'el-icon-s-fold',
				'el-icon-s-unfold',
				'el-icon-s-operation',
				'el-icon-s-promotion',
				'el-icon-s-release',
				'el-icon-s-ticket',
				'el-icon-s-management',
				'el-icon-s-open',
				'el-icon-s-shop',
				'el-icon-s-marketing',
				'el-icon-s-flag',
				'el-icon-s-comment',
				'el-icon-s-finance',
				'el-icon-s-claim',
				'el-icon-s-custom',
				'el-icon-s-opportunity',
				'el-icon-s-data',
				'el-icon-s-check',
				'el-icon-s-grid',
				'el-icon-menu',
				'el-icon-chat-dot-square',
				'el-icon-message',
				'el-icon-postcard',
				'el-icon-position',
				'el-icon-microphone',
				'el-icon-close-notification',
				'el-icon-bangzhu',
				'el-icon-time',
				'el-icon-odometer',
				'el-icon-crop',
				'el-icon-aim',
				'el-icon-switch-button',
				'el-icon-full-screen',
				'el-icon-copy-document',
				'el-icon-mic',
				'el-icon-stopwatch',
			],
			menulistBorderBottom: {},
			verticalFlag: false,
			isCollapse: false,
			verticalStyle2: {"isCollapse":false,"close":{"contentBox":{"hover":{},"active":{"margin":"0 0 0 54px"},"default":{"minHeight":"100%","padding":"0","position":"relative","background":"red","display":"block"}},"box":{"hover":{},"active":{"width":"54px"},"default":{"overflow":"hidden","top":"0","left":"0","background":"#f9fbfd","bottom":"0","width":"64px","fontSize":"0px","position":"fixed","transition":"width 0.3s","height":"100%","zIndex":"1001"}},"menu":{"two":{"title":{"hover":{"padding":"0 20px","lineHeight":"56px","color":"#ffe4c7","background":"#6aab9c","height":"56px"},"active":{"padding":"0 20px","lineHeight":"56px","color":"#ffe4c7","background":"#6aab9c","height":"56px"},"default":{"padding":"0 20px","backgroundColor":"rgb(106, 171, 156)","lineHeight":"56px","color":"#fff","height":"56px"}},"box":{"hover":{},"default":{"border":"none"}}},"box":{"hover":{},"default":{"border":0,"padding":"0","listStyle":"none","margin":"0","position":"relative","background":"red"}},"one":{"box1":{"hover":{"color":"#ffe4c7","background":"#6aab9c"},"active":{"color":"#ffe4c7","background":"#6aab9c"},"default":{"cursor":"pointer","padding":"0 20px","whiteSpace":"nowrap","position":"relative","color":"#333","background":"#fff"}},"icon":{"hover":{},"default":{"verticalAlign":"middle","margin":"0","color":"inherit","textAlign":"center","display":"inline-block","width":"24px","fontSize":"18px"},"flag":true},"box":{"hover":{},"default":{"padding":"0","listStyle":"none","margin":"0"}},"title":{"hover":{},"default":{"width":"0","verticalAlign":"middle","fontSize":"14px","color":"inherit","height":"0"}},"arrow":{"hover":{},"default":{"verticalAlign":"middle","margin":"-7px 0 0 0","top":"50%","color":"inherit","display":"none","fontSize":"12px","position":"absolute","right":"20px"}}}},"btn":{"icon":{"hover":{},"default":{"margin":"0 2px","fontSize":"14px","color":"#fff","height":"40px"},"text":"icon-xihuan"},"hover":{"opacity":"0.8"},"default":{"border":"0","cursor":"pointer","padding":"0 9px","margin":"0 0 10px","outline":"none","color":"#fff","borderRadius":"0","background":"rgba(64, 158, 255, 1)","width":"auto","fontSize":"14px","height":"40px"},"text":"切换"},"user":{"two":{"title":{"hover":{"padding":"0 20px","backgroundColor":"#6aab9c","lineHeight":"56px","color":"#ffe4c7","height":"56px"},"active":{"padding":"0 20px","backgroundColor":"#6aab9c","lineHeight":"56px","color":"#ffe4c7","height":"56px"},"default":{"padding":"0 20px","backgroundColor":"#6aab9c","lineHeight":"56px","color":"#fff","height":"56px"}},"box":{"hover":{},"default":{"border":"none"}}},"one":{"box1":{"hover":{"color":"#ffe4c7","background":"#6aab9c"},"active":{"color":"#ffe4c7","background":"#6aab9c"},"default":{"cursor":"pointer","padding":"0 20px","whiteSpace":"nowrap","position":"relative","color":"#fff","background":"#6aab9c"}},"icon":{"hover":{},"default":{"verticalAlign":"middle","margin":"0","color":"inherit","textAlign":"center","display":"inline-block","width":"24px","fontSize":"18px"},"flag":true,"text":"icon-kuaijiezhifu"},"box":{"hover":{},"default":{"padding":"0","listStyle":"none","margin":"0"}},"title":{"hover":{},"default":{"width":"0","verticalAlign":"middle","fontSize":"14px","color":"inherit","height":"0"}},"arrow":{"hover":{},"default":{"verticalAlign":"middle","margin":"-7px 0 0 0","top":"50%","color":"inherit","display":"none","fontSize":"12px","position":"absolute","right":"20px"}}}},"userinfo":{"nickname":{"hover":{},"default":{"fontSize":"24px","lineHeight":"1.5","color":"#fff","textAlign":"center"}},"img":{"hover":{},"default":{"width":"100%","objectFit":"cover","borderRadius":"20px","display":"block","height":"170px"}},"box":{"hover":{},"default":{"width":"100%","padding":"20px","display":"none","height":"auto"}}},"home":{"two":{"title":{"hover":{"padding":"0 20px","backgroundColor":"red !important","lineHeight":"56px","color":"#fff","height":"56px"},"active":{"padding":"0 20px","backgroundColor":"blue !important","lineHeight":"56px","color":"#fff","height":"56px"},"default":{"padding":"0 20px","backgroundColor":"#fff","lineHeight":"56px","color":"#646","height":"56px"}},"box":{"hover":{},"default":{"border":"none"}}},"one":{"box1":{"hover":{"color":"#ffe4c7","background":"#6aab9c"},"active":{"color":"#ffe4c7","background":"#6aab9c"},"default":{"cursor":"pointer","padding":"0 20px","whiteSpace":"nowrap","position":"relative"}},"icon":{"hover":{},"default":{"verticalAlign":"middle","margin":"0","color":"inherit","textAlign":"center","display":"inline-block","width":"24px","fontSize":"18px"},"flag":true,"text":"icon-shouye-zhihui"},"box":{"hover":{},"default":{"padding":"0","listStyle":"none","margin":"0"}},"title":{"hover":{},"default":{"width":"0","verticalAlign":"middle","fontSize":"14px","color":"inherit","height":"0"}},"arrow":{"hover":{},"default":{"verticalAlign":"middle","margin":"-7px 0 0 0","top":"50%","color":"inherit","display":"none","fontSize":"12px","position":"absolute","right":"20px"}}}}},"open":{"contentBox":{"hover":{},"default":{"padding":"0 0 0 210px","margin":"0","position":"relative","background":"#f9fbfd","display":"block"}},"box":{"hover":{},"default":{"margin":"0px 0","overflow":"hidden","top":"0","borderRadius":"0","left":"0","bottom":"0","background":"#6aab9c","width":"210px","fontSize":"0px","position":"fixed","transition":"width 0.3s","zIndex":"1001"}},"menu":{"two":{"title":{"hover":{"padding":"0 40px","lineHeight":"50px","color":"#ffe4c7","background":"#6aab9c","height":"50px"},"active":{"padding":"0 40px","lineHeight":"50px","color":"#ffe4c7","background":"#6aab9c","height":"50px"},"default":{"padding":"0 40px","color":"#fff","background":"#6aab9c","lineHeight":"50px","fontSize":"16px","fontWeight":"600","height":"50px"}},"box":{"hover":{},"default":{"background":"#6aab9c"}}},"box":{"hover":{},"default":{"border":0,"listStyle":"none","margin":"0","background":"#6aab9c","flexDirection":"column","display":"flex","position":"relative"}},"one":{"box1":{"hover":{"color":"#ffe4c7","background":"#6aab9c"},"active":{"color":"#ffe4c7","background":"#6aab9c"},"default":{"cursor":"pointer","padding":"0 20px","whiteSpace":"nowrap","color":"#fff","background":"rgb(106, 171, 156)","position":"relative","fontWeight":"600"}},"icon":{"hover":{},"default":{"verticalAlign":"middle","margin":"0 3px","color":"inherit","textAlign":"center","display":"inline-block","width":"34px","fontSize":"18px"},"flag":true},"box":{"hover":{},"default":{"padding":"0","margin":"0"}},"title":{"hover":{},"default":{"color":"inherit","verticalAlign":"middle","fontSize":"18px"}},"arrow":{"hover":{},"default":{"verticalAlign":"middle","margin":"-7px 0 0 0","top":"50%","color":"inherit","fontSize":"12px","position":"absolute","right":"20px"}}}},"btn":{"icon":{"hover":{},"default":{"margin":"0 2px","fontSize":"14px","color":"#fff","height":"40px"},"text":"icon-xihuan"},"hover":{"opacity":"0.8"},"default":{"border":"0","cursor":"pointer","padding":"0 9px","outline":"none","color":"#fff","borderRadius":"4px","background":"rgba(64, 158, 255, 1)","display":"none","width":"auto","fontSize":"14px","height":"40px"},"text":"切换"},"user":{"two":{"title":{"hover":{"padding":"0 40px","lineHeight":"50px","color":"#ffe4c7","background":"#6aab9c","height":"50px"},"active":{"padding":"0 40px","lineHeight":"50px","color":"#ffe4c7","background":"#6aab9c","height":"50px"},"default":{"padding":"0 40px","color":"#fff","background":"#6aab9c","lineHeight":"50px","fontSize":"16px","fontWeight":"600","height":"50px"}},"box":{"hover":{},"default":{"background":"#6aab9c"}}},"one":{"box1":{"hover":{"color":"#ffe4c7","background":"#6aab9c"},"active":{"color":"#ffe4c7!important","background":"#6aab9c!important"},"default":{"cursor":"pointer","padding":"0 20px","whiteSpace":"nowrap","color":"#fff","background":"#6aab9c","letterSpacing":"1px","position":"relative","fontWeight":"600"}},"icon":{"hover":{},"default":{"verticalAlign":"middle","margin":"0 3px","color":"inherit","textAlign":"center","display":"inline-block","width":"34px","fontSize":"18px"},"flag":true,"text":"icon-kuaijiezhifu"},"box":{"hover":{},"default":{"padding":"0","listStyle":"none","background":"#6aab9c","order":"1"}},"title":{"hover":{},"default":{"color":"inherit","verticalAlign":"middle","fontSize":"18px"},"text":"个人中心"},"arrow":{"hover":{},"default":{"verticalAlign":"middle","margin":"-7px 0 0 0","top":"50%","color":"inherit","fontSize":"12px","position":"absolute","right":"20px"}}}},"userinfo":{"nickname":{"hover":{},"default":{"fontSize":"24px","lineHeight":"1.5","color":"#fff","textAlign":"center"}},"img":{"hover":{},"default":{"width":"100%","objectFit":"cover","borderRadius":"20px","display":"block","height":"170px"}},"box":{"hover":{},"default":{"width":"100%","padding":"20px","display":"none","height":"auto"}}},"home":{"two":{"title":{"hover":{"padding":"0 40px","lineHeight":"50px","color":"#ffe4c7","background":"#6aab9c","height":"50px"},"active":{"padding":"0 40px","lineHeight":"50px","color":"#ffe4c7","background":"#6aab9c","height":"50px"},"default":{"padding":"0 40px","lineHeight":"50px","color":"#fff","background":"#6aab9c","height":"50px"}},"box":{"hover":{},"default":{"border":"none"}}},"one":{"box1":{"hover":{"color":"#ffe4c7","background":"#6aab9c"},"active":{"color":"#ffe4c7","background":"#6aab9c"},"default":{"cursor":"pointer","padding":"0 20px","whiteSpace":"nowrap","color":"#fff","letterSpacing":"1px","position":"relative","fontWeight":"600"}},"icon":{"hover":{},"default":{"verticalAlign":"middle","margin":"0 3px","color":"inherit","textAlign":"center","display":"inline-block","width":"34px","fontSize":"18px"},"flag":true,"text":"icon-shouye-zhihui"},"box":{"hover":{},"default":{"padding":"0","listStyle":"none","margin":"0"}},"title":{"hover":{},"default":{"color":"inherit","verticalAlign":"middle","fontSize":"18px"},"text":"系统首页"},"arrow":{"hover":{},"default":{"verticalAlign":"middle","margin":"-7px 0 0 0","top":"50%","color":"inherit","fontSize":"12px","position":"absolute","right":"20px"}}}}}},
			verticalIsMultiple: true,
		}
	},
	computed: {
		activeMenu() {
			const route = this.$route
			const {
				meta,
				path
			} = route
			// if st path, the sidebar will highlight the path you sete
			if (meta.activeMenu) {
				return meta.activeMenu
			}
			return path
		}
	},
	watch:{
		avatar(){
			this.$forceUpdate()
		},
	},
	mounted() {
		const menus = menu.list()
		if(menus) {
			this.menuList = menus
		} else {
			let params = {
				page: 1,
				limit: 1,
				sort: 'id',
			}
			
			this.$http({
				url: "menu/list",
				method: "get",
				params: params
			}).then(({
				data
			}) => {
				if (data && data.code === 0) {
					this.menuList = JSON.parse(data.data.list[0].menujson);
					this.$storage.set("menus", this.menuList);
				}
			})
		}
		this.role = this.$storage.get('role')
		
		for(let i=0;i<this.menuList.length;i++) {
			if(this.menuList[i].roleName == this.role) {
				this.menuList = this.menuList[i];
				break;
			}
		}
		
		let sessionTable = this.$storage.get("sessionTable")
		this.$http({
			url: sessionTable + '/session',
			method: "get"
		}).then(({
			data
		}) => {
			if (data && data.code === 0) {
				if(sessionTable == 'xuesheng') {
					this.avatar = data.data.touxiang
				}
				if(sessionTable == 'qiye') {
					this.avatar = data.data.touxiang
				}
				if(sessionTable=='users') {
					this.avatar = data.data.image
				}
				this.user = data.data;
			} else {
				let message = this.$message
				message.error(data.msg);
			}
		});
	},
	created(){
		this.icons.sort(()=>{
			return (0.5-Math.random())
		})
	},
	methods: {
		collapse() {
		  this.isCollapse = !this.isCollapse
		  this.$emit('oncollapsechange', this.isCollapse)
		},
		menuHandler(name) {
			let router = this.$router
			name = '/'+name
			router.push(name)
		},
	}
}
</script>
<style lang="scss" scoped>
	.app-sidebar {
	  .el-scrollbar {
	    height: 100%;
	
	    & ::v-deep .scrollbar-wrapper {
	      overflow-x: hidden;
	    }
		
				// 竖向
		.el-menu-vertical-demo {
		  .el-submenu:first-of-type ::v-deep .el-submenu__title .el-submenu__icon-arrow {
		    display: none;
		  }
		}
		
		.el-menu-vertical-demo>.el-menu-item {
				  				  cursor: pointer;
				  				  padding: 0 20px;
				  				  color: #333;
				  				  white-space: nowrap;
				  				  background: #fff;
				  				  position: relative;
				  		}
		
		.el-menu-vertical-demo>.el-menu-item:hover {
						color: #fff;
						background: blue;
					}
		
		.el-menu-vertical-demo .el-submenu ::v-deep .el-submenu__title {
						cursor: pointer;
						padding: 0 20px;
						color: #333;
						white-space: nowrap;
						background: #fff;
						position: relative;
					}
		
		.el-menu-vertical-demo .el-submenu ::v-deep .el-submenu__title:hover {
						color: #fff;
						background: blue;
					}
		
		.el-menu-vertical-demo .el-submenu ::v-deep .el-submenu__title .el-submenu__icon-arrow {
						margin: -7px 0 0 0;
						top: 50%;
						color: inherit;
						vertical-align: middle;
						font-size: 12px;
						position: absolute;
						right: 20px;
					}
		
		.el-menu-vertical-demo .el-submenu {
						padding: 0;
						margin: 0;
						list-style: none;
					}
		
		// .el-menu-vertical-demo .el-submenu ::v-deep .el-menu {
		// 				// 		border: none;
		// 				// 		display: none;
		// 				// }
		
		.el-menu-vertical-demo .el-submenu ::v-deep .el-menu .el-menu-item {
						padding: 0 40px;
						color: #666;
						background: #fff;
						line-height: 50px;
						height: 50px;
					}
		
		.el-menu-vertical-demo .el-submenu ::v-deep .el-menu .el-menu-item:hover {
						padding: 0 40px;
						color: #fff;
						background: red;
						line-height: 50px;
						height: 50px;
					}
		
		.el-menu-vertical-demo .el-submenu ::v-deep .el-menu .el-menu-item.is-active {
						padding: 0 40px;
						color: #fff;
						background: blue;
						line-height: 50px;
						height: 50px;
					}
		// 竖向
			  }
	  	}
	// 竖向 样式二-open
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.other {
		font-size: inherit;
		background: none;
	}
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.home {
		font-size: inherit;
		background: none;
	}
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.other>.el-tooltip {
				cursor: pointer;
				padding: 0 20px;
				color: #fff;
				white-space: nowrap;
				background: rgb(106, 171, 156);
				font-weight: 600;
				position: relative;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.other>.el-tooltip:hover {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title {
				cursor: pointer !important;
				padding: 0 20px !important;
				color: #fff !important;
				white-space: nowrap !important;
				background: rgb(106, 171, 156) !important;
				font-weight: 600 !important;
				position: relative !important;
			}
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.other.is-active>.el-tooltip {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title:hover {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other.is-active ::v-deep .el-submenu__title {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title .iconfont {
				margin: 0 3px;
				color: inherit;
				display: inline-block;
				vertical-align: middle;
				width: 34px;
				font-size: 18px;
				text-align: center;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title .el-submenu__icon-arrow {
				margin: -7px 0 0 0;
				top: 50%;
				color: inherit;
				vertical-align: middle;
				font-size: 12px;
				position: absolute;
				right: 20px;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 ::v-deep .el-submenu.other .el-menu {
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other .el-menu .el-menu-item {
				padding: 0 40px !important;
				color: #fff !important;
				background: #6aab9c !important;
				font-weight: 600 !important;
				font-size: 16px !important;
				line-height: 50px !important;
				height: 50px !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other .el-menu .el-menu-item:hover {
				padding: 0 40px !important;
				color: #ffe4c7 !important;
				background: #6aab9c !important;
				line-height: 50px !important;
				height: 50px !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.other .el-menu .el-menu-item.is-active {
				padding: 0 40px !important;
				color: #ffe4c7 !important;
				background: #6aab9c !important;
				line-height: 50px !important;
				height: 50px !important;
			}

	// 竖向 样式二-close
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.other>.el-tooltip {
				cursor: pointer;
				padding: 0 20px;
				color: #333;
				white-space: nowrap;
				background: #fff;
				position: relative;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.other>.el-tooltip:hover {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.other.is-active>.el-tooltip {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title {
				cursor: pointer !important;
				padding: 0 20px !important;
				color: #333 !important;
				white-space: nowrap !important;
				background: #fff !important;
				position: relative !important;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title:hover {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title .iconfont {
				margin: 0;
				color: inherit;
				display: inline-block;
				vertical-align: middle;
				width: 24px;
				font-size: 18px;
				text-align: center;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other ::v-deep .el-submenu__title .el-submenu__icon-arrow {
				margin: -7px 0 0 0;
				top: 50%;
				color: inherit;
				display: none;
				vertical-align: middle;
				font-size: 12px;
				position: absolute;
				right: 20px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other .el-menu {
				border: none;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other .el-menu--vertical.other .el-menu-item {
				background-color: rgb(106, 171, 156);
				padding: 0 20px;
				color: #fff;
				line-height: 56px;
				height: 56px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other .el-menu--vertical.other .el-menu-item:hover {
				padding: 0 20px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 56px;
				height: 56px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.other .el-menu--vertical.other .el-menu-item.is-active {
				padding: 0 20px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 56px;
				height: 56px;
			}
	
	// 竖向 样式二-open-首页
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.home>.el-tooltip {
				cursor: pointer;
				padding: 0 20px;
				color: #fff;
				white-space: nowrap;
				background: rgb(106, 171, 156);
				font-weight: 600;
				position: relative;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.home>.el-tooltip:hover {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.home.is-active>.el-tooltip {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title {
				cursor: pointer !important;
				padding: 0 20px !important;
				color: #fff !important;
				white-space: nowrap !important;
				background: rgb(106, 171, 156) !important;
				font-weight: 600 !important;
				position: relative !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title:hover {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title .iconfont {
				margin: 0 3px;
				color: inherit;
				display: inline-block;
				vertical-align: middle;
				width: 34px;
				font-size: 18px;
				text-align: center;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title .el-submenu__icon-arrow {
				margin: -7px 0 0 0;
				top: 50%;
				color: inherit;
				vertical-align: middle;
				font-size: 12px;
				position: absolute;
				right: 20px;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home .el-menu {
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home .el-menu .el-menu-item {
				padding: 0 40px;
				color: #fff;
				background: #6aab9c;
				font-weight: 600;
				font-size: 16px;
				line-height: 50px;
				height: 50px;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home .el-menu .el-menu-item:hover {
				padding: 0 40px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 50px;
				height: 50px;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.home .el-menu .el-menu-item.is-active {
				padding: 0 40px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 50px;
				height: 50px;
			}
	
	// 竖向 样式二-close-首页
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.home>.el-tooltip {
				cursor: pointer;
				padding: 0 20px;
				color: #333;
				white-space: nowrap;
				background: #fff;
				position: relative;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.home>.el-tooltip:hover {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.home.is-active>.el-tooltip {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title {
				cursor: pointer;
				padding: 0 20px;
				color: #333;
				white-space: nowrap;
				background: #fff;
				position: relative;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title:hover {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title .iconfont {
				margin: 0;
				color: inherit;
				display: inline-block;
				vertical-align: middle;
				width: 24px;
				font-size: 18px;
				text-align: center;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home ::v-deep .el-submenu__title .el-submenu__icon-arrow {
				margin: -7px 0 0 0;
				top: 50%;
				color: inherit;
				display: none;
				vertical-align: middle;
				font-size: 12px;
				position: absolute;
				right: 20px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home .el-menu {
				border: none;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home .el-menu--vertical.home .el-menu-item {
				background-color: rgb(106, 171, 156);
				padding: 0 20px;
				color: #fff;
				line-height: 56px;
				height: 56px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home .el-menu--vertical.home .el-menu-item:hover {
				padding: 0 20px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 56px;
				height: 56px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.home .el-menu--vertical.home .el-menu-item.is-active {
				padding: 0 20px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 56px;
				height: 56px;
			}
	
	// 竖向 样式二-open-个人中心
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.user>.el-tooltip {
				cursor: pointer;
				padding: 0 20px;
				color: #fff;
				white-space: nowrap;
				background: rgb(106, 171, 156);
				font-weight: 600;
				position: relative;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.user>.el-tooltip:hover {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2>.el-menu-item.user.is-active>.el-tooltip {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title {
				cursor: pointer !important;
				padding: 0 20px !important;
				color: #fff !important;
				white-space: nowrap !important;
				background: rgb(106, 171, 156) !important;
				font-weight: 600 !important;
				position: relative !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title:hover {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title .iconfont {
				margin: 0 3px;
				color: inherit;
				display: inline-block;
				vertical-align: middle;
				width: 34px;
				font-size: 18px;
				text-align: center;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title .el-submenu__icon-arrow {
				margin: -7px 0 0 0;
				top: 50%;
				color: inherit;
				vertical-align: middle;
				font-size: 12px;
				position: absolute;
				right: 20px;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 ::v-deep .el-submenu.user .el-menu {
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user .el-menu .el-menu-item {
				padding: 0 40px !important;
				color: #fff !important;
				background: #6aab9c !important;
				font-weight: 600 !important;
				font-size: 16px !important;
				line-height: 50px !important;
				height: 50px !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user .el-menu .el-menu-item:hover {
				padding: 0 40px !important;
				color: #ffe4c7 !important;
				background: #6aab9c !important;
				line-height: 50px !important;
				height: 50px !important;
			}
	
	.scrollbar-wrapper-open .el-menu-vertical-2 .el-submenu.user .el-menu .el-menu-item.is-active {
				padding: 0 40px !important;
				color: #ffe4c7 !important;
				background: #6aab9c !important;
				line-height: 50px !important;
				height: 50px !important;
			}
	
	// 竖向 样式二-close-个人中心
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.user>.el-tooltip {
				cursor: pointer;
				padding: 0 20px;
				color: #333;
				white-space: nowrap;
				background: #fff;
				position: relative;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.user>.el-tooltip:hover {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2>.el-menu-item.user.is-active>.el-tooltip {
				color: #ffe4c7;
				background: #6aab9c;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title {
				cursor: pointer !important;
				padding: 0 20px !important;
				color: #333 !important;
				white-space: nowrap !important;
				background: #fff !important;
				position: relative !important;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title:hover {
				color: #ffe4c7 !important;
				background: #6aab9c !important;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title .iconfont {
				margin: 0;
				color: inherit;
				display: inline-block;
				vertical-align: middle;
				width: 24px;
				font-size: 18px;
				text-align: center;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user ::v-deep .el-submenu__title .el-submenu__icon-arrow {
				margin: -7px 0 0 0;
				top: 50%;
				color: inherit;
				display: none;
				vertical-align: middle;
				font-size: 12px;
				position: absolute;
				right: 20px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user .el-menu {
				border: none;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user .el-menu--vertical.user .el-menu-item {
				background-color: rgb(106, 171, 156);
				padding: 0 20px;
				color: #fff;
				line-height: 56px;
				height: 56px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user .el-menu--vertical.user .el-menu-item:hover {
				padding: 0 20px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 56px;
				height: 56px;
			}
	
	.scrollbar-wrapper-close .el-menu-vertical-2 .el-submenu.user .el-menu--vertical.user .el-menu-item.is-active {
				padding: 0 20px;
				color: #ffe4c7;
				background: #6aab9c;
				line-height: 56px;
				height: 56px;
			}

	.app-sidebar ::v-deep .el-scrollbar__wrap {
		overflow-x: hidden;
	}

	.app-sidebar ::v-deep .el-scrollbar__bar.is-vertical > div {
		background: rgba(255, 255, 255, 0.22);
	}

	.app-sidebar ::v-deep .app-sidebar__toggle {
		width: calc(100% - 24px) !important;
		margin: 14px 12px 10px !important;
		height: 40px !important;
		border-radius: 12px !important;
		border: 1px solid rgba(255, 255, 255, 0.16) !important;
		background: rgba(255, 255, 255, 0.08) !important;
		color: rgba(255, 255, 255, 0.92) !important;
		box-shadow: 0 10px 24px rgba(0, 0, 0, 0.18) !important;
		backdrop-filter: blur(10px);
		display: flex;
		align-items: center;
		gap: 10px;
	}

	.app-sidebar ::v-deep .app-sidebar__toggle:hover {
		background: rgba(255, 255, 255, 0.12) !important;
	}

	.app-sidebar ::v-deep .app-sidebar__user {
		margin: 10px 12px 12px !important;
		padding: 12px 10px !important;
		border-radius: 14px !important;
		background: rgba(255, 255, 255, 0.07) !important;
		border: 1px solid rgba(255, 255, 255, 0.12) !important;
		backdrop-filter: blur(10px);
		display: flex;
		align-items: center;
		gap: 10px;
	}

	.app-sidebar ::v-deep .app-sidebar__avatar {
		width: 36px;
		height: 36px;
		border-radius: 14px;
		object-fit: cover;
	}

	.app-sidebar ::v-deep .app-sidebar__user .el-image {
		box-shadow: 0 10px 22px rgba(0, 0, 0, 0.25);
	}

	.app-sidebar ::v-deep .app-sidebar__name {
		font-size: 14px;
		line-height: 20px;
		font-weight: 700;
		color: rgba(255, 255, 255, 0.92);
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.app-sidebar.is-collapsed ::v-deep .app-sidebar__name {
		display: none;
	}

	.app-sidebar ::v-deep .el-menu {
		border-right: 0 !important;
		background: transparent !important;
	}

	.app-sidebar ::v-deep .app-sidebar__menu {
		padding: 8px 10px 14px !important;
	}

	.app-sidebar ::v-deep .app-sidebar__menu > .el-menu-item,
	.app-sidebar ::v-deep .app-sidebar__menu .el-submenu__title {
		height: 44px !important;
		line-height: 44px !important;
		border-radius: 12px !important;
		margin: 4px 2px !important;
		padding-left: 14px !important;
		padding-right: 14px !important;
		background: transparent !important;
		color: rgba(255, 255, 255, 0.88) !important;
		transition: background-color 0.15s ease, color 0.15s ease, transform 0.15s ease;
	}

	.app-sidebar ::v-deep .app-sidebar__menu > .el-menu-item:hover,
	.app-sidebar ::v-deep .app-sidebar__menu .el-submenu__title:hover {
		background: rgba(255, 255, 255, 0.08) !important;
		transform: translateY(-1px);
	}

	.app-sidebar ::v-deep .app-sidebar__menu > .el-menu-item.is-active,
	.app-sidebar ::v-deep .app-sidebar__menu .el-submenu.is-active > .el-submenu__title {
		background: linear-gradient(135deg, rgba(16, 185, 129, 0.95), rgba(34, 197, 94, 0.9)) !important;
		color: rgba(15, 23, 42, 0.92) !important;
		box-shadow: 0 14px 28px rgba(16, 185, 129, 0.22);
	}

	.app-sidebar ::v-deep .app-sidebar__menu .el-submenu__icon-arrow {
		color: rgba(255, 255, 255, 0.7) !important;
	}

	.app-sidebar ::v-deep .app-sidebar__menu .el-menu--inline {
		background: rgba(2, 6, 23, 0.16) !important;
		border-radius: 12px;
		margin: 6px 2px 8px;
		padding: 6px 6px 8px;
	}

	.app-sidebar ::v-deep .app-sidebar__menu .el-menu--inline .el-menu-item {
		height: 40px !important;
		line-height: 40px !important;
		border-radius: 10px !important;
		margin: 3px 2px !important;
		background: transparent !important;
		color: rgba(226, 232, 240, 0.92) !important;
	}

	.app-sidebar ::v-deep .app-sidebar__menu .el-menu--inline .el-menu-item:hover {
		background: rgba(255, 255, 255, 0.08) !important;
	}

	.app-sidebar ::v-deep .app-sidebar__menu .el-menu--inline .el-menu-item.is-active {
		background: rgba(16, 185, 129, 0.18) !important;
		color: rgba(236, 253, 245, 0.95) !important;
	}
</style>
