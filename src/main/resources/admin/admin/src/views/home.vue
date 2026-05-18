<template>
<div class="content" :style='{"minHeight":"100vh","padding":"30px","alignItems":"flex-start","flexWrap":"wrap","background":"url(http://codegen.caihongy.cn/20240220/927b2d08dcdb48b3af07cef8d1a59f59.png) no-repeat center top / cover","display":"flex","width":"100%"}'>
	<!-- notice -->
	<!-- title -->
	<div class="text" :style='{"width":"100%","margin":"20px auto","fontSize":"30px","color":"rgb(51, 51, 51)","textAlign":"center","fontWeight":"bold"}'>欢迎使用 {{this.$project.projectName}}</div>
	<!-- statis -->
	<div v-if="!isCompanyRole" :style='{"width":"100%","margin":"0 0 20px 0","alignItems":"center","justifyContent":"center","display":"flex"}'>
		<div :style='{"border":"1px solid  #f0f0f0","margin":"0 10px","borderRadius":"4px","background":"#ffffff","display":"flex"}' v-if="isAuth('shixigangwei','首页总数')">
			<div :style='{"width":"80px","alignItems":"center","justifyContent":"center","display":"flex","height":"80px"}'>
				<span class="icon iconfont icon-tongji5" :style='{"color":"#f7b36b","fontSize":"24px"}'></span>
			</div>
			<div :style='{"width":"160px","flexDirection":"column","justifyContent":"center","display":"flex"}'>
				<div :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"20px","color":"#333","fontWeight":"bold","height":"24px"}'>{{shixigangweiCount}}</div>
				<div :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"16px","color":"#666","height":"24px"}'>实习岗位总数</div>
			</div>
		</div>
		<div :style='{"border":"1px solid rgb(240, 240, 240)","margin":"0 10px","borderRadius":"4px","background":"rgb(255, 255, 255)","display":"flex"}' v-if="isAuth('luyongtongzhi','首页总数')">
			<div :style='{"width":"80px","alignItems":"center","justifyContent":"center","display":"flex","height":"80px"}'>
				<span class="icon iconfont icon-tongji5" :style='{"color":"rgb(247, 179, 107)","fontSize":"24px"}'></span>
			</div>
			<div :style='{"width":"160px","flexDirection":"column","justifyContent":"center","display":"flex"}'>
				<div :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"20px","color":"#333","fontWeight":"bold","height":"24px"}'>{{luyongtongzhiCount}}</div>
				<div :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"16px","color":"#666","height":"24px"}'>录用通知总数</div>
			</div>
		</div>
		<div :style='{"border":"1px solid rgb(240, 240, 240)","margin":"0 10px","borderRadius":"4px","background":"rgb(255, 255, 255)","display":"flex"}' v-if="isAuth('shixipingjia','首页总数')">
			<div :style='{"width":"80px","alignItems":"center","justifyContent":"center","display":"flex","height":"80px"}'>
				<span class="icon iconfont icon-tongji5" :style='{"color":"rgb(247, 179, 107)","fontSize":"24px"}'></span>
			</div>
			<div :style='{"width":"160px","flexDirection":"column","justifyContent":"center","display":"flex"}'>
				<div :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"20px","color":"#333","fontWeight":"bold","height":"24px"}'>{{shixipingjiaCount}}</div>
				<div :style='{"margin":"5px 0","lineHeight":"24px","fontSize":"16px","color":"#666","height":"24px"}'>实习报告总数</div>
			</div>
		</div>
	</div>
	<!-- statis -->
	

	<div v-if="isCompanyRole" :style='{"width":"100%","margin":"0 0 20px 0","display":"flex"}'>
		<div :style='{"border":"1px solid #f0f0f0","borderRadius":"6px","background":"#ffffff","padding":"18px 20px","width":"100%"}' v-loading="companyReputationLoading">
			<div :style='{"display":"flex","alignItems":"center","justifyContent":"space-between","flexWrap":"wrap"}'>
				<div :style='{"fontSize":"18px","fontWeight":"700","color":"#333","lineHeight":"26px"}'>企业口碑概览</div>
				<div :style='{"display":"flex","alignItems":"center","gap":"10px","flexWrap":"wrap"}'>
					<el-button size="mini" type="primary" :loading="companyReputationLoading" @click="refreshCompanyReputation">刷新</el-button>
					<el-button size="mini" type="success" @click="companyLlmVisible=true">智能分析</el-button>
				</div>
			</div>

			<div :style='{"margin":"12px 0 0","display":"flex","gap":"14px","flexWrap":"wrap"}'>
				<div :style='{"border":"1px solid #f0f0f0","borderRadius":"6px","padding":"12px 14px","minWidth":"220px"}'>
					<div :style='{"fontSize":"13px","color":"#666","lineHeight":"18px"}'>企业名称</div>
					<div :style='{"margin":"6px 0 0","fontSize":"16px","fontWeight":"700","color":"#333","lineHeight":"22px"}'>{{companyInfo.qiyemingcheng || '-'}}</div>
				</div>
				<div :style='{"border":"1px solid #f0f0f0","borderRadius":"6px","padding":"12px 14px","minWidth":"220px"}'>
					<div :style='{"fontSize":"13px","color":"#666","lineHeight":"18px"}'>口碑指数</div>
					<div :style='{"margin":"6px 0 0","display":"flex","alignItems":"baseline","gap":"10px","flexWrap":"wrap"}'>
						<div :style='{"fontSize":"22px","fontWeight":"800","color":"#16a34a","lineHeight":"28px"}'>{{companyReputationScore}}</div>
						<div :style='{"fontSize":"13px","color":"#666","lineHeight":"18px"}'>/ 100</div>
					</div>
				</div>
				<div :style='{"border":"1px solid #f0f0f0","borderRadius":"6px","padding":"12px 14px","minWidth":"220px"}'>
					<div :style='{"fontSize":"13px","color":"#666","lineHeight":"18px"}'>实习评价数量</div>
					<div :style='{"margin":"6px 0 0","fontSize":"22px","fontWeight":"800","color":"#333","lineHeight":"28px"}'>{{companyReviews.length}}</div>
				</div>
			</div>

			<div :style='{"margin":"14px 0 0"}'>
				<div :style='{"fontSize":"14px","fontWeight":"700","color":"#333","lineHeight":"22px","margin":"0 0 8px 0"}'>高频关键词</div>
				<div v-if="companyHotWords.length" :style='{"display":"flex","gap":"8px","flexWrap":"wrap"}'>
					<el-tag v-for="w in companyHotWords" :key="w.word" size="mini">{{w.word}} {{w.count}}</el-tag>
				</div>
				<el-empty v-else description="暂无可统计的关键词"></el-empty>
			</div>

			<div :style='{"margin":"14px 0 0"}'>
				<div :style='{"fontSize":"14px","fontWeight":"700","color":"#333","lineHeight":"22px","margin":"0 0 8px 0"}'>最新实习评价摘录</div>
				<div v-if="companyReviewExcerpts.length" :style='{"display":"flex","flexDirection":"column","gap":"10px"}'>
					<div v-for="item in companyReviewExcerpts" :key="item.key" :style='{"border":"1px dashed #e5e7eb","borderRadius":"6px","padding":"10px 12px"}'>
						<div :style='{"display":"flex","alignItems":"center","justifyContent":"space-between","gap":"10px","flexWrap":"wrap"}'>
							<div :style='{"fontSize":"13px","color":"#111827","fontWeight":"700"}'>{{item.title}}</div>
							<div :style='{"fontSize":"12px","color":"#6b7280"}'>{{item.time}}</div>
						</div>
						<div :style='{"margin":"6px 0 0","fontSize":"13px","color":"#374151","lineHeight":"20px"}'>{{item.text}}</div>
					</div>
				</div>
				<el-empty v-else description="暂无实习评价内容"></el-empty>
			</div>

			<div :style='{"margin":"14px 0 0"}'>
				<div :style='{"fontSize":"14px","fontWeight":"700","color":"#333","lineHeight":"22px","margin":"0 0 8px 0"}'>智能口碑摘要</div>
				<div v-if="companyLlmAnalysisText" :style='{"border":"1px solid #f0f0f0","borderRadius":"6px","padding":"10px 12px","fontSize":"13px","color":"#374151","lineHeight":"20px","background":"#fafafa"}'>{{companyLlmAnalysisText}}</div>
				<div v-else :style='{"fontSize":"13px","color":"#6b7280","lineHeight":"20px"}'>点击“智能分析”生成企业口碑画像与风险预警。</div>
			</div>
		</div>
		<llm-exam-analysis-dialog
			mode="company"
			:visible.sync="companyLlmVisible"
			:company="companyInfo"
			:reviews="companyReviews"
			@analysis-ready="onCompanyLlmReady"
		></llm-exam-analysis-dialog>
	</div>
	
	
	<!-- echarts -->
	<!-- 4 -->
	<div v-if="!isCompanyRole"  class="type4" :style='{"alignContent":"flex-start","padding":"0","flexWrap":"wrap","background":"none","display":"flex","width":"100%","position":"relative","justifyContent":"space-between","height":"auto"}'>
		<div id="shixigangweiChart1" class="echarts1" v-if="isAuth('shixigangwei','首页统计')"></div>
		<div id="shixigangweiChart2" class="echarts2" v-if="isAuth('shixigangwei','首页统计')"></div>
		<div id="luyongtongzhiChart1" class="echarts3" v-if="isAuth('luyongtongzhi','首页统计')"></div>
		<div id="shixipingjiaChart1" class="echarts4" v-if="isAuth('shixipingjia','首页统计')"></div>
	</div>
	<div v-if="!isCompanyRole" class="type5" :style='{"alignContent":"flex-start","padding":"0","flexWrap":"wrap","background":"none","display":"flex","width":"100%","position":"relative","justifyContent":"space-between","height":"auto"}'>
		<div id="jiuyeDiquMapChart" class="echarts1" v-if="isAuth('luyongtongzhi','首页统计')"></div>
	</div>
