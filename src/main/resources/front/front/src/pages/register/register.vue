<template>
  <div class="auth-page">
    <div class="auth-shell">
      <div class="auth-card">
        <div class="auth-header">
          <div class="auth-header-text">
            <div class="auth-title">创建账号</div>
            <div class="auth-desc">完善信息后即可注册</div>
          </div>
        </div>

        <el-form
          class="auth-form"
          v-if="pageFlag == 'register'"
          ref="registerForm"
          :model="registerForm"
          :rules="rules"
        >
          <el-form-item
            class="auth-item"
            v-if="tableName == 'xuesheng'"
            prop="xueshengzhanghao"
          >
            <el-input
              v-model="registerForm.xueshengzhanghao"
              placeholder="学生账号"
              prefix-icon="el-icon-user"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'xuesheng'"
            prop="mima"
          >
            <el-input
              v-model="registerForm.mima"
              type="password"
              show-password
              placeholder="密码"
              prefix-icon="el-icon-lock"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'xuesheng'"
            prop="mima2"
          >
            <el-input
              v-model="registerForm.mima2"
              type="password"
              show-password
              placeholder="确认密码"
              prefix-icon="el-icon-lock"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'xuesheng'"
            prop="xueshengxingming"
          >
            <el-input
              v-model="registerForm.xueshengxingming"
              placeholder="学生姓名"
              prefix-icon="el-icon-edit"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'xuesheng'"
            prop="xingbie"
          >
            <el-select v-model="registerForm.xingbie" placeholder="性别">
              <el-option
                v-for="(item, index) in xueshengxingbieOptions"
                :key="index"
                :label="item"
                :value="item"
              />
            </el-select>
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'xuesheng'"
            prop="shoujihao"
          >
            <el-input
              v-model="registerForm.shoujihao"
              placeholder="手机号"
              prefix-icon="el-icon-phone"
            />
          </el-form-item>
          <el-form-item
            class="auth-item auth-upload"
            v-if="tableName == 'xuesheng'"
            prop="touxiang"
          >
            <file-upload
              tip="点击上传头像"
              action="file/upload"
              :limit="1"
              :multiple="true"
              :fileUrls="registerForm.touxiang ? registerForm.touxiang : ''"
              @change="xueshengtouxiangUploadChange"
            ></file-upload>
          </el-form-item>

          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="qiyezhanghao"
          >
            <el-input
              v-model="registerForm.qiyezhanghao"
              placeholder="企业账号"
              prefix-icon="el-icon-office-building"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="mima"
          >
            <el-input
              v-model="registerForm.mima"
              type="password"
              show-password
              placeholder="密码"
              prefix-icon="el-icon-lock"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="mima2"
          >
            <el-input
              v-model="registerForm.mima2"
              type="password"
              show-password
              placeholder="确认密码"
              prefix-icon="el-icon-lock"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="fuzeren"
          >
            <el-input
              v-model="registerForm.fuzeren"
              placeholder="负责人"
              prefix-icon="el-icon-user"
            />
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="xingbie"
          >
            <el-select v-model="registerForm.xingbie" placeholder="性别">
              <el-option
                v-for="(item, index) in qiyexingbieOptions"
                :key="index"
                :label="item"
                :value="item"
              />
            </el-select>
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="shoujihaoma"
          >
            <el-input
              v-model="registerForm.shoujihaoma"
              placeholder="手机号码"
              prefix-icon="el-icon-phone"
            />
          </el-form-item>
          <el-form-item
            class="auth-item auth-upload"
            v-if="tableName == 'qiye'"
            prop="touxiang"
          >
            <file-upload
              tip="点击上传头像"
              action="file/upload"
              :limit="1"
              :multiple="true"
              :fileUrls="registerForm.touxiang ? registerForm.touxiang : ''"
              @change="qiyetouxiangUploadChange"
            ></file-upload>
          </el-form-item>
          <el-form-item
            class="auth-item"
            v-if="tableName == 'qiye'"
            prop="qiyemingcheng"
          >
            <el-input
              v-model="registerForm.qiyemingcheng"
              placeholder="企业名称"
              prefix-icon="el-icon-s-management"
            />
          </el-form-item>

          <el-form-item class="auth-actions">
            <el-button
              type="primary"
              class="auth-primary"
              @click="submitForm('registerForm')"
              >注册</el-button
            >
          </el-form-item>

          <div class="auth-footer">
            <router-link class="auth-link" to="/login"
              >已有账户？去登录</router-link
            >
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script>
import logo from "@/assets/logo.png";

