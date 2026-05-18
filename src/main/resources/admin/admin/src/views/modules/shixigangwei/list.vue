<template>
	<div class="main-content" :style='{"padding":"20px 30px","background":"#f9fbfd","flexDirection":"column","display":"flex"}'>
		<!-- 列表页 -->
		<template v-if="showFlag">
			<el-form class="center-form-pv" :style='{"margin":"0 0 20px","alignItems":"center","flexWrap":"wrap","display":"flex"}' :inline="true" :model="searchForm">
				<el-row :style='{"margin":"0 10px 0 0","display":"flex"}' >
					<div :style='{"margin":"0 10px 0 0","display":"flex"}'>
						<label :style='{"margin":"0 10px 0 0","color":"#666","display":"none","lineHeight":"40px","fontSize":"16px","fontWeight":"500","height":"40px"}' class="item-label">实习名称</label>
						<el-input v-model="searchForm.shiximingcheng" placeholder="实习名称" @keydown.enter.native="search()" clearable></el-input>
					</div>
					<div :style='{"margin":"0 10px 0 0","display":"flex"}' class="select" label="岗位类型" prop="gangweileixing">
						<label :style='{"margin":"0 10px 0 0","color":"#666","display":"none","lineHeight":"40px","fontSize":"16px","fontWeight":"500","height":"40px"}' class="item-label">岗位类型</label>
						<el-select clearable v-model="searchForm.gangweileixing" placeholder="请选择岗位类型" >
							<el-option v-for="(item,index) in gangweileixingOptions" v-bind:key="index" :label="item" :value="item"></el-option>
						</el-select>
					</div>
					<div :style='{"margin":"0 10px 0 0","display":"flex"}' class="select">
						<label :style='{"margin":"0 10px 0 0","color":"#666","display":"none","lineHeight":"40px","fontSize":"16px","fontWeight":"500","height":"40px"}' class="item-label">是否通过</label>
						<el-select clearable v-model="searchForm.sfsh" placeholder="是否通过">
							<el-option v-for="(item,index) in sfshOptions" v-bind:key="index" :label="item" :value="item"></el-option>
						</el-select>
					</div>
					<el-button class="search" type="success" @click="search()">
						<span class="icon iconfont icon-fangdajing07" :style='{"margin":"0 2px","fontSize":"16px","color":"#fff","height":"40px"}'></span>
						查询
					</el-button>
				</el-row>

				<el-row class="actions" :style='{"flexWrap":"wrap","margin":"0","display":"flex"}'>
					<el-button class="add" v-if="isAuth('shixigangwei','新增')" type="success" @click="addOrUpdateHandler()">
						<span class="icon iconfont icon-tianjia10" :style='{"margin":"0 2px","fontSize":"14px","color":"#fff","fontWeight":"600","height":"40px"}'></span>
						添加
					</el-button>
					<el-button class="del" v-if="isAuth('shixigangwei','删除')" :disabled="dataListSelections.length?false:true" type="danger" @click="deleteHandler()">
						<span class="icon iconfont icon-shanchu1" :style='{"margin":"0 2px","fontSize":"14px","color":"#ffffff","fontWeight":"600","height":"40px"}'></span>
						删除
					</el-button>


					<el-button class="btn18" v-if="isAuth('shixigangwei','审核')" :disabled="dataListSelections.length?false:true" type="success" @click="shBatchDialog()">
						<span class="icon iconfont icon-shenhe9" :style='{"margin":"0 2px","fontSize":"14px","color":"rgb(106, 171, 156)","height":"40px"}'></span>
						审核
					</el-button>

					<el-button class="btn18" v-if="isAuth('shixigangwei','岗位类型统计')" type="success" @click="chartDialog1()">
						<span class="icon iconfont icon-xihuan" :style='{"margin":"0 2px","fontSize":"14px","color":"rgb(106, 171, 156)","height":"40px"}'></span>
						岗位类型统计
					</el-button>
					<el-button class="btn18" v-if="isAuth('shixigangwei','岗位薪资统计')" type="success" @click="chartDialog2()">
						<span class="icon iconfont icon-xihuan" :style='{"margin":"0 2px","fontSize":"14px","color":"rgb(106, 171, 156)","height":"40px"}'></span>
						岗位薪资统计
					</el-button>
				</el-row>
			</el-form>
			<div :style='{"width":"100%","padding":"0"}'>
				<el-table class="tables"
					:stripe='true'
					:style='{"width":"100%","padding":"0","borderColor":"#eee","borderStyle":"solid","borderWidth":"1px 0 0 1px","background":"#fff"}' 
					:border='true'
					v-if="isAuth('shixigangwei','查看')"
					:data="dataList"
					v-loading="dataListLoading"
				@selection-change="selectionChangeHandler">
					<el-table-column :resizable='true' type="selection" align="center" width="50"></el-table-column>
					<el-table-column :resizable='true' :sortable='true' label="序号" type="index" width="50" />
					<el-table-column :resizable='true' :sortable='true'  
						prop="qiyemingcheng"
						label="企业名称">
						<template slot-scope="scope">
							{{scope.row.qiyemingcheng}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="shiximingcheng"
						label="实习名称">
						<template slot-scope="scope">
							{{scope.row.shiximingcheng}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="gangweileixing"
						label="岗位类型">
						<template slot-scope="scope">
							{{scope.row.gangweileixing}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="fengmian" width="200" label="封面">
						<template slot-scope="scope">
							<div v-if="scope.row.fengmian">
								<img v-if="scope.row.fengmian.substring(0,4)=='http'" :src="scope.row.fengmian.split(',')[0]" width="100" height="100" style="object-fit: cover" @click="imgPreView(scope.row.fengmian.split(',')[0])">
								<img v-else :src="$base.url+scope.row.fengmian.split(',')[0]" width="100" height="100" style="object-fit: cover" @click="imgPreView($base.url+scope.row.fengmian.split(',')[0])">
							</div>
							<div v-else>无图片</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="shixigangwei"
						label="实习岗位">
						<template slot-scope="scope">
							{{scope.row.shixigangwei}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="gangweiyaoqiu"
						label="岗位要求">
						<template slot-scope="scope">
							{{scope.row.gangweiyaoqiu}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="xinzidaiyu"
						label="薪资待遇">
						<template slot-scope="scope">
							{{scope.row.xinzidaiyu}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="gongzuodidian"
						label="工作地点">
						<template slot-scope="scope">
							{{scope.row.gongzuodidian}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="qiyezhanghao"
						label="企业账号">
						<template slot-scope="scope">
							{{scope.row.qiyezhanghao}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true'  
						prop="fuzeren"
						label="负责人">
						<template slot-scope="scope">
							{{scope.row.fuzeren}}
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="shhf" label="审核回复" show-overflow-tooltip>
						<template slot-scope="scope">
							<div style="white-space: nowrap;">{{scope.row.shhf}}</div>
						</template>
					</el-table-column>
					<el-table-column :resizable='true' :sortable='true' prop="sfsh" label="审核状态">
						<template slot-scope="scope">
							<el-tag v-if="scope.row.sfsh=='否'" type="danger">未通过</el-tag>
							<el-tag v-if="scope.row.sfsh=='待审核'" type="warning">待审核</el-tag>
							<el-tag v-if="scope.row.sfsh=='是'" type="success">通过</el-tag>
						</template>
					</el-table-column>
					
					<el-table-column width="300" label="操作">
						<template slot-scope="scope">
							<el-button class="view" v-if=" isAuth('shixigangwei','查看')" type="success" @click="addOrUpdateHandler(scope.row.id,'info')">
								<span class="icon iconfont icon-chakan2" :style='{"margin":"0 0px","fontSize":"15px","color":"#fff","height":"40px"}'></span>
								查看
							</el-button>
							<el-button class="btn8" v-if="isAuth('shixigangwei','申请')" @click="shixishenqingCrossAddOrUpdateHandler(scope.row,'cross','','','[1]','已申请')" type="success">
								<span class="icon iconfont icon-xihuan" :style='{"margin":"0 0px","fontSize":"15px","color":"#212529","height":"40px"}'></span>
								申请
							</el-button>
							<el-button class="edit" v-if=" isAuth('shixigangwei','修改')  && scope.row.sfsh=='待审核' " type="success" @click="addOrUpdateHandler(scope.row.id)">
								<span class="icon iconfont icon-xiugai17" :style='{"margin":"0 0px","fontSize":"15px","color":"#fff","height":"40px"}'></span>
								修改
							</el-button>

							<el-button class="btn8" v-if="isAuth('shixigangwei','私聊')" type="success" @click="chatClick(scope.row)">
								<span class="icon iconfont icon-zhangjie8" :style='{"margin":"0 0px","fontSize":"15px","color":"#212529","height":"40px"}'></span>
								私聊
							</el-button>



							<el-button class="del" v-if="isAuth('shixigangwei','删除') " type="primary" @click="deleteHandler(scope.row.id )">
								<span class="icon iconfont icon-shanchu8" :style='{"margin":"0 2px","fontSize":"15px","color":"#fff","height":"40px"}'></span>
								删除
							</el-button>
						</template>
					</el-table-column>
				</el-table>
			</div>
			<el-pagination
				@size-change="sizeChangeHandle"
				@current-change="currentChangeHandle"
				:current-page="pageIndex"
				background
				:page-sizes="[10, 50, 100, 200]"
				:page-size="pageSize"
				:layout="layouts.join()"
				:total="totalPage"
				prev-text="上一页 "
				next-text="下一页 "
				:hide-on-single-page="false"
				:style='{"width":"100%","padding":"0","margin":"20px 0 0","whiteSpace":"nowrap","color":"#333","fontWeight":"500"}'
			></el-pagination>
		</template>
		
		<!-- 添加/修改页面  将父组件的search方法传递给子组件-->
		<add-or-update v-if="addOrUpdateFlag" :parent="this" ref="addOrUpdate"></add-or-update>

		<shixishenqing-cross-add-or-update v-if="shixishenqingCrossAddOrUpdateFlag" :parent="this" ref="shixishenqingCrossaddOrUpdate"></shixishenqing-cross-add-or-update>

		
		<el-dialog :title="this.batchIds.length>1?'批量审核':'审核'" :visible.sync="sfshBatchVisiable" width="50%">
			<el-form ref="shBatchForm" :model="shBatchForm" :rules="shRules" label-width="80px">
				<el-form-item label="审核状态" prop="sfsh">
					<el-select v-model="shBatchForm.sfsh" placeholder="审核状态">
						<el-option label="通过" value="是"></el-option>
						<el-option label="不通过" value="否"></el-option>
						<el-option label="待审核" value="待审核"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label="内容" prop="shhf">
					<el-input type="textarea" :rows="8" v-model="shBatchForm.shhf"></el-input>
				</el-form-item>
			</el-form>
			<span slot="footer" class="dialog-footer">
				<el-button @click="sfshBatchVisiable=false">取 消</el-button>
				<el-button type="primary" @click="shBatchHandler">确 定</el-button>
			</span>
		</el-dialog>


		<el-dialog
		  :visible.sync="chartVisiable1"
		  width="800">
			<div id="gangweileixingChart1" style="width:100%;height:600px;"></div>
		  <span slot="footer" class="dialog-footer">
			<el-button @click="chartDialog1">返回</el-button>
		  </span>
		</el-dialog>
		<el-dialog
		  :visible.sync="chartVisiable2"
		  width="800">
			<div id="xinzidaiyuChart2" style="width:100%;height:600px;"></div>
		  <span slot="footer" class="dialog-footer">
			<el-button @click="chartDialog2">返回</el-button>
		  </span>
		</el-dialog>

		<el-dialog :visible.sync="chatVisible" @close="clearChat" :title="nowname" :append-to-body="true">
			<div class="chat-content" id="chat-content">
				<div v-bind:key="item.id" v-for="item in chatList">
					<div v-if="item.uid==myid" class="right-content">
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="warning"></el-alert>
						<el-image v-else fit="cover" :src="item.content?$base.url + item.content:''"
							style="width: 100px;height: 100px;"
							:preview-src-list="[item.content?$base.url + item.content:'']"></el-image>
						<img :src="avatar?$base.url + avatar:require('@/assets/img/avator.png')" alt=""
							style="width: 30px;border-radius: 50%;height: 30px;margin: 0 0 0 10px;" />
					</div>
					<div v-else class="left-content">
						<img :src="nowfpic?$base.url + nowfpic:require('@/assets/img/avator.png')" alt=""
							style="width: 30px;border-radius: 50%;height: 30px;margin: 0 10px 0 0;" />
						<el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
							type="success"></el-alert>
						<el-image v-else fit="cover" :src="item.content?$base.url + item.content:''"
							style="width: 100px;height: 100px;"
							:preview-src-list="[item.content?$base.url + item.content:'']"></el-image>
					</div>
					<div class="clear-float"></div>
				</div>
			</div>
			<div slot="footer" class="dialog-footer">
				<el-input @keydown.enter.native="addChat" v-model="chatForm.content" placeholder="请输入内容"
					style="width: calc(100% - 180px);float: left;">
				</el-input>
				<el-button :disabled="chatForm.content?false:true" type="primary" @click="addChat">发送</el-button>
				<el-upload style="display: inline-block;margin: 0 0 0 6px;" class="upload-demo" :action="uploadUrl"
					:on-success="uploadSuccess" :show-file-list="false">
					<el-button type="success">上传图片</el-button>
				</el-upload>
			</div>
		</el-dialog>
		<el-dialog title="预览图" :visible.sync="previewVisible" width="50%">
			<img :src="previewImg" alt="" style="width: 100%;">
		</el-dialog>
	</div>
</template>

<script>
import * as echarts from 'echarts'
import chinaJson from "@/components/echarts/china.json";
import axios from 'axios'
import AddOrUpdate from "./add-or-update";
import shixishenqingCrossAddOrUpdate from "../shixishenqing/add-or-update";
	export default {
		data() {
			return {
				gangweileixingOptions: [],
				searchForm: {
					key: ""
				},
				form:{},
				sfshOptions: [],
				dataList: [],
				pageIndex: 1,
				pageSize: 10,
				totalPage: 0,
				dataListLoading: false,
				dataListSelections: [],
				showFlag: true,
				sfshVisiable: false,
				shForm: {},
				sfshBatchVisiable: false,
				shBatchForm: {
					sfsh:'',
					shhf:''
				},
				shRules: {
					sfsh:[{ required: true, message: '审核状态不能为空', trigger: 'blur' },],
					shhf:[{ required: true, message: '审核回复不能为空', trigger: 'blur' },],
				},
				batchIds:[], 
				chartVisiable1: false,
				chartVisiable2: false,
				addOrUpdateFlag:false,
				shixishenqingCrossAddOrUpdateFlag: false,
				layouts: ["total","prev","pager","next","sizes","jumper"],
				chatVisible: false,
				nowfid: 0,
				nowfpic: '',
				nowname: '',
				chatList: [],
				chatForm: {
					content: ''
				},
				chatTimer: null,
				uploadUrl: this.$base.url + 'file/upload',
				previewImg: '',
				previewVisible: false,
			};
		},
		created() {
			this.init();
			this.getDataList();
			this.contentStyleChange()
		},
		mounted() {
		},
		filters: {
			htmlfilter: function (val) {
				return val.replace(/<[^>]*>/g).replace(/undefined/g,'');
			}
		},
		computed: {
			tablename(){
				return this.$storage.get('sessionTable')
			},
			avatar() {
				return this.$storage.get('headportrait') ? this.$storage.get('headportrait') : ''
			},
			myid() {
				return this.$storage.get('userid') ? this.$storage.get('userid') : ''
			},
		},
		components: {
			AddOrUpdate,
			shixishenqingCrossAddOrUpdate,
		},
		methods: {
			imgPreView(url){
				this.previewImg = url
				this.previewVisible = true
			},
			chatClick(row) {
				if(row.id == this.myid){
					this.$message.error('不能给自己发消息！')
					return false
				}
				this.nowfid = row.id
				if(row.touxiang){
					this.nowfpic = row.touxiang.split(',')[0]
				}else if(row.headportrait){
					this.nowfpic = row.headportrait.split(',')[0]
				}
				this.getChatList()
				this.chatVisible = true
			},
			getChatList() {
				this.$http.get('chatmessage/mlist', {
					params: {
						page: 1,
						limit: 1000,
						uid: this.myid,
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
			clearChat() {
				clearTimeout(this.chatTimer)
				this.chatList = []
				this.getRecordList()
			},
			uploadSuccess(res) {
				if (res.code == 0) {
					clearTimeout(this.chatTimer)
					this.$http.get('friend/page', {
						params: {
							uid: this.myid,
							fid: this.nowfid,
						}
					}).then(obj => {
						if (obj.data && obj.data.code == 0) {
							if (!obj.data.data.list.length) {
								this.$http.post('friend/add', {
									uid: this.myid,
									fid: this.nowfid,
									name: this.nowname,
									picture: this.nowfpic,
									type: 2,
									tablename: 'shixigangwei',
								}).then(res => {
									this.$http.post('friend/add', {
										uid: this.nowfid,
										fid: this.myid,
										type: 2,
										tablename: this.tablename,
										name: this.$storage.get('adminName'),
										picture: this.avatar,
									}).then(res1 => {
			
									})
								})
							}
							this.$http.post('chatmessage/add', {
								uid: this.myid,
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
					})
				}
			},
			addChat() {
				clearTimeout(this.chatTimer)
				this.$http.get('friend/page', {
					params: {
						uid: this.myid,
						fid: this.nowfid,
					}
				}).then(obj => {
					if (obj.data && obj.data.code == 0) {
						if (!obj.data.data.list.length) {
							this.$http.post('friend/add', {
								uid: this.myid,
								fid: this.nowfid,
								name: this.nowname,
								picture: this.nowfpic,
								type: 2,
								tablename: 'shixigangwei',
							}).then(res => {
								this.$http.post('friend/add', {
									uid: this.nowfid,
									fid: this.myid,
									type: 2,
									tablename: this.tablename,
									name: this.$storage.get('adminName'),
									picture: this.avatar,
								}).then(res1 => {
			
								})
							})
						}
						this.$http.post('chatmessage/add', {
							uid: this.myid,
							fid: this.nowfid,
							content: this.chatForm.content,
							format: 1
						}).then(res2 => {
							this.chatForm = {
								content: ''
							}
							this.getChatList()
						})
					}
				})
			},
			contentStyleChange() {
				this.contentPageStyleChange()
			},
			// 分页
			contentPageStyleChange(){
				let arr = []

				// if(this.contents.pageTotal) arr.push('total')
				// if(this.contents.pageSizes) arr.push('sizes')
				// if(this.contents.pagePrevNext){
				//   arr.push('prev')
				//   if(this.contents.pagePager) arr.push('pager')
				//   arr.push('next')
				// }
				// if(this.contents.pageJumper) arr.push('jumper')
				// this.layouts = arr.join()
				// this.contents.pageEachNum = 10
			},
			shixishenqingCrossAddOrUpdateHandler(row,type,crossOptAudit,crossOptPay,statusColumnName,tips,statusColumnValue){
				if(crossOptAudit=='是'&&row.sfsh!='是') {
					this.$message({
						message: "请审核通过后再操作",
						type: "success",
						duration: 1500,
						onClose: () => {
						}
					});
					return
				}
				this.showFlag = false;
				this.addOrUpdateFlag = false;
				this.shixishenqingCrossAddOrUpdateFlag = true;
				this.$storage.set('crossObj',row);
				this.$storage.set('crossTable','shixigangwei');
				this.$storage.set('statusColumnName',statusColumnName);
				this.$storage.set('statusColumnValue',statusColumnValue);
				this.$storage.set('tips',tips);
				if(statusColumnName!=''&&!statusColumnName.startsWith("[")) {
					var obj = this.$storage.getObj('crossObj');
					for (var o in obj){
						if(o==statusColumnName && obj[o]==statusColumnValue){
							this.$message({
								message: tips,
								type: "success",
								duration: 1500,
								onClose: () => {
									this.getDataList();
								}
							});
							this.showFlag = true;
							this.shixishenqingCrossAddOrUpdateFlag = false;
							return;
						}
					}
				}
				this.$nextTick(() => {
					this.$refs.shixishenqingCrossaddOrUpdate.init(row.id,type);
				});
			},


		//统计接口
		chartDialog1() {
			this.chartVisiable1 = !this.chartVisiable1;
			this.$nextTick(()=>{
				var gangweileixingChart1 = echarts.init(document.getElementById("gangweileixingChart1"),'macarons');
				this.$http({
					url: "shixigangwei/group/gangweileixing",
					method: "get",
				}).then(({ data }) => {
					if (data && data.code === 0) {
						let res = data.data;
						let xAxis = [];
						let yAxis = [];
						let pArray = []
						for(let i=0;i<res.length;i++){
							xAxis.push(res[i].gangweileixing);
							yAxis.push(parseFloat((res[i].total)));
							pArray.push({
								value: parseFloat((res[i].total)),
								name: res[i].gangweileixing
							})
						}
						var option = {};
						option = {
							title: {
								text: '岗位类型统计',
								left: 'center'
							},
							legend: {
							  orient: 'vertical',
							  left: 'left'
							},
							tooltip: {
							  trigger: 'item',
							  formatter: '{b} : {c} ({d}%)'
							},
							series: [
								{
									type: 'pie',
									radius: '55%',
									center: ['50%', '60%'],
									data: pArray,
									emphasis: {
										itemStyle: {
											shadowBlur: 10,
											shadowOffsetX: 0,
											shadowColor: 'rgba(0, 0, 0, 0.5)'
										}
									}
								}
							]
						};
						// 使用刚指定的配置项和数据显示图表。
						gangweileixingChart1.setOption(option);
						  //根据窗口的大小变动图表
						window.onresize = function() {
							gangweileixingChart1.resize();
						};
					}
				});
			})
		},

		//统计接口
		chartDialog2() {
			this.chartVisiable2 = !this.chartVisiable2;
			this.$nextTick(()=>{

				var xinzidaiyuChart2 = echarts.init(document.getElementById("xinzidaiyuChart2"),'macarons');
				this.$http({
					url: `shixigangwei/value/gangweileixing/xinzidaiyu`,
					method: "get",
				}).then(({ data }) => {
					if (data && data.code === 0) {
						let res = data.data;
						let xAxis = [];
						let yAxis = [];
						let pArray = []
						for(let i=0;i<res.length;i++){
							xAxis.push(res[i].gangweileixing);
							yAxis.push(parseFloat((res[i].total)));
							pArray.push({
								value: parseFloat((res[i].total)),
								name: res[i].gangweileixing
							})
						}
						var option = {};
						option = {
							title: {
								text: '岗位薪资统计',
								left: 'center'
							},
							tooltip: {
							  trigger: 'item',
							  formatter: '{b} : {c}'
							},
							xAxis: {
								type: 'category',
								boundaryGap: false,
								data: xAxis
							},
							yAxis: {
								type: 'value'
							},
							series: [{
								data: yAxis,
								type: 'line',
								areaStyle: {},
								smooth: true
							}]
						};
						// 使用刚指定的配置项和数据显示图表。
						xinzidaiyuChart2.setOption(option);
						  //根据窗口的大小变动图表
						window.onresize = function() {
							xinzidaiyuChart2.resize();
						};
					}
				});
			})
		},



		init () {
			this.sfshOptions = "是,否,待审核".split(',');
			this.$http({
				url: `option/gangweileixing/gangweileixing`,
				method: "get"
			}).then(({ data }) => {
				if (data && data.code === 0) {
					this.gangweileixingOptions = data.data;
				} else {
					this.$message.error(data.msg);
				}
			});
		},
		search() {
			this.pageIndex = 1;
			this.getDataList();
		},

		// 获取数据列表
		getDataList() {
			this.dataListLoading = true;
			let params = {
				page: this.pageIndex,
				limit: this.pageSize,
				sort: 'id',
				order: 'desc',
			}
 			if(this.searchForm.shiximingcheng!='' && this.searchForm.shiximingcheng!=undefined){
				params['shiximingcheng'] = '%' + this.searchForm.shiximingcheng + '%'
			}
			if(this.searchForm.gangweileixing!='' && this.searchForm.gangweileixing!=undefined){
				params['gangweileixing'] = this.searchForm.gangweileixing
			}
			if(this.searchForm.sfsh!='' && this.searchForm.sfsh!=undefined){
				params['sfsh'] = this.searchForm.sfsh
			}
			let user = JSON.parse(this.$storage.getObj('userForm'))
			this.$http({
				url: "shixigangwei/page",
				method: "get",
				params: params
			}).then(({ data }) => {
				if (data && data.code === 0) {
					this.dataList = data.data.list;
					this.totalPage = data.data.total;
				} else {
					this.dataList = [];
					this.totalPage = 0;
				}
				this.dataListLoading = false;
			});
		},
		// 每页数
		sizeChangeHandle(val) {
			this.pageSize = val;
			this.pageIndex = 1;
			this.getDataList();
		},
		// 当前页
		currentChangeHandle(val) {
			this.pageIndex = val;
			this.getDataList();
		},
		// 多选
		selectionChangeHandler(val) {
			this.dataListSelections = val;
		},
		// 添加/修改
		addOrUpdateHandler(id,type) {
			this.showFlag = false;
			this.addOrUpdateFlag = true;
			this.crossAddOrUpdateFlag = false;
			if(type!='info'){
				type = 'else';
			}
			this.$nextTick(() => {
				this.$refs.addOrUpdate.init(id,type);
			});
		},
		//批量审核窗口
		shBatchDialog(){
			for(let x in this.dataListSelections){
				if(this.dataListSelections[x].sfsh&&this.dataListSelections[x].sfsh!='待审核'){
					this.$message.error('存在已审核数据，不能继续操作');
					this.batchIds = []
					return false
				}
				this.batchIds.push(this.dataListSelections[x].id)
			}
			this.sfshBatchVisiable = true
		  
		},
		//批量审核
		shBatchHandler(){
			this.$refs["shBatchForm"].validate(valid => {
				if(valid){
					this.$confirm(`是否${this.batchIds.length>1?'一键审核':'审核'}选中数据?`, "提示", {
						confirmButtonText: "确定",
						cancelButtonText: "取消",
						type: "warning"
					}).then(() => {
						this.$http({
							url: "shixigangwei/shBatch?sfsh="+this.shBatchForm.sfsh+"&shhf="+this.shBatchForm.shhf,
							method: "post",
							data: this.batchIds
						}).then(({ data }) => {
							if (data && data.code === 0) {
								this.$message({
									message: "操作成功",
									type: "success",
									duration: 1500,
									onClose: () => {
										this.getDataList();
										this.sfshBatchVisiable = false
										this.batchIds = []
									}
								});
							} else {
								this.$message.error(data.msg);
							}
						});
					});
				}
			})
		},
		shixigangweistatusChange(e,row){
			if(row.status==0){
				row.passwordwrongnum = 0
			}
			this.$http({
				url:'shixigangwei/update',
				method:'post',
				data:row
			}).then(res=>{
				if(row.status==1){
					this.$message.error('该用户已锁定')
				}else{
					this.$message.success('该用户已解除锁定')
				}
			})
		},
		// 删除
		async deleteHandler(id ) {
			var ids = id? [Number(id)]: this.dataListSelections.map(item => {
				return Number(item.id);
			});
			await this.$confirm(`确定进行[${id ? "删除" : "批量删除"}]操作?`, "提示", {
				confirmButtonText: "确定",
				cancelButtonText: "取消",
				type: "warning"
			}).then(async () => {
				await this.$http({
					url: "shixigangwei/delete",
					method: "post",
					data: ids
				}).then(async ({ data }) => {
					if (data && data.code === 0) {
						this.$message({
							message: "操作成功",
							type: "success",
							duration: 1500,
							onClose: () => {
								this.search();
							}
						});
            
					} else {
						this.$message.error(data.msg);
					}
				});
			});
		},


	}

};
</script>
<style lang="scss" scoped>
	
	.center-form-pv {
	  .el-date-editor.el-input {
	    width: auto;
	  }
	}
	
	.el-input {
	  width: auto;
	}
	
	// form
	.center-form-pv .el-input ::v-deep .el-input__inner {
				border: 2px solid #ddd;
				border-radius: 4px;
				padding: 0 12px;
				color: #000000;
				width: 210px;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .el-select ::v-deep .el-input__inner {
				border: 2px solid #ddd;
				border-radius: 4px;
				padding: 0 10px;
				box-shadow: none;
				outline: none;
				color: #000000;
				width: 210px;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .el-date-editor ::v-deep .el-input__inner {
				border: 2px solid #ddd;
				border-radius: 4px;
				padding: 0 10px 0 30px;
				box-shadow: none;
				outline: none;
				color: #000000;
				width: 170px;
				font-size: 14px;
				height: 40px;
			}
	
	.center-form-pv .search {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 24px;
				color: #fff;
				background: #6aab9c;
				width: auto;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .search:hover {
				opacity: 0.8;
			}
	
	.center-form-pv .actions .add {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 10px;
				margin: 4px;
				outline: none;
				color: #fff;
				background: #6aab9c;
				font-weight: 600;
				width: auto;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .actions .add:hover {
				opacity: 0.8;
			}
	
	.center-form-pv .actions .del {
				border: 1px solid rgb(106, 171, 156);
				cursor: pointer;
				border-radius: 4px;
				padding: 0 10px;
				margin: 4px;
				outline: none;
				color: #ffffff;
				background: rgb(106, 171, 156);
				font-weight: 600;
				width: auto;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .actions .del:hover {
				opacity: 0.8;
			}
	
	.center-form-pv .actions .statis {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 10px;
				margin: 4px;
				outline: none;
				color: #fff;
				background: rgb(106, 171, 156);
				font-weight: 600;
				width: auto;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .actions .statis:hover {
				opacity: 0.8;
			}
	
	.center-form-pv .actions .btn18 {
				border: 1px solid rgb(106, 171, 156);
				cursor: pointer;
				border-radius: 4px;
				padding: 0 10px;
				margin: 4px;
				color: rgb(106, 171, 156);
				background: none;
				width: auto;
				font-size: 16px;
				height: 40px;
			}
	
	.center-form-pv .actions .btn18:hover {
				opacity: 0.8;
			}
	
	// table
	.el-table ::v-deep .el-table__header-wrapper thead {
				color: #000000;
				width: 100%;
			}
	
	.el-table ::v-deep .el-table__header-wrapper thead tr {
				background: #fff;
			}
	
	.el-table ::v-deep .el-table__header-wrapper thead tr th {
				padding: 12px 0;
				border-color: #000;
				border-width: 0 0 1px 0;
				border-style: solid;
				text-align: left;
			}

	.el-table ::v-deep .el-table__header-wrapper thead tr th .cell {
				padding: 0 0 0 2px;
				word-wrap: normal;
				white-space: normal;
				font-weight: bold;
				display: flex;
				vertical-align: middle;
				font-size: 15px;
				line-height: 24px;
				text-overflow: ellipsis;
				word-break: break-all;
				width: 100%;
				align-items: center;
				position: relative;
			}

	
	.el-table ::v-deep .el-table__body-wrapper tbody {
				width: 100%;
			}

	.el-table ::v-deep .el-table__body-wrapper tbody tr {
				background: #fff;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td {
				padding: 6px 0;
				color: #000;
				background: #fff;
				font-weight: 400;
				border-color: #f0f0f0;
				border-width: 0 0 1px 0;
				border-style: solid;
				text-align: left;
			}
	
		.el-table ::v-deep .el-table__body-wrapper tbody tr.el-table__row--striped td {
		background: #FAFAFA;
	}
		
	.el-table ::v-deep .el-table__body-wrapper tbody tr:hover td {
				padding: 6px 0;
				color: #000;
				border-color: #eee;
				border-width: 0 0 1px 0;
				border-style: solid;
				text-align: left;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td {
				padding: 6px 0;
				color: #000;
				background: #fff;
				font-weight: 400;
				border-color: #f0f0f0;
				border-width: 0 0 1px 0;
				border-style: solid;
				text-align: left;
			}

	.el-table ::v-deep .el-table__body-wrapper tbody tr td .cell {
				padding: 0 0 0 2px;
				overflow: hidden;
				word-break: break-all;
				white-space: normal;
				font-size: 14px;
				line-height: 24px;
				text-overflow: ellipsis;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .view {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 5px;
				margin: 0 5px 10px 0;
				outline: none;
				color: #fff;
				background: #6aab9c;
				font-weight: 600;
				width: auto;
				font-size: 15px;
				height: 32px;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .view:hover {
				opacity: 0.8;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .add {
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .add:hover {
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .edit {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 5px;
				margin: 0 5px 10px 0;
				color: #fff;
				background: #f7b36b;
				font-weight: 600;
				width: auto;
				font-size: 15px;
				height: 32px;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .edit:hover {
				opacity: 0.8;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .del {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 10px;
				margin: 0 5px 0 0;
				outline: none;
				color: #fff;
				background: #ff9691;
				font-weight: 600;
				width: auto;
				font-size: 15px;
				height: 32px;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .del:hover {
				opacity: 0.8;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .btn8 {
				cursor: pointer;
				border: 0;
				border-radius: 4px;
				padding: 0 5px;
				margin: 0 5px 10px 0;
				color: #212529;
				background: #e2e3e5;
				font-weight: 600;
				width: auto;
				font-size: 15px;
				height: 32px;
			}
	
	.el-table ::v-deep .el-table__body-wrapper tbody tr td .btn8:hover {
				opacity: 0.5;
			}
	
	// pagination
	.main-content .el-pagination ::v-deep .el-pagination__total {
				margin: 0 10px 0 0;
				color: #666;
				font-weight: 400;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .btn-prev {
				border: none;
				border-radius: 2px;
				padding: 0 10px;
				margin: 0 5px;
				color: #666;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				min-width: 35px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .btn-next {
				border: none;
				border-radius: 2px;
				padding: 0 10px;
				margin: 0 5px;
				color: #666;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				min-width: 35px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .btn-prev:disabled {
				border: none;
				cursor: not-allowed;
				border-radius: 2px;
				padding: 0 10px;
				margin: 0 5px;
				color: #C0C4CC;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .btn-next:disabled {
				border: none;
				cursor: not-allowed;
				border-radius: 2px;
				padding: 0 10px;
				margin: 0 5px;
				color: #C0C4CC;
				background: #f4f4f5;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}

	.main-content .el-pagination ::v-deep .el-pager {
				padding: 0;
				margin: 0;
				display: inline-block;
				vertical-align: top;
			}

	.main-content .el-pagination ::v-deep .el-pager .number {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #666;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pager .number:hover {
				cursor: pointer;
				padding: 0 4px;
				margin: 0 5px;
				color: #409EFF;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #f4f4f5;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pager .number.active {
				cursor: default;
				padding: 0 4px;
				margin: 0 5px;
				color: #FFF;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				border-radius: 2px;
				background: #6aab9c;
				text-align: center;
				min-width: 30px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__sizes {
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input {
				margin: 0 5px;
				width: 100px;
				position: relative;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input .el-input__inner {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 25px 0 8px;
				color: #606266;
				display: inline-block;
				font-size: 13px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input span.el-input__suffix {
				top: 0;
				position: absolute;
				right: 0;
				height: 100%;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__sizes .el-input .el-input__suffix .el-select__caret {
				cursor: pointer;
				color: #C0C4CC;
				width: 25px;
				font-size: 14px;
				line-height: 28px;
				text-align: center;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__jump {
				margin: 0 0 0 24px;
				color: #606266;
				display: inline-block;
				vertical-align: top;
				font-size: 13px;
				line-height: 28px;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__jump .el-input {
				border-radius: 3px;
				padding: 0 2px;
				margin: 0 2px;
				display: inline-block;
				width: 50px;
				font-size: 14px;
				line-height: 18px;
				position: relative;
				text-align: center;
				height: 28px;
			}
	
	.main-content .el-pagination ::v-deep .el-pagination__jump .el-input .el-input__inner {
				border: 1px solid #DCDFE6;
				cursor: pointer;
				padding: 0 3px;
				color: #606266;
				display: inline-block;
				font-size: 14px;
				line-height: 28px;
				border-radius: 3px;
				outline: 0;
				background: #FFF;
				width: 100%;
				text-align: center;
				height: 28px;
			}
	
	// list one
	.one .list1-view {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 15px;
				margin: 0;
				outline: none;
				color: #fff;
				background: #6aab9c;
				font-weight: 600;
				width: auto;
				font-size: 14px;
				height: 40px;
			}
	
	.one .list1-view:hover {
				opacity: 0.8;
			}
	
	.one .list1-edit {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 15px;
				margin: 0;
				outline: none;
				color: #fff;
				background: #4d6e94;
				font-weight: 600;
				width: auto;
				font-size: 14px;
				height: 40px;
			}
	
	.one .list1-edit:hover {
				opacity: 0.8;
			}
	
	.one .list1-del {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 15px;
				margin: 0;
				outline: none;
				color: #fff;
				background: #ff9691;
				font-weight: 600;
				width: auto;
				font-size: 14px;
				height: 40px;
			}
	
	.one .list1-del:hover {
				opacity: 0.8;
			}
	
	.one .list1-btn8 {
				border: 0;
				cursor: pointer;
				border-radius: 4px;
				padding: 0 24px;
				margin: 4px;
				outline: none;
				color: #333;
				background: rgb(226, 227, 229);
				font-weight: 600;
				width: auto;
				font-size: 14px;
				height: 40px;
			}
	
	.one .list1-btn8:hover {
				opacity: 0.8;
			}
	
	.main-content .el-table .el-switch {
				display: inline-flex;
				vertical-align: middle;
				line-height: 30px;
				position: relative;
				align-items: center;
				height: 30px;
			}
	.main-content .el-table .el-switch ::v-deep .el-switch__label--left {
				cursor: pointer;
				margin: 0 10px 0 0;
				color: #333;
				font-weight: 500;
				display: inline-block;
				vertical-align: middle;
				font-size: 16px;
				transition: .2s;
				height: 30px;
			}
	.main-content .el-table .el-switch ::v-deep .el-switch__label--right {
				cursor: pointer;
				margin: 0 0 0 10px;
				color: #333;
				font-weight: 500;
				display: inline-block;
				vertical-align: middle;
				font-size: 16px;
				transition: .2s;
				height: 30px;
			}
	.main-content .el-table .el-switch ::v-deep .el-switch__core {
				border: 1px solid #eeeeee;
				cursor: pointer;
				border-radius: 15px;
				margin: 0;
				background: #ffe4c7;
				display: inline-block;
				width: 40px;
				box-sizing: border-box;
				transition: border-color .3s,background-color .3s;
				height: 20px;
			}
	.main-content .el-table .el-switch ::v-deep .el-switch__core::after {
				border-radius: 100%;
				top: 1px;
				left: 1px;
				background: #fff;
				width: 16px;
				position: absolute;
				transition: all .3s;
				height: 16px;
			}
	.main-content .el-table .el-switch.is-checked ::v-deep .el-switch__core::after {
				margin: 0 0 0 -16px;
				left: 100%;
			}
	
	.main-content .el-table .el-rate ::v-deep .el-rate__item {
				cursor: pointer;
				display: inline-block;
				vertical-align: middle;
				font-size: 0;
				position: relative;
			}
	.main-content .el-table .el-rate ::v-deep .el-rate__item .el-rate__icon {
				margin: 0 3px;
				display: inline-block;
				font-size: 18px;
				position: relative;
				transition: .3s;
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