</div>
</template>
<script>
//4
import router from '@/router/router-static'
import * as echarts from 'echarts'
import chinaJson from "@/components/echarts/china.json";
import LlmExamAnalysisDialog from '@/views/modules/qiye/LlmExamAnalysisDialog.vue'
export default {
	data() {
		return {
            shixigangweiCount: 0,
            luyongtongzhiCount: 0,
			companyReputationLoading: false,
			companyInfo: {},
			companyReviews: [],
			companyHotWords: [],
			companyReviewExcerpts: [],
			companyReputationScore: 0,
			companyLlmVisible: false,
			companyLlmData: null,
            shixipingjiaCount: 0,
			line: {"backgroundColor":"transparent","yAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":15,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,0.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"xAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":4,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":false},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"color":["#73c0de","#5470c6","#91cc75","#fac858","#ee6666","#3ba272","#fc8452","#9a60b4","#ea7ccc"],"legend":{"padding":0,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"#333","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":20,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"showSymbol":true,"symbol":"emptyCircle","symbolSize":4},"tooltip":{"backgroundColor":"#fff","textStyle":{"color":"#333"}},"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"}},
			bar: {"backgroundColor":"transparent","yAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":12,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#666","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,0.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"xAxis":{"axisLabel":{"borderType":"solid","rotate":0,"padding":0,"shadowOffsetX":0,"margin":4,"backgroundColor":"transparent","borderColor":"#000","shadowOffsetY":0,"color":"#333","shadowBlur":0,"show":true,"inside":false,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"width":"","fontSize":12,"lineHeight":24,"shadowColor":"transparent","fontWeight":"normal","height":""},"axisTick":{"show":true,"length":5,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"inside":false},"splitLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":false},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"cap":"butt","color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"rgba(0,0,0,.5)"},"show":true},"splitArea":{"show":false,"areaStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"rgba(25,25,25,.3)","opacity":1,"shadowBlur":10,"shadowColor":"rgba(0,0,0,.5)"}}},"color":["#00ff00","#91cc75","#fac858","#ee6666","#73c0de","#3ba272","#fc8452","#9a60b4","#ea7ccc"],"legend":{"padding":0,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"#333","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":"auto","top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":20,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"barWidth":"auto","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#666","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"colorBy":"data","barCategoryGap":"20%"},"tooltip":{"backgroundColor":"#fff","textStyle":{"color":"#333"}},"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"},"base":{"animate":true,"interval":2000}},
			pie: {"tooltip":{"backgroundColor":"#fff","textStyle":{"color":"#333"}},"backgroundColor":"transparent","color":["#5470c6","#91cc75","#fac858","#ee6666","#73c0de","#3ba272","#fc8452","#9a60b4","#ea7ccc"],"title":{"borderType":"solid","padding":0,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"left","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":600,"textBorderColor":"#666","textShadowBlur":0},"shadowColor":"transparent"},"legend":{"padding":0,"itemGap":5,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#666","shadowOffsetY":0,"orient":"horizontal","shadowBlur":0,"bottom":"auto","itemHeight":4,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"right":0,"top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"right","borderWidth":0,"width":"80%","itemWidth":4,"textStyle":{"textBorderWidth":0,"color":"#333","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":20,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#666","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"label":{"borderType":"solid","rotate":0,"padding":0,"textBorderWidth":0,"backgroundColor":"transparent","borderColor":"#666","color":"#333","show":true,"textShadowColor":"transparent","distanceToLabelLine":5,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"fontSize":12,"lineHeight":18,"textShadowOffsetX":0,"position":"outside","textShadowOffsetY":0,"textBorderType":"solid","textBorderColor":"#666","textShadowBlur":0},"labelLine":{"show":true,"length":10,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"#333","shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"#000"},"length2":14,"smooth":false}}},
			funnel: {"tooltip":{"backgroundColor":"#fff","textStyle":{"color":"#333"}},"backgroundColor":"transparent","color":["#5470c6","#91cc75","#fac858","#ee6666","#73c0de","#3ba272","#fc8452","#9a60b4","#ea7ccc"],"title":{"borderType":"solid","padding":2,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"shadowBlur":0,"bottom":"auto","show":true,"right":"auto","top":"auto","borderRadius":0,"left":"center","borderWidth":0,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","fontSize":14,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"#ccc","textShadowBlur":0},"shadowColor":"transparent"},"legend":{"padding":5,"itemGap":10,"shadowOffsetX":0,"backgroundColor":"transparent","borderColor":"#ccc","shadowOffsetY":0,"orient":"vertical","shadowBlur":0,"bottom":"auto","itemHeight":14,"show":true,"icon":"roundRect","itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"inherit","shadowOffsetY":0,"color":"inherit","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"transparent"},"top":"auto","borderRadius":0,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"color":"inherit","shadowBlur":0,"width":"auto","type":"inherit","opacity":1,"shadowColor":"transparent"},"left":"left","borderWidth":0,"width":"auto","itemWidth":25,"textStyle":{"textBorderWidth":0,"color":"#666","textShadowColor":"transparent","ellipsis":"...","overflow":"none","fontSize":12,"lineHeight":24,"textShadowOffsetX":0,"textShadowOffsetY":0,"textBorderType":"solid","fontWeight":500,"textBorderColor":"transparent","textShadowBlur":0},"shadowColor":"rgba(0,0,0,.3)","height":"auto"},"series":{"itemStyle":{"borderType":"solid","shadowOffsetX":0,"borderColor":"#000","shadowOffsetY":0,"color":"","shadowBlur":0,"borderWidth":0,"opacity":1,"shadowColor":"#000"},"label":{"borderType":"solid","rotate":0,"padding":0,"textBorderWidth":0,"backgroundColor":"transparent","borderColor":"#fff","color":"","show":true,"textShadowColor":"transparent","distanceToLabelLine":5,"ellipsis":"...","overflow":"none","borderRadius":0,"borderWidth":0,"fontSize":12,"lineHeight":18,"textShadowOffsetX":0,"position":"outside","textShadowOffsetY":0,"textBorderType":"solid","textBorderColor":"#fff","textShadowBlur":0},"labelLine":{"show":true,"length":10,"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"shadowBlur":0,"width":1,"type":"solid","opacity":1,"shadowColor":"#000"},"length2":14,"smooth":false}}},
			boardBase: {"funnelNum":8,"lineNum":20,"gaugeNum":8,"barNum":20,"pieNum":12},
			gauge: {"tooltip":{"backgroundColor":"#fff","textStyle":{"color":"#333"}},"backgroundColor":"transparent","color":["#5470c6","#91cc75","#fac858","#ee6666","#73c0de","#3ba272","#fc8452","#9a60b4","#ea7ccc"],"title":{"top":"top","left":"left","textStyle":{"fontSize":14,"lineHeight":24,"color":"#666","fontWeight":500}},"series":{"pointer":{"offsetCenter":[0,"10%"],"icon":"path://M2.9,0.7L2.9,0.7c1.4,0,2.6,1.2,2.6,2.6v115c0,1.4-1.2,2.6-2.6,2.6l0,0c-1.4,0-2.6-1.2-2.6-2.6V3.3C0.3,1.9,1.4,0.7,2.9,0.7z","width":8,"length":"80%"},"axisLine":{"lineStyle":{"shadowOffsetX":0,"shadowOffsetY":0,"opacity":0.5,"shadowBlur":1,"shadowColor":"#000"},"roundCap":true},"anchor":{"show":true,"itemStyle":{"color":"inherit"},"size":18,"showAbove":true},"emphasis":{"disabled":false},"progress":{"show":true,"roundCap":true,"overlap":true},"splitNumber":25,"detail":{"formatter":"{value}","backgroundColor":"inherit","color":"#fff","borderRadius":3,"width":20,"fontSize":14,"height":16},"title":{"fontSize":14},"animation":true}},
		};
	},
	components: {
		LlmExamAnalysisDialog
	},
	computed: {
		isCompanyRole() {
			return this.$storage.get('role') === '企业'
		},
		companyLlmAnalysisText() {
			const raw = this.companyLlmData && this.companyLlmData.llmAnalysis ? String(this.companyLlmData.llmAnalysis) : ''
			if (!raw) return ''
			const text = raw.replace(/<json>[\s\S]*?<\/json>/i, '').trim()
			return text.length > 220 ? `${text.slice(0, 220)}...` : text
		}
	},
	mounted(){
		this.init();
		this.getshixigangweiCount();
		this.shixigangweiChat1();
		this.shixigangweiChat2();
		this.getluyongtongzhiCount();
		this.luyongtongzhiChat1();
		this.jiuyeDiquMapChart();
		this.getshixipingjiaCount();
		this.shixipingjiaChat1();
		if (this.isCompanyRole) {
			this.refreshCompanyReputation()
		}
	},
	methods:{
		// 统计图动画
		myChartInterval(type, xAxisData, seriesData, myChart) {
			this.$nextTick(() => {
				setInterval(() => {
					let xAxis = xAxisData.shift()
					xAxisData.push(xAxis)
					let series = seriesData.shift()
					seriesData.push(series)
				
					if (type == 1) {
						myChart.setOption({
							xAxis: [{
								data: xAxisData
							}],
							series: [{
								data: seriesData
							}]
						});
					}
					if (type == 2) {
						myChart.setOption({
							yAxis: [{
								data: xAxisData
							}],
							series: [{
								data: seriesData
							}]
						});
					}
				}, $template2.back.board.bar.base.interval);
			})
		},
		init(){
			if(this.$storage.get('Token')){
			this.$http({
				url: `${this.$storage.get('sessionTable')}/session`,
				method: "get"
			}).then(({ data }) => {
				if (data && data.code != 0) {
				router.push({ name: 'login' })
				}
			});
			}else{
				router.push({ name: 'login' })
			}
		},
		stripHtml(text) {
			if (!text) return ''
			return String(text)
				.replace(/<[^>]*?>/g, '')
				.replace(/&nbsp;/g, ' ')
				.replace(/\s+/g, ' ')
				.trim()
		},
		getReviewContent(review) {
			if (!review) return ''
			if (review.shixineirong) return review.shixineirong
			if (review.shixinengrong) return review.shixinengrong
			return ''
		},
		buildHotWords(text) {
			const plain = this.stripHtml(text)
			const cleaned = plain
				.replace(/[0-9a-zA-Z]/g, ' ')
				.replace(/[\s\r\n\t]+/g, ' ')
				.replace(/[，。！？；：、,.!?;:"'“”‘’（）()【】\[\]《》<>—\-_/\\|@#$%^&*+=~`·]/g, ' ')
			const chunks = cleaned.match(/[\u4e00-\u9fa5]{2,}/g) || []
			const stop = new Set(['我们', '他们', '你们', '因为', '所以', '然后', '但是', '还有', '以及', '这个', '那个', '公司', '企业', '实习', '岗位', '工作', '学生', '老师'])
			const freq = {}
			for (let c of chunks) {
				c = String(c || '').trim()
				if (!c) continue
				const maxLen = Math.min(60, c.length)
				for (let i = 0; i < maxLen - 1; i++) {
					const w = c.slice(i, i + 2)
					if (stop.has(w)) continue
					freq[w] = (freq[w] || 0) + 1
				}
			}
			return Object.keys(freq)
				.map(k => ({word: k, count: freq[k]}))
				.sort((a, b) => b.count - a.count)
				.slice(0, 12)
		},
		buildReputationScore(reviews) {
			const list = Array.isArray(reviews) ? reviews : []
			const positive = ['满意', '推荐', '喜欢', '友好', '支持', '成长', '提升', '学习', '收获', '环境好', '氛围好', '稳定', '合理', '规范', '福利', '薪资']
			const negative = ['不满意', '不推荐', '压榨', '加班', '拖欠', '糟', '差', '不好', '混乱', '强度大', '环境差', '工资低', '不规范', '不合理', '风险']
			let pos = 0
			let neg = 0
			for (const r of list) {
				const t = this.stripHtml(this.getReviewContent(r))
				if (!t) continue
				for (const w of positive) {
					if (t.includes(w)) pos += 1
				}
				for (const w of negative) {
					if (t.includes(w)) neg += 1
				}
			}
			const base = 60
			const sizeBoost = Math.min(20, Math.round(Math.log10(Math.max(1, list.length)) * 20))
			const sentiment = (pos - neg) * 3
			const score = Math.max(0, Math.min(100, base + sizeBoost + sentiment))
			return Math.round(score)
		},
		buildReviewExcerpts(reviews) {
			const list = Array.isArray(reviews) ? reviews : []
			return list.slice(0, 3).map((r, idx) => {
				const name = r && r.xueshengxingming ? String(r.xueshengxingming) : `评价${idx + 1}`
				const time = r && r.dengjishijian ? String(r.dengjishijian) : ''
				const text = this.stripHtml(this.getReviewContent(r))
				const shortText = text.length > 140 ? `${text.slice(0, 140)}...` : text
				return {
					key: String(r && (r.id || r.dengjishijian || idx)),
					title: name,
					time,
					text: shortText || '-'
				}
			})
		},
		refreshCompanyReputation() {
			if (this.companyReputationLoading) return
			this.companyReputationLoading = true
			this.$http({
				url: `${this.$storage.get('sessionTable')}/session`,
				method: "get"
			}).then(({ data }) => {
				if (data && data.code === 0) {
					this.companyInfo = data.data || {}
				} else {
					this.companyInfo = {}
				}
				const qiyezhanghao = this.companyInfo && this.companyInfo.qiyezhanghao ? String(this.companyInfo.qiyezhanghao) : ''
				const qiyemingcheng = this.companyInfo && this.companyInfo.qiyemingcheng ? String(this.companyInfo.qiyemingcheng) : ''
				const params = {
					page: 1,
					limit: 200,
					sort: 'dengjishijian',
					order: 'desc',
				}
				if (qiyezhanghao) {
					params.qiyezhanghao = `%${qiyezhanghao}%`
				}
				if (qiyemingcheng) {
					params.qiyemingcheng = `%${qiyemingcheng}%`
				}
				return this.$http({
					url: 'shixiqingkuang/page',
					method: 'get',
					params
				})
			}).then(({ data }) => {
				const list = data && data.code === 0 && data.data && Array.isArray(data.data.list) ? data.data.list : []
				this.companyReviews = list
				const allText = list.map(r => this.getReviewContent(r)).join(' ')
				this.companyHotWords = this.buildHotWords(allText)
				this.companyReviewExcerpts = this.buildReviewExcerpts(list)
				this.companyReputationScore = this.buildReputationScore(list)
			}).catch(() => {
				this.companyInfo = {}
				this.companyReviews = []
				this.companyHotWords = []
				this.companyReviewExcerpts = []
				this.companyReputationScore = 0
			}).finally(() => {
				this.companyReputationLoading = false
			})
		},
		onCompanyLlmReady(payload) {
			this.companyLlmData = payload || null
		},
		getshixigangweiCount() {
			this.$http({
				url: `shixigangwei/count`,
				method: "get"
			}).then(({
				data
			}) => {
				if (data && data.code == 0) {
					this.shixigangweiCount = data.data
				}
			})
		},
// 1234 饼
		shixigangweiChat1() {
			this.$nextTick(()=>{

        var shixigangweiChart1 = echarts.init(document.getElementById("shixigangweiChart1"),'macarons');
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
					if(this.boardBase&&i==this.boardBase.pieNum){
						break;
					}
                    xAxis.push(res[i].gangweileixing);
                    yAxis.push(parseFloat((res[i].total)));
                    pArray.push({
                        value: parseFloat((res[i].total)),
                        name: res[i].gangweileixing
                    })
                }
                var option = {};
				let titleObj = this.pie.title
				titleObj.text = '岗位类型统计'
				
				const legendObj = this.pie.legend
				let tooltipObj = {trigger: 'item',formatter: '{b} : {c} ({d}%)'}
				tooltipObj = Object.assign(tooltipObj , this.pie.tooltip?this.pie.tooltip:{})
				
				let seriesObj = {
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
				seriesObj = Object.assign(seriesObj , this.pie.series)
				const gridObj = this.pie.grid
                option = {
                	backgroundColor: this.pie.backgroundColor,
                	color: this.pie.color,
                	title: titleObj,
                	legend: legendObj,
					grid: gridObj,
                	tooltip: tooltipObj,
                	series: [seriesObj]
                };
                // 使用刚指定的配置项和数据显示图表。
                shixigangweiChart1.setOption(option);
				// 动画效果
				
                  //根据窗口的大小变动图表
									window.addEventListener('resize', () => {
										shixigangweiChart1.resize();
									})
            }
        });
      })
    },

    shixigangweiChat2() {
      this.$nextTick(()=>{

        var shixigangweiChart2 = echarts.init(document.getElementById("shixigangweiChart2"),'macarons');
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
					if(this.boardBase&&i==this.boardBase.lineNum){
						break;
					}
                    xAxis.push(res[i].gangweileixing);
                    yAxis.push(parseFloat((res[i].total)));
                    pArray.push({
                        value: parseFloat((res[i].total)),
                        name: res[i].gangweileixing
                    })
                }
                var option = {};
				let titleObj = this.line.title
				titleObj.text = '岗位薪资统计'
				
				const legendObj = this.line.legend
				let tooltipObj = { trigger: 'item',formatter: '{b} : {c}'}
				tooltipObj = Object.assign(tooltipObj , this.line.tooltip?this.line.tooltip:{})
				
				let xAxisObj = this.line.xAxis
				xAxisObj.type = 'category'
				xAxisObj.boundaryGap = false
				xAxisObj.data = xAxis
				
				let yAxisObj = this.line.yAxis
				yAxisObj.type = 'value'
				
				let seriesObj = {
					data: yAxis,
					type: 'line',
					areaStyle: {},
					smooth: true
				}
				seriesObj = Object.assign(seriesObj , this.line.series)
				const gridObj = this.line.grid
				
                option = {
                    backgroundColor: this.line.backgroundColor,
                    color: this.line.color,
                    title: titleObj,
                    legend: legendObj,
                    tooltip: tooltipObj,
                    xAxis: xAxisObj,
                    yAxis: yAxisObj,
                    series: [seriesObj],
					grid: gridObj,
                };
                // 使用刚指定的配置项和数据显示图表。
                shixigangweiChart2.setOption(option);
				
				// 动画效果
                  //根据窗口的大小变动图表
                window.addEventListener('resize', () => {
										shixigangweiChart2.resize();
								})
            }
        });
      })
    },

		getluyongtongzhiCount() {
			this.$http({
				url: `luyongtongzhi/count`,
				method: "get"
			}).then(({
				data
			}) => {
				if (data && data.code == 0) {
					this.luyongtongzhiCount = data.data
				}
			})
		},
// 1234 饼
		luyongtongzhiChat1() {
			this.$nextTick(()=>{

        var luyongtongzhiChart1 = echarts.init(document.getElementById("luyongtongzhiChart1"),'macarons');
        this.$http({
            url: "luyongtongzhi/group/luyongzhuangtai",
            method: "get",
        }).then(({ data }) => {
            if (data && data.code === 0) {
                let res = data.data;
                let xAxis = [];
                let yAxis = [];
                let pArray = []
                for(let i=0;i<res.length;i++){
					if(this.boardBase&&i==this.boardBase.pieNum){
						break;
					}
                    xAxis.push(res[i].luyongzhuangtai);
                    yAxis.push(parseFloat((res[i].total)));
                    pArray.push({
                        value: parseFloat((res[i].total)),
                        name: res[i].luyongzhuangtai
                    })
                }
                var option = {};
				let titleObj = this.pie.title
				titleObj.text = '录用结果统计'
				
				const legendObj = this.pie.legend
				let tooltipObj = {trigger: 'item',formatter: '{b} : {c} ({d}%)'}
				tooltipObj = Object.assign(tooltipObj , this.pie.tooltip?this.pie.tooltip:{})
				
				let seriesObj = {
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
				seriesObj = Object.assign(seriesObj , this.pie.series)
				const gridObj = this.pie.grid
                option = {
                	backgroundColor: this.pie.backgroundColor,
                	color: this.pie.color,
                	title: titleObj,
                	legend: legendObj,
					grid: gridObj,
                	tooltip: tooltipObj,
                	series: [seriesObj]
                };
                // 使用刚指定的配置项和数据显示图表。
                luyongtongzhiChart1.setOption(option);
				// 动画效果
				
                  //根据窗口的大小变动图表
									window.addEventListener('resize', () => {
										luyongtongzhiChart1.resize();
									})
            }
        });
      })
    },


		getshixipingjiaCount() {
			this.$http({
				url: `shixipingjia/count`,
				method: "get"
			}).then(({
				data
			}) => {
				if (data && data.code == 0) {
					this.shixipingjiaCount = data.data
				}
			})
		},
// 1234 竖
		shixipingjiaChat1() {
			this.$nextTick(()=>{

        var shixipingjiaChart1 = echarts.init(document.getElementById("shixipingjiaChart1"),'macarons');
        this.$http({
            url: `shixipingjia/value/xueshengxingming/shixipingfen`,
            method: "get",
        }).then(({ data }) => {
            if (data && data.code === 0) {
                let res = data.data;
                let xAxis = [];
                let yAxis = [];
                let pArray = []
                for(let i=0;i<res.length;i++){
					if(this.boardBase&&i==this.boardBase.barNum){
						break;
					}
                    xAxis.push(res[i].xueshengxingming);
                    yAxis.push(parseFloat((res[i].total)));
                    pArray.push({
                        value: parseFloat((res[i].total)),
                        name: res[i].xueshengxingming
                    })
                }
                var option = {};
				let titleObj = this.bar.title
				titleObj.text = '学生实习评分统计'
				
				const legendObj = this.bar.legend
				let tooltipObj = {trigger: 'item',formatter: '{b} : {c}'}
				tooltipObj = Object.assign(tooltipObj , this.bar.tooltip?this.bar.tooltip:{})
				
				let xAxisObj = this.bar.xAxis
				xAxisObj.type = 'category'
				xAxisObj.data = xAxis
				
				let yAxisObj = this.bar.yAxis
				yAxisObj.type = 'value'
				let seriesObj = {
					data: yAxis,
					type: 'bar'
				}
				seriesObj = Object.assign(seriesObj , this.bar.series)
				const gridObj = this.bar.grid
				
                option = {
                    backgroundColor: this.bar.backgroundColor,
                    color: this.bar.color,
                    title: titleObj,
                    legend: legendObj,
					grid: gridObj,
                    tooltip: tooltipObj,
                    xAxis: xAxisObj,
                    yAxis: yAxisObj,
                    series: [seriesObj]
                };
                // 使用刚指定的配置项和数据显示图表。
                shixipingjiaChart1.setOption(option);
				// 动画效果
				this.myChartInterval(1, option.xAxis.data, option.series[0].data, shixipingjiaChart1)
				
                  //根据窗口的大小变动图表
									window.addEventListener('resize', () => {
										shixipingjiaChart1.resize();
									})
            }
        });
      })
    },

		getProvinceNameFromLocation(location) {
			if (!location || typeof location !== 'string') return null
			const text = location.replace(/\s+/g, '')
			if (text.includes('香港')) return '香港特别行政区'
			if (text.includes('澳门')) return '澳门特别行政区'
			if (text.includes('内蒙古')) return '内蒙古自治区'
			if (text.includes('广西')) return '广西壮族自治区'
			if (text.includes('宁夏')) return '宁夏回族自治区'
			if (text.includes('新疆')) return '新疆维吾尔自治区'
			if (text.includes('西藏')) return '西藏自治区'
			if (text.includes('北京')) return '北京市'
			if (text.includes('天津')) return '天津市'
			if (text.includes('上海')) return '上海市'
			if (text.includes('重庆')) return '重庆市'
			if (text.includes('台湾')) return '台湾省'

			const provinceKeys = [
				'河北','山西','辽宁','吉林','黑龙江','江苏','浙江','安徽','福建','江西','山东','河南','湖北','湖南','广东','海南','四川','贵州','云南','陕西','甘肃','青海'
			]
			for (let i = 0; i < provinceKeys.length; i++) {
				const key = provinceKeys[i]
				if (text.includes(key)) return `${key}省`
			}

			return null
		},
		jiuyeDiquMapChart() {
			this.$nextTick(() => {
				const el = document.getElementById("jiuyeDiquMapChart")
				if (!el) return

				echarts.registerMap('china', chinaJson)
				const mapChart = echarts.init(el, 'macarons')

				this.$http({
					url: "luyongtongzhi/group/gongzuodidian",
					method: "get",
				}).then(({ data }) => {
					const provinceCountMap = {}
					if (data && data.code === 0) {
						const res = data.data || []
						for (let i = 0; i < res.length; i++) {
							const provinceName = this.getProvinceNameFromLocation(res[i].gongzuodidian)
							if (!provinceName) continue
							const value = Number(res[i].total) || 0
							provinceCountMap[provinceName] = (provinceCountMap[provinceName] || 0) + value
						}
					}

					const seriesData = Object.keys(provinceCountMap).map((name) => ({
						name,
						value: provinceCountMap[name]
					}))
					const maxVal = seriesData.reduce((max, item) => Math.max(max, item.value || 0), 0) || 1

					const option = {
						backgroundColor: 'transparent',
						title: {
							text: '就业地域分布',
							left: 'left',
							textStyle: {
								color: '#666',
								fontSize: 14,
								fontWeight: 600
							}
						},
						tooltip: {
							trigger: 'item',
							formatter: (params) => {
								const value = params && (params.value || params.value === 0) ? params.value : 0
								return `${params.name}<br/>就业人数：${value}`
							}
						},
						visualMap: {
							min: 0,
							max: maxVal,
							left: 10,
							bottom: 10,
							inRange: {
								color: ['#e0ffff', '#006edd']
							},
							textStyle: {
								color: '#333'
							}
						},
						series: [
							{
								name: '就业地域分布',
								type: 'map',
								map: 'china',
								roam: true,
								label: {
									show: false
								},
								emphasis: {
									label: {
										show: true
									}
								},
								data: seriesData
							}
						]
					}

					mapChart.setOption(option)
					window.addEventListener('resize', () => {
						mapChart.resize()
					})
				})
			})
		},

  }
};
</script>
<style lang="scss" scoped>
    .cardView {
        display: flex;
        flex-wrap: wrap;
        width: 100%;

        .cards {
            display: flex;
            align-items: center;
            width: 100%;
            margin-bottom: 10px;
            justify-content: center;
            .card {
                width: calc(25% - 20px);
                margin: 0 10px;
                ::v-deep.el-card__body{
                    padding: 0;
                }
            }
        }
    }
	
	// 日历
	.calendar td .text {
				border-radius: 12px;
				flex-direction: column;
				background: #fff;
				display: flex;
				width: 100%;
				justify-content: center;
				align-items: center;
				height: 100%;
			}
	.calendar td .text:hover {
				background: rgba(78,110,242,.1);
			}
	.calendar td .text .new {
				color: #000;
				font-size: 24px;
				line-height: 1.4;
			}
	.calendar td .text .old {
				color: #666;
				font-size: 16px;
				line-height: 1.4;
			}
	.calendar td.festival .text {
				border-radius: 12px;
				flex-direction: column;
				background: #ffe4c7;
				display: flex;
				width: 100%;
				justify-content: center;
				align-items: center;
				height: 100%;
			}
	.calendar td.festival .text:hover {
			}
	.calendar td.festival .text .new {
				color: #000;
				font-size: 24px;
				line-height: 1.4;
			}
	.calendar td.festival .text .old {
				color: #666;
				font-size: 16px;
				line-height: 1.4;
			}
	.calendar td.other .text {
				border-radius: 12px;
				flex-direction: column;
				background: #fff;
				display: flex;
				width: 100%;
				justify-content: center;
				align-items: center;
				opacity: 0.3;
				height: 100%;
			}
	.calendar td.other .text:hover {
				background: rgba(78,110,242,.1);
			}
	.calendar td.other .text .new {
				color: #000;
				font-size: 24px;
				line-height: 1.4;
			}
	.calendar td.other .text .old {
				color: #666;
				font-size: 16px;
				line-height: 1.4;
			}
	.calendar td.today .text {
				border-radius: 12px;
				flex-direction: column;
				color: #fff;
				background: #6aab9c;
				display: flex;
				width: 100%;
				justify-content: center;
				align-items: center;
				height: 100%;
			}
	.calendar td.today .text:hover {
				background: rgba(64, 158, 255,.5);
			}
	.calendar td.today .text .new {
				color: inherit;
				font-size: 24px;
				line-height: 1.4;
			}
	.calendar td.today .text .old {
				color: inherit;
				font-size: 16px;
				line-height: 1.4;
			}
	
	// echarts1
	.type1 .echarts1 {
				border: 1px solid #ddd;
				border-radius: 4px;
				padding: 20px;
				margin: 10px 0;
				background: #fff;
				width: 50%;
				position: relative;
				transition: 0.3s;
				height: 360px;
			}
	.type1 .echarts1:hover {
			}
	// echarts2
	.type2 .echarts1 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type2 .echarts1:hover {
			}
	.type2 .echarts2 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type2 .echarts2:hover {
			}
	// echarts3
	.type3 .echarts1 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 100%;
				position: relative;
				transition: 0.3s;
				height: 400px;
				order: 3;
			}
	.type3 .echarts1:hover {
			}
	.type3 .echarts2 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type3 .echarts2:hover {
			}
	.type3 .echarts3 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type3 .echarts3:hover {
			}
	// echarts4
	.type4 .echarts1 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type4 .echarts1:hover {
			}
	.type4 .echarts2 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type4 .echarts2:hover {
			}
	.type4 .echarts3 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type4 .echarts3:hover {
			}
	.type4 .echarts4 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type4 .echarts4:hover {
			}
	// echarts5
	.type5 .echarts1 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 100%;
				position: relative;
				transition: 0.3s;
				height: 400px;
				order: 3;
			}
	.type5 .echarts1:hover {
			}
	.type5 .echarts2 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type5 .echarts2:hover {
			}
	.type5 .echarts3 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type5 .echarts3:hover {
			}
	.type5 .echarts4 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type5 .echarts4:hover {
			}
	.type5 .echarts5 {
				border: 1px solid #ddd;
				border-radius: 8px;
				padding: 20px;
				margin: 10px 0;
				background: rgba(255,255,255,1);
				width: 49%;
				position: relative;
				transition: 0.3s;
				height: 400px;
			}
	.type5 .echarts5:hover {
			}
	
	.echarts-flag-2 {
	  display: flex;
	  flex-wrap: wrap;
	  justify-content: space-between;
	  padding: 10px 20px;
	  background: rebeccapurple;
	
	  &>div {
	    width: 32%;
	    height: 300px;
	    margin: 10px 0;
	    background: rgba(255,255,255,.1);
	    border-radius: 8px;
	    padding: 10px 20px;
	  }
	}
</style>
