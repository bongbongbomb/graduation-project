<template>
  <div
    :style="{
      width: '80%',
      padding: '20px',
      margin: '10px auto',
      position: 'relative',
      background: '#fff',
    }"
  >
    <el-form
      :style="{
        width: '100%',
        position: 'relative',
        flexWrap: 'wrap',
        justifyContent: 'space-between',
        display: 'flex',
      }"
      class="add-update-preview"
      ref="ruleForm"
      :model="ruleForm"
      :rules="rules"
      label-width="80px"
    >
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="企业账号"
        prop="qiyezhanghao"
      >
        <el-input
          v-model="ruleForm.qiyezhanghao"
          placeholder="企业账号"
          clearable
          :disabled="false || ro.qiyezhanghao"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="企业名称"
        prop="qiyemingcheng"
      >
        <el-input
          v-model="ruleForm.qiyemingcheng"
          placeholder="企业名称"
          clearable
          :disabled="false || ro.qiyemingcheng"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="实习岗位"
        prop="gangweileixing"
      >
        <el-input
          v-model="ruleForm.gangweileixing"
          placeholder="实习岗位"
          clearable
          :disabled="false || ro.gangweileixing"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="工作地点"
        prop="gongzuodidian"
      >
        <el-input
          v-model="ruleForm.gongzuodidian"
          placeholder="工作地点"
          clearable
          :disabled="false || ro.gongzuodidian"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="实习图片"
        v-if="type != 'cross' || (type == 'cross' && !ro.shixitupian)"
        prop="shixitupian"
      >
        <file-upload
          tip="点击上传实习图片"
          action="file/upload"
          :limit="3"
          :multiple="true"
          :fileUrls="ruleForm.shixitupian ? ruleForm.shixitupian : ''"
          @change="shixitupianUploadChange"
        ></file-upload>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        class="upload"
        v-else
        label="实习图片"
        prop="shixitupian"
      >
        <img
          v-if="ruleForm.shixitupian.substring(0, 4) == 'http'"
          class="upload-img"
          style="margin-right: 20px"
          v-bind:key="index"
          :src="ruleForm.shixitupian.split(',')[0]"
          width="100"
          height="100"
        />
        <img
          v-else
          class="upload-img"
          style="margin-right: 20px"
          v-bind:key="index"
          v-for="(item, index) in ruleForm.shixitupian.split(',')"
          :src="baseUrl + item"
          width="100"
          height="100"
        />
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="实习报告"
        prop="shixibaogao"
      >
        <file-upload
          tip="点击上传实习报告"
          action="file/upload"
          :limit="1"
          :type="3"
          :multiple="true"
          :fileUrls="ruleForm.shixibaogao ? ruleForm.shixibaogao : ''"
          @change="shixibaogaoUploadChange"
        ></file-upload>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="登记时间"
        prop="dengjishijian"
      >
        <el-date-picker
          :disabled="false || ro.dengjishijian"
          value-format="yyyy-MM-dd HH:mm:ss"
          v-model="ruleForm.dengjishijian"
          type="datetime"
          placeholder="登记时间"
        >
        </el-date-picker>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="学生账号"
        prop="xueshengzhanghao"
      >
        <el-input
          v-model="ruleForm.xueshengzhanghao"
          placeholder="学生账号"
          clearable
          :disabled="false || ro.xueshengzhanghao"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="学生姓名"
        prop="xueshengxingming"
      >
        <el-input
          v-model="ruleForm.xueshengxingming"
          placeholder="学生姓名"
          clearable
          :disabled="false || ro.xueshengxingming"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="实习评价"
        prop="shixineirong"
      >
        <editor
          :style="{
            padding: '0',
            boxShadow: 'none',
            margin: '0',
            borderColor: '#E2E3E5',
            backgroundColor: '#fff',
            borderRadius: '0',
            borderWidth: '1px',
            width: '100%',
            borderStyle: 'solid',
            height: 'auto',
          }"
          v-model="ruleForm.shixineirong"
          class="editor"
          action="file/upload"
        >
        </editor>
      </el-form-item>

      <el-form-item
        :style="{
          width: '100%',
          padding: '0',
          margin: '0',
          textAlign: 'center',
        }"
      >
        <el-button
          :style="{
            border: '0',
            cursor: 'pointer',
            padding: '0 10px',
            margin: '0 20px 0 0',
            outline: 'none',
            color: 'rgba(255, 255, 255, 1)',
            borderRadius: '4px',
            background: '#FE6917',
            width: 'auto',
            lineHeight: '30px',
            fontSize: '14px',
            height: '30px',
          }"
          type="primary"
          @click="onSubmit"
          >提交</el-button
        >
        <el-button
          :style="{
            border: '0',
            cursor: 'pointer',
            padding: '0 10px',
            margin: '0',
            outline: 'none',
            color: '#fff',
            borderRadius: '5px',
            background: '#9E9E9E',
            width: 'auto',
            lineHeight: '30px',
            fontSize: '14px',
            height: '30px',
          }"
          @click="back()"
          >返回</el-button
        >
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
export default {
  data() {
    let self = this;
    return {
      id: "",
      baseUrl: "",
      ro: {
        qiyezhanghao: false,
        qiyemingcheng: false,
        gangweileixing: false,
        gongzuodidian: false,
        shixitupian: false,
        shixibaogao: false,
        shixineirong: false,
        dengjishijian: false,
        xueshengzhanghao: false,
        xueshengxingming: false,
      },
      type: "",
      userTableName: localStorage.getItem("UserTableName"),
      ruleForm: {
        qiyezhanghao: "",
        qiyemingcheng: "",
        gangweileixing: "",
        gongzuodidian: "",
        shixitupian: "",
        shixibaogao: "",
        shixineirong: "",
        dengjishijian: "",
        xueshengzhanghao: "",
        xueshengxingming: "",
      },

      rules: {
        qiyezhanghao: [],
        qiyemingcheng: [],
        gangweileixing: [],
        gongzuodidian: [],
        shixitupian: [],
        shixibaogao: [],
        shixineirong: [],
        dengjishijian: [],
        xueshengzhanghao: [],
        xueshengxingming: [],
      },
      centerType: false,
    };
  },
  computed: {},
  components: {},
  created() {
    if (this.$route.query.centerType) {
      this.centerType = true;
    }
    //this.bg();
    let type = this.$route.query.type ? this.$route.query.type : "";
    this.init(type);
    this.baseUrl = this.$config.baseUrl;
  },
  methods: {
    getMakeZero(s) {
      return s < 10 ? "0" + s : s;
    },
    // 下载
    download(file) {
      window.open(`${file}`);
    },
    // 初始化
    init(type) {
      this.type = type;
      if (type == "cross") {
        var obj = JSON.parse(localStorage.getItem("crossObj"));
        for (var o in obj) {
          if (o == "qiyezhanghao") {
            this.ruleForm.qiyezhanghao = obj[o];
            this.ro.qiyezhanghao = true;
            continue;
          }
          if (o == "qiyemingcheng") {
            this.ruleForm.qiyemingcheng = obj[o];
            this.ro.qiyemingcheng = true;
            continue;
          }
          if (o == "gangweileixing") {
            this.ruleForm.gangweileixing = obj[o];
            this.ro.gangweileixing = true;
            continue;
          }
          if (o == "gongzuodidian") {
            this.ruleForm.gongzuodidian = obj[o];
            this.ro.gongzuodidian = true;
            continue;
          }
          if (o == "shixitupian") {
            this.ruleForm.shixitupian = obj[o].split(",")[0];
            this.ro.shixitupian = true;
            continue;
          }
          if (o == "shixibaogao") {
            this.ruleForm.shixibaogao = obj[o];
            this.ro.shixibaogao = true;
            continue;
          }
          if (o == "shixineirong") {
            this.ruleForm.shixineirong = obj[o];
            this.ro.shixineirong = true;
            continue;
          }
          if (o == "dengjishijian") {
            this.ruleForm.dengjishijian = obj[o];
            this.ro.dengjishijian = true;
            continue;
          }
          if (o == "xueshengzhanghao") {
            this.ruleForm.xueshengzhanghao = obj[o];
            this.ro.xueshengzhanghao = true;
            continue;
          }
          if (o == "xueshengxingming") {
            this.ruleForm.xueshengxingming = obj[o];
            this.ro.xueshengxingming = true;
            continue;
          }
        }
      } else if (type == "edit") {
        this.info();
      }
      // 获取用户信息
      this.$http
        .get(this.userTableName + "/session", { emulateJSON: true })
        .then((res) => {
          if (res.data.code == 0) {
            var json = res.data.data;
            if (
              (json.xueshengzhanghao != "" && json.xueshengzhanghao) ||
              json.xueshengzhanghao == 0
            ) {
              this.ruleForm.xueshengzhanghao = json.xueshengzhanghao;
              this.ro.xueshengzhanghao = true;
            }
            if (
              (json.xueshengxingming != "" && json.xueshengxingming) ||
              json.xueshengxingming == 0
            ) {
              this.ruleForm.xueshengxingming = json.xueshengxingming;
              this.ro.xueshengxingming = true;
            }
          }
        });

      if (
        localStorage.getItem("raffleType") &&
        localStorage.getItem("raffleType") != null
      ) {
        localStorage.removeItem("raffleType");
        setTimeout(() => {
          this.onSubmit();
        }, 300);
      }
    },

    // 多级联动参数
    // 多级联动参数
    info() {
      this.$http
        .get(`shixiqingkuang/detail/${this.$route.query.id}`, {
          emulateJSON: true,
        })
        .then((res) => {
          if (res.data.code == 0) {
            this.ruleForm = res.data.data;
          }
        });
    },
    // 提交
    onSubmit() {
      //更新跨表属性
      var crossuserid;
      var crossrefid;
      var crossoptnum;
      this.$refs["ruleForm"].validate((valid) => {
        if (valid) {
          if (this.type == "cross") {
            var statusColumnName = localStorage.getItem("statusColumnName");
            var statusColumnValue = localStorage.getItem("statusColumnValue");
            if (statusColumnName && statusColumnName != "") {
              var obj = JSON.parse(localStorage.getItem("crossObj"));
              if (!statusColumnName.startsWith("[")) {
                for (var o in obj) {
                  if (o == statusColumnName) {
                    obj[o] = statusColumnValue;
                  }
                }
                var table = localStorage.getItem("crossTable");
                this.$http.post(table + "/update", obj).then((res) => {});
              } else {
                crossuserid = Number(localStorage.getItem("frontUserid"));
                crossrefid = obj["id"];
                crossoptnum = localStorage.getItem("statusColumnName");
                crossoptnum = crossoptnum.replace(/\[/, "").replace(/\]/, "");
              }
            }
          }
          if (crossrefid && crossuserid) {
            this.ruleForm.crossuserid = crossuserid;
            this.ruleForm.crossrefid = crossrefid;
            var params = {
              page: 1,
              limit: 10,
              crossuserid: crossuserid,
              crossrefid: crossrefid,
            };
            this.$http
              .get("shixiqingkuang/list", {
                params: params,
              })
              .then((res) => {
                if (res.data.data.total >= crossoptnum) {
                  this.$message({
                    message: localStorage.getItem("tips"),
                    type: "error",
                    duration: 1500,
                  });
                  return false;
                } else {
                  // 跨表计算

                  this.$http
                    .post(
                      `shixiqingkuang/${
                        this.ruleForm.id
                          ? "update"
                          : this.centerType
                          ? "save"
                          : "add"
                      }`,
                      this.ruleForm,
                    )
                    .then((res) => {
                      if (res.data.code == 0) {
                        this.$message({
                          message: "操作成功",
                          type: "success",
                          duration: 1500,
                          onClose: () => {
                            this.$router.go(-1);
                          },
                        });
                      } else {
                        this.$message({
                          message: res.data.msg,
                          type: "error",
                          duration: 1500,
                        });
                      }
                    });
                }
              });
          } else {
            this.$http
              .post(
                `shixiqingkuang/${
                  this.ruleForm.id ? "update" : this.centerType ? "save" : "add"
                }`,
                this.ruleForm,
              )
              .then((res) => {
                if (res.data.code == 0) {
                  this.$message({
                    message: "操作成功",
                    type: "success",
                    duration: 1500,
                    onClose: () => {
                      this.$router.go(-1);
                    },
                  });
                } else {
                  this.$message({
                    message: res.data.msg,
                    type: "error",
                    duration: 1500,
                  });
                }
              });
          }
        }
      });
    },
    // 获取uuid
    getUUID() {
      return new Date().getTime();
    },
    // 返回
    back() {
      this.$router.go(-1);
    },
    shixitupianUploadChange(fileUrls) {
      this.ruleForm.shixitupian = fileUrls.replace(
        new RegExp(this.$config.baseUrl, "g"),
        "",
      );
    },
    shixibaogaoUploadChange(fileUrls) {
      this.ruleForm.shixibaogao = fileUrls.replace(
        new RegExp(this.$config.baseUrl, "g"),
        "",
      );
    },
  },
};
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.el-date-editor.el-input {
  width: auto;
}

