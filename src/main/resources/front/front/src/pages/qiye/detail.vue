<template>
  <div>
    <div
      :style="{
        padding: '20px 20px 20px 15%',
        margin: '10px auto 0',
        borderRadius: '27px',
        background:
          'url(http://codegen.caihongy.cn/20240120/d40775f482fb4eaa8a715212bf1ab10f.png)',
        width: '80%',
        backgroundSize: '100% 100%',
        backgroundRepeat: 'no-repeat',
      }"
      class="breadcrumb-preview"
    >
      <el-breadcrumb
        :separator="'Ξ'"
        :style="{ fontSize: '14px', lineHeight: '1' }"
      >
        <el-breadcrumb-item class="item1" to="/"
          ><a>首页</a></el-breadcrumb-item
        >
        <el-breadcrumb-item
          class="item2"
          v-for="(item, index) in breadcrumbItem"
          :key="index"
          :to="'/index/qiye?centerType=' + (centerType ? '1' : '0')"
          ><a>{{ item.name }}</a></el-breadcrumb-item
        >
        <el-breadcrumb-item class="item3"
          ><a href="javascript:void(0);">详情</a></el-breadcrumb-item
        >
      </el-breadcrumb>
    </div>
    <div
      :style="{
        padding: '20px 20px 20px 15%',
        margin: '10px auto 0',
        borderRadius: '27px',
        background:
          'url(http://codegen.caihongy.cn/20240120/d40775f482fb4eaa8a715212bf1ab10f.png)',
        width: '80%',
        backgroundSize: '100% 100%',
        backgroundRepeat: 'no-repeat',
      }"
    >
      <el-button size="mini" @click="backClick">返回</el-button>
    </div>
    <div
      class="detail-preview"
      :style="{
        padding: '30px 22px',
        margin: '10px auto',
        flexWrap: 'wrap',
        background: '#fff',
        display: 'flex',
        width: '60%',
        position: 'relative',
      }"
    >
      <div
        class="attr"
        :style="{
          minHeight: '75px',
          padding: '0',
          background: 'none',
          flex: '1',
          display: 'flex',
          width: '55%',
          position: 'relative',
          order: '2',
        }"
      >
        <div
          class="info"
          :style="{
            padding: '10px',
            margin: '0 0 0 0',
            background: '#fff',
            flex: '1',
          }"
        >
          <div
            class="item"
            :style="{
              padding: '10px',
              margin: '0 0 10px 0',
              alignItems: 'center',
              background: 'none',
              justifyContent: 'space-between',
              display: 'flex',
            }"
          >
            <div
              :style="{ color: '#000', fontSize: '18px', fontWeight: 'bold' }"
            >
              {{ detail.fuzeren }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '0px',
              margin: '0 0 10px 0',
              background: '#fff',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                whiteSpace: 'nowrap',
                color: '#9e9e9e',
                textAlign: 'right',
                width: '102px',
                fontSize: '14px',
                lineHeight: '24px',
              }"
            >
              企业账号
            </div>
            <div
              :style="{
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '24px',
                color: '#3B2626',
                flex: '1',
              }"
            >
              {{ detail.qiyezhanghao }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '0px',
              margin: '0 0 10px 0',
              background: '#fff',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                whiteSpace: 'nowrap',
                color: '#9e9e9e',
                textAlign: 'right',
                width: '102px',
                fontSize: '14px',
                lineHeight: '24px',
              }"
            >
              性别
            </div>
            <div
              :style="{
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '24px',
                color: '#3B2626',
                flex: '1',
              }"
            >
              {{ detail.xingbie }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '0px',
              margin: '0 0 10px 0',
              background: '#fff',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                whiteSpace: 'nowrap',
                color: '#9e9e9e',
                textAlign: 'right',
                width: '102px',
                fontSize: '14px',
                lineHeight: '24px',
              }"
            >
              手机号码
            </div>
            <div
              :style="{
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '24px',
                color: '#3B2626',
                flex: '1',
              }"
            >
              {{ detail.shoujihaoma }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '0px',
              margin: '0 0 10px 0',
              background: '#fff',
              display: 'flex',
            }"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                whiteSpace: 'nowrap',
                color: '#9e9e9e',
                textAlign: 'right',
                width: '102px',
                fontSize: '14px',
                lineHeight: '24px',
              }"
            >
              企业名称
            </div>
            <div
              :style="{
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '24px',
                color: '#3B2626',
                flex: '1',
              }"
            >
              {{ detail.qiyemingcheng }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '0px',
              margin: '0 0 10px 0',
              background: '#fff',
              display: 'flex',
            }"
            v-if="centerType"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                whiteSpace: 'nowrap',
                color: '#9e9e9e',
                textAlign: 'right',
                width: '102px',
                fontSize: '14px',
                lineHeight: '24px',
              }"
            >
              审核状态
            </div>
            <div
              :style="{
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '24px',
                color: '#3B2626',
                flex: '1',
              }"
            >
              {{
                detail.sfsh == "是"
                  ? "通过"
                  : detail.sfsh == "否"
                  ? "不通过"
                  : "待审核"
              }}
            </div>
          </div>
          <div
            class="item"
            :style="{
              padding: '0px',
              margin: '0 0 10px 0',
              background: '#fff',
              display: 'flex',
            }"
            v-if="centerType"
          >
            <div
              class="lable"
              :style="{
                padding: '0 10px',
                whiteSpace: 'nowrap',
                color: '#9e9e9e',
                textAlign: 'right',
                width: '102px',
                fontSize: '14px',
                lineHeight: '24px',
              }"
            >
              审核回复
            </div>
            <div
              :style="{
                padding: '0 10px',
                fontSize: '14px',
                lineHeight: '24px',
                color: '#3B2626',
                flex: '1',
              }"
            >
              {{ detail.shhf }}
            </div>
          </div>
          <div
            class="btn"
            :style="{
              padding: '10px 0',
              flexWrap: 'wrap',
              textAlign: 'left',
              display: 'block',
            }"
          >
            <el-button
              :style="{
                border: '0',
                cursor: 'pointer',
                padding: '0 10px',
                margin: '0 auto 10px',
                outline: 'none',
                color: '#fff',
                borderRadius: '10px',
                background: '#3554A4',
                width: 'auto',
                lineHeight: '40px',
                fontSize: '14px',
                height: '40px',
              }"
              v-if="
                btnAuth('qiye', '修改') &&
                detail.sfsh != '是' &&
                detail.sfsh != '否'
              "
              @click="editClick"
              >修改</el-button
            >
            <el-button
              :style="{
                border: '0',
                cursor: 'pointer',
                padding: '0 10px',
                margin: '0 auto 10px',
                outline: 'none',
                color: '#000',
                borderRadius: '10px',
                background: '#FFC174',
                width: 'auto',
                lineHeight: '40px',
                fontSize: '14px',
                height: '40px',
              }"
              v-if="btnAuth('qiye', '删除')"
              @click="delClick"
              >删除</el-button
            >
            <el-button
              :style="{
                border: '0',
                cursor: 'pointer',
                padding: '0 10px',
                margin: '0 auto 10px',
                outline: 'none',
                color: '#000',
                borderRadius: '10px',
                background: '#FFC174',
                width: 'auto',
                lineHeight: '40px',
                fontSize: '14px',
                height: '40px',
              }"
              v-if="btnAuth('qiye', '私聊') && detail.id != mid"
              @click="chatClick"
              >私聊</el-button
            >
            <el-button
              :style="{
                border: '0',
                cursor: 'pointer',
                padding: '0 10px',
                margin: '0 auto 10px',
                outline: 'none',
                color: '#000',
                borderRadius: '10px',
                background: '#FFC174',
                width: 'auto',
                lineHeight: '40px',
                fontSize: '14px',
                height: '40px',
              }"
              v-if="
                btnAuth('qiye', '审核') &&
                (detail.sfsh == '待审核' || !detail.sfsh)
              "
              @click="onSH"
              type="warning"
              >审核</el-button
            >
          </div>
        </div>
      </div>

      <el-carousel
        v-if="detailBanner.length"
        :style="{
          width: '45%',
          padding: '0',
          margin: '0',
          height: '480px',
          order: '1',
        }"
        trigger="click"
        indicator-position="inside"
        arrow="always"
        type="default"
        direction="horizontal"
        height="480px"
        :autoplay="false"
        :interval="3000"
        :loop="true"
      >
        <el-carousel-item
          :style="{ borderRadius: '10px', width: '100%', height: '100%' }"
          v-for="item in detailBanner"
          :key="item.id"
        >
          <img
            :style="{ objectFit: 'cover', width: '100%', height: '100%' }"
            :preview-src-list="[item]"
            v-if="item.substr(0, 4) == 'http'"
            :src="item"
            class="image"
          />
          <img
            :style="{ objectFit: 'cover', width: '100%', height: '100%' }"
            :preview-src-list="[baseUrl + item]"
            v-else
            :src="baseUrl + item"
            class="image"
          />
        </el-carousel-item>
      </el-carousel>

      <el-tabs
        class="detail"
        :style="{
          border: '0',
          width: '100%',
          boxShadow: 'none',
          margin: '20px 0',
          background: '#F7F5F7',
          order: '4',
        }"
        v-model="activeName"
        type="border-card"
      >
      </el-tabs>
      <el-dialog title="审核" :visible.sync="sfshVisiable" width="50%">
        <el-form ref="shForm" :model="shForm" label-width="80px">
          <el-form-item label="审核状态">
            <el-select v-model="shForm.sfsh" placeholder="审核状态">
              <el-option label="通过" value="是"></el-option>
              <el-option label="不通过" value="否"></el-option>
              <el-option label="待审核" value="待审核"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="内容">
            <el-input
              type="textarea"
              :rows="8"
              v-model="shForm.shhf"
            ></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="sfshVisiable = false">取 消</el-button>
          <el-button type="primary" @click="shHandler">确 定</el-button>
        </div>
      </el-dialog>
    </div>
    <div
      class="share_view"
      :style="{
        boxShadow: '0 1px 6px rgba(53, 84, 164, .3)',
        borderRadius: '0 10px 10px 0',
        left: '0',
        bottom: '20%',
        background: '#fff',
        width: '50px',
        position: 'fixed',
        zIndex: '11',
      }"
    ></div>
    <el-dialog :visible.sync="chatVisible" @close="clearChat" :title="fname">
      <div class="chat-content" id="chat-content">
        <div v-bind:key="item.id" v-for="item in chatList">
          <div v-if="item.uid == mid" class="right-content">
            <el-alert
              v-if="item.format == 1"
              class="text-content"
              :title="item.content"
              :closable="false"
              type="warning"
            ></el-alert>
            <el-image
              v-else
              fit="cover"
              :src="item.content ? baseUrl + item.content : ''"
              style="width: 100px; height: 100px"
              :preview-src-list="[item.content ? baseUrl + item.content : '']"
            ></el-image>
            <img
              :src="mpic ? baseUrl + mpic : require('@/assets/avator.png')"
              alt=""
              style="
                width: 30px;
                border-radius: 50%;
                height: 30px;
                margin: 0 0 0 10px;
              "
            />
          </div>
          <div v-else class="left-content">
            <img
              :src="fpic ? baseUrl + fpic : require('@/assets/avator.png')"
              alt=""
              style="
                width: 30px;
                border-radius: 50%;
                height: 30px;
                margin: 0 10px 0 0;
              "
            />
            <el-alert
              v-if="item.format == 1"
              class="text-content"
              :title="item.content"
              :closable="false"
              type="success"
            ></el-alert>
            <el-image
              v-else
              fit="cover"
              :src="item.content ? baseUrl + item.content : ''"
              style="width: 100px; height: 100px"
              :preview-src-list="[item.content ? baseUrl + item.content : '']"
            ></el-image>
          </div>
          <div class="clear-float"></div>
        </div>
      </div>
      <div slot="footer" class="dialog-footer">
        <el-input
          size="small"
          @keydown.enter.native="addChat"
          v-model="chatForm.content"
          placeholder="请输入内容"
          style="width: calc(100% - 240px); float: left"
        >
        </el-input>
        <el-button
          size="small"
          :disabled="chatForm.content ? false : true"
          type="primary"
          @click="addChat"
          >发送</el-button
        >
        <el-upload
          style="display: inline-block; margin: 0 6px"
          class="upload-demo"
          :action="uploadUrl"
          :on-success="uploadSuccess"
          :show-file-list="false"
        >
          <el-button size="small" type="success">上传图片</el-button>
        </el-upload>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";
