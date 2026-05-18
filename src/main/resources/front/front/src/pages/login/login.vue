<template>
  <div class="auth-page">
    <div class="auth-shell">
      <div class="auth-card">
        <div class="auth-header">
          <div class="auth-header-text">
            <div class="auth-title">
              基于Spring Boot的企业口碑智能分析系统的设计与实现
            </div>
            <div class="auth-desc">登录后进入系统</div>
          </div>
        </div>

        <el-form
          ref="loginForm"
          class="auth-form"
          :model="loginForm"
          :rules="rules"
        >
          <el-form-item v-if="loginType == 1" prop="username">
            <el-input
              v-model="loginForm.username"
              placeholder="账号"
              prefix-icon="el-icon-user"
              autocomplete="username"
            />
          </el-form-item>

          <el-form-item v-if="loginType == 1" prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              show-password
              placeholder="密码"
              prefix-icon="el-icon-lock"
              autocomplete="current-password"
            />
          </el-form-item>

          <el-form-item v-if="roles.length > 1" class="auth-role">
            <el-select
              v-model="loginForm.tableName"
              placeholder="请选择角色"
              @change="selectChange"
            >
              <el-option
                v-for="(item, index) in roles"
                :key="index"
                :label="item.roleName"
                :value="item.tableName"
              />
            </el-select>
          </el-form-item>

          <el-form-item class="auth-actions">
            <el-button
              type="primary"
              class="auth-primary"
              @click="submitForm('loginForm')"
              >登录</el-button
            >
          </el-form-item>

          <div class="auth-footer">
            <div class="auth-footer-title">还没有账号？选择角色注册</div>
            <div class="auth-register-list">
              <router-link
                v-for="item in registerRoles"
                :key="item.tableName"
                class="auth-register-link"
                :to="{
                  path: '/register',
                  query: { role: item.tableName, pageFlag: 'register' },
                }"
              >
                注册{{ item.roleName.replace("注册", "") }}
              </router-link>
            </div>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import menu from "@/config/menu";
import logo from "@/assets/logo.png";
export default {
  data() {
    return {
      baseUrl: this.$config.baseUrl,
      logoUrl: logo,
      loginType: 1,
      roleMenus: [],
      loginForm: {
        username: "",
        password: "",
        tableName: "",
        code: "",
      },
      role: "",
      roles: [],
      rules: {
        username: [{ required: true, message: "请输入账号", trigger: "blur" }],
        password: [{ required: true, message: "请输入密码", trigger: "blur" }],
      },
      codes: [
        {
          num: 1,
          color: "#000",
          rotate: "10deg",
          size: "16px",
        },
        {
          num: 2,
          color: "#000",
          rotate: "10deg",
          size: "16px",
        },
        {
          num: 3,
          color: "#000",
          rotate: "10deg",
          size: "16px",
        },
        {
          num: 4,
          color: "#000",
          rotate: "10deg",
          size: "16px",
        },
      ],
      flag: false,
      verifyCheck2: false,
    };
  },
  created() {
    this.roleMenus = menu.list();
    for (let item in this.roleMenus) {
      if (this.roleMenus[item].hasFrontLogin == "是") {
        this.roles.push(this.roleMenus[item]);
      }
    }
  },
  mounted() {},
  computed: {
    registerRoles() {
      return (this.roles || []).filter(
        (item) => item && item.hasFrontRegister == "是",
      );
    },
  },
  methods: {
    randomString() {
      var len = 4;
      var chars = [
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z",
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
      ];
      var colors = [
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
      ];
      var sizes = ["14", "15", "16", "17", "18"];
      for (var i = 0; i < len; i++) {
        // 随机验证码
        var key = Math.floor(Math.random() * chars.length);
        this.codes[i].num = chars[key];
        // 随机验证码颜色
        var code = "#";
        for (var j = 0; j < 6; j++) {
          var colorKey = Math.floor(Math.random() * colors.length);
          code += colors[colorKey];
        }
        this.codes[i].color = code;
        // 随机验证码方向
        var rotate = Math.floor(Math.random() * 45);
        var plus = Math.floor(Math.random() * 2);
        if (plus == 1) rotate = "-" + rotate;
        this.codes[i].rotate = "rotate(" + rotate + "deg)";
        // 随机验证码字体大小
        var size = Math.floor(Math.random() * sizes.length);
        this.codes[i].size = sizes[size] + "px";
      }
    },
    selectChange(e) {
      for (let x in this.roles) {
        if (this.roles[x].tableName == e) {
          this.role = this.roles[x].roleName;
        }
      }
    },
    submitForm(formName) {
      if (this.roles.length != 1) {
        if (!this.role) {
          this.$message.error("请选择登录用户类型");
          return false;
        }
      } else {
        this.role = this.roles[0].roleName;
        this.loginForm.tableName = this.roles[0].tableName;
      }
      if (!this.loginForm.username) {
        this.$message.error("请输入用户名");
        return;
      }
      if (!this.loginForm.password) {
        this.$message.error("请输入密码");
        return;
      }

      this.loginPost(formName);
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    loginPost(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          this.$http
            .get(`${this.loginForm.tableName}/login`, {
              params: this.loginForm,
            })
            .then((res) => {
              if (res.data.code === 0) {
                localStorage.setItem("frontToken", res.data.token);
                localStorage.setItem("UserTableName", this.loginForm.tableName);
                localStorage.setItem("username", this.loginForm.username);
                // localStorage.setItem('adminName', this.loginForm.username);
                localStorage.setItem(
                  "frontSessionTable",
                  this.loginForm.tableName,
                );
                localStorage.setItem("frontRole", this.role);
                localStorage.setItem("keyPath", 0);
                this.$router.push("/");
                this.$message({
                  message: "登录成功",
                  type: "success",
                  duration: 1500,
                });
              } else {
                this.$message.error(res.data.msg);
              }
            });
        } else {
          return false;
        }
      });
    },
  },
};
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.auth-page {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 36px 16px;
  background-image: url("~@/assets/bg.jpg");
  background-size: cover;
  background-position: center;
}

