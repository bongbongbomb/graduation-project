<template>
	<div class="navbar">
		<div class="navbar-left">
			<div class="navbar-brand">{{this.$project.projectName}}</div>
		</div>

		<div class="navbar-right">
			<div class="navbar-links">
				<div class="nav-pill" @click="handleCommand('')">首页</div>
				<div class="nav-pill" @click="handleCommand('center')">个人中心</div>
				<div v-if="changeHasChat()" class="nav-pill" @click="handleCommand('chat')">聊天记录</div>
			</div>

			<el-dropdown class="user-dropdown" @command="handleCommand" trigger="click">
				<div class="user-trigger">
					<el-image v-if="user" class="user-avatar" :src="avatar?this.$base.url + avatar : require('@/assets/img/avator.png')" fit="cover"></el-image>
					<span class="user-name">{{this.$storage.get('adminName')}}</span>
					<i class="el-icon-arrow-down user-caret"></i>
				</div>
				<el-dropdown-menu slot="dropdown" class="user-menu">
					<el-dropdown-item command="center">个人中心</el-dropdown-item>
					<el-dropdown-item v-if="changeHasChat()" command="chat">聊天记录</el-dropdown-item>
					<el-dropdown-item v-if="this.$storage.get('role')!='管理员'" command="front">退出到前台</el-dropdown-item>
					<el-dropdown-item v-if="this.$storage.get('role')=='管理员'" command="backUp">数据备份</el-dropdown-item>
					<el-dropdown-item divided command="logout">退出登录</el-dropdown-item>
				</el-dropdown-menu>
			</el-dropdown>
		</div>
		<el-dialog :visible.sync="recordVisible" :title="'聊天记录'" :append-to-body="true">
			<div class="z-box" :style='{"width":"70%","padding":"20px","margin":"0 auto"}'>
				<div class="section-content" v-for="item in recordList" :key="item.id" @click="chatClick(item)">
					<img :src="item.picture?$base.url + item.picture:require('@/assets/img/avator.png')" style="width: 60px;border-radius: 50%;"
						alt="">
					<div style="margin: 0 0 0 10px;display: flex;flex-direction: column;align-items: flex-start;">
						<div :style='{"fontSize":"14px","color":"#000","flex":"1","fontWeight":"bold"}'
							class="item-style">{{item.name}}</div>
						<div :style='{"color":"#666","flex":"1","fontSize":"14px","lineHeight":"1.5","display":"flex","alignItems":"center"}'
							class="item-style">
							<div v-if="item.notreadnum" style="padding: 0 5px;height: 16px;border-radius: 50%;text-align: center;line-height: 16px;font-size: 12px;background: #f00;color:#fff;width: auto;margin: 0 2px 0 0">{{item.notreadnum}}</div>
							{{item.content.split('/').length&&item.content.split('/')[0]=='upload'?'[图片]':item.content}}
						</div>
					</div>
				</div>
				<div class="noList" v-if="!recordList.length">
					暂无聊天记录
				</div>
			</div>
		</el-dialog>
		<el-dialog :visible.sync="chatVisible" @close="clearChat" :title="nowname" :append-to-body="true">
			<div class="chat-content" id="chat-content">
				<div v-bind:key="item.id" v-for="item in chatList">
					<div v-if="item.uid==myid" class="right-content">
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="warning"></el-alert>
						<el-image v-else fit="cover" :src="item.content?$base.url + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?$base.url + item.content:'']"></el-image>
						<img :src="avatar?$base.url + avatar:require('@/assets/img/avator.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 0 0 10px;" />
					</div>
					<div v-else class="left-content">
						<img :src="nowfpic?$base.url + nowfpic:require('@/assets/img/avator.png')" alt="" style="width: 30px;border-radius: 50%;height: 30px;margin: 0 10px 0 0;" />
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="success"></el-alert>
						<el-image v-else fit="cover" :src="item.content?$base.url + item.content:''" style="width: 100px;height: 100px;" :preview-src-list="[item.content?$base.url + item.content:'']"></el-image>
					</div>
					<div class="clear-float"></div>
				</div>
			</div>
			<div slot="footer" class="dialog-footer">
				<el-input @keydown.enter.native="addChat" v-model="chatForm.content" placeholder="请输入内容" style="width: calc(100% - 180px);float: left;">
				</el-input>
				<el-button :disabled="chatForm.content?false:true" type="primary" @click="addChat">发送</el-button>
				<el-upload style="display: inline-block;margin: 0 0 0 6px;" class="upload-demo" :action="uploadUrl" :on-success="uploadSuccess"
				    :show-file-list="false">
				    <el-button type="success">上传图片</el-button>
				</el-upload>
			</div>
		</el-dialog>
	</div>
