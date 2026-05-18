<template>
	<div>
		<div class="auth-bg">
			<el-form v-if="pageFlag=='register'" ref="rgsForm" class="auth-card rgs-form" :model="ruleForm" :rules="rules" @submit.native.prevent>
				<div class="auth-header">
					<div class="auth-title">基于Spring Boot的企业口碑智能分析系统的设计与实现</div>
					<div class="auth-subtitle">注册新账号</div>
				</div>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('xueshengzhanghao')?'required':''">学生账号</div>
					<el-input  v-model="ruleForm.xueshengzhanghao"  autocomplete="off" placeholder="学生账号"  type="text"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('mima')?'required':''">密码</div>
					<el-input  v-model="ruleForm.mima"  autocomplete="off" placeholder="密码"  type="password"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('mima')?'required':''">确认密码</div>
					<el-input  v-model="ruleForm.mima2" autocomplete="off" placeholder="确认密码" type="password" />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('xueshengxingming')?'required':''">学生姓名</div>
					<el-input  v-model="ruleForm.xueshengxingming"  autocomplete="off" placeholder="学生姓名"  type="text"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('xingbie')?'required':''">性别</div>
                    <el-select v-model="ruleForm.xingbie" placeholder="请选择性别" >
                        <el-option
                            v-for="(item,index) in xueshengxingbieOptions"
                            v-bind:key="index"
                            :label="item"
                            :value="item">
                        </el-option>
                    </el-select>
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('shoujihao')?'required':''">手机号</div>
					<el-input  v-model="ruleForm.shoujihao"  autocomplete="off" placeholder="手机号"  type="text"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='xuesheng'">
					<div class="auth-label" :class="changeRules('touxiang')?'required':''">头像</div>
                    <file-upload
                        tip="点击上传头像"
                        action="file/upload"
                        :limit="3"
                        :multiple="true"
                        :fileUrls="ruleForm.touxiang?ruleForm.touxiang:''"
                        @change="xueshengtouxiangUploadChange"
                    ></file-upload>
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('qiyezhanghao')?'required':''">企业账号</div>
					<el-input  v-model="ruleForm.qiyezhanghao"  autocomplete="off" placeholder="企业账号"  type="text"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('mima')?'required':''">密码</div>
					<el-input  v-model="ruleForm.mima"  autocomplete="off" placeholder="密码"  type="password"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('mima')?'required':''">确认密码</div>
					<el-input  v-model="ruleForm.mima2" autocomplete="off" placeholder="确认密码" type="password" />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('fuzeren')?'required':''">负责人</div>
					<el-input  v-model="ruleForm.fuzeren"  autocomplete="off" placeholder="负责人"  type="text"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('xingbie')?'required':''">性别</div>
                    <el-select v-model="ruleForm.xingbie" placeholder="请选择性别" >
                        <el-option
                            v-for="(item,index) in qiyexingbieOptions"
                            v-bind:key="index"
                            :label="item"
                            :value="item">
                        </el-option>
                    </el-select>
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('shoujihaoma')?'required':''">手机号码</div>
					<el-input  v-model="ruleForm.shoujihaoma"  autocomplete="off" placeholder="手机号码"  type="text"  />
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('touxiang')?'required':''">头像</div>
                    <file-upload
                        tip="点击上传头像"
                        action="file/upload"
                        :limit="3"
                        :multiple="true"
                        :fileUrls="ruleForm.touxiang?ruleForm.touxiang:''"
                        @change="qiyetouxiangUploadChange"
                    ></file-upload>
				</el-form-item>

				<el-form-item class="auth-item" v-if="tableName=='qiye'">
					<div class="auth-label" :class="changeRules('qiyemingcheng')?'required':''">企业名称</div>
					<el-input  v-model="ruleForm.qiyemingcheng"  autocomplete="off" placeholder="企业名称"  type="text"  />
				</el-form-item>

				<div class="auth-actions">
					<el-button class="auth-primary" type="primary" @click="login()">注册</el-button>
				</div>

				<div class="auth-footer">
					<span class="auth-footer-text">已有账号？</span>
					<span class="auth-footer-link" @click="close()">直接登录</span>
				</div>
			</el-form>
			
		</div>
	</div>
</template>