import Swiper from "swiper";

export default {
  //数据集合
  data() {
    return {
      tablename: "qiye",
      baseUrl: "",
      breadcrumbItem: [
        {
          name: "企业",
        },
      ],
      title: "",
      detailBanner: [],
      userid: localStorage.getItem("frontUserid"),
      id: 0,
      detail: {},
      activeName: "first",
      total: 1,
      pageSize: 5,
      totalPage: 1,
      buynumber: 1,
      sfshVisiable: false,
      shForm: {
        sfsh: "是",
        shhf: "",
      },
      centerType: false,
      shareUrl: location.href,
      mid: localStorage.getItem("frontUserid"),
      chatVisible: false,
      chatList: [],
      chatForm: {
        content: "",
      },
      chatTimer: null,
      uploadUrl: this.$config.baseUrl + "file/upload",
      fpic: "",
      fname: "",
      fid: "",
      mpic: localStorage.getItem("frontHeadportrait"),
    };
  },
  created() {
    if (this.$route.query.centerType && this.$route.query.centerType != 0) {
      this.centerType = true;
    }

    this.init();
  },
  mounted() {},
  //方法集合
  methods: {
    init() {
      this.id = this.$route.query.id;
      this.baseUrl = this.$config.baseUrl;
      this.$http.get(this.tablename + "/detail/" + this.id, {}).then((res) => {
        if (res.data.code == 0) {
          this.detail = res.data.data;
          this.title = this.detail.fuzeren;
          this.detailBanner = this.detail.touxiang
            ? this.detail.touxiang.split(",")
            : [];
          if (res.data.data.touxiang) {
            this.fpic = res.data.data.touxiang.split(",")[0];
          } else if (res.data.data.headportrait) {
            this.fpic = res.data.data.headportrait.split(",")[0];
          }
          if (res.data.data.qiyezhanghao) {
            this.fname = res.data.data.qiyezhanghao;
          }
          this.fid = res.data.data.id;
          this.$forceUpdate();

          if (localStorage.getItem("frontToken")) {
          }
        }
      });
    },
    onSH() {
      this.sfshVisiable = true;
    },
    shHandler() {
      this.$confirm(`确定操作?`, "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      }).then(() => {
        this.detail.sfsh = this.shForm.sfsh;
        this.detail.shhf = this.shForm.shhf;
        this.$http.post(`${this.tablename}/update`, this.detail).then((res) => {
          if (res.data.code == 0) {
            this.sfshVisiable = false;
            this.$message({
              message: "操作成功",
              type: "success",
              duration: 1500,
            });
          }
        });
      });
    },
    curChange(page) {
      this.getDiscussList(page);
    },
    prevClick(page) {
      this.getDiscussList(page);
    },
    nextClick(page) {
      this.getDiscussList(page);
    },
    sizeChange(size) {
      this.pageSize = size;
      this.getDiscussList(1);
    },
    // 返回按钮
    backClick() {
      let params = {};
      if (this.centerType) {
        params.centerType = 1;
      }
      this.$router.push({ path: "/index/qiye", query: params });
    },
    // 下载
    download(file) {
      if (!file) {
        this.$message({
          type: "error",
          message: "文件不存在",
          duration: 1500,
        });
        return;
      }
      let arr = file.replace(new RegExp("upload/", "g"), "");
      axios
        .get(this.baseUrl + "/file/download?fileName=" + arr, {
          headers: {
            token: localStorage.getItem("frontToken"),
          },
          responseType: "blob",
        })
        .then(
          ({ data }) => {
            const binaryData = [];
            binaryData.push(data);
            const objectUrl = window.URL.createObjectURL(
              new Blob(binaryData, {
                type: "application/pdf;chartset=UTF-8",
              }),
            );
            const a = document.createElement("a");
            a.href = objectUrl;
            a.download = arr;
            // a.click()
            // 下面这个写法兼容火狐
            a.dispatchEvent(
              new MouseEvent("click", {
                bubbles: true,
                cancelable: true,
                view: window,
              }),
            );
            window.URL.revokeObjectURL(data);
          },
          (err) => {
            axios
              .get(
                (location.href.split(this.$config.name).length > 1
                  ? location.href.split(this.$config.name)[0]
                  : "") +
                  this.$config.name +
                  "/file/download?fileName=" +
                  arr,
                {
                  headers: {
                    token: localStorage.getItem("frontToken"),
                  },
                  responseType: "blob",
                },
              )
              .then(({ data }) => {
                const binaryData = [];
                binaryData.push(data);
                const objectUrl = window.URL.createObjectURL(
                  new Blob(binaryData, {
                    type: "application/pdf;chartset=UTF-8",
                  }),
                );
                const a = document.createElement("a");
                a.href = objectUrl;
                a.download = arr;
                // a.click()
                // 下面这个写法兼容火狐
                a.dispatchEvent(
                  new MouseEvent("click", {
                    bubbles: true,
                    cancelable: true,
                    view: window,
                  }),
                );
                window.URL.revokeObjectURL(data);
              });
          },
        );
    },

    // 权限判断
    btnAuth(tableName, key) {
      if (this.centerType) {
        return this.isBackAuth(tableName, key);
      } else {
        return this.isAuth(tableName, key);
      }
    },
    // 修改
    editClick() {
      this.$router.push(`/index/qiyeAdd?type=edit&&id=${this.detail.id}`);
    },
    // 删除
    async delClick() {
      await this.$confirm("是否删除此企业？")
        .then((_) => {
          this.$http.post("qiye/delete", [this.detail.id]).then(async (res) => {
            if (res.data.code == 0) {
              this.$message({
                type: "success",
                message: "删除成功!",
                duration: 1500,
                onClose: () => {
                  history.back();
                },
              });
            }
          });
        })
        .catch((_) => {});
    },
    chatClick() {
      this.getChatList();
      this.chatVisible = true;
    },
    getChatList() {
      this.$http
        .get("chatmessage/mlist", {
          params: {
            page: 1,
            limit: 1000,
            uid: Number(localStorage.getItem("frontUserid")),
            fid: this.fid,
          },
        })
        .then((res) => {
          if (res.data && res.data.code == 0) {
            this.chatList = res.data.data.list;
            let div = document.getElementsByClassName("chat-content")[0];
            setTimeout(() => {
              if (div) div.scrollTop = div.scrollHeight;
            }, 0);
            this.chatTimer = setTimeout(() => {
              this.getChatList();
            }, 5000);
          }
        });
    },
    clearChat() {
      clearTimeout(this.chatTimer);
    },
    uploadSuccess(res) {
      if (res.code == 0) {
        clearTimeout(this.chatTimer);
        this.$http
          .get("friend/page", {
            params: {
              uid: Number(localStorage.getItem("frontUserid")),
              fid: this.fid,
            },
          })
          .then((obj) => {
            if (obj.data && obj.data.code == 0) {
              if (!obj.data.data.list.length) {
                this.$http
                  .post("friend/add", {
                    uid: Number(localStorage.getItem("frontUserid")),
                    fid: this.fid,
                    name: this.fname,
                    picture: this.fpic,
                    type: 2,
                    tablename: "qiye",
                  })
                  .then((res) => {
                    this.$http
                      .post("friend/add", {
                        uid: this.fid,
                        fid: Number(localStorage.getItem("frontUserid")),
                        type: 2,
                        tablename: localStorage.getItem("frontSessionTable"),
                        name: localStorage.getItem("username"),
                        picture: this.mpic,
                      })
                      .then((res1) => {});
                  });
              }
              this.$http
                .post("chatmessage/add", {
                  uid: Number(localStorage.getItem("frontUserid")),
                  fid: this.fid,
                  content: "upload/" + res.file,
                  format: 2,
                })
                .then((res2) => {
                  this.chatForm = {
                    content: "",
                  };
                  this.getChatList();
                });
            }
          });
      }
    },
    addChat() {
      clearTimeout(this.chatTimer);
      this.$http
        .get("friend/page", {
          params: {
            uid: Number(localStorage.getItem("frontUserid")),
            fid: this.fid,
          },
        })
        .then((obj) => {
          if (obj.data && obj.data.code == 0) {
            if (!obj.data.data.list.length) {
              this.$http
                .post("friend/add", {
                  uid: Number(localStorage.getItem("frontUserid")),
                  fid: this.fid,
                  name: this.fname,
                  picture: this.fpic,
                  type: 2,
                  tablename: "qiye",
                })
                .then((res) => {
                  this.$http
                    .post("friend/add", {
                      uid: this.fid,
                      fid: Number(localStorage.getItem("frontUserid")),
                      type: 2,
                      tablename: localStorage.getItem("frontSessionTable"),
                      name: localStorage.getItem("username"),
                      picture: this.mpic,
                    })
                    .then((res1) => {});
                });
            }
            this.$http
              .post("chatmessage/add", {
                uid: Number(localStorage.getItem("frontUserid")),
                fid: this.fid,
                content: this.chatForm.content,
                format: 1,
              })
              .then((res2) => {
                this.chatForm = {
                  content: "",
                };
                this.getChatList();
              });
          }
        });
    },
  },
};
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.editor ::v-deep .avatar-uploader {
  height: 0;
  line-height: 0;
}