</template>

<script>
	import axios from 'axios'
	export default {
		data() {
			return {
				dialogVisible: false,
				ruleForm: {},
				user: null,
				recordList: [],
				recordVisible: false,
				chatVisible: false,
				nowfid: 0,
				nowfpic:'',
				nowname: '',
				chatList: [],
				chatForm: {
					content: ''
				},
				chatTimer: null,
				uploadUrl: this.$base.url + 'file/upload',
				hasChatList: [
					'xuesheng',
					'qiye',
					'shixigangwei',
				],
			};
		},
		created() {
		},
		computed: {
			avatar(){
				return this.$storage.get('headportrait')?this.$storage.get('headportrait'):''
			},
			myid(){
				return this.$storage.get('userid')?this.$storage.get('userid'):''
			},
		},
		mounted() {
			let sessionTable = this.$storage.get("sessionTable")
			this.$http({
				url: sessionTable + '/session',
				method: "get"
			}).then(({
				data
			}) => {
				if (data && data.code === 0) {
					if(sessionTable == 'xuesheng') {
						this.$storage.set('headportrait',data.data.touxiang)
					}
					if(sessionTable == 'qiye') {
						this.$storage.set('headportrait',data.data.touxiang)
					}
					if(sessionTable == 'users') {
						this.$storage.set('headportrait',data.data.image)
					}
					this.$storage.set('userForm',JSON.stringify(data.data))
					this.user = data.data;
					this.$storage.set('userid',data.data.id);
				} else {
					let message = this.$message
					message.error(data.msg);
				}
			});
		},
		methods: {
			changeHasChat(){
				let table = this.$storage.get('sessionTable')
				for(let x in this.hasChatList){
					if(this.hasChatList[x]==table){
						return true
					}
				}
				return false
			},
			handleCommand(name) {
				if (name == 'front') {
					this.onIndexTap()
				} else if (name == 'logout') {
					this.onLogout()
				} else if (name == 'board'){
					this.toBoard()
				} else if (name == 'backUp'){
					this.backUp()
				} 
				else if (name == 'chat'){
					this.getRecordList()
				}
				else {
					let router = this.$router
					name = '/'+name
					router.push(name)
				}
			},
			getRecordList() {
				this.$http.get('friend/page2', {
					params: {
						uid: this.$storage.get('userid'),
						type: 2
					}
				}).then(res => {
					if (res.data && res.data.code == 0) {
						this.recordList = res.data.data.list
						this.recordVisible = true
					}
				})
			},
			chatClick(row) {
				this.nowfid = row.fid
				this.nowfpic = row.picture
				this.nowname = row.name
				this.getChatList()
				this.chatVisible = true
			},
			getChatList() {
				this.$http.get('chatmessage/mlist', {
					params: {
						page: 1,
						limit: 1000,
						uid: this.$storage.get('userid'),
						fid: this.nowfid
					}
				}).then(res => {
					if (res.data && res.data.code == 0) {
						this.chatList = res.data.data.list
						let div = document.getElementsByClassName('chat-content')[0]
						setTimeout(() => {
							if (div)
								div.scrollTop = div.scrollHeight
						}, 0)
						this.chatTimer = setTimeout(() => {
							this.getChatList()
						}, 5000)
					}
				})
			},
			clearChat(){
				clearTimeout(this.chatTimer)
				this.chatList = []
				this.getRecordList()
			},
			uploadSuccess(res) {
				if (res.code == 0) {
					clearTimeout(this.chatTimer)
					this.$http.post('chatmessage/add', {
						uid: this.$storage.get('userid'),
						fid: this.nowfid,
						content: 'upload/' + res.file,
						format: 2
					}).then(res2 => {
						this.chatForm = {
							content: ''
						}
						this.getChatList()
					})
				}
			},
			addChat() {
				clearTimeout(this.chatTimer)
				this.$http.post('chatmessage/add', {
					uid: this.$storage.get('userid'),
					fid: this.nowfid,
					content: this.chatForm.content,
					format: 1
				}).then(res2 => {
					this.chatForm = {
						content: ''
					}
					this.getChatList()
				})
			},
			onLogout() {
				let storage = this.$storage
				let router = this.$router
				storage.clear()
				this.$store.dispatch('tagsView/delAllViews')
				router.replace({
					name: "login"
				});
			},
			onIndexTap(){
				window.location.href = `${this.$base.indexUrl}`
			},
            backUp() {
                this.$confirm('是否备份数据库?', '数据备份提示', {
                    confirmButtonText: '是',
                    cancelButtonText: '否',
                    type: 'warning'
                }).then(() => {
                    this.$http({
                        url: '/mysqldump',
                        method: "get"
                    }).then(({
                        data
                    }) => {
                        if (data) {
                            const binaryData = [];
                            binaryData.push(data);
                            const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
                                type: 'application/pdf;chartset=UTF-8'
                            }))
                            const a = document.createElement('a')
                            a.href = objectUrl
                            a.download = 'mysql.dmp'
                            // a.click()
                            // 下面这个写法兼容火狐
                            a.dispatchEvent(new MouseEvent('click', {
                                bubbles: true,
                                cancelable: true,
                                view: window
                            }))
                            window.URL.revokeObjectURL(data)
                            message.message("数据备份成功")
                        } else {
                            let message = this.$message
                            message.error(data.msg);
                        }
                    });
                });
            },
		}
	};
