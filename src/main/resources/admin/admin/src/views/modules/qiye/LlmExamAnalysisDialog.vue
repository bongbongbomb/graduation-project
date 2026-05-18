<template>
	<el-dialog :title="dialogTitle" :visible.sync="innerVisible" width="70%" @open="handleDialogOpen">
		<div ref="exportRoot" v-loading="llmLoading" class="llm-dashboard">
			<div v-if="llmData">
				<div class="llm-grid">
					<div class="llm-card llm-card-glow">
						<div class="llm-card-title">{{scoreCardTitle}}</div>
						<div class="llm-score-wrap">
							<el-progress type="circle" :percentage="llmData.scorePercent" :stroke-width="10"></el-progress>
							<div class="llm-score-sub">{{llmData.myScore}} / {{llmData.totalScore}} 分</div>
							<div class="llm-badge" :class="badgeClass(llmData.scorePercent)">{{badgeText(llmData.scorePercent)}}</div>
						</div>
					</div>

					<div class="llm-card">
						<div class="llm-card-title">{{pieCardTitle}}</div>
						<div class="llm-pie-wrap">
							<div class="llm-pie" :style="{background: typePieGradient(llmData)}"></div>
							<div class="llm-pie-center">
								<div class="llm-pie-main">{{pieCenterMain(llmData)}}</div>
								<div class="llm-pie-sub">{{pieCenterSub}}</div>
							</div>
						</div>
						<div class="llm-legend">
							<div v-for="seg in typePieSegments(llmData)" :key="seg.key" class="llm-legend-item">
								<span class="llm-dot" :style="{background: seg.color}"></span>
								<span class="llm-legend-name">{{seg.name}}</span>
								<span class="llm-legend-val">{{seg.total}}{{typeUnit}}</span>
							</div>
						</div>
					</div>

					<div class="llm-card">
						<div class="llm-card-title">{{radarCardTitle}}</div>
						<div class="llm-radar">
							<svg viewBox="0 0 240 240" class="llm-radar-svg">
								<defs>
									<linearGradient id="llmRadarFill" x1="0" y1="0" x2="1" y2="1">
										<stop offset="0%" stop-color="#00e5ff" stop-opacity="0.55"></stop>
										<stop offset="100%" stop-color="#7c4dff" stop-opacity="0.55"></stop>
									</linearGradient>
									<filter id="llmGlow" x="-50%" y="-50%" width="200%" height="200%">
										<feGaussianBlur stdDeviation="3" result="blur"></feGaussianBlur>
										<feMerge>
											<feMergeNode in="blur"></feMergeNode>
											<feMergeNode in="SourceGraphic"></feMergeNode>
										</feMerge>
									</filter>
								</defs>
								<g>
									<polygon :points="radarGridPoints(1)" class="llm-radar-grid"></polygon>
									<polygon :points="radarGridPoints(0.66)" class="llm-radar-grid"></polygon>
									<polygon :points="radarGridPoints(0.33)" class="llm-radar-grid"></polygon>
								</g>
								<g class="llm-radar-axes">
									<line v-for="a in radarAxes(llmData)" :key="a.key" :x1="a.x1" :y1="a.y1" :x2="a.x2" :y2="a.y2"></line>
								</g>
								<polygon :points="radarDataPoints(llmData)" class="llm-radar-area"></polygon>
								<polyline :points="radarDataPoints(llmData)" class="llm-radar-line" filter="url(#llmGlow)"></polyline>
								<circle v-for="p in radarDots(llmData)" :key="p.key" :cx="p.x" :cy="p.y" r="3.4" class="llm-radar-dot" filter="url(#llmGlow)"></circle>
							</svg>
							<div class="llm-radar-labels">
								<div v-for="l in radarLabels(llmData)" :key="l.key" class="llm-radar-label" :style="{left: l.left, top: l.top}">
									{{l.name}}
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="llm-split">
					<div class="llm-card llm-card-wide">
						<div class="llm-card-title">{{barsCardTitle}}</div>
						<div class="llm-bars">
							<div v-for="item in llmData.typeStats" :key="item.type" class="llm-bar-row">
								<div class="llm-bar-label">{{item.name}}</div>
								<div class="llm-bar-track">
									<div class="llm-bar-fill" :style="{width: scoreRatio(item) + '%'}"></div>
									<div class="llm-bar-meta">{{item.myScore}} / {{item.totalScore}} 分</div>
								</div>
								<div class="llm-bar-track llm-bar-track-thin">
									<div class="llm-bar-fill llm-bar-fill-alt" :style="{width: percent(item.accuracy) + '%'}"></div>
									<div class="llm-bar-meta">{{percent(item.accuracy)}}%</div>
								</div>
							</div>
						</div>
					</div>

					<div class="llm-card llm-card-wide">
						<div class="llm-card-title">{{topCardTitle}}</div>
						<div class="llm-bars">
							<div v-for="q in lostTopQuestions(llmData)" :key="q.key" class="llm-bar-row">
								<div class="llm-bar-label" :title="q.fullName">{{q.index}}. {{q.name}}</div>
								<div class="llm-bar-track">
									<div class="llm-bar-fill llm-bar-fill-warn" :style="{width: q.ratio + '%'}"></div>
									<div class="llm-bar-meta">{{topValueLabel}} {{q.lost}}</div>
								</div>
							</div>
							<el-empty v-if="lostTopQuestions(llmData).length===0" :description="topEmptyText"></el-empty>
						</div>
					</div>
				</div>

				<div class="llm-card llm-card-wide">
					<div class="llm-card-title">{{textCardTitle}}</div>
					<div class="llm-richtext" v-html="llmAnalysisHtml"></div>
					<el-empty v-if="!llmAnalysisHtml" description="暂无文字分析"></el-empty>
				</div>
			</div>
			<el-empty v-else description="暂无分析结果"></el-empty>
		</div>
		<span slot="footer" class="dialog-footer">
			<el-button @click="innerVisible=false">关闭</el-button>
			<el-button type="success" :disabled="!llmData" @click="exportReport">导出下载</el-button>
			<el-button type="primary" :loading="llmLoading" @click="fetchLlmAnalysis(true)">重新分析</el-button>
		</span>
	</el-dialog>
</template>