<script>
export default {
	data() {
		return {
			ruleForm: {
			},
			forgetForm: {},
            pageFlag : '',
			tableName:"",
			rules: {},
            xueshengxingbieOptions: [],
            qiyexingbieOptions: [],
		};
	},
	mounted(){
		this.pageFlag = this.$route.query.pageFlag
		if(this.$route.query.pageFlag=='register'){
			
			let table = this.$storage.get("loginTable");
			this.tableName = table;
			if(this.tableName=='xuesheng'){
				this.ruleForm = {
					xueshengzhanghao: '',
					mima: '',
					xueshengxingming: '',
					xingbie: '',
					shoujihao: '',
					touxiang: '',
				}
			}
			if(this.tableName=='qiye'){
				this.ruleForm = {
					qiyezhanghao: '',
					mima: '',
					fuzeren: '',
					xingbie: '',
					shoujihaoma: '',
					touxiang: '',
					qiyemingcheng: '',
					sfsh: '',
					shhf: '',
				}
			}
			if ('xuesheng' == this.tableName) {
				this.rules.xueshengzhanghao = [{ required: true, message: '请输入学生账号', trigger: 'blur' }]
			}
			if ('xuesheng' == this.tableName) {
				this.rules.mima = [{ required: true, message: '请输入密码', trigger: 'blur' }]
			}
			if ('xuesheng' == this.tableName) {
				this.rules.xueshengxingming = [{ required: true, message: '请输入学生姓名', trigger: 'blur' }]
			}
			if ('qiye' == this.tableName) {
				this.rules.qiyezhanghao = [{ required: true, message: '请输入企业账号', trigger: 'blur' }]
			}
			if ('qiye' == this.tableName) {
				this.rules.mima = [{ required: true, message: '请输入密码', trigger: 'blur' }]
			}
			if ('qiye' == this.tableName) {
				this.rules.fuzeren = [{ required: true, message: '请输入负责人', trigger: 'blur' }]
			}
			this.xueshengxingbieOptions = "男,女".split(',')
			this.qiyexingbieOptions = "男,女".split(',')
		}
	},
	created() {
	},
	destroyed() {
		  	},
	methods: {
		changeRules(name){
			if(this.rules[name]){
				return true
			}
			return false
		},
		// 获取uuid
		getUUID () {
			return new Date().getTime();
		},
		close(){
			this.$router.push({ path: "/login" });
		},
        xueshengtouxiangUploadChange(fileUrls) {
            this.ruleForm.touxiang = fileUrls;
        },
        qiyetouxiangUploadChange(fileUrls) {
            this.ruleForm.touxiang = fileUrls;
        },

        // 多级联动参数


		// 注册
		login() {
			var url=this.tableName+"/register";
					if((!this.ruleForm.xueshengzhanghao) && `xuesheng` == this.tableName){
						this.$message.error(`学生账号不能为空`);
						return
					}
					if((!this.ruleForm.mima) && `xuesheng` == this.tableName){
						this.$message.error(`密码不能为空`);
						return
					}
					if((this.ruleForm.mima!=this.ruleForm.mima2) && `xuesheng` == this.tableName){
						this.$message.error(`两次密码输入不一致`);
						return
					}
					if((!this.ruleForm.xueshengxingming) && `xuesheng` == this.tableName){
						this.$message.error(`学生姓名不能为空`);
						return
					}
					if(`xuesheng` == this.tableName && this.ruleForm.shoujihao &&(!this.$validate.isMobile(this.ruleForm.shoujihao))){
						this.$message.error(`手机号应输入手机格式`);
						return
					}
            if(this.ruleForm.touxiang!=null) {
                this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url,"g"),"");
            }
			  if(this.tableName=='qiye'){
				  this.ruleForm.sfsh = '待审核'
			  }
					if((!this.ruleForm.qiyezhanghao) && `qiye` == this.tableName){
						this.$message.error(`企业账号不能为空`);
						return
					}
					if((!this.ruleForm.mima) && `qiye` == this.tableName){
						this.$message.error(`密码不能为空`);
						return
					}
					if((this.ruleForm.mima!=this.ruleForm.mima2) && `qiye` == this.tableName){
						this.$message.error(`两次密码输入不一致`);
						return
					}
					if((!this.ruleForm.fuzeren) && `qiye` == this.tableName){
						this.$message.error(`负责人不能为空`);
						return
					}
					if(`qiye` == this.tableName && this.ruleForm.shoujihaoma &&(!this.$validate.isMobile(this.ruleForm.shoujihaoma))){
						this.$message.error(`手机号码应输入手机格式`);
						return
					}
            if(this.ruleForm.touxiang!=null) {
                this.ruleForm.touxiang = this.ruleForm.touxiang.replace(new RegExp(this.$base.url,"g"),"");
            }
			this.$http({
				url: url,
				method: "post",
				data:this.ruleForm
			}).then(({ data }) => {
				if (data && data.code === 0) {
					this.$message({
						message: "注册成功",
						type: "success",
						duration: 1500,
						onClose: () => {
							this.$router.replace({ path: "/login" });
						}
					});
				} else {
					this.$message.error(data.msg);
				}
			});
		}
	}
};
</script>