.add-update-preview .el-form-item ::v-deep .el-form-item__label {
  padding: 0 10px 0 0;
  color: #000;
  font-weight: 500;
  width: 80px;
  font-size: 14px;
  line-height: 40px;
  text-align: right;
}

.add-update-preview .el-form-item ::v-deep .el-form-item__content {
  margin-left: 80px;
}

.add-update-preview .el-input ::v-deep .el-input__inner {
  border: 1px solid #e2e3e5;
  border-radius: 0;
  padding: 0 12px;
  box-shadow: none;
  outline: none;
  color: #000;
  width: 400px;
  font-size: 14px;
  height: 40px;
}
.add-update-preview .el-input-number ::v-deep .el-input__inner {
  text-align: left;
  border: 1px solid #e2e3e5;
  border-radius: 0;
  padding: 0 12px;
  box-shadow: none;
  outline: none;
  color: #000;
  width: 400px;
  font-size: 14px;
  height: 40px;
}
.add-update-preview .el-input-number ::v-deep .el-input-number__decrease {
  display: none;
}
.add-update-preview .el-input-number ::v-deep .el-input-number__increase {
  display: none;
}

.add-update-preview .el-select ::v-deep .el-input__inner {
  border: 1px solid #e2e3e5;
  border-radius: 0;
  padding: 0 10px;
  box-shadow: none;
  outline: none;
  color: #000;
  width: 400px;
  font-size: 14px;
  height: 40px;
}