.auth-shell {
  width: 100%;
  display: flex;
  justify-content: center;
}

.auth-card {
  width: 100%;
  max-width: 460px;
  padding: 28px 28px 22px;
  border-radius: 18px;
  background: rgba(255, 255, 255, 0.92);
  box-shadow: 0 16px 40px rgba(0, 0, 0, 0.25);
  backdrop-filter: blur(10px);
}

.auth-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin: 0 0 18px;
}

.auth-logo {
  width: 44px;
  height: 44px;
  border-radius: 10px;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.18);
  background: #fff;
  object-fit: cover;
}

.auth-header-text {
  min-width: 0;
}

.auth-title {
  color: #0f172a;
  font-size: 18px;
  font-weight: 700;
  letter-spacing: 0.2px;
}

.auth-desc {
  margin-top: 2px;
  color: rgba(15, 23, 42, 0.62);
  font-size: 13px;
}

.auth-form ::v-deep .el-form-item {
  margin-bottom: 14px;
}

.auth-form ::v-deep .el-form-item__error {
  padding-top: 4px;
}

.auth-form ::v-deep .el-input__inner {
  height: 46px;
  line-height: 46px;
  border-radius: 12px;
  border: 1px solid rgba(15, 23, 42, 0.12);
  background: rgba(255, 255, 255, 0.85);
  transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
}

.auth-form ::v-deep .el-input__inner:focus {
  border-color: rgba(99, 102, 241, 0.7);
  box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.12);
  background: rgba(255, 255, 255, 1);
}

.auth-form ::v-deep .el-input__prefix {
  left: 12px;
}

.auth-form ::v-deep .el-input--prefix .el-input__inner {
  padding-left: 38px;
}

.auth-form ::v-deep .el-select {
  width: 100%;
}

.auth-actions {
  margin-top: 6px;
}

.auth-primary {
  width: 100%;
  height: 46px;
  border: 0;
  border-radius: 12px;
  background: linear-gradient(135deg, #ff7a18, #af002d 45%, #319197);
  box-shadow: 0 10px 24px rgba(0, 0, 0, 0.18);
  font-size: 16px;
  font-weight: 700;
  letter-spacing: 0.5px;
}

.auth-primary:hover,
.auth-primary:focus {
  filter: brightness(1.03);
}

.auth-footer {
  margin-top: 18px;
  padding-top: 14px;
  border-top: 1px solid rgba(15, 23, 42, 0.08);
}

.auth-footer-title {
  color: rgba(15, 23, 42, 0.72);
  font-size: 13px;
  margin-bottom: 10px;
}

.auth-register-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.auth-register-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 10px 12px;
  border-radius: 12px;
  border: 1px solid rgba(15, 23, 42, 0.12);
  background: rgba(255, 255, 255, 0.85);
  color: rgba(15, 23, 42, 0.78);
  font-size: 13px;
  text-decoration: none;
  transition: transform 0.15s ease, box-shadow 0.15s ease,
    border-color 0.15s ease;
}

.auth-register-link:hover {
  transform: translateY(-1px);
  box-shadow: 0 10px 18px rgba(0, 0, 0, 0.12);
  border-color: rgba(99, 102, 241, 0.35);
}
</style>
