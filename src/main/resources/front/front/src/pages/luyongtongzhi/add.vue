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
        label="实习名称"
        prop="shiximingcheng"
      >
        <el-input
          v-model="ruleForm.shiximingcheng"
          placeholder="实习名称"
          clearable
          :disabled="false || ro.shiximingcheng"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="岗位类型"
        prop="gangweileixing"
      >
        <el-input
          v-model="ruleForm.gangweileixing"
          placeholder="岗位类型"
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
        label="封面"
        v-if="type != 'cross' || (type == 'cross' && !ro.fengmian)"
        prop="fengmian"
      >
        <file-upload
          tip="点击上传封面"
          action="file/upload"
          :limit="3"
          :multiple="true"
          :fileUrls="ruleForm.fengmian ? ruleForm.fengmian : ''"
          @change="fengmianUploadChange"
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
        label="封面"
        prop="fengmian"
      >
        <img
          v-if="ruleForm.fengmian.substring(0, 4) == 'http'"
          class="upload-img"
          style="margin-right: 20px"
          v-bind:key="index"
          :src="ruleForm.fengmian.split(',')[0]"
          width="100"
          height="100"
        />
        <img
          v-else
          class="upload-img"
          style="margin-right: 20px"
          v-bind:key="index"
          v-for="(item, index) in ruleForm.fengmian.split(',')"
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
        label="上班时间"
        prop="shangbanshijian"
      >
        <el-date-picker
          :disabled="false || ro.shangbanshijian"
          format="yyyy 年 MM 月 dd 日"
          value-format="yyyy-MM-dd"
          v-model="ruleForm.shangbanshijian"
          type="date"
          placeholder="上班时间"
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
        label="录用状态"
        prop="luyongzhuangtai"
      >
        <el-select
          v-model="ruleForm.luyongzhuangtai"
          placeholder="请选择录用状态"
          :disabled="false || ro.luyongzhuangtai"
        >
          <el-option
            v-for="(item, index) in luyongzhuangtaiOptions"
            :key="index"
            :label="item"
            :value="item"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="录用时间"
        prop="luyongshijian"
      >
        <el-date-picker
          :disabled="false || ro.luyongshijian"
          format="yyyy 年 MM 月 dd 日"
          value-format="yyyy-MM-dd"
          v-model="ruleForm.luyongshijian"
          type="date"
          placeholder="录用时间"
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
        label="负责人"
        prop="fuzeren"
      >
        <el-input
          v-model="ruleForm.fuzeren"
          placeholder="负责人"
          clearable
          :disabled="false || ro.fuzeren"
        ></el-input>
      </el-form-item>
      <el-form-item
        :style="{
          width: '49%',
          padding: '10px',
          margin: '0 0 10px',
          background: 'none',
        }"
        label="录用详情"
        prop="luyongxiangqing"
      >
        <el-input
          type="textarea"
          :rows="8"
          placeholder="录用详情"
          v-model="ruleForm.luyongxiangqing"
        >
        </el-input>
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
        xueshengzhanghao: false,
        xueshengxingming: false,
        qiyemingcheng: false,
        shiximingcheng: false,
        gangweileixing: false,
        fengmian: false,
        gongzuodidian: false,
        shangbanshijian: false,
        luyongzhuangtai: false,
        luyongshijian: false,
        luyongxiangqing: false,
        qiyezhanghao: false,
        fuzeren: false,
      },
      type: "",
      userTableName: localStorage.getItem("UserTableName"),
      ruleForm: {
        xueshengzhanghao: "",
        xueshengxingming: "",
        qiyemingcheng: "",
        shiximingcheng: "",
        gangweileixing: "",
        fengmian: "",
        gongzuodidian: "",
        shangbanshijian: "",
        luyongzhuangtai: "",
        luyongshijian: "",
        luyongxiangqing: "",
        qiyezhanghao: "",
        fuzeren: "",
      },
      luyongzhuangtaiOptions: [],

      rules: {
        xueshengzhanghao: [],
        xueshengxingming: [],
        qiyemingcheng: [],
        shiximingcheng: [],
        gangweileixing: [],
        fengmian: [],
        gongzuodidian: [],
        shangbanshijian: [],
        luyongzhuangtai: [],
        luyongshijian: [],
        luyongxiangqing: [],
        qiyezhanghao: [],
        fuzeren: [],
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
    this.ruleForm.luyongshijian = this.getCurDate();
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
          if (o == "qiyemingcheng") {
            this.ruleForm.qiyemingcheng = obj[o];
            this.ro.qiyemingcheng = true;
            continue;
          }
          if (o == "shiximingcheng") {
            this.ruleForm.shiximingcheng = obj[o];
            this.ro.shiximingcheng = true;
            continue;
          }
          if (o == "gangweileixing") {
            this.ruleForm.gangweileixing = obj[o];
            this.ro.gangweileixing = true;
            continue;
          }
          if (o == "fengmian") {
            this.ruleForm.fengmian = obj[o].split(",")[0];
            this.ro.fengmian = true;
            continue;
          }
          if (o == "gongzuodidian") {
            this.ruleForm.gongzuodidian = obj[o];
            this.ro.gongzuodidian = true;
            continue;
          }
          if (o == "shangbanshijian") {
            this.ruleForm.shangbanshijian = obj[o];
            this.ro.shangbanshijian = true;
            continue;
          }
          if (o == "luyongzhuangtai") {
            this.ruleForm.luyongzhuangtai = obj[o];
            this.ro.luyongzhuangtai = true;
            continue;
          }
          if (o == "luyongshijian") {
            this.ruleForm.luyongshijian = obj[o];
            this.ro.luyongshijian = true;
            continue;
          }
          if (o == "luyongxiangqing") {
            this.ruleForm.luyongxiangqing = obj[o];
            this.ro.luyongxiangqing = true;
            continue;
          }
          if (o == "qiyezhanghao") {
            this.ruleForm.qiyezhanghao = obj[o];
            this.ro.qiyezhanghao = true;
            continue;
          }
          if (o == "fuzeren") {
            this.ruleForm.fuzeren = obj[o];
            this.ro.fuzeren = true;
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
              (json.qiyemingcheng != "" && json.qiyemingcheng) ||
              json.qiyemingcheng == 0
            ) {
              this.ruleForm.qiyemingcheng = json.qiyemingcheng;
              this.ro.qiyemingcheng = true;
            }
            if (
              (json.qiyezhanghao != "" && json.qiyezhanghao) ||
              json.qiyezhanghao == 0
            ) {
              this.ruleForm.qiyezhanghao = json.qiyezhanghao;
              this.ro.qiyezhanghao = true;
            }
            if ((json.fuzeren != "" && json.fuzeren) || json.fuzeren == 0) {
              this.ruleForm.fuzeren = json.fuzeren;
              this.ro.fuzeren = true;
            }
          }
        });
      this.luyongzhuangtaiOptions = "已通过录用,未通过录用".split(",");

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
        .get(`luyongtongzhi/detail/${this.$route.query.id}`, {
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
              .get("luyongtongzhi/list", {
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
                      `luyongtongzhi/${
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
                `luyongtongzhi/${
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
    fengmianUploadChange(fileUrls) {
      this.ruleForm.fengmian = fileUrls.replace(
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
