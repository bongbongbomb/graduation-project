<template>
  <div class="main-containers">
    <div class="body-containers">
      <div class="top-container">
        <div class="top-brand" @click="goMenu('/index/home')">
          <span class="top-title"
            >基于Spring Boot的企业口碑智能分析系统的设计与实现</span
          >
        </div>

        <div class="menu-preview top-menu">
          <el-scrollbar wrap-class="scrollbar-wrapper-horizontal">
            <el-menu
              class="el-menu-horizontal-demo"
              :style="{
                border: 0,
                padding: '0',
                listStyle: 'none',
                margin: '0',
                background: 'transparent',
                display: 'flex',
                position: 'relative',
                justifyContent: 'flex-start',
                height: '60px',
                alignItems: 'center',
              }"
              :default-active="activeMenu"
              :unique-opened="true"
              mode="horizontal"
              :router="true"
              @select="handleSelect"
            >
              <el-menu-item
                class="home"
                index="/index/home"
                @click.native="goMenu('/index/home')"
              >
                <span class="icon iconfont icon-shouye-zhihui"></span>
                <span>系统首页</span>
              </el-menu-item>
              <el-menu-item
                class="item"
                v-for="(menu, index) in menuList"
                :index="menu.url"
                :key="index"
                @click.native="goMenu(menu.url)"
              >
                <i :class="iconArr[index]"></i>
                <span>{{ menu.name }}</span>
              </el-menu-item>
              <el-menu-item
                class="user"
                index="/index/center"
                v-if="Token && notAdmin"
                @click.native="goMenu('/index/center')"
              >
                <span class="icon iconfont icon-shouye-zhihui"></span>
                <span>个人中心</span>
              </el-menu-item>
            </el-menu>
          </el-scrollbar>
        </div>

        <div class="top-actions">
          <img
            v-if="headportrait && Token"
            class="top-avatar"
            :src="
              headportrait
                ? baseUrl + headportrait
                : require('@/assets/avator.png')
            "
          />
          <div v-if="Token" class="top-username">{{ username }}</div>
          <div
            v-if="Token && notAdmin"
            class="top-link"
            @click="goMenu('/index/center')"
          >
            个人中心
          </div>
          <el-button v-if="!Token" class="top-btn" @click="toLogin()"
            >登录/注册</el-button
          >
          <el-button v-if="Token" class="top-btn" @click="logout"
            >退出</el-button
          >
        </div>
      </div>

      <div class="banner-preview" :style="{ width: '100%', height: 'auto' }">
        <el-carousel
          :style="{ width: '100%', margin: '0 auto' }"
          trigger="click"
          indicator-position="inside"
          arrow="always"
          type="default"
          direction="horizontal"
          height="400px"
          :autoplay="true"
          :interval="3000"
          :loop="true"
        >
          <el-carousel-item
            :style="{ borderRadius: '0', width: '100%', height: '100%' }"
            v-for="item in carouselList"
            :key="item.id"
          >
            <el-image
              v-if="preHttp(item.value)"
              @click="carouselClick(item.url)"
              :style="{ objectFit: 'cover', width: '100%', height: '100%' }"
              :src="item.value"
              fit="cover"
            ></el-image>
            <el-image
              v-else
              @click="carouselClick(item.url)"
              :style="{ objectFit: 'cover', width: '100%', height: '100%' }"
              :src="baseUrl + item.value"
              fit="cover"
            ></el-image>
          </el-carousel-item>
        </el-carousel>
      </div>

      <router-view id="scrollView"></router-view>

      <div class="bottom-preview" :style="{ width: '100%', height: 'auto' }">
        <div
          :style="{
            minHeight: '100px',
            padding: '20px',
            overflow: 'hidden',
            color: '#fff',
            background: '#000',
            width: '100%',
            height: 'auto',
          }"
        >
          <div v-html="bottomContent"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Vue from "vue";