.detail-preview {
  .attr {
    .el-carousel ::v-deep .el-carousel__indicator button {
      width: 0;
      height: 0;
      display: none;
    }

    .el-input-number__decrease:hover:not(.is-disabled)
      ~ .el-input
      .el-input__inner:not(.is-disabled),
    .el-input-number__increase:hover:not(.is-disabled)
      ~ .el-input
      .el-input__inner:not(.is-disabled) {
      border-color: none;
    }
  }

  .detail {
    & ::v-deep .el-tabs__header .el-tabs__nav-wrap {
      margin-bottom: 0;
    }

    & .add .el-textarea {
      width: auto;
    }
  }
}

.attr .el-carousel ::v-deep .el-carousel__container .el-carousel__arrow--left {
  width: 36px;
  font-size: 12px;
  height: 36px;
}

.attr
  .el-carousel
  ::v-deep
  .el-carousel__container
  .el-carousel__arrow--left:hover {
  background: #fe6917;
}

.attr .el-carousel ::v-deep .el-carousel__container .el-carousel__arrow--right {
  width: 36px;
  font-size: 12px;
  height: 36px;
}

.attr
  .el-carousel
  ::v-deep
  .el-carousel__container
  .el-carousel__arrow--right:hover {
  background: #fe6917;
}

