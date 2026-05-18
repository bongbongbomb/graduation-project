const base = {
    get() {
        return {
            url : "http://localhost:8080/springboot8d6m43dj/",
            name: "springboot8d6m43dj",
            // 退出到首页链接
            indexUrl: 'http://localhost:8080/springboot8d6m43dj/front/dist/index.html'
        };
    },
    getProjectName(){
        return {
            projectName: "基于Spring Boot的企业口碑智能分析系统的设计与实现"
        } 
    }
}
export default base