</script>


<style lang="scss" scoped>
	.navbar {
		height: 100%;
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 0 18px;
		color: rgba(15, 23, 42, 0.92);
		background: rgba(255, 255, 255, 0.72);
		border-bottom: 1px solid rgba(15, 23, 42, 0.06);
		backdrop-filter: blur(10px);
	}

	.navbar-left {
		display: flex;
		align-items: center;
		min-width: 180px;
	}

	.navbar-brand {
		font-size: 18px;
		line-height: 24px;
		font-weight: 800;
		letter-spacing: 0.4px;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.navbar-right {
		display: flex;
		align-items: center;
		gap: 12px;
	}

	.navbar-links {
		display: flex;
		align-items: center;
		gap: 8px;
	}

	.nav-pill {
		cursor: pointer;
		padding: 8px 12px;
		border-radius: 999px;
		font-size: 14px;
		line-height: 18px;
		font-weight: 700;
		color: rgba(15, 23, 42, 0.86);
		background: rgba(15, 23, 42, 0.04);
		border: 1px solid rgba(15, 23, 42, 0.06);
		user-select: none;
		transition: background-color 0.15s ease, transform 0.15s ease, border-color 0.15s ease;
	}

	.nav-pill:hover {
		background: rgba(16, 185, 129, 0.14);
		border-color: rgba(16, 185, 129, 0.25);
		transform: translateY(-1px);
	}

	.user-trigger {
		display: flex;
		align-items: center;
		gap: 10px;
		cursor: pointer;
		padding: 6px 10px;
		border-radius: 12px;
		background: rgba(15, 23, 42, 0.04);
		border: 1px solid rgba(15, 23, 42, 0.06);
		user-select: none;
	}

	.user-avatar {
		width: 32px;
		height: 32px;
		border-radius: 12px;
		object-fit: cover;
		box-shadow: 0 10px 22px rgba(15, 23, 42, 0.12);
	}

	.user-name {
		max-width: 140px;
		font-size: 14px;
		line-height: 18px;
		font-weight: 800;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}

	.user-caret {
		font-size: 12px;
		color: rgba(15, 23, 42, 0.55);
	}

	@media (max-width: 900px) {
		.navbar-links {
			display: none;
		}
	}

	@media (prefers-color-scheme: dark) {
		.navbar {
			color: rgba(226, 232, 240, 0.9);
			background: rgba(15, 23, 42, 0.72);
			border-bottom-color: rgba(148, 163, 184, 0.14);
		}
		.nav-pill {
			color: rgba(226, 232, 240, 0.88);
			background: rgba(148, 163, 184, 0.08);
			border-color: rgba(148, 163, 184, 0.14);
		}
		.user-trigger {
			background: rgba(148, 163, 184, 0.08);
			border-color: rgba(148, 163, 184, 0.14);
		}
		.user-caret {
			color: rgba(226, 232, 240, 0.55);
		}
	}

	.top-el-dropdown-menu-2 div.item1 {
				padding: 0 3px;
				color: inherit;
				font-weight: 600;
				display: none;
				font-size: inherit;
				line-height: 32px;
			}

	.top-el-dropdown-menu-2 div.item1:hover {
				color: #ffe4c7;
			}
	
	.top-el-dropdown-menu-2 div.item2 {
				padding: 0 3px;
				color: inherit;
				font-weight: 600;
				display: none;
				font-size: inherit;
				line-height: 32px;
			}
	
	.top-el-dropdown-menu-2 div.item2:hover {
				color: #ffe4c7;
			}
	
	.top-el-dropdown-menu-2 div.item3 {
				cursor: pointer;
				padding: 0 3px;
				margin: 0 10px 0 0;
				color: inherit;
				font-weight: 500;
				font-size: inherit;
				line-height: 32px;
			}
	
	.top-el-dropdown-menu-2 div.item3:hover {
			}
	
	.top-el-dropdown-menu-2 div.item4 {
				cursor: pointer;
				padding: 0 3px;
				color: inherit;
				font-weight: 500;
				font-size: inherit;
				line-height: 32px;
			}
	
	.top-el-dropdown-menu-2 div.item4:hover {
			}
	.top-el-dropdown-menu-2 div.item5 {
				cursor: pointer;
				padding: 0 3px;
				margin: 0 10px 0 0;
				color: inherit;
				font-size: inherit;
				line-height: 32px;
			}
	
	.top-el-dropdown-menu-2 div.item5:hover {
			}
	.top-el-dropdown-menu-2 div.item6 {
				cursor: pointer;
				padding: 0 3px;
				margin: 0 10px 0 0;
				color: inherit;
				font-size: inherit;
				line-height: 32px;
			}
	
	.top-el-dropdown-menu-2 div.item6:hover {
			}
	.section-content {
		cursor: pointer;
		padding: 20px;
		box-shadow: 0px 4px 10px 0px rgba(0, 0, 0, 0.3);
		margin: 0 0 20px;
		color: #333;
		background: #fff;
		display: flex;
		width: 100%;
		border-color: #efefef;
		border-width: 0;
		align-items: center;
		border-style: solid;
		position: relative;
	}
	
	.section-content:hover {
		color: #fff;
		background: #DF847F10;
	}
	.chat-content {
		padding-bottom: 20px;
		width: 100%;
		margin-bottom: 10px;
		max-height: 300px;
		height: 300px;
		overflow-y: scroll;
		border: 1px solid #eeeeee;
		background: #fff;
	
		.left-content {
			float: left;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}
	
		.right-content {
			float: right;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}
	}
	
	.clear-float {
		clear: both;
	}
	.noList {
		color: #9e9e9e;
		width: 100%;
		text-align: center;
		padding: 60px 0;
	}
</style>