.attr .el-carousel ::v-deep .el-carousel__indicators {
  padding: 0;
  margin: 0;
  z-index: 2;
  position: absolute;
  list-style: none;
}

.attr .el-carousel ::v-deep .el-carousel__indicators li {
  padding: 0;
  margin: 0 4px;
  background: #fff;
  display: inline-block;
  width: 12px;
  opacity: 0.4;
  transition: 0.3s;
  height: 12px;
}

.attr .el-carousel ::v-deep .el-carousel__indicators li:hover {
  padding: 0;
  margin: 0 4px;
  background: #fe6917;
  display: inline-block;
  width: 24px;
  opacity: 0.7;
  height: 12px;
}

.attr .el-carousel ::v-deep .el-carousel__indicators li.is-active {
  padding: 0;
  margin: 0 4px;
  background: #fe6917;
  display: inline-block;
  width: 24px;
  opacity: 1;
  height: 12px;
}

.attr .el-input-number ::v-deep .el-input-number__decrease {
  cursor: pointer;
  z-index: 1;
  display: flex;
  border-color: #dcdfe6;
  border-radius: 4px 0 0 4px;
  top: 1px;
  left: 1px;
  background: #000;
  width: 40px;
  justify-content: center;
  border-width: 0 1px 0 0;
  align-items: center;
  position: absolute;
  border-style: solid;
  text-align: center;
  height: 38px;
}