export default {
  data() {
    return {
      activeIndex: "0",
      roleMenus: [
        {
          backMenu: [
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "私聊"],
                  appFrontIcon: "cuIcon-wenzi",
                  buttons: ["新增", "查看", "修改", "删除"],
                  menu: "学生",
                  menuJump: "列表",
                  tableName: "xuesheng",
                },
              ],
              menu: "学生管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "审核", "私聊"],
                  appFrontIcon: "cuIcon-rank",
                  buttons: ["新增", "查看", "修改", "删除", "审核"],
                  menu: "企业",
                  menuJump: "列表",
                  tableName: "qiye",
                },
              ],
              menu: "企业管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除"],
                  appFrontIcon: "cuIcon-similar",
                  buttons: ["新增", "查看", "修改", "删除"],
                  menu: "岗位类型",
                  menuJump: "列表",
                  tableName: "gangweileixing",
                },
              ],
              menu: "岗位类型管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "审核",
                    "岗位类型统计",
                    "岗位薪资统计",
                    "首页总数",
                    "首页统计",
                    "私聊",
                    "申请",
                  ],
                  appFrontIcon: "cuIcon-goodsnew",
                  buttons: [
                    "查看",
                    "修改",
                    "删除",
                    "审核",
                    "首页总数",
                    "首页统计",
                  ],
                  menu: "实习岗位",
                  menuJump: "列表",
                  tableName: "shixigangwei",
                },
              ],
              menu: "实习岗位管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "录用通知"],
                  appFrontIcon: "cuIcon-time",
                  buttons: ["查看", "修改", "删除"],
                  menu: "实习申请",
                  menuJump: "列表",
                  tableName: "shixishenqing",
                },
              ],
              menu: "实习申请管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "录用结果统计",
                    "首页总数",
                    "首页统计",
                    "实习情况",
                  ],
                  appFrontIcon: "cuIcon-attentionfavor",
                  buttons: ["首页总数", "首页统计", "查看", "修改", "删除"],
                  menu: "录用通知",
                  menuJump: "列表",
                  tableName: "luyongtongzhi",
                },
              ],
              menu: "录用通知管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "实习报告"],
                  appFrontIcon: "cuIcon-explore",
                  buttons: ["查看", "修改", "删除"],
                  menu: "实习情况",
                  menuJump: "列表",
                  tableName: "shixiqingkuang",
                },
              ],
              menu: "实习情况管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "学生实习评分统计",
                    "首页总数",
                    "首页统计",
                  ],
                  appFrontIcon: "cuIcon-vip",
                  buttons: ["首页总数", "首页统计", "查看", "修改", "删除"],
                  menu: "实习报告",
                  menuJump: "列表",
                  tableName: "shixipingjia",
                },
              ],
              menu: "实习报告管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除"],
                  appFrontIcon: "cuIcon-news",
                  buttons: ["新增", "查看", "修改", "删除"],
                  menu: "公告资讯分类",
                  tableName: "newstype",
                },
                {
                  allButtons: ["新增", "查看", "修改", "删除"],
                  appFrontIcon: "cuIcon-news",
                  buttons: ["新增", "查看", "修改", "删除"],
                  menu: "公告资讯",
                  tableName: "news",
                },
                {
                  allButtons: ["新增", "查看", "修改", "删除"],
                  appFrontIcon: "cuIcon-medal",
                  buttons: ["查看", "修改"],
                  menu: "轮播图管理",
                  tableName: "config",
                },
                {
                  allButtons: ["查看", "删除"],
                  appFrontIcon: "cuIcon-goods",
                  buttons: ["查看", "删除"],
                  menu: "系统日志",
                  tableName: "syslog",
                },
                {
                  allButtons: ["查看", "修改"],
                  appFrontIcon: "cuIcon-flashlightopen",
                  buttons: ["查看", "修改"],
                  menu: "关于我们",
                  tableName: "aboutus",
                },
              ],
              menu: "系统管理",
            },
          ],
          frontMenu: [
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "审核",
                    "岗位类型统计",
                    "岗位薪资统计",
                    "首页总数",
                    "首页统计",
                    "私聊",
                    "申请",
                  ],
                  appFrontIcon: "cuIcon-phone",
                  buttons: ["查看", "私聊", "申请"],
                  menu: "实习岗位列表",
                  menuJump: "列表",
                  tableName: "shixigangwei",
                },
              ],
              menu: "实习岗位模块",
            },
          ],
          hasBackLogin: "是",
          hasBackRegister: "否",
          hasFrontLogin: "否",
          hasFrontRegister: "否",
          roleName: "管理员",
          tableName: "users",
        },
        {
          backMenu: [
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "录用通知"],
                  appFrontIcon: "cuIcon-time",
                  buttons: ["查看"],
                  menu: "实习申请",
                  menuJump: "列表",
                  tableName: "shixishenqing",
                },
              ],
              menu: "实习申请管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "录用结果统计",
                    "首页总数",
                    "首页统计",
                    "实习情况",
                  ],
                  appFrontIcon: "cuIcon-attentionfavor",
                  buttons: ["查看", "实习情况"],
                  menu: "录用通知",
                  menuJump: "列表",
                  tableName: "luyongtongzhi",
                },
              ],
              menu: "录用通知管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "实习报告"],
                  appFrontIcon: "cuIcon-explore",
                  buttons: ["查看"],
                  menu: "实习情况",
                  menuJump: "列表",
                  tableName: "shixiqingkuang",
                },
              ],
              menu: "实习情况管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "学生实习评分统计",
                    "首页总数",
                    "首页统计",
                  ],
                  appFrontIcon: "cuIcon-vip",
                  buttons: ["查看"],
                  menu: "实习报告",
                  menuJump: "列表",
                  tableName: "shixipingjia",
                },
              ],
              menu: "实习报告管理",
            },
          ],
          frontMenu: [
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "审核",
                    "岗位类型统计",
                    "岗位薪资统计",
                    "首页总数",
                    "首页统计",
                    "私聊",
                    "申请",
                  ],
                  appFrontIcon: "cuIcon-phone",
                  buttons: ["查看", "私聊", "申请"],
                  menu: "实习岗位列表",
                  menuJump: "列表",
                  tableName: "shixigangwei",
                },
              ],
              menu: "实习岗位模块",
            },
          ],
          hasBackLogin: "否",
          hasBackRegister: "否",
          hasFrontLogin: "是",
          hasFrontRegister: "是",
          roleName: "学生",
          tableName: "xuesheng",
        },
        {
          backMenu: [
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "审核",
                    "岗位类型统计",
                    "岗位薪资统计",
                    "首页总数",
                    "首页统计",
                    "私聊",
                    "申请",
                  ],
                  appFrontIcon: "cuIcon-goodsnew",
                  buttons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "首页总数",
                    "首页统计",
                  ],
                  menu: "实习岗位",
                  menuJump: "列表",
                  tableName: "shixigangwei",
                },
              ],
              menu: "实习岗位管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "录用通知"],
                  appFrontIcon: "cuIcon-time",
                  buttons: ["查看", "录用通知"],
                  menu: "实习申请",
                  menuJump: "列表",
                  tableName: "shixishenqing",
                },
              ],
              menu: "实习申请管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "录用结果统计",
                    "首页总数",
                    "首页统计",
                    "实习情况",
                  ],
                  appFrontIcon: "cuIcon-attentionfavor",
                  buttons: ["查看", "修改", "删除", "首页总数", "首页统计"],
                  menu: "录用通知",
                  menuJump: "列表",
                  tableName: "luyongtongzhi",
                },
              ],
              menu: "录用通知管理",
            },
            {
              child: [
                {
                  allButtons: ["新增", "查看", "修改", "删除", "实习报告"],
                  appFrontIcon: "cuIcon-explore",
                  buttons: ["查看", "实习报告"],
                  menu: "实习情况",
                  menuJump: "列表",
                  tableName: "shixiqingkuang",
                },
              ],
              menu: "实习情况管理",
            },
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "学生实习评分统计",
                    "首页总数",
                    "首页统计",
                  ],
                  appFrontIcon: "cuIcon-vip",
                  buttons: ["查看", "首页总数", "首页统计"],
                  menu: "实习报告",
                  menuJump: "列表",
                  tableName: "shixipingjia",
                },
              ],
              menu: "实习报告管理",
            },
          ],
          frontMenu: [
            {
              child: [
                {
                  allButtons: [
                    "新增",
                    "查看",
                    "修改",
                    "删除",
                    "审核",
                    "岗位类型统计",
                    "岗位薪资统计",
                    "首页总数",
                    "首页统计",
                    "私聊",
                    "申请",
                  ],
                  appFrontIcon: "cuIcon-phone",
                  buttons: ["查看", "私聊", "申请"],
                  menu: "实习岗位列表",
                  menuJump: "列表",
                  tableName: "shixigangwei",
                },
              ],
              menu: "实习岗位模块",
            },
          ],
          hasBackLogin: "是",
          hasBackRegister: "是",
          hasFrontLogin: "否",
          hasFrontRegister: "否",
          roleName: "企业",
          tableName: "qiye",
        },
      ],
      baseUrl: "",
      carouselList: [],
      menuList: [],
      form: {
        ask: "",
        userid: localStorage.getItem("frontUserid"),
      },
      headportrait: localStorage.getItem("frontHeadportrait")
        ? localStorage.getItem("frontHeadportrait")
        : "",
      Token: localStorage.getItem("frontToken"),
      username: localStorage.getItem("username"),
      notAdmin: localStorage.getItem("frontSessionTable") != '"users"',
      timer: "",
      iconArr: [
        "el-icon-star-off",
        "el-icon-goods",
        "el-icon-warning",
        "el-icon-question",
        "el-icon-info",
        "el-icon-help",
        "el-icon-picture-outline-round",
        "el-icon-camera-solid",
        "el-icon-video-camera-solid",
        "el-icon-video-camera",
        "el-icon-bell",
        "el-icon-s-cooperation",
        "el-icon-s-order",
        "el-icon-s-platform",
        "el-icon-s-operation",
        "el-icon-s-promotion",
        "el-icon-s-release",
        "el-icon-s-ticket",
        "el-icon-s-management",
        "el-icon-s-open",
        "el-icon-s-shop",
        "el-icon-s-marketing",
        "el-icon-s-flag",
        "el-icon-s-comment",
        "el-icon-s-finance",
        "el-icon-s-claim",
        "el-icon-s-opportunity",
        "el-icon-s-data",
        "el-icon-s-check",
      ],
      bottomContent: "",
    };
  },
  created() {
    this.baseUrl = this.$config.baseUrl;
    this.menuList = this.$config.indexNav;
    this.getCarousel();
    if (
      localStorage.getItem("frontToken") &&
      localStorage.getItem("frontToken") != null
    ) {
      this.getSession();
    }
  },
  mounted() {
    this.activeIndex = localStorage.getItem("keyPath") || "0";
  },
  computed: {
    activeMenu() {
      const route = this.$route;
      const { meta, path } = route;
      // if st path, the sidebar will highlight the path you sete
      if (meta.activeMenu) {
        return meta.activeMenu;
      }
      return path;
    },
  },
  watch: {
    $route(newValue) {
      let url = window.location.href;
      let arr = url.split("#");
      for (let x in this.menuList) {
        if (newValue.path == this.menuList[x].url) {
          this.activeIndex = x;
        }
      }
      this.Token = localStorage.getItem("frontToken");
      if (arr[1] != "/index/home") {
        var element = document.getElementById("scrollView");
        var distance = element.offsetTop;
        window.scrollTo(0, distance);
      } else {
        window.scrollTo(0, 0);
      }
    },
    headportrait() {
      this.$forceUpdate();
    },
  },
  methods: {
    preHttp(str) {
      return str && str.substr(0, 4) == "http";
    },

    async getSession() {
      await this.$http
        .get(`${localStorage.getItem("UserTableName")}/session`, {
          emulateJSON: true,
        })
        .then(async (res) => {
          if (res.data.code == 0) {
            localStorage.setItem("sessionForm", JSON.stringify(res.data.data));
            localStorage.setItem("frontUserid", res.data.data.id);
            if (res.data.data.vip) {
              localStorage.setItem("vip", res.data.data.vip);
            }
            if (res.data.data.touxiang) {
              this.headportrait = res.data.data.touxiang;
              localStorage.setItem("frontHeadportrait", res.data.data.touxiang);
            } else if (res.data.data.headportrait) {
              this.headportrait = res.data.data.headportrait;
              localStorage.setItem(
                "frontHeadportrait",
                res.data.data.headportrait,
              );
            }
          }
        });
    },
    handleSelect(keyPath) {
      if (keyPath) {
        localStorage.setItem("keyPath", keyPath);
      }
    },
    toLogin() {
      this.$router.push("/login");
    },
    logout() {
      localStorage.clear();
      Vue.http.headers.common["Token"] = "";
      this.$router.push("/index/home");
      this.activeIndex = "0";
      localStorage.setItem("keyPath", this.activeIndex);
      this.Token = "";
      this.$forceUpdate();
      this.$message({
        message: "登出成功",
        type: "success",
        duration: 1000,
      });
    },
    getCarousel() {
      this.$http
        .get("config/list", { params: { page: 1, limit: 3 } })
        .then((res) => {
          if (res.data.code == 0) {
            this.carouselList = res.data.data.list;
          }
        });
    },
    // 轮播图跳转
    carouselClick(url) {
      if (url) {
        if (url.indexOf("https") != -1) {
          window.open(url);
        } else {
          this.$router.push(url);
        }
      }
    },
    goBackend() {
      localStorage.setItem("Token", localStorage.getItem("frontToken"));
      localStorage.setItem("role", localStorage.getItem("frontRole"));
      localStorage.setItem(
        "sessionTable",
        localStorage.getItem("frontSessionTable"),
      );
      localStorage.setItem(
        "headportrait",
        localStorage.getItem("frontHeadportrait"),
      );
      localStorage.setItem("userid", localStorage.getItem("frontUserid"));
      window.location.href = `${this.$config.baseUrl}admin/dist/index.html`;
    },
    goMenu(path) {
      this.$router.push(path);
    },
  },
};
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.body-containers {
  min-height: 100vh;
  padding: 96px 0 0;
  margin: 0;
  position: relative;
  background: #f7f5f7;
}