<script>
	export default {
		props: {
			mode: {
				type: String,
				default: 'exam'
			},
			visible: {
				type: Boolean,
				default: false
			},
			paper: {
				type: Object,
				default: () => ({})
			},
			questions: {
				type: Array,
				default: () => []
			},
			internship: {
				type: Object,
				default: () => ({})
			},
			company: {
				type: Object,
				default: () => ({})
			},
			reviews: {
				type: Array,
				default: () => []
			}
		},
		data() {
			return {
				llmLoading: false,
				llmData: null,
				llmAnalysisHtml: '',
			}
		},
		computed: {
			modeKey() {
				return String(this.mode || '').toLowerCase()
			},
			isInternship() {
				return this.modeKey === 'internship'
			},
			isCompany() {
				return this.modeKey === 'company'
			},
			dialogTitle() {
				if (this.isInternship) {
					const name = this.internship && this.internship.xueshengxingming ? ` - ${this.internship.xueshengxingming}` : ''
					return `实习报告分析${name}`
				}
				if (this.isCompany) {
					const name = this.company && this.company.qiyemingcheng ? ` - ${this.company.qiyemingcheng}` : ''
					return `企业口碑画像${name}`
				}
				return '大模型分析'
			},
			scoreCardTitle() {
				if (this.isInternship) return '实习评分占比'
				if (this.isCompany) return '口碑指数'
				return '得分占比'
			},
			pieCardTitle() {
				if (this.isInternship || this.isCompany) {
					return this.llmData && this.llmData.pieStats ? '关键词占比' : '能力维度占比'
				}
				return '题型占比'
			},
			pieCenterSub() {
				if (this.isInternship || this.isCompany) {
					return this.llmData && this.llmData.pieStats ? '关键词' : '维度'
				}
				return '题'
			},
			typeUnit() {
				if (this.isInternship || this.isCompany) {
					return this.llmData && this.llmData.pieStats ? '%' : '分'
				}
				return '题'
			},
			radarCardTitle() {
				if (this.isInternship) return '能力维度雷达'
				if (this.isCompany) return '多维度画像雷达'
				return '题型能力雷达'
			},
			barsCardTitle() {
				if (this.isInternship || this.isCompany) return '维度得分与达成率'
				return '题型得分与正确率'
			},
			topCardTitle() {
				if (this.isInternship) return '待改进 TOP5'
				if (this.isCompany) return '风险预警 TOP5'
				return '失分 TOP5'
			},
			topValueLabel() {
				if (this.isInternship) return '严重度'
				if (this.isCompany) return '风险值'
				return '失分'
			},
			topEmptyText() {
				if (this.isInternship) return '暂无可统计的待改进项'
				if (this.isCompany) return '暂无风险预警'
				return '暂无可统计的客观题失分'
			},
			textCardTitle() {
				if (this.isInternship) return '大模型实习分析'
				if (this.isCompany) return '大模型风险与口碑分析'
				return '大模型文字分析'
			},
			innerVisible: {
				get() {
					return this.visible
				},
				set(val) {
					this.$emit('update:visible', val)
				}
			}
		},
		watch: {
			visible(val) {
				if (val) {
					this.fetchLlmAnalysis(false)
				}
			},
			internship: {
				handler() {
					if (this.visible) {
						this.fetchLlmAnalysis(true)
					}
				},
				deep: false
			},
			company: {
				handler() {
					if (this.visible) {
						this.fetchLlmAnalysis(true)
					}
				},
				deep: false
			},
			reviews: {
				handler() {
					if (this.visible) {
						this.fetchLlmAnalysis(true)
					}
				},
				deep: false
			}
		},
		methods: {
			handleDialogOpen() {
				this.fetchLlmAnalysis(false)
			},
			pieCenterMain(llmData) {
				if (this.isInternship || this.isCompany) {
					const stats = (llmData && llmData.pieStats) ? llmData.pieStats : ((llmData && llmData.typeStats) ? llmData.typeStats : [])
					return stats.length || 0
				}
				return llmData && llmData.questionTotal ? llmData.questionTotal : 0
			},
			stripHtml(text) {
				if (!text) {
					return ''
				}
				return String(text)
					.replace(/<[^>]*?>/g, '')
					.replace(/&nbsp;/g, ' ')
					.replace(/\s+/g, ' ')
					.trim()
			},
			percent(value) {
				return Math.round((Number(value) || 0) * 100)
			},
			buildLlmBaseData() {
				const paperid = this.paper && this.paper.id ? Number(this.paper.id) : null
				const userid = Number(localStorage.getItem('frontUserid')) || null
				const papername = this.paper && this.paper.name ? String(this.paper.name) : ''

				let totalScore = 0
				let myScore = 0
				const typeNameMap = {0: '单选题', 1: '多选题', 2: '判断题', 3: '填空题', 4: '主观题'}
				const typeAgg = {}

				const objectiveWrong = []
				const list = Array.isArray(this.questions) ? this.questions : []
				for (let i = 0; i < list.length; i++) {
					const q = list[i] || {}
					const t = Number(q.type)
					const s = Number(q.score) || 0
					const ms = Number(q.myscore) || 0
					totalScore += s
					myScore += ms

					if (!typeAgg[t]) {
						typeAgg[t] = {type: t, name: typeNameMap[t] || String(t), total: 0, totalScore: 0, myScore: 0}
					}
					typeAgg[t].total += 1
					typeAgg[t].totalScore += s
					typeAgg[t].myScore += ms

					if ([0, 1, 2, 3].includes(t) && s > 0 && ms !== s) {
						objectiveWrong.push({
							questionid: q.id || q.questionid,
							questionname: this.stripHtml(q.questionname),
							type: t,
							score: s,
							myanswer: q.myanswer ? String(q.myanswer) : '',
							answer: q.answer ? String(q.answer) : '',
							analysis: this.stripHtml(q.analysis),
							lost: Math.max(0, s - ms)
						})
					}
				}

				const scorePercent = totalScore > 0 ? Math.round((myScore * 100) / totalScore) : 0
				const typeStats = Object.keys(typeAgg)
					.map(k => {
						const row = typeAgg[k]
						const acc = row.totalScore > 0 ? row.myScore / row.totalScore : 0
						return {...row, accuracy: Number(acc.toFixed(4))}
					})
					.sort((a, b) => a.type - b.type)

				objectiveWrong.sort((a, b) => (b.lost || 0) - (a.lost || 0))
				const weakQuestions = objectiveWrong.slice(0, 5)

				return {
					paperid,
					userid,
					papername,
					questionTotal: list.length,
					totalScore,
					myScore,
					scorePercent,
					typeStats,
					weakQuestions,
					llmAnalysis: '',
				}
			},
			buildInternshipBaseData() {
				const v = this.internship || {}
				const rawScore = Number(v.shixipingfen)
				const myScore = Number.isFinite(rawScore) ? rawScore : 0
				const totalScore = this.inferInternshipTotalScore(myScore)
				const scorePercent = totalScore > 0 ? Math.max(0, Math.min(100, Math.round((myScore * 100) / totalScore))) : 0
				const dims = ['工作态度', '专业技能', '沟通协作', '学习能力', '职业素养']
				const typeStats = dims.map((name, idx) => {
					const accuracy = totalScore > 0 ? Math.max(0, Math.min(1, myScore / totalScore)) : 0
					const my = Math.max(0, Math.min(100, Math.round(accuracy * 100)))
					return {type: idx, name, total: my, totalScore: 100, myScore: my, accuracy: Number((my / 100).toFixed(4))}
				})
				return {
					internshipid: v.id ? Number(v.id) : null,
					qiyemingcheng: v.qiyemingcheng ? String(v.qiyemingcheng) : '',
					xueshengzhanghao: v.xueshengzhanghao ? String(v.xueshengzhanghao) : '',
					xueshengxingming: v.xueshengxingming ? String(v.xueshengxingming) : '',
					gangweileixing: v.gangweileixing ? String(v.gangweileixing) : '',
					pingjiashijian: v.pingjiashijian ? String(v.pingjiashijian) : '',
					fuzeren: v.fuzeren ? String(v.fuzeren) : '',
					shixipingfen: myScore,
					pingjianeirong: v.pingjianeirong ? String(v.pingjianeirong) : '',
					questionTotal: typeStats.length,
					totalScore,
					myScore,
					scorePercent,
					typeStats,
					weakQuestions: [],
					llmAnalysis: '',
				}
			},
			buildCompanyBaseData() {
				const c = this.company || {}
				const qiyemingcheng = c.qiyemingcheng ? String(c.qiyemingcheng) : ''
				const qiyezhanghao = c.qiyezhanghao ? String(c.qiyezhanghao) : ''
				const gangweileixing = c.gangweileixing ? String(c.gangweileixing) : ''
				const gongzuodidian = c.gongzuodidian ? String(c.gongzuodidian) : ''
				const shiximingcheng = c.shiximingcheng ? String(c.shiximingcheng) : ''
				const reviewList = Array.isArray(this.reviews) ? this.reviews : []
				const rawReviews = reviewList
					.map(r => (r && r.shixineirong ? this.stripHtml(r.shixineirong) : ''))
					.filter(t => t && t.trim())
				const seedScore = rawReviews.length ? 70 : 0
				const totalScore = 100
				const myScore = seedScore
				const scorePercent = Math.max(0, Math.min(100, Math.round((myScore * 100) / totalScore)))
				const dims = ['薪资福利', '成长机会', '工作强度', '管理制度', '团队氛围', '合规风险']
				const typeStats = dims.map((name, idx) => {
					const accuracy = totalScore > 0 ? Math.max(0, Math.min(1, myScore / totalScore)) : 0
					const my = Math.max(0, Math.min(100, Math.round(accuracy * 100)))
					return {type: idx, name, total: my, totalScore: 100, myScore: my, accuracy: Number((my / 100).toFixed(4))}
				})
				return {
					qiyemingcheng,
					qiyezhanghao,
					gangweileixing,
					gongzuodidian,
					shiximingcheng,
					reviewCount: rawReviews.length,
					rawReviews,
					questionTotal: typeStats.length,
					totalScore,
					myScore,
					scorePercent,
					typeStats,
					weakQuestions: [],
					pieStats: null,
					riskTips: [],
					llmAnalysis: '',
				}
			},
			inferInternshipTotalScore(myScore) {
				const s = Number(myScore)
				if (!Number.isFinite(s) || s <= 0) return 100
				if (s <= 5) return 5
				if (s <= 10) return 10
				return 100
			},
			buildLlmPrompt(base) {
				const lines = []
				lines.push('你是教学助理，请基于以下考试数据对学生本次在线考试进行学习诊断。')
				lines.push('输出要求：使用 Markdown 富文本格式，分标题呈现，包含列表与重点加粗。')
				lines.push('至少包含：## 总览、## 优势、## 薄弱点、## 可执行建议、## 下一步学习计划(3-5条)。')
				lines.push('')
				lines.push(`考试：${base.papername}（paperid=${base.paperid}）`)
				lines.push(`总分：${base.totalScore}，得分：${base.myScore}，得分占比：${base.scorePercent}%`)
				lines.push('')
				lines.push('按题型得分：')
				for (let i = 0; i < base.typeStats.length; i++) {
					const t = base.typeStats[i]
					lines.push(`- ${t.name}：${t.myScore}/${t.totalScore} 分（${this.percent(t.accuracy)}%）`)
				}
				if (base.weakQuestions && base.weakQuestions.length > 0) {
					lines.push('')
					lines.push('易错题(节选)：')
					for (let i = 0; i < base.weakQuestions.length; i++) {
						const q = base.weakQuestions[i]
						let qname = q.questionname || ''
						if (qname.length > 160) {
							qname = qname.slice(0, 160) + '...'
						}
						lines.push(`${i + 1}. ${qname}｜你的答案:${q.myanswer}｜正确答案:${q.answer}｜解析:${q.analysis}`)
					}
				}
				return lines.join('\n')
			},
			buildInternshipPrompt(base) {
				const lines = []
				lines.push('你是高校实习指导老师与企业导师的联合顾问，请基于以下实习评价数据，对学生实习情况做分析。')
				lines.push('输出要求：先输出一个严格 JSON（放在 <json> 与 </json> 标签内），再输出 Markdown 富文本分析。')
				lines.push('JSON 字段要求：')
				lines.push('- title: string')
				lines.push('- dimensions: [{name: string, score: number(0-100)}]（5项，维度建议：工作态度、专业技能、沟通协作、学习能力、职业素养）')
				lines.push('- keywords: [{name: string, weight: number}]（3-6项，weight 为占比，合计 100）')
				lines.push('- issues: [{name: string, severity: number(0-100)}]（0-5项）')
				lines.push('- suggestions: string[]（5-8条，可执行）')
				lines.push('Markdown 部分至少包含：## 总览、## 亮点、## 风险与不足、## 可执行建议、## 下一步成长计划(3-5条)。')
				lines.push('')
				lines.push(`学生：${base.xueshengxingming}（账号：${base.xueshengzhanghao}）`)
				lines.push(`企业：${base.qiyemingcheng}｜岗位：${base.gangweileixing}`)
				if (base.pingjiashijian) {
					lines.push(`评价时间：${base.pingjiashijian}`)
				}
				if (base.fuzeren) {
					lines.push(`评价人：${base.fuzeren}`)
				}
				lines.push(`评分：${base.myScore}/${base.totalScore}（${base.scorePercent}%）`)
				lines.push('')
				if (base.pingjianeirong) {
					lines.push('评价内容：')
					lines.push(base.pingjianeirong)
				} else {
					lines.push('评价内容：无（请基于已有信息给出合理分析，并提示需补充的关键信息）。')
				}
				return lines.join('\n')
			},
			buildCompanyPrompt(base) {
				const lines = []
				lines.push('你是企业口碑与用工风险分析专家，请基于以下原始评价内容，生成企业口碑画像与风险预警。')
				lines.push('输出要求：先输出一个严格 JSON（放在 <json> 与 </json> 标签内），再输出 Markdown 富文本分析。')
				lines.push('JSON 字段要求：')
				lines.push('- title: string')
				lines.push('- score: number(0-100)（企业口碑指数）')
				lines.push('- dimensions: [{name: string, score: number(0-100)}]（6项左右，多维度画像）')
				lines.push('- keywords: [{name: string, weight: number}]（4-8项，weight 为占比，合计 100）')
				lines.push('- risks: [{name: string, severity: number(0-100)}]（0-5项，风险预警）')
				lines.push('- riskTips: string[]（3-6条，可操作的风险提示）')
				lines.push('Markdown 部分至少包含：## 总览、## 画像解读、## 风险预警、## 原始评价摘要、## 建议。')
				lines.push('')
				lines.push(`企业：${base.qiyemingcheng || ''}（账号：${base.qiyezhanghao || ''}）`)
				if (base.gangweileixing || base.shiximingcheng) {
					lines.push(`岗位：${base.gangweileixing || ''}｜实习：${base.shiximingcheng || ''}`)
				}
				if (base.gongzuodidian) {
					lines.push(`地点：${base.gongzuodidian}`)
				}
				lines.push(`评价条数：${Number(base.reviewCount) || 0}`)
				lines.push('')
				const list = Array.isArray(base.rawReviews) ? base.rawReviews : []
				const maxN = 20
				lines.push(`原始评价（最多展示 ${maxN} 条，已做截断）：`)
				for (let i = 0; i < Math.min(maxN, list.length); i++) {
					const t = String(list[i] || '').trim()
					const s = t.length > 260 ? (t.slice(0, 260) + '...') : t
					lines.push(`${i + 1}. ${s}`)
				}
				if (list.length === 0) {
					lines.push('无（请提示需要补充评价数据）。')
				}
				return lines.join('\n')
			},
			extractJsonBlock(text) {
				const raw = String(text || '')
				const tagMatch = raw.match(/<json>\s*([\s\S]*?)\s*<\/json>/i)
				if (tagMatch && tagMatch[1]) {
					return tagMatch[1].trim()
				}
				const fenceMatch = raw.match(/```json\s*([\s\S]*?)\s*```/i)
				if (fenceMatch && fenceMatch[1]) {
					return fenceMatch[1].trim()
				}
				return ''
			},
			applyInternshipJsonToBase(base, parsed) {
				const p = parsed || {}
				const dims = Array.isArray(p.dimensions) ? p.dimensions : []
				const stats = []
				for (let i = 0; i < dims.length; i++) {
					const d = dims[i] || {}
					const name = d.name ? String(d.name) : `维度${i + 1}`
					const score = Math.max(0, Math.min(100, Number(d.score) || 0))
					stats.push({
						type: i,
						name,
						total: Math.round(score),
						totalScore: 100,
						myScore: Math.round(score),
						accuracy: Number((score / 100).toFixed(4))
					})
				}
				const issues = Array.isArray(p.issues) ? p.issues : []
				const weakQuestions = issues.slice(0, 5).map((it, idx) => {
					const name = it && it.name ? String(it.name) : `问题${idx + 1}`
					const sev = Math.max(0, Math.min(100, Number(it.severity) || 0))
					return {
						questionid: `issue_${idx}`,
						questionname: name,
						lost: Math.round(sev)
					}
				})
				let keywords = Array.isArray(p.keywords) ? p.keywords : []
				keywords = keywords.filter(k => k && k.name)
				if (keywords.length > 0) {
					const byWeight = keywords
						.map((k, idx) => ({type: idx, name: String(k.name), total: Math.max(0, Number(k.weight) || 0)}))
					const total = byWeight.reduce((s, r) => s + r.total, 0) || 1
					const normalized = byWeight.map(r => ({...r, total: Math.round((r.total * 100) / total)}))
					base.typeStats = stats.length ? stats : base.typeStats
					base.weakQuestions = weakQuestions
					base.pieStats = normalized
				} else {
					base.typeStats = stats.length ? stats : base.typeStats
					base.weakQuestions = weakQuestions
					base.pieStats = null
				}
				base.title = p.title ? String(p.title) : ''
				base.suggestions = Array.isArray(p.suggestions) ? p.suggestions : []
				return base
			},
			applyCompanyJsonToBase(base, parsed) {
				const p = parsed || {}
				const rawScore = Number(p.score)
				const score = Number.isFinite(rawScore) ? Math.max(0, Math.min(100, rawScore)) : base.myScore
				base.totalScore = 100
				base.myScore = Math.round(score)
				base.scorePercent = Math.round(score)
				base.title = p.title ? String(p.title) : ''

				const dims = Array.isArray(p.dimensions) ? p.dimensions : []
				const stats = []
				for (let i = 0; i < dims.length; i++) {
					const d = dims[i] || {}
					const name = d.name ? String(d.name) : `维度${i + 1}`
					const v = Math.max(0, Math.min(100, Number(d.score) || 0))
					stats.push({
						type: i,
						name,
						total: Math.round(v),
						totalScore: 100,
						myScore: Math.round(v),
						accuracy: Number((v / 100).toFixed(4))
					})
				}
				if (stats.length) {
					base.typeStats = stats
					base.questionTotal = stats.length
				}

				let keywords = Array.isArray(p.keywords) ? p.keywords : []
				keywords = keywords.filter(k => k && k.name)
				if (keywords.length > 0) {
					const byWeight = keywords.map((k, idx) => ({type: idx, name: String(k.name), total: Math.max(0, Number(k.weight) || 0)}))
					const total = byWeight.reduce((s, r) => s + r.total, 0) || 1
					base.pieStats = byWeight.map(r => ({...r, total: Math.round((r.total * 100) / total)}))
				} else {
					base.pieStats = null
				}

				const risks = Array.isArray(p.risks) ? p.risks : []
				base.weakQuestions = risks.slice(0, 5).map((it, idx) => {
					const name = it && it.name ? String(it.name) : `风险${idx + 1}`
					const sev = Math.max(0, Math.min(100, Number(it.severity) || 0))
					return {
						questionid: `risk_${idx}`,
						questionname: name,
						lost: Math.round(sev)
					}
				})
				base.riskTips = Array.isArray(p.riskTips) ? p.riskTips.map(s => String(s)).filter(Boolean) : []
				return base
			},
			callDeepSeek(prompt) {
				const apiUrl = localStorage.getItem('deepseekApiUrl') || 'https://api.deepseek.com/v1/chat/completions'
				const apiModel = localStorage.getItem('deepseekModel') || 'deepseek-chat'
				const apiKey = localStorage.getItem('deepseekApiKey') || 'sk-9481e94180d84b7bb612b45fadfc86bb'

				if (!apiKey) {
					return Promise.reject(new Error('未配置 deepseekApiKey'))
				}

				return fetch(apiUrl, {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json',
						Authorization: `Bearer ${apiKey}`,
					},
					body: JSON.stringify({
						model: apiModel,
						messages: [
							{role: 'system', content: '你是严谨的学习诊断助手，善于用数据给出建议。'},
							{role: 'user', content: prompt},
						],
						temperature: 0.2,
					}),
				})
					.then(resp => {
						if (!resp.ok) {
							return resp.text().then(t => {
								throw new Error(t || `HTTP ${resp.status}`)
							})
						}
						return resp.json()
					})
					.then(respJson => {
						const content = (((respJson || {}).choices || [])[0] || {}).message
							? (((respJson || {}).choices || [])[0] || {}).message.content
							: ''
						return String(content || '').trim()
					})
			},
			fetchLlmAnalysis(force) {
				if (!this.isInternship && !this.isCompany && (!this.paper || !this.paper.id)) {
					return
				}
				if (this.llmLoading) {
					return
				}
				if (!force && this.llmData) {
					return
				}
				this.llmLoading = true
				const base = this.isInternship ? this.buildInternshipBaseData() : (this.isCompany ? this.buildCompanyBaseData() : this.buildLlmBaseData())
				this.llmData = base
				this.llmAnalysisHtml = ''
				const prompt = this.isInternship ? this.buildInternshipPrompt(base) : (this.isCompany ? this.buildCompanyPrompt(base) : this.buildLlmPrompt(base))
				this.callDeepSeek(prompt)
					.then(text => {
						if (this.isInternship) {
							const jsonStr = this.extractJsonBlock(text)
							let parsed = null
							if (jsonStr) {
								try {
									parsed = JSON.parse(jsonStr)
								} catch (e) {
									parsed = null
								}
							}
							const applied = this.applyInternshipJsonToBase({...base}, parsed)
							this.llmData = {...applied, llmAnalysis: text}
							const md = jsonStr ? String(text).replace(/<json>[\s\S]*?<\/json>/i, '').trim() : text
							this.llmAnalysisHtml = this.renderMarkdownSafe(md)
							this.$emit('analysis-ready', this.llmData)
						} else if (this.isCompany) {
							const jsonStr = this.extractJsonBlock(text)
							let parsed = null
							if (jsonStr) {
								try {
									parsed = JSON.parse(jsonStr)
								} catch (e) {
									parsed = null
								}
							}
							const applied = this.applyCompanyJsonToBase({...base}, parsed)
							this.llmData = {...applied, llmAnalysis: text}
							const md = jsonStr ? String(text).replace(/<json>[\s\S]*?<\/json>/i, '').trim() : text
							this.llmAnalysisHtml = this.renderMarkdownSafe(md)
							this.$emit('analysis-ready', this.llmData)
						} else {
							this.llmData = {...base, llmAnalysis: text}
							this.llmAnalysisHtml = this.renderMarkdownSafe(text)
							this.$emit('analysis-ready', this.llmData)
						}
					})
					.catch(err => {
						this.llmData = {...base, llmAnalysis: ''}
						this.llmAnalysisHtml = ''
						this.$message.error(err && err.message ? err.message : '大模型调用失败')
					})
					.finally(() => {
						this.llmLoading = false
					})
			},
			escapeHtml(text) {
				return String(text || '')
					.replace(/&/g, '&amp;')
					.replace(/</g, '&lt;')
					.replace(/>/g, '&gt;')
					.replace(/"/g, '&quot;')
					.replace(/'/g, '&#39;')
			},
			formatInline(text) {
				let s = String(text || '')
				s = s.replace(/\[([^\]]+)\]\((https?:\/\/[^\s)]+)\)/g, '<a href="$2" target="_blank" rel="noopener noreferrer">$1</a>')
				s = s.replace(/\*\*([^*]+)\*\*/g, '<strong>$1</strong>')
				s = s.replace(/\*([^*]+)\*/g, '<em>$1</em>')
				s = s.replace(/`([^`]+)`/g, '<code>$1</code>')
				return s
			},
			renderMarkdownSafe(md) {
				const raw = String(md || '').replace(/\r\n/g, '\n')
				const codeBlocks = []
				const withTokens = raw.replace(/```([\s\S]*?)```/g, (m, code) => {
					const token = `@@CODE_${codeBlocks.length}@@`
					codeBlocks.push(code || '')
					return token
				})
				const escaped = this.escapeHtml(withTokens)
				const lines = escaped.split('\n')
				let out = []
				let inUl = false
				let inOl = false
				let para = []

				const flushPara = () => {
					if (para.length === 0) return
					out.push(`<p>${this.formatInline(para.join('<br/>'))}</p>`)
					para = []
				}
				const closeLists = () => {
					if (inUl) {
						out.push('</ul>')
						inUl = false
					}
					if (inOl) {
						out.push('</ol>')
						inOl = false
					}
				}

				for (let i = 0; i < lines.length; i++) {
					const line = lines[i]
					const codeMatch = line.match(/^@@CODE_(\d+)@@$/)
					if (codeMatch) {
						flushPara()
						closeLists()
						const idx = Number(codeMatch[1])
						const code = this.escapeHtml(codeBlocks[idx] || '').replace(/\r\n/g, '\n')
						out.push(`<pre class="llm-code"><code>${code}</code></pre>`)
						continue
					}

					const trimmed = line.trim()
					if (!trimmed) {
						flushPara()
						closeLists()
						continue
					}

					const h3 = trimmed.match(/^###\s+(.*)$/)
					const h2 = trimmed.match(/^##\s+(.*)$/)
					const h1 = trimmed.match(/^#\s+(.*)$/)
					if (h1 || h2 || h3) {
						flushPara()
						closeLists()
						const text = this.formatInline((h1 || h2 || h3)[1] || '')
						const tag = h1 ? 'h1' : (h2 ? 'h2' : 'h3')
						out.push(`<${tag}>${text}</${tag}>`)
						continue
					}

					if (/^---+$/.test(trimmed)) {
						flushPara()
						closeLists()
						out.push('<hr/>')
						continue
					}

					const ul = trimmed.match(/^-+\s+(.*)$/)
					const ol = trimmed.match(/^\d+\.\s+(.*)$/)
					if (ul) {
						flushPara()
						if (inOl) {
							out.push('</ol>')
							inOl = false
						}
						if (!inUl) {
							out.push('<ul>')
							inUl = true
						}
						out.push(`<li>${this.formatInline(ul[1])}</li>`)
						continue
					}
					if (ol) {
						flushPara()
						if (inUl) {
							out.push('</ul>')
							inUl = false
						}
						if (!inOl) {
							out.push('<ol>')
							inOl = true
						}
						out.push(`<li>${this.formatInline(ol[1])}</li>`)
						continue
					}

					if (inUl || inOl) {
						closeLists()
					}
					para.push(trimmed)
				}

				flushPara()
				closeLists()
				return out.join('\n')
			},
			badgeText(scorePercent) {
				const p = Number(scorePercent) || 0
				if (p >= 85) return '优秀'
				if (p >= 70) return '良好'
				if (p >= 60) return '及格'
				return '需加强'
			},
			badgeClass(scorePercent) {
				const p = Number(scorePercent) || 0
				if (p >= 85) return 'llm-badge-ok'
				if (p >= 70) return 'llm-badge-good'
				if (p >= 60) return 'llm-badge-warn'
				return 'llm-badge-bad'
			},
			scoreRatio(item) {
				const total = Number(item && item.totalScore) || 0
				const my = Number(item && item.myScore) || 0
				if (total <= 0) return 0
				return Math.max(0, Math.min(100, Math.round((my * 100) / total)))
			},
			typePieSegments(llmData) {
				const stats = (llmData && llmData.pieStats) ? llmData.pieStats : ((llmData && llmData.typeStats) ? llmData.typeStats : [])
				const palette = ['#00e5ff', '#7c4dff', '#00e676', '#ff9100', '#ff1744', '#18ffff']
				const segs = []
				for (let i = 0; i < stats.length; i++) {
					const t = stats[i]
					segs.push({
						key: String(t.type),
						name: t.name,
						total: Number(t.total) || 0,
						color: palette[i % palette.length],
					})
				}
				return segs.filter(s => s.total > 0)
			},
			typePieGradient(llmData) {
				const segs = this.typePieSegments(llmData)
				const total = segs.reduce((sum, s) => sum + (Number(s.total) || 0), 0) || 1
				let acc = 0
				const parts = []
				for (let i = 0; i < segs.length; i++) {
					const s = segs[i]
					const start = acc
					acc += (Number(s.total) || 0) / total
					const end = acc
					parts.push(`${s.color} ${Math.round(start * 100)}% ${Math.round(end * 100)}%`)
				}
				if (parts.length === 0) {
					return 'conic-gradient(#e0e0e0 0% 100%)'
				}
				return `conic-gradient(${parts.join(',')})`
			},
			radarAxes(llmData) {
				const stats = (llmData && llmData.typeStats) ? llmData.typeStats : []
				const n = Math.max(3, stats.length || 3)
				const cx = 120
				const cy = 120
				const r = 86
				let res = []
				for (let i = 0; i < n; i++) {
					const ang = (Math.PI * 2 * i) / n - Math.PI / 2
					res.push({
						key: `a_${i}`,
						x1: cx,
						y1: cy,
						x2: cx + r * Math.cos(ang),
						y2: cy + r * Math.sin(ang),
					})
				}
				return res
			},
			radarGridPoints(scale) {
				const n = 5
				const cx = 120
				const cy = 120
				const r = 86 * (Number(scale) || 1)
				let pts = []
				for (let i = 0; i < n; i++) {
					const ang = (Math.PI * 2 * i) / n - Math.PI / 2
					const x = cx + r * Math.cos(ang)
					const y = cy + r * Math.sin(ang)
					pts.push(`${x.toFixed(1)},${y.toFixed(1)}`)
				}
				return pts.join(' ')
			},
			radarDataPoints(llmData) {
				const stats = (llmData && llmData.typeStats) ? llmData.typeStats : []
				const n = Math.max(3, stats.length || 3)
				const cx = 120
				const cy = 120
				const r = 86
				let pts = []
				for (let i = 0; i < n; i++) {
					const t = stats[i] || {}
					const v = Math.max(0, Math.min(1, Number(t.accuracy) || 0))
					const ang = (Math.PI * 2 * i) / n - Math.PI / 2
					const x = cx + r * v * Math.cos(ang)
					const y = cy + r * v * Math.sin(ang)
					pts.push(`${x.toFixed(1)},${y.toFixed(1)}`)
				}
				return pts.join(' ')
			},
			radarDots(llmData) {
				const stats = (llmData && llmData.typeStats) ? llmData.typeStats : []
				const n = Math.max(3, stats.length || 3)
				const cx = 120
				const cy = 120
				const r = 86
				let res = []
				for (let i = 0; i < n; i++) {
					const t = stats[i] || {}
					const v = Math.max(0, Math.min(1, Number(t.accuracy) || 0))
					const ang = (Math.PI * 2 * i) / n - Math.PI / 2
					res.push({
						key: `d_${i}`,
						x: (cx + r * v * Math.cos(ang)).toFixed(1),
						y: (cy + r * v * Math.sin(ang)).toFixed(1),
					})
				}
				return res
			},
			radarLabels(llmData) {
				const stats = (llmData && llmData.typeStats) ? llmData.typeStats : []
				const n = Math.max(3, stats.length || 3)
				const cx = 120
				const cy = 120
				const r = 104
				let res = []
				for (let i = 0; i < n; i++) {
					const t = stats[i] || {name: `T${i + 1}`}
					const ang = (Math.PI * 2 * i) / n - Math.PI / 2
					const x = cx + r * Math.cos(ang)
					const y = cy + r * Math.sin(ang)
					res.push({
						key: `l_${i}`,
						name: t.name,
						left: `${Math.max(0, Math.min(220, x - 24)).toFixed(0)}px`,
						top: `${Math.max(0, Math.min(220, y - 10)).toFixed(0)}px`,
					})
				}
				return res
			},
			lostTopQuestions(llmData) {
				const list = (llmData && llmData.weakQuestions) ? llmData.weakQuestions : []
				const rows = []
				for (let i = 0; i < list.length; i++) {
					const q = list[i] || {}
					const lost = Number(q.lost) || 0
					const fullName = String(q.questionname || '')
					rows.push({
						key: String(q.questionid || i),
						index: i + 1,
						name: fullName.slice(0, 26),
						fullName,
						lost,
					})
				}
				const maxLost = rows.reduce((m, r) => Math.max(m, r.lost), 0) || 1
				return rows
					.filter(r => r.lost > 0)
					.map(r => ({...r, ratio: Math.round((r.lost * 100) / maxLost)}))
			},
			exportReport() {
				const base = this.llmData || {}
				const title = (this.isInternship
					? (base.title || `实习报告分析-${base.xueshengxingming || ''}`)
					: (this.isCompany ? (base.title || `企业口碑画像-${base.qiyemingcheng || ''}`) : (base.papername || '大模型分析'))) || '报告'
				const safeName = String(title).replace(/[\\/:*?"<>|]+/g, '_').slice(0, 80) || '报告'
				const stats = Array.isArray(base.typeStats) ? base.typeStats : []
				const barsHtml = stats.map(s => {
					const pct = this.scoreRatio(s)
					return `<div class="row"><div class="name">${this.escapeHtml(s.name)}</div><div class="bar"><div class="fill" style="width:${pct}%"></div><div class="meta">${this.escapeHtml(String(s.myScore))} / ${this.escapeHtml(String(s.totalScore))}</div></div></div>`
				}).join('')
				const pieSegs = this.typePieSegments(base)
				const keyHtml = pieSegs.map(s => `<li>${this.escapeHtml(s.name)}：${this.escapeHtml(String(s.total))}${this.escapeHtml(this.typeUnit)}</li>`).join('')
				const analysis = this.llmAnalysisHtml || ''
				const headerLines = []
				if (this.isInternship) {
					headerLines.push(`<div class="kv">学生：${this.escapeHtml(base.xueshengxingming || '')}（${this.escapeHtml(base.xueshengzhanghao || '')}）</div>`)
					headerLines.push(`<div class="kv">企业：${this.escapeHtml(base.qiyemingcheng || '')}｜岗位：${this.escapeHtml(base.gangweileixing || '')}</div>`)
					if (base.pingjiashijian) headerLines.push(`<div class="kv">评价时间：${this.escapeHtml(base.pingjiashijian || '')}</div>`)
					if (base.fuzeren) headerLines.push(`<div class="kv">评价人：${this.escapeHtml(base.fuzeren || '')}</div>`)
				} else if (this.isCompany) {
					headerLines.push(`<div class="kv">企业：${this.escapeHtml(base.qiyemingcheng || '')}（${this.escapeHtml(base.qiyezhanghao || '')}）</div>`)
					const job = [base.gangweileixing || '', base.shiximingcheng || ''].filter(Boolean).join('｜')
					if (job) headerLines.push(`<div class="kv">岗位/实习：${this.escapeHtml(job)}</div>`)
					if (base.gongzuodidian) headerLines.push(`<div class="kv">地点：${this.escapeHtml(base.gongzuodidian || '')}</div>`)
					headerLines.push(`<div class="kv">评价条数：${this.escapeHtml(String(base.reviewCount || 0))}</div>`)
				} else {
					headerLines.push(`<div class="kv">考试：${this.escapeHtml(base.papername || '')}</div>`)
				}
				headerLines.push(`<div class="kv">评分：${this.escapeHtml(String(base.myScore || 0))} / ${this.escapeHtml(String(base.totalScore || 0))}（${this.escapeHtml(String(base.scorePercent || 0))}%）</div>`)
				const html = `<!doctype html><html><head><meta charset="utf-8"/><title>${this.escapeHtml(safeName)}</title><style>
body{font-family:-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica,Arial,"PingFang SC","Hiragino Sans GB","Microsoft YaHei",sans-serif;margin:24px;color:#0b1226;}
h1{font-size:20px;margin:0 0 10px;}
.kv{margin:4px 0;color:rgba(11,18,38,.78);font-size:13px;}
.sec{margin-top:18px;}
.sec h2{font-size:16px;margin:0 0 10px;}
.row{display:flex;gap:10px;align-items:center;margin:8px 0;}
.name{width:110px;font-weight:700;font-size:12px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
.bar{position:relative;flex:1;height:26px;border-radius:10px;background:rgba(11,18,38,.06);overflow:hidden;}
.fill{height:100%;background:linear-gradient(90deg,rgba(0,229,255,.95),rgba(124,77,255,.9));}
.meta{position:absolute;inset:0;display:flex;align-items:center;justify-content:flex-end;padding-right:10px;font-size:12px;font-weight:800;color:rgba(11,18,38,.72);}
ul{padding-left:18px;margin:8px 0;}
.analysis{margin-top:10px;line-height:1.75;}
.analysis h1,.analysis h2,.analysis h3{margin:12px 0 8px;}
.analysis p{margin:6px 0;}
.analysis strong{background:rgba(0,229,255,.16);padding:0 2px;border-radius:4px;}
				</style></head><body>
<h1>${this.escapeHtml(title)}</h1>
${headerLines.join('')}
<div class="sec"><h2>${this.escapeHtml(this.barsCardTitle)}</h2>${barsHtml || '<div>暂无数据</div>'}</div>
<div class="sec"><h2>${this.escapeHtml(this.pieCardTitle)}</h2><ul>${keyHtml || '<li>暂无数据</li>'}</ul></div>
<div class="sec"><h2>${this.escapeHtml(this.textCardTitle)}</h2><div class="analysis">${analysis || '暂无文字分析'}</div></div>
</body></html>`
				const blob = new Blob([html], {type: 'text/html;charset=utf-8'})
				const objectUrl = window.URL.createObjectURL(blob)
				const a = document.createElement('a')
				a.href = objectUrl
				a.download = `${safeName}.html`
				a.dispatchEvent(new MouseEvent('click', {bubbles: true, cancelable: true, view: window}))
				window.URL.revokeObjectURL(objectUrl)
			},
		}
	}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
	.llm-dashboard {
		background: radial-gradient(1200px 480px at 10% 0%, rgba(124, 77, 255, 0.18), transparent 55%),
			radial-gradient(900px 420px at 90% 10%, rgba(0, 229, 255, 0.16), transparent 50%),
			linear-gradient(180deg, rgba(10, 14, 26, 0.02), rgba(10, 14, 26, 0));
		border-radius: 12px;
		padding: 6px;
	}
	.llm-grid {
		display: grid;
		grid-template-columns: repeat(3, minmax(0, 1fr));
		gap: 14px;
	}
	.llm-split {
		display: grid;
		grid-template-columns: repeat(2, minmax(0, 1fr));
		gap: 14px;
		margin-top: 14px;
	}
	.llm-card {
		position: relative;
		border-radius: 14px;
		padding: 14px 14px 12px;
		background: linear-gradient(180deg, rgba(255,255,255,0.85), rgba(255,255,255,0.6));
		box-shadow: 0 10px 30px rgba(20, 24, 40, 0.10);
		overflow: hidden;
	}
	.llm-card::before {
		content: '';
		position: absolute;
		inset: -2px;
		background: linear-gradient(120deg, rgba(0,229,255,0.30), rgba(124,77,255,0.28), rgba(0,230,118,0.22));
		filter: blur(18px);
		opacity: 0.55;
		pointer-events: none;
	}
	.llm-card-wide {
		margin-top: 14px;
	}
	.llm-card-title {
		position: relative;
		font-weight: 700;
		color: #0b1226;
		letter-spacing: 0.5px;
		margin-bottom: 10px;
	}
	.llm-score-wrap {
		position: relative;
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 8px;
		padding: 6px 0 4px;
	}
	.llm-score-sub {
		position: relative;
		font-size: 13px;
		color: rgba(20, 24, 40, 0.75);
	}
	.llm-badge {
		position: relative;
		display: inline-flex;
		align-items: center;
		justify-content: center;
		height: 26px;
		padding: 0 10px;
		border-radius: 999px;
		font-weight: 700;
		font-size: 12px;
		letter-spacing: 0.8px;
		color: #0b1226;
		background: rgba(255,255,255,0.8);
		border: 1px solid rgba(11, 18, 38, 0.08);
		box-shadow: 0 10px 18px rgba(10, 12, 24, 0.10);
	}
	.llm-badge-ok { background: linear-gradient(90deg, rgba(0,230,118,0.28), rgba(0,229,255,0.22)); }
	.llm-badge-good { background: linear-gradient(90deg, rgba(0,229,255,0.26), rgba(124,77,255,0.20)); }
	.llm-badge-warn { background: linear-gradient(90deg, rgba(255,145,0,0.26), rgba(255,23,68,0.16)); }
	.llm-badge-bad { background: linear-gradient(90deg, rgba(255,23,68,0.22), rgba(124,77,255,0.18)); }

	.llm-pie-wrap {
		position: relative;
		height: 150px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.llm-pie {
		width: 150px;
		height: 150px;
		border-radius: 50%;
		box-shadow: 0 16px 30px rgba(15, 18, 30, 0.18);
		transform: translateZ(0);
		animation: llmSpinIn 900ms ease-out both;
	}
	.llm-pie::after {
		content: '';
		position: absolute;
		inset: 14px;
		border-radius: 50%;
		background: radial-gradient(circle at 35% 25%, rgba(255,255,255,0.95), rgba(255,255,255,0.7));
	}
	.llm-pie-center {
		position: absolute;
		width: 96px;
		height: 96px;
		border-radius: 50%;
		background: rgba(255,255,255,0.72);
		backdrop-filter: blur(10px);
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		box-shadow: inset 0 0 0 1px rgba(11,18,38,0.08), 0 14px 26px rgba(10, 12, 24, 0.10);
	}
	.llm-pie-main {
		font-size: 28px;
		font-weight: 800;
		color: #0b1226;
		line-height: 1;
	}
	.llm-pie-sub {
		margin-top: 2px;
		font-size: 12px;
		color: rgba(20, 24, 40, 0.70);
	}
	.llm-legend {
		position: relative;
		display: grid;
		grid-template-columns: repeat(2, minmax(0, 1fr));
		gap: 8px 10px;
		margin-top: 10px;
	}
	.llm-legend-item {
		display: flex;
		align-items: center;
		gap: 8px;
		font-size: 12px;
		color: rgba(20, 24, 40, 0.82);
	}
	.llm-dot {
		width: 10px;
		height: 10px;
		border-radius: 50%;
		box-shadow: 0 0 0 3px rgba(11, 18, 38, 0.06);
	}
	.llm-legend-name {
		flex: 1;
		min-width: 0;
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.llm-legend-val {
		font-weight: 700;
	}

	.llm-radar {
		position: relative;
		height: 210px;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.llm-radar-svg {
		width: 210px;
		height: 210px;
	}
	.llm-radar-grid {
		fill: rgba(11, 18, 38, 0.02);
		stroke: rgba(11, 18, 38, 0.10);
		stroke-width: 1;
	}
	.llm-radar-axes line {
		stroke: rgba(11, 18, 38, 0.10);
		stroke-width: 1;
	}
	.llm-radar-area {
		fill: url(#llmRadarFill);
		animation: llmFadeIn 700ms ease-out both;
	}
	.llm-radar-line {
		fill: none;
		stroke: #00e5ff;
		stroke-width: 2.4;
		stroke-linejoin: round;
		stroke-linecap: round;
		animation: llmStroke 900ms ease-out both;
	}
	.llm-radar-dot {
		fill: #7c4dff;
		stroke: rgba(255,255,255,0.9);
		stroke-width: 1;
	}
	.llm-radar-labels {
		position: absolute;
		width: 240px;
		height: 240px;
		pointer-events: none;
	}
	.llm-radar-label {
		position: absolute;
		font-size: 12px;
		font-weight: 700;
		color: rgba(11, 18, 38, 0.70);
		padding: 2px 6px;
		border-radius: 8px;
		background: rgba(255,255,255,0.62);
		backdrop-filter: blur(8px);
		box-shadow: 0 10px 20px rgba(10, 12, 24, 0.10);
		transform: translate(-50%, -50%);
	}

	.llm-bars {
		position: relative;
		display: flex;
		flex-direction: column;
		gap: 10px;
	}
	.llm-bar-row {
		display: grid;
		grid-template-columns: 120px 1fr;
		gap: 10px;
		align-items: center;
	}
	.llm-bar-label {
		font-size: 12px;
		font-weight: 700;
		color: rgba(11, 18, 38, 0.78);
		overflow: hidden;
		text-overflow: ellipsis;
		white-space: nowrap;
	}
	.llm-bar-track {
		position: relative;
		height: 30px;
		border-radius: 10px;
		background: rgba(11, 18, 38, 0.05);
		overflow: hidden;
		box-shadow: inset 0 0 0 1px rgba(11,18,38,0.06);
	}
	.llm-bar-track-thin {
		height: 22px;
		margin-top: -2px;
	}
	.llm-bar-fill {
		height: 100%;
		border-radius: 10px;
		background: linear-gradient(90deg, rgba(0,229,255,0.95), rgba(124,77,255,0.90));
		box-shadow: 0 8px 18px rgba(124,77,255,0.24);
		transition: width 700ms cubic-bezier(.2,.9,.2,1);
	}
	.llm-bar-fill-alt {
		background: linear-gradient(90deg, rgba(0,230,118,0.90), rgba(0,229,255,0.88));
		box-shadow: 0 8px 18px rgba(0,230,118,0.18);
	}
	.llm-bar-fill-warn {
		background: linear-gradient(90deg, rgba(255,145,0,0.92), rgba(255,23,68,0.86));
		box-shadow: 0 8px 18px rgba(255,23,68,0.16);
	}
	.llm-bar-meta {
		position: absolute;
		inset: 0;
		display: flex;
		align-items: center;
		justify-content: flex-end;
		padding-right: 10px;
		font-size: 12px;
		font-weight: 800;
		color: rgba(11, 18, 38, 0.72);
		mix-blend-mode: multiply;
	}

	.llm-richtext {
		position: relative;
		padding: 6px 2px 0;
		color: rgba(11, 18, 38, 0.84);
		line-height: 1.75;
		word-break: break-word;
	}
	.llm-richtext h1, .llm-richtext h2, .llm-richtext h3 {
		color: #0b1226;
		margin: 12px 0 8px;
	}
	.llm-richtext h1 { font-size: 18px; }
	.llm-richtext h2 { font-size: 16px; }
	.llm-richtext h3 { font-size: 14px; }
	.llm-richtext p { margin: 6px 0; }
	.llm-richtext ul, .llm-richtext ol { padding-left: 18px; margin: 8px 0; }
	.llm-richtext li { margin: 6px 0; }
	.llm-richtext strong {
		color: #0b1226;
		background: linear-gradient(90deg, rgba(0,229,255,0.18), rgba(124,77,255,0.12));
		padding: 0 2px;
		border-radius: 4px;
	}
	.llm-richtext code {
		font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono", "Courier New", monospace;
		background: rgba(11, 18, 38, 0.06);
		padding: 2px 6px;
		border-radius: 6px;
	}
	.llm-richtext a { color: #1976d2; text-decoration: none; font-weight: 700; }
	.llm-richtext a:hover { text-decoration: underline; }
	.llm-richtext hr {
		border: none;
		height: 1px;
		background: linear-gradient(90deg, transparent, rgba(11,18,38,0.18), transparent);
		margin: 10px 0;
	}
	.llm-code {
		margin: 10px 0;
		padding: 12px;
		border-radius: 12px;
		background: linear-gradient(180deg, rgba(11,18,38,0.94), rgba(11,18,38,0.86));
		color: rgba(255,255,255,0.92);
		overflow: auto;
		box-shadow: 0 16px 30px rgba(10, 12, 24, 0.20);
	}
	.llm-code code {
		background: transparent;
		padding: 0;
		color: inherit;
	}

	@keyframes llmSpinIn {
		from { transform: scale(0.92) rotate(-20deg); opacity: 0; }
		to { transform: scale(1) rotate(0deg); opacity: 1; }
	}
	@keyframes llmFadeIn {
		from { opacity: 0; transform: translateY(6px); }
		to { opacity: 1; transform: translateY(0); }
	}
	@keyframes llmStroke {
		from { stroke-dasharray: 520; stroke-dashoffset: 520; }
		to { stroke-dasharray: 520; stroke-dashoffset: 0; }
	}

	@media (max-width: 1100px) {
		.llm-grid { grid-template-columns: 1fr; }
		.llm-split { grid-template-columns: 1fr; }
		.llm-bar-row { grid-template-columns: 96px 1fr; }
	}
</style>