.attr .el-input-number ::v-deep .el-input-number__decrease i {
  color: #fff;
  font-size: 14px;
}

.attr .el-input-number ::v-deep .el-input-number__increase {
  cursor: pointer;
  z-index: 1;
  display: flex;
  border-color: #dcdfe6;
  right: 1px;
  border-radius: 0 4px 4px 0;
  top: 1px;
  background: #000;
  width: 40px;
  justify-content: center;
  border-width: 0 0 0 1px;
  align-items: center;
  position: absolute;
  border-style: solid;
  text-align: center;
  height: 38px;
}

.attr .el-input-number ::v-deep .el-input-number__increase i {
  color: #fff;
  font-size: 14px;
}

.attr .el-input-number ::v-deep .el-input .el-input__inner {
  border: 1px solid #000;
  border-radius: 4px;
  padding: 0;
  color: #000;
  background: #fff;
  display: inline-block;
  width: 100%;
  font-size: 15px;
  line-height: 40px;
  text-align: center;
  height: 40px;
}

.detail-preview .detail.el-tabs ::v-deep .el-tabs__header {
  margin: 0;
  background: none;
  border-color: #fe6917;
  border-width: 20px 0 0;
  border-style: solid;
}

.detail-preview .detail.el-tabs ::v-deep .el-tabs__header .el-tabs__item {
  border: 0;
  padding: 0 20px;
  margin: 0 10px;
  color: #fff;
  font-weight: 500;
  display: inline-block;
  font-size: 14px;
  line-height: 40px;
  border-radius: 0 0 20px 20px;
  background: #9e9e9e;
  position: relative;
  list-style: none;
  height: 40px;
}