.top-container {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 96px;
  z-index: 1002;
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 0 18px;
  background: rgba(255, 255, 255, 0.92);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(15, 23, 42, 0.08);
  box-shadow: 0 12px 30px rgba(0, 0, 0, 0.12);
}

.top-brand {
  display: flex;
  align-items: center;
  gap: 12px;
  cursor: pointer;
  flex: 0 0 auto;
}

.top-logo {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
}

.top-title {
  font-size: 20px;
  font-weight: 800;
  color: #1e3a8a;
  white-space: nowrap;
  letter-spacing: 0.2px;
}

.top-menu {
  flex: 1;
  min-width: 0;
}

.top-actions {
  display: flex;
  align-items: center;
  gap: 10px;
  flex: 0 0 auto;
}

.top-avatar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid rgba(255, 255, 255, 0.9);
  box-shadow: 0 10px 18px rgba(0, 0, 0, 0.16);
}

.top-username {
  color: rgba(15, 23, 42, 0.78);
  font-size: 14px;
  font-weight: 700;
}

.top-link {
  color: rgba(30, 58, 138, 0.9);
  font-size: 14px;
  font-weight: 700;
  padding: 8px 10px;
  border-radius: 12px;
  cursor: pointer;
  transition: background 0.15s ease, color 0.15s ease;
}