.add-update-preview .el-date-editor ::v-deep .el-input__inner {
  border: 1px solid #e2e3e5;
  border-radius: 0;
  padding: 0 10px 0 30px;
  box-shadow: none;
  outline: none;
  color: #000;
  width: 400px;
  font-size: 14px;
  height: 40px;
}

.add-update-preview ::v-deep .el-upload--picture-card {
  background: transparent;
  border: 0;
  border-radius: 0;
  width: auto;
  height: auto;
  line-height: initial;
  vertical-align: middle;
}

.add-update-preview ::v-deep .upload .upload-img {
  border: 1px solid #e2e3e5;
  cursor: pointer;
  border-radius: 6px;
  color: #000;
  width: 200px;
  font-size: 32px;
  line-height: 60px;
  text-align: center;
  height: 60px;
}

.add-update-preview ::v-deep .el-upload-list .el-upload-list__item {
  border: 1px solid #e2e3e5;
  cursor: pointer;
  border-radius: 6px;
  color: #000;
  width: 200px;
  font-size: 32px;
  line-height: 60px;
  text-align: center;
  height: 60px;
}

.add-update-preview ::v-deep .el-upload .el-icon-plus {
  border: 1px solid #e2e3e5;
  cursor: pointer;
  border-radius: 6px;
  color: #000;
  width: 200px;
  font-size: 32px;
  line-height: 60px;
  text-align: center;
  height: 60px;
}

.add-update-preview .el-textarea ::v-deep .el-textarea__inner {
  border: 1px solid #e2e3e5;
  border-radius: 0;
  padding: 12px;
  box-shadow: none;
  outline: none;
  color: #000;
  width: 400px;
  font-size: 14px;
  height: 120px;
}
</style>
