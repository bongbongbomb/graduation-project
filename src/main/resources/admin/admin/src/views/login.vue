<template>
  <div class="auth-page">
    <div class="auth-bg">
      <div class="auth-card">
        <div class="auth-header">
          <div class="auth-title">基于Spring Boot的企业口碑智能分析系统的设计与实现</div>
          <div class="auth-subtitle">登录后台管理</div>
        </div>

        <el-form class="auth-form" :model="rulesForm" @submit.native.prevent>
          <el-form-item v-if="loginType==1" class="auth-item">
            <div class="auth-label">用户名</div>
            <el-input v-model="rulesForm.username" placeholder="请输入用户名" autocomplete="on" prefix-icon="el-icon-user" />
          </el-form-item>

          <el-form-item v-if="loginType==1" class="auth-item">
            <div class="auth-label">密码</div>
            <el-input v-model="rulesForm.password" placeholder="请输入密码" type="password" autocomplete="on" prefix-icon="el-icon-lock" show-password />
          </el-form-item>

          <div v-if="roles.length>1" class="auth-roles">
            <div class="auth-label">角色</div>
            <el-radio-group v-model="rulesForm.role" class="auth-role-group">
              <el-radio v-if="loginType==1||(loginType==2&&item.roleName!='管理员')" v-for="item in roles" :key="item.roleName" :label="item.roleName">
                {{item.roleName}}
              </el-radio>
            </el-radio-group>
          </div>

          <div class="auth-actions">
            <el-button v-if="loginType==1" class="auth-primary" type="primary" @click="login()">登录</el-button>
            <el-button class="auth-secondary" type="primary" plain @click="register('qiye')">注册企业</el-button>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>
<script>
import menu from "@/utils/menu";
export default {
  data() {
    return {
		verifyCheck2: false,
		flag: false,
      baseUrl:this.$base.url,
      loginType: 1,
      rulesForm: {
        username: "",
        password: "",
        role: "",
      },
      menus: [],
      roles: [],
      tableName: "",
    };
  },
  mounted() {
    let menus = menu.list();
    this.menus = menus;

    for (let i = 0; i < this.menus.length; i++) {
      if (this.menus[i].hasBackLogin=='是') {
        this.roles.push(this.menus[i])
      }
    }

  },
  created() {

  },
  destroyed() {
	    },
  components: {
  },
  methods: {

    //注册
    register(tableName){
		this.$storage.set("loginTable", tableName);
		this.$router.push({path:'/register',query:{pageFlag:'register'}})
    },
    // 登陆
    login() {

		if (!this.rulesForm.username) {
			this.$message.error("请输入用户名");
			return;
		}
		if (!this.rulesForm.password) {
			this.$message.error("请输入密码");
			return;
		}
		if(this.roles.length>1) {
			if (!this.rulesForm.role) {
				this.$message.error("请选择角色");
				return;
			}

			let menus = this.menus;
			for (let i = 0; i < menus.length; i++) {
				if (menus[i].roleName == this.rulesForm.role) {
					this.tableName = menus[i].tableName;
				}
			}
		} else {
			this.tableName = this.roles[0].tableName;
			this.rulesForm.role = this.roles[0].roleName;
		}
		
		this.loginPost()
    },
	loginPost() {
		this.$http({
			url: `${this.tableName}/login?username=${this.rulesForm.username}&password=${this.rulesForm.password}`,
			method: "post"
		}).then(({ data }) => {
			if (data && data.code === 0) {
				this.$storage.set("Token", data.token);
				this.$storage.set("role", this.rulesForm.role);
				this.$storage.set("sessionTable", this.tableName);
				this.$storage.set("adminName", this.rulesForm.username);
				this.$router.replace({ path: "/" });
			} else {
				this.$message.error(data.msg);
			}
		});
	},
  }
}
</script>

<style lang="scss" scoped>
.auth-page {
  min-height: 100vh;
}

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
  max-width: 440px;
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.78);
  backdrop-filter: blur(10px);
  box-shadow: 0 18px 60px rgba(0, 0, 0, 0.22);
  border: 1px solid rgba(255, 255, 255, 0.45);
  padding: 28px 26px 24px;
}

.auth-header {
  text-align: left;
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

.auth-form {
  width: 100%;
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

.auth-roles {
  margin: 10px 0 6px;
}

.auth-role-group {
  display: flex;
  flex-wrap: wrap;
  gap: 10px 14px;
  padding: 10px 12px;
  border-radius: 12px;
  background: rgba(15, 23, 42, 0.04);
  border: 1px solid rgba(15, 23, 42, 0.06);
}

.auth-actions {
  margin-top: 18px;
  display: flex;
  gap: 12px;
}

.auth-primary,
.auth-secondary {
  flex: 1;
  height: 44px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 700;
}

.auth-primary {
  background: linear-gradient(135deg, #16a34a, #10b981);
  border: 0;
}

.auth-secondary {
  border: 1px solid rgba(15, 23, 42, 0.14);
}

.auth-card ::v-deep .el-form-item__content {
  line-height: initial;
}

.auth-card ::v-deep .el-input__inner {
  height: 44px;
  border-radius: 12px;
  border: 1px solid rgba(15, 23, 42, 0.12);
  background: rgba(255, 255, 255, 0.92);
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
}

.auth-card ::v-deep .el-input__inner:focus {
  border-color: rgba(16, 185, 129, 0.7);
  box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.18);
}

.auth-card ::v-deep .el-input__prefix {
  left: 12px;
}

.auth-card ::v-deep .el-input__icon {
  line-height: 44px;
}

.auth-card ::v-deep .el-radio__input .el-radio__inner {
  border-color: rgba(15, 23, 42, 0.35);
}

.auth-card ::v-deep .el-radio__label {
  color: rgba(15, 23, 42, 0.85);
  font-size: 14px;
}

.auth-card ::v-deep .el-radio__input.is-checked .el-radio__inner {
  background: #10b981;
  border-color: #10b981;
}

.auth-card ::v-deep .el-radio__input.is-checked + .el-radio__label {
  color: rgba(15, 23, 42, 0.95);
}

@media (max-width: 480px) {
  .auth-card {
    padding: 22px 18px 18px;
    border-radius: 14px;
  }
  .auth-actions {
    flex-direction: column;
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
  .auth-label {
    color: rgba(226, 232, 240, 0.75);
  }
  .auth-role-group {
    background: rgba(148, 163, 184, 0.08);
    border-color: rgba(148, 163, 184, 0.14);
  }
  .auth-card ::v-deep .el-input__inner {
    background: rgba(2, 6, 23, 0.35);
    border-color: rgba(148, 163, 184, 0.22);
    color: rgba(248, 250, 252, 0.9);
  }
  .auth-card ::v-deep .el-radio__label {
    color: rgba(226, 232, 240, 0.85);
  }
  .auth-secondary {
    color: rgba(226, 232, 240, 0.9);
    border-color: rgba(148, 163, 184, 0.26);
    background: rgba(2, 6, 23, 0.18);
  }
}

</style>