.detail-preview .detail.el-tabs ::v-deep .el-tabs__header .el-tabs__item:hover {
  border: 0;
  border-radius: 0 0 20px 20px;
  margin: 0 10px;
  color: #fff;
  background: #3554a4;
}

.detail-preview
  .detail.el-tabs
  ::v-deep
  .el-tabs__header
  .el-tabs__item.is-active {
  border: 0;
  border-radius: 0 0 20px 20px;
  margin: 0 10px;
  color: #fff;
  background: #3554a4;
}

.detail-preview .detail.el-tabs ::v-deep .el-tabs__content {
  padding: 15px;
}

.detail-preview .detail.el-tabs .add ::v-deep .el-form-item__label {
  padding: 0 10px 0 0;
  color: #666;
  width: 80px;
  font-size: 14px;
  line-height: 40px;
  text-align: right;
}

.detail-preview .detail.el-tabs .add ::v-deep .el-textarea__inner {
}

.breadcrumb-preview .el-breadcrumb ::v-deep .el-breadcrumb__separator {
  margin: 0 9px;
  color: #ccc;
  font-weight: 500;
}

.breadcrumb-preview .el-breadcrumb .item1 ::v-deep .el-breadcrumb__inner a {
  color: #000;
  display: inline-block;
}

.breadcrumb-preview .el-breadcrumb .item2 ::v-deep .el-breadcrumb__inner a {
  color: #000;
  display: inline-block;
}