<style lang="scss" scoped>
.auth-bg {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 32px 20px;
  background: linear-gradient(135deg, rgba(17, 24, 39, 0.75), rgba(17, 24, 39, 0.35)),
    url("~@/assets/img/bg.jpg") center / cover no-repeat;
}

.auth-card {
  width: 100%;
  max-width: 520px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.78);
  backdrop-filter: blur(10px);
  box-shadow: 0 18px 60px rgba(0, 0, 0, 0.22);
  border: 1px solid rgba(255, 255, 255, 0.45);
  padding: 28px 26px 22px;
}

.auth-header {
  margin-bottom: 18px;
}

.auth-title {
  font-size: 22px;
  line-height: 30px;
  color: #0f172a;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.auth-subtitle {
  margin-top: 6px;
  font-size: 14px;
  color: rgba(15, 23, 42, 0.7);
}

.auth-item {
  margin-bottom: 14px;
}

.auth-label {
  font-size: 13px;
  line-height: 18px;
  margin-bottom: 8px;
  color: rgba(15, 23, 42, 0.78);
  font-weight: 600;
}

.auth-actions {
  margin-top: 18px;
  display: flex;
}

.auth-primary {
  width: 100%;
  height: 44px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 700;
  background: linear-gradient(135deg, #16a34a, #10b981);
  border: 0;
}

.auth-footer {
  margin-top: 14px;
  display: flex;
  justify-content: center;
  gap: 6px;
  font-size: 14px;
  line-height: 20px;
  user-select: none;
}

.auth-footer-text {
  color: rgba(15, 23, 42, 0.68);
}

.auth-footer-link {
  color: #0ea5e9;
  font-weight: 700;
  cursor: pointer;
}

.auth-card ::v-deep .el-form-item__content {
  line-height: initial;
}

.auth-card ::v-deep .el-input__inner,
.auth-card ::v-deep .el-select .el-input__inner,
.auth-card ::v-deep .el-date-editor .el-input__inner {
  height: 44px;
  border-radius: 12px;
  border: 1px solid rgba(15, 23, 42, 0.12);
  background: rgba(255, 255, 255, 0.92);
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.auth-card ::v-deep .el-input__inner:focus,
.auth-card ::v-deep .el-select .el-input__inner:focus,
.auth-card ::v-deep .el-date-editor .el-input__inner:focus {
  border-color: rgba(16, 185, 129, 0.7);
  box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.18);
}

.auth-card ::v-deep .el-date-editor.el-input {
  width: 100%;
}

.auth-card ::v-deep .el-upload--picture-card {
  background: transparent;
  border: 0;
  border-radius: 0;
  width: auto;
  height: auto;
  line-height: initial;
  vertical-align: middle;
}

.auth-card ::v-deep .upload .upload-img,
.auth-card ::v-deep .el-upload-list .el-upload-list__item,
.auth-card ::v-deep .el-upload .el-icon-plus {
  cursor: pointer;
  border-radius: 12px;
  background: rgba(255, 255, 255, 0.92);
  border: 1px dashed rgba(15, 23, 42, 0.18);
  width: 92px;
  height: 64px;
  line-height: 64px;
  text-align: center;
  color: rgba(15, 23, 42, 0.65);
}

@media (max-width: 480px) {
  .auth-card {
    padding: 22px 18px 18px;
    border-radius: 14px;
  }
}

@media (prefers-color-scheme: dark) {
  .auth-card {
    background: rgba(15, 23, 42, 0.72);
    border-color: rgba(148, 163, 184, 0.2);
  }
  .auth-title {
    color: rgba(248, 250, 252, 0.95);
  }
  .auth-subtitle,
  .auth-label,
  .auth-footer-text {
    color: rgba(226, 232, 240, 0.75);
  }
  .auth-card ::v-deep .el-input__inner,
  .auth-card ::v-deep .el-select .el-input__inner,
  .auth-card ::v-deep .el-date-editor .el-input__inner {
    background: rgba(2, 6, 23, 0.35);
    border-color: rgba(148, 163, 184, 0.22);
    color: rgba(248, 250, 252, 0.9);
  }
  .auth-card ::v-deep .upload .upload-img,
  .auth-card ::v-deep .el-upload-list .el-upload-list__item,
  .auth-card ::v-deep .el-upload .el-icon-plus {
    background: rgba(2, 6, 23, 0.2);
    border-color: rgba(148, 163, 184, 0.26);
    color: rgba(226, 232, 240, 0.75);
  }
}

	.required {
		position: relative;
	}
	.required::after{
				color: red;
				left: -10px;
				position: absolute;
				content: "*";
			}
	.editor>.avatar-uploader {
		line-height: 0;
		height: 0;
	}
</style>