.top-link:hover {
  background: rgba(30, 58, 138, 0.08);
}

.top-btn.el-button {
  border: 1px solid rgba(15, 23, 42, 0.12);
  background: rgba(255, 255, 255, 0.8);
  color: rgba(15, 23, 42, 0.78);
  border-radius: 12px;
  padding: 10px 12px;
  font-weight: 700;
}

.top-btn.el-button:hover,
.top-btn.el-button:focus {
  border-color: rgba(99, 102, 241, 0.35);
  background: rgba(255, 255, 255, 1);
  color: rgba(30, 58, 138, 0.95);
}

.menu-preview {
  .el-scrollbar {
    height: 100%;

    & ::v-deep .scrollbar-wrapper-vertical {
      overflow-x: hidden;
    }

    & ::v-deep .scrollbar-wrapper-horizontal {
      overflow-y: hidden;

      .el-scrollbar__view {
        white-space: nowrap;
      }
    }
  }
}

.menu-preview .el-menu-horizontal-demo .el-menu-item {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  height: 40px;
  line-height: 40px;
  border-radius: 14px;
  margin: 0 6px;
  padding: 0 14px;
  border: 1px solid transparent;
  background: transparent;
  transition: background 0.15s ease, border-color 0.15s ease, color 0.15s ease,
    transform 0.15s ease;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item .icon,
.menu-preview .el-menu-horizontal-demo .el-menu-item i {
  font-size: 16px;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.home,
.menu-preview .el-menu-horizontal-demo .el-menu-item.item {
  color: rgba(15, 23, 42, 0.78);
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.home:hover,
.menu-preview .el-menu-horizontal-demo .el-menu-item.item:hover {
  background: rgba(99, 102, 241, 0.08);
  border-color: rgba(99, 102, 241, 0.18);
  transform: translateY(-1px);
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.home.is-active,
.menu-preview .el-menu-horizontal-demo .el-menu-item.item.is-active {
  color: rgba(99, 102, 241, 1);
  background: rgba(99, 102, 241, 0.12);
  border-color: rgba(99, 102, 241, 0.25);
  font-weight: 800;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.user {
  cursor: pointer;
  border: 0;
  padding: 0 20px;
  color: #333;
  white-space: nowrap;
  display: none;
  font-size: 14px;
  line-height: 56px;
  background: #fff;
  align-items: center;
  position: relative;
  list-style: none;
  height: 56px;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.user:hover {
  color: #fff;
  background: red;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.user.is-active {
  color: #fff;
  background: blue;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.service {
  cursor: pointer;
  border: 0;
  padding: 0 20px;
  color: #333;
  white-space: nowrap;
  display: none;
  font-size: 14px;
  line-height: 56px;
  background: #fff;
  align-items: center;
  position: relative;
  list-style: none;
  height: 56px;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.service:hover {
  color: #fff;
  background: red;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.service.is-active {
  color: #fff;
  background: blue;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.shop {
  cursor: pointer;
  border: 1px solid #000;
  padding: 0 5px;
  color: #000;
  white-space: nowrap;
  display: flex;
  font-size: 18px;
  line-height: 36px;
  background: none;
  border-width: 0 0 0 2px;
  align-items: center;
  position: relative;
  list-style: none;
  height: 36px;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.shop:hover {
  color: #fe6917;
  background: none;
  font-weight: bold;
  border-color: #fe6917;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.shop.is-active {
  color: #fe6917;
  background: none;
  font-weight: bold;
  border-color: #fe6917;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.back {
  cursor: pointer;
  border: 1px solid #000;
  padding: 0 5px;
  color: #000;
  white-space: nowrap;
  display: flex;
  font-size: 18px;
  line-height: 36px;
  background: none;
  border-width: 0 0 0 2px;
  align-items: center;
  position: relative;
  list-style: none;
  height: 36px;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.back:hover {
  color: #fe6917;
  background: none;
  font-weight: bold;
  border-color: #fe6917;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.back.is-active {
  color: #fe6917;
  background: none;
  font-weight: bold;
  border-color: #fe6917;
}

.menu-preview .el-menu-horizontal-demo .el-menu-item.item {
  border: 1px solid transparent;
}

.banner-preview {
  .el-carousel ::v-deep .el-carousel__indicator button {
    width: 0;
    height: 0;
    display: none;
  }
}

.banner-preview
  .el-carousel
  ::v-deep
  .el-carousel__container
  .el-carousel__arrow--left {
  width: 36px;
  font-size: 12px;
  height: 36px;
}

.banner-preview
  .el-carousel
  ::v-deep
  .el-carousel__container
  .el-carousel__arrow--left:hover {
  background: red;
}

.banner-preview
  .el-carousel
  ::v-deep
  .el-carousel__container
  .el-carousel__arrow--right {
  width: 36px;
  font-size: 12px;
  height: 36px;
}

.banner-preview
  .el-carousel
  ::v-deep
  .el-carousel__container
  .el-carousel__arrow--right:hover {
  background: red;
}

.banner-preview .el-carousel ::v-deep .el-carousel__indicators {
  padding: 0;
  margin: 0;
  z-index: 2;
  position: absolute;
  list-style: none;
}

.banner-preview .el-carousel ::v-deep .el-carousel__indicators li {
  padding: 0;
  margin: 0 4px;
  background: #3554a4;
  display: inline-block;
  width: 12px;
  opacity: 0.8;
  transition: 0.3s;
  height: 12px;
}

.banner-preview .el-carousel ::v-deep .el-carousel__indicators li:hover {
  padding: 0;
  margin: 0 4px;
  background: #fe6917;
  display: inline-block;
  width: 24px;
  opacity: 0.7;
  height: 12px;
}

.banner-preview .el-carousel ::v-deep .el-carousel__indicators li.is-active {
  padding: 0;
  margin: 0 4px;
  background: #fe6917;
  display: inline-block;
  width: 24px;
  opacity: 1;
  height: 12px;
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
  }

  .right-content {
    float: right;
    margin-bottom: 10px;
    padding: 10px;
    max-width: 80%;
  }
}

.clear-float {
  clear: both;
}

// -------- search --------
.main-containers .search .select ::v-deep .el-input__inner {
  border: 0;
  border-radius: 4px;
  padding: 0 30px 0 10px;
  box-shadow: 0 0 6px rgba(64, 158, 255, 0.3);
  outline: none;
  color: rgba(64, 158, 255, 1);
  width: 180px;
  font-size: 14px;
  height: 44px;
}

.main-containers .search .input ::v-deep .el-input__inner {
  border: 0;
  border-radius: 4px;
  padding: 0 10px;
  box-shadow: 0 0 6px rgba(64, 158, 255, 0.3);
  outline: none;
  color: rgba(64, 158, 255, 1);
  width: 180px;
  font-size: 14px;
  height: 44px;
}
// -------- search --------

.main-containers .btn-service {
  border: 0;
  padding: 0;
  margin: 0 10px;
  color: #3554a4;
  background: none;
  width: auto;
  font-size: 16px;
  line-height: 90px;
  height: 90px;
  order: 4;
}

.main-containers .btn-service:hover {
  opacity: 0.8;
}

.main-containers .btn-shop {
  border: 0;
  padding: 0;
  margin: 0 10px;
  color: #3554a4;
  background: none;
  display: none;
  width: auto;
  font-size: 16px;
  line-height: 90px;
  height: 90px;
}

.main-containers .btn-shop:hover {
  opacity: 0.8;
}
</style>