.breadcrumb-preview .el-breadcrumb .item3 ::v-deep .el-breadcrumb__inner a {
  color: #000;
  display: inline-block;
}

#pagination.el-pagination ::v-deep .el-pagination__total {
  margin: 0 10px 0 0;
  color: #666;
  font-weight: 400;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .btn-prev {
  border: none;
  border-radius: 30px;
  padding: 0;
  margin: 0 5px;
  color: #fff;
  background: #3554a4;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  min-width: 35px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .btn-next {
  border: none;
  border-radius: 30px;
  padding: 0;
  margin: 0 5px;
  color: #fff;
  background: #3554a4;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  min-width: 35px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .btn-prev:disabled {
  border: none;
  cursor: not-allowed;
  border-radius: 30px;
  padding: 0;
  margin: 0 5px;
  color: #c0c4cc;
  background: #666;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .btn-next:disabled {
  border: none;
  cursor: not-allowed;
  border-radius: 30px;
  padding: 0;
  margin: 0 5px;
  color: #c0c4cc;
  background: #666;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .el-pager {
  padding: 0;
  margin: 0;
  display: inline-block;
  vertical-align: top;
}

#pagination.el-pagination ::v-deep .el-pager .number {
  cursor: pointer;
  padding: 0 4px;
  margin: 0 5px;
  color: #000;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  border-radius: 30px;
  background: #cbcbcb;
  text-align: center;
  min-width: 30px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .el-pager .number:hover {
  cursor: pointer;
  padding: 0 4px;
  margin: 0 5px;
  color: #fff;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  border-radius: 30px;
  background: #fe6917;
  text-align: center;
  min-width: 30px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .el-pager .number.active {
  cursor: default;
  padding: 0 4px;
  margin: 0 5px;
  color: #fff;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  border-radius: 30px;
  background: #fe6917;
  text-align: center;
  min-width: 30px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .el-pagination__sizes {
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .el-pagination__sizes .el-input {
  margin: 0 5px;
  width: 100px;
  position: relative;
}

#pagination.el-pagination
  ::v-deep
  .el-pagination__sizes
  .el-input
  .el-input__inner {
  border: 1px solid #dcdfe6;
  cursor: pointer;
  padding: 0 25px 0 8px;
  color: #606266;
  display: inline-block;
  font-size: 13px;
  line-height: 28px;
  border-radius: 3px;
  outline: 0;
  background: #fff;
  width: 100%;
  text-align: center;
  height: 28px;
}

#pagination.el-pagination
  ::v-deep
  .el-pagination__sizes
  .el-input
  span.el-input__suffix {
  top: 0;
  position: absolute;
  right: 0;
  height: 100%;
}

#pagination.el-pagination
  ::v-deep
  .el-pagination__sizes
  .el-input
  .el-input__suffix
  .el-select__caret {
  cursor: pointer;
  color: #c0c4cc;
  width: 25px;
  font-size: 14px;
  line-height: 28px;
  text-align: center;
}

#pagination.el-pagination ::v-deep .el-pagination__jump {
  margin: 0 0 0 24px;
  color: #606266;
  display: inline-block;
  vertical-align: top;
  font-size: 13px;
  line-height: 28px;
  height: 28px;
}

#pagination.el-pagination ::v-deep .el-pagination__jump .el-input {
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

#pagination.el-pagination
  ::v-deep
  .el-pagination__jump
  .el-input
  .el-input__inner {
  border: 1px solid #dcdfe6;
  cursor: pointer;
  padding: 0 3px;
  color: #606266;
  display: inline-block;
  font-size: 14px;
  line-height: 28px;
  border-radius: 3px;
  outline: 0;
  background: #fff;
  width: 100%;
  text-align: center;
  height: 28px;
}
.share_view {
  position: fixed;
  right: 0;
  bottom: 20%;
  background: #fff;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  .share {
    width: 40px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-bottom: 1px solid #eee;
    cursor: pointer;
  }
  .share:last-of-type {
    border: none;
  }
}

.detail-preview .el-rate ::v-deep .el-rate__item {
  cursor: pointer;
  display: inline-block;
  vertical-align: middle;
  font-size: 0;
  position: relative;
}

.detail-preview .el-rate ::v-deep .el-rate__item .el-rate__icon {
  margin: 0 3px;
  display: block;
  font-size: 18px;
  position: relative;
  transition: 0.3s;
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
</style>