export default {
  //数据集合
  data() {
    return {
      pageFlag: "",
      tableName: "",
      registerForm: {},
      forgetForm: {},
      rules: {},
      requiredRules: {},
      xueshengxingbieOptions: [],
      qiyexingbieOptions: [],
      logoUrl: logo,
    };
  },
  mounted() {
    if (this.$route.query.pageFlag == "register") {
      this.tableName = this.$route.query.role;
      if (this.tableName == "xuesheng") {
        this.registerForm = {
          xueshengzhanghao: "",
          mima: "",
          mima2: "",
          xueshengxingming: "",
          xingbie: "",
          shoujihao: "",
          touxiang: "",
        };
      }
      if (this.tableName == "qiye") {
        this.registerForm = {
          qiyezhanghao: "",
          mima: "",
          mima2: "",
          fuzeren: "",
          xingbie: "",
          shoujihaoma: "",
          touxiang: "",
          qiyemingcheng: "",
          sfsh: "",
          shhf: "",
        };
      }
      if ("xuesheng" == this.tableName) {
        this.requiredRules.xueshengzhanghao = [
          { required: true, message: "请输入学生账号", trigger: "blur" },
        ];
      }
      if ("xuesheng" == this.tableName) {
        this.requiredRules.mima = [
          { required: true, message: "请输入密码", trigger: "blur" },
        ];
      }
      if ("xuesheng" == this.tableName) {
        this.requiredRules.xueshengxingming = [
          { required: true, message: "请输入学生姓名", trigger: "blur" },
        ];
      }
      if ("qiye" == this.tableName) {
        this.requiredRules.qiyezhanghao = [
          { required: true, message: "请输入企业账号", trigger: "blur" },
        ];
      }
      if ("qiye" == this.tableName) {
        this.requiredRules.mima = [
          { required: true, message: "请输入密码", trigger: "blur" },
        ];
      }
      if ("qiye" == this.tableName) {
        this.requiredRules.fuzeren = [
          { required: true, message: "请输入负责人", trigger: "blur" },
        ];
      }
    }
  },
  created() {
    this.pageFlag = this.$route.query.pageFlag;
    if (this.$route.query.pageFlag == "register") {
      if ("xuesheng" == this.tableName) {
        this.rules.xueshengzhanghao = [
          { required: true, message: "请输入学生账号", trigger: "blur" },
        ];
      }
      if ("xuesheng" == this.tableName) {
        this.rules.mima = [
          { required: true, message: "请输入密码", trigger: "blur" },
        ];
      }
      if ("xuesheng" == this.tableName) {
        this.rules.xueshengxingming = [
          { required: true, message: "请输入学生姓名", trigger: "blur" },
        ];
      }
      this.xueshengxingbieOptions = "男,女".split(",");
      if ("xuesheng" == this.tableName) {
        this.rules.shoujihao = [
          {
            required: true,
            validator: this.$validate.isMobile,
            trigger: "blur",
          },
        ];
      }
      if ("qiye" == this.tableName) {
        this.rules.qiyezhanghao = [
          { required: true, message: "请输入企业账号", trigger: "blur" },
        ];
      }
      if ("qiye" == this.tableName) {
        this.rules.mima = [
          { required: true, message: "请输入密码", trigger: "blur" },
        ];
      }
      if ("qiye" == this.tableName) {
        this.rules.fuzeren = [
          { required: true, message: "请输入负责人", trigger: "blur" },
        ];
      }
      this.qiyexingbieOptions = "男,女".split(",");
      if ("qiye" == this.tableName) {
        this.rules.shoujihaoma = [
          {
            required: true,
            validator: this.$validate.isMobile,
            trigger: "blur",
          },
        ];
      }
    }
  },
  //方法集合
  methods: {
    changeRules(name) {
      if (this.requiredRules[name]) {
        return true;
      }
      return false;
    },
    // 获取uuid
    getUUID() {
      return new Date().getTime();
    },
    // 下二随
    xueshengtouxiangUploadChange(fileUrls) {
      this.registerForm.touxiang = fileUrls.replace(
        new RegExp(this.$config.baseUrl, "g"),
        "",
      );
    },
    qiyetouxiangUploadChange(fileUrls) {
      this.registerForm.touxiang = fileUrls.replace(
        new RegExp(this.$config.baseUrl, "g"),
        "",
      );
    },

    // 多级联动参数

    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          var url = this.tableName + "/register";
          if (
            !this.registerForm.xueshengzhanghao &&
            `xuesheng` == this.tableName
          ) {
            this.$message.error(`学生账号不能为空`);
            return;
          }
          if (
            `xuesheng` == this.tableName &&
            this.registerForm.mima != this.registerForm.mima2
          ) {
            this.$message.error(`两次密码输入不一致`);
            return;
          }
          if (!this.registerForm.mima && `xuesheng` == this.tableName) {
            this.$message.error(`密码不能为空`);
            return;
          }
          if (
            !this.registerForm.xueshengxingming &&
            `xuesheng` == this.tableName
          ) {
            this.$message.error(`学生姓名不能为空`);
            return;
          }
          if (
            `xuesheng` == this.tableName &&
            this.registerForm.shoujihao &&
            !this.$validate.isMobile2(this.registerForm.shoujihao)
          ) {
            this.$message.error(`手机号应输入手机格式`);
            return;
          }
          if (this.tableName == "qiye") {
            this.registerForm.sfsh = "待审核";
          }
          if (!this.registerForm.qiyezhanghao && `qiye` == this.tableName) {
            this.$message.error(`企业账号不能为空`);
            return;
          }
          if (
            `qiye` == this.tableName &&
            this.registerForm.mima != this.registerForm.mima2
          ) {
            this.$message.error(`两次密码输入不一致`);
            return;
          }
          if (!this.registerForm.mima && `qiye` == this.tableName) {
            this.$message.error(`密码不能为空`);
            return;
          }
          if (!this.registerForm.fuzeren && `qiye` == this.tableName) {
            this.$message.error(`负责人不能为空`);
            return;
          }
          if (
            `qiye` == this.tableName &&
            this.registerForm.shoujihaoma &&
            !this.$validate.isMobile2(this.registerForm.shoujihaoma)
          ) {
            this.$message.error(`手机号码应输入手机格式`);
            return;
          }
          this.$http.post(url, this.registerForm).then((res) => {
            if (res.data.code === 0) {
              this.$message({
                message: "注册成功",
                type: "success",
                duration: 1500,
                onClose: () => {
                  this.$router.push("/login");
                },
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
    resetForm(formName) {
      this.$refs[formName].resetFields();
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
  max-width: 520px;
  max-height: calc(100vh - 72px);
  overflow: auto;
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

.auth-item {
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

.auth-upload ::v-deep .upload {
  width: 100%;
}

.auth-upload ::v-deep .el-upload--picture-card {
  width: 100%;
  height: 86px;
  border-radius: 14px;
  border: 1px dashed rgba(15, 23, 42, 0.25);
  background: rgba(255, 255, 255, 0.75);
  display: flex;
  align-items: center;
  justify-content: center;
}

.auth-upload ::v-deep .el-upload-list--picture-card {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.auth-upload ::v-deep .el-upload-list__item {
  width: 86px;
  height: 86px;
  border-radius: 14px;
  overflow: hidden;
}

.auth-footer {
  margin-top: 18px;
  padding-top: 14px;
  border-top: 1px solid rgba(15, 23, 42, 0.08);
  text-align: center;
}

.auth-link {
  color: rgba(15, 23, 42, 0.72);
  text-decoration: none;
  font-size: 13px;
}

.auth-link:hover {
  color: rgba(99, 102, 241, 0.9);
}
</style>
