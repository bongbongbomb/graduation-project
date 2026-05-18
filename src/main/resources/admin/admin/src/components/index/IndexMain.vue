<template>
	<div style="height: 100%;">
		<el-main class="layout-main" :class="{ 'is-collapsed': isCollapse }">
			<index-aside class="layout-aside" :is-collapse="isCollapse" @oncollapsechange="collapseChange"></index-aside>
			<index-header class="layout-header"></index-header>
			<div class="layout-body">
				<bread-crumbs class="layout-breadcrumb" :title="title"></bread-crumbs>
				<tags-view />
				<router-view class="router-view"></router-view>
			</div>
		</el-main>
	</div>
</template>

<script>
	import IndexAside from '@/components/index/IndexAsideStatic'
	import IndexHeader from '@/components/index/IndexHeader'
	import TagsView from '@/components/index/TagsView'
	import menu from "@/utils/menu";
	export default {
		components: {
			IndexAside,
			IndexHeader,
			TagsView
		},
		data() {
			return {
				menuList: [],
				role: "",
				currentIndex: -2,
				itemMenu: [],
				title: '',
				isCollapse: false,
			};
		},
		mounted() {
			let menus = menu.list();
			this.menuList = menus;
			this.role = this.$storage.get("role");
		},
		created() {
			this.init();
		},
		methods: {
			init(){
				this.$nextTick(()=>{
					
				})
			},
			collapseChange(collapse) {
				this.isCollapse = collapse
			},
			menuHandler(menu) {
				this.$router.push({
					name: menu.tableName
				});
				this.title = menu.menu;
			},
			titleChange(index, menus) {
				this.currentIndex = index
				this.itemMenu = menus;
			},
			homeChange(index) {
				this.itemMenu = [];
				this.title = ""
				this.currentIndex = index
				this.$router.push({
					name: 'home'
				});
			},
			centerChange(index) {
				this.itemMenu = [{
					"buttons": ["新增", "查看", "修改", "删除"],
					"menu": "修改密码",
					"tableName": "updatePassword"
				}, {
					"buttons": ["新增", "查看", "修改", "删除"],
					"menu": "个人信息",
					"tableName": "center"
				}];
				this.title = ""
				this.currentIndex = index
				this.$router.push({
					name: 'home'
				});
				
			}
		}
	};
</script>
<style lang="scss" scoped>
	a {
		text-decoration: none;
		color: #555;
	}

	a:hover {
		background: #00c292;
	}
	
	.el-main {
		padding: 0;
		display: block;
	}

	.layout-main {
		--sidebar-width: 228px;
		--sidebar-width-collapsed: 72px;
		--header-height: 64px;

		min-height: 100%;
		background: #f6f8fb;
		padding-left: var(--sidebar-width);
	}

	.layout-main.is-collapsed {
		padding-left: var(--sidebar-width-collapsed);
	}

	.layout-aside {
		position: fixed;
		top: 0;
		left: 0;
		bottom: 0;
		width: var(--sidebar-width);
		z-index: 1001;
		overflow: hidden;
		transition: width 0.3s ease;
		background: linear-gradient(180deg, #0f172a 0%, #111827 100%);
		box-shadow: 0 18px 50px rgba(15, 23, 42, 0.28);
	}

	.layout-main.is-collapsed .layout-aside {
		width: var(--sidebar-width-collapsed);
	}

	.layout-header {
		position: fixed;
		top: 0;
		right: 0;
		left: var(--sidebar-width);
		height: var(--header-height);
		z-index: 1000;
		transition: left 0.3s ease;
	}

	.layout-main.is-collapsed .layout-header {
		left: var(--sidebar-width-collapsed);
	}

	.layout-body {
		padding-top: var(--header-height);
		min-height: 100%;
	}

	.layout-breadcrumb {
		padding: 12px 0;
		margin: 0 auto;
		width: calc(100% - 48px);
		background: transparent;
	}

	.nav-list {
		width: 100%;
		margin: 0 auto;
		text-align: left;
		margin-top: 20px;

		.nav-title {
			display: inline-block;
			font-size: 15px;
			color: #333;
			padding: 15px 25px;
			border: none;
		}

		.nav-title.active {
			color: #555;
			cursor: default;
			background-color: #fff;
		}
	}

	.nav-item {
		margin-top: 20px;
		background: #FFFFFF;
		padding: 15px 0;

		.menu {
			padding: 15px 25px;
		}
	}
	
	.detail-form-content {
	    background: transparent;
	}
</style>
