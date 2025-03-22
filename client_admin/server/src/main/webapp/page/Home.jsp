<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 首页 -->
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8"/>
    <title>首页</title>
    <!-- 引入刚刚下载的 ECharts 文件 -->
    <script src="../js/index.js"></script>
    <script src="../js/axios.min.js"></script>
    <script src="../js/echarts.js"></script>
    <link rel="stylesheet" href="../layui/css/layui.css">
    <link rel="stylesheet" href="../css/diy.css">

</head>
<style>
    canvas {
        position: relative !important;
    }

    #test div::before {
        content: '';
        width: 100px;
        position: absolute;
        top: 154px;
        right: 129px;
        z-index: 999;
        height: 20px;
        background-color: #FFFFFF;
    }

    #i {
        position: fixed;
        top: 400px;
        right: 100px;
        z-index: 1000;
    }

</style>

<body>
<div>
    <div class="layui-col-md">
        <div class="layui-panel">
            <div id="i"></div>
        </div>
    </div>
</div>
<!-- 为 ECharts 准备一个定义了宽高的 DOM -->

                                            <div class="box">
            <div id="book_information" style="width: 600px;height:400px;display: none"></div>
        </div>
                            <div class="box">
            <div id="sales_data" style="width: 600px;height:400px;display: none"></div>
        </div>
            
    
    
    <script src="../js/base.js"></script>
<script type="text/javascript">
    var BaseUrl = baseUrl()
    let personInfo = JSON.parse(sessionStorage.personInfo)

    // 请求数据

    async function get_list() {
        let {data: ren} = await axios.get(BaseUrl + '/api/auth/get_list', {
            params: {
                user_group: personInfo.user_group
            }
        })
        permissions = ren.result.list


    function $get_power(path) {
        var list = permissions;
        var obj;
        for (var i = 0; i < list.length; i++) {
            var o = list[i];
            if (o.path === path) {
                obj = o;
                break;
            }
        }
        return obj;
    }

    /**
     * 是否有统计字段的权限
     */
    function $check_figure(path) {
        var o = $get_power(path);
        if (o) {
            var option = JSON.parse(o.option);
            if (option.figure)
                return true
        }
        return false;
    }

    function $check_comment(path) {
        var o = this.$get_power(path);
        if (o) {
            var option = JSON.parse(o.option);
            if (option.can_show_comment)
                return true
        }
        return false;
    }

                                    let book_information = document.querySelector('#book_information')

                if (personInfo.user_group === '管理员' || $check_figure('/book_information/table')) {
                        book_information.style.display = 'block'
                } else {
                        book_information.style.display = 'none'
                }
                                let sales_data = document.querySelector('#sales_data')

                if (personInfo.user_group === '管理员' || $check_figure('/sales_data/table')) {
                        sales_data.style.display = 'block'
                } else {
                        sales_data.style.display = 'none'
                }
                }

    get_list()

    async function echartsFun(id, url, title) {

        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById(id));

        let user_group = personInfo.user_group
        let user_id = personInfo.user_id

                                        
        let {data: res} = await axios.get(url)

        let arr = []

        arr = res.result.list.map((o) => {
            return {
                name: o[1],
                value: o[0]
            };
        });
        // 指定图表的配置项和数据
        var option = {
            title: {
                text: title,
                left: 'center'
            },
            tooltip: {
                trigger: 'item'
            },
            legend: {
                orient: 'vertical',
                left: 'left'
            },
            series: [
                {
                    name: '参数',
                    type: 'pie',
                    radius: '50%',
                    data: arr,
                    emphasis: {
                        itemStyle: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        }
                    }
                }
            ]
        };

        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }

                                function book_information(){
                let query_str = "";
                let name_list = []
                                                        let group_by_value = "book_name";
                                                                                                query_str = query_str+"inventory_quantity"+","
                        name_list.push("库存数量")
                                                                                        async function echartsFun1(id, url) {
                    var app = {};

                    var chartDom = document.getElementById(id);
                    var myChart = echarts.init(chartDom);
                    var option;

                    let user_group = personInfo.user_group
                    let user_id = personInfo.user_id

                                                                                                                                                                                                                                                                                                                                                
                    let {data: res} = await axios.get(url)
                    let arr_name = []
                                                                                                                                                                                    let arr1 = []
                                                                                                                                                    for (let i = 0; i < res.result.list.length; i++) {
                        arr_name.push(res.result.list[i][0])
                                                                                                                                                                                        arr1.push(res.result.list[i][1])
                                                                                                                                                        }

                    const posList = [
                        'left',
                        'right',
                        'top',
                        'bottom',
                        'inside',
                        'insideTop',
                        'insideLeft',
                        'insideRight',
                        'insideBottom',
                        'insideTopLeft',
                        'insideTopRight',
                        'insideBottomLeft',
                        'insideBottomRight'
                    ];
                    app.configParameters = {
                        rotate: {
                            min: -90,
                            max: 90
                        },
                        align: {
                            options: {
                                left: 'left',
                                center: 'center',
                                right: 'right'
                            }
                        },
                        verticalAlign: {
                            options: {
                                top: 'top',
                                middle: 'middle',
                                bottom: 'bottom'
                            }
                        },
                        position: {
                            options: posList.reduce(function (map, pos) {
                                map[pos] = pos;
                                return map;
                            }, {})
                        },
                        distance: {
                            min: 0,
                            max: 100
                        }
                    };
                    app.config = {
                        rotate: 90,
                        align: 'left',
                        verticalAlign: 'middle',
                        position: 'insideBottom',
                        distance: 15,
                        onChange: function () {
                            const labelOption = {
                                rotate: app.config.rotate,
                                align: app.config.align,
                                verticalAlign: app.config.verticalAlign,
                                position: app.config.position,
                                distance: app.config.distance
                            };
                            myChart.setOption({
                                series: [
                                    {
                                        label: labelOption
                                    },
                                    {
                                        label: labelOption
                                    },
                                    {
                                        label: labelOption
                                    },
                                    {
                                        label: labelOption
                                    }
                                ]
                            });
                        }
                    };
                    const labelOption = {
                        show: true,
                        position: app.config.position,
                        distance: app.config.distance,
                        align: app.config.align,
                        verticalAlign: app.config.verticalAlign,
                        rotate: app.config.rotate,
                        formatter: '{c}  {name|{a}}',
                        fontSize: 16,
                        rich: {
                            name: {}
                        }
                    };
                    option = {
                        title: {
                            text: '书籍信息'
                        },
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {
                                type: 'shadow'
                            }
                        },
                        legend: {
                            data: ['Forest', 'Steppe', 'Desert', 'Wetland']
                        },
                        toolbox: {
                            show: true,
                            orient: 'vertical',
                            left: 'right',
                            top: 'center',
                            feature: {
                                mark: { show: true },
                                dataView: { show: true, readOnly: false },
                                magicType: { show: true, type: ['line', 'bar', 'stack'] },
                                restore: { show: true },
                                saveAsImage: { show: true }
                            }
                        },
                        xAxis: [
                            {
                                type: 'category',
                                axisTick: { show: false },
                                data: arr_name,
                                axisLabel:{
                                    show:true,
                                    interval : 0
                                }
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value'
                            }
                        ],
                        series: [
                                                                                                                                                                                                                                                                                                                {
                                        name: name_list[0],
                                        type: 'bar',
                                        barGap: 0,
                                        label: labelOption,
                                        emphasis: {
                                            focus: 'series'
                                        },
                                        data: arr1
                                    },
                                                                                                                                                                                                                                                ]
                    };

                    if (arr_name.length>4){
                        option.axisLabel= {
                            interval: 0, //使x轴文字显示全
                            formatter: function (params) {
                                let newParamsName = '';
                                const paramsNameNumber = params.length; // 文字总长度
                                const provideNumber = 4; //一行显示几个字
                                const rowNumber = Math.ceil(paramsNameNumber / provideNumber);
                                if (paramsNameNumber > provideNumber) {
                                    for (let p = 0; p < rowNumber; p++) {
                                        const start = p * provideNumber;
                                        const end = start + provideNumber;
                                        const tempStr = p === rowNumber - 1 ? params.substring(start, paramsNameNumber) : params.substring(start, end) + '\n';
                                        newParamsName += tempStr;
                                    }
                                } else {
                                    newParamsName = params;
                                }
                                return newParamsName;
                            },
                        }
                    }
                    myChart.setOption(option);

                }
                query_str = query_str.substr(0,query_str.length-1);
                echartsFun1('book_information', BaseUrl + '/api/book_information/bar_group?field='+query_str+"&groupby="+group_by_value, '书籍信息统计')
            }
                book_information()

                            function sales_data(){
                let query_str = "";
                let name_list = []
                                                        let group_by_value = "statistical_date";
                                                        query_str = query_str+"sales_quantity"+","
                        name_list.push("售卖数量")
                                                                query_str = query_str+"profit_amount"+","
                        name_list.push("利润金额")
                                                                    async function echartsFun1(id, url) {
                    var app = {};

                    var chartDom = document.getElementById(id);
                    var myChart = echarts.init(chartDom);
                    var option;

                    let user_group = personInfo.user_group
                    let user_id = personInfo.user_id

                                                                                                                                                                                                                                                        
                    let {data: res} = await axios.get(url)
                    let arr_name = []
                                                                                                            let arr1 = []
                                                                                                let arr2 = []
                                                                                                                for (let i = 0; i < res.result.list.length; i++) {
                        arr_name.push(res.result.list[i][0])
                                                                                                                arr1.push(res.result.list[i][1])
                                                                                                        arr2.push(res.result.list[i][2])
                                                                                                                    }

                    const posList = [
                        'left',
                        'right',
                        'top',
                        'bottom',
                        'inside',
                        'insideTop',
                        'insideLeft',
                        'insideRight',
                        'insideBottom',
                        'insideTopLeft',
                        'insideTopRight',
                        'insideBottomLeft',
                        'insideBottomRight'
                    ];
                    app.configParameters = {
                        rotate: {
                            min: -90,
                            max: 90
                        },
                        align: {
                            options: {
                                left: 'left',
                                center: 'center',
                                right: 'right'
                            }
                        },
                        verticalAlign: {
                            options: {
                                top: 'top',
                                middle: 'middle',
                                bottom: 'bottom'
                            }
                        },
                        position: {
                            options: posList.reduce(function (map, pos) {
                                map[pos] = pos;
                                return map;
                            }, {})
                        },
                        distance: {
                            min: 0,
                            max: 100
                        }
                    };
                    app.config = {
                        rotate: 90,
                        align: 'left',
                        verticalAlign: 'middle',
                        position: 'insideBottom',
                        distance: 15,
                        onChange: function () {
                            const labelOption = {
                                rotate: app.config.rotate,
                                align: app.config.align,
                                verticalAlign: app.config.verticalAlign,
                                position: app.config.position,
                                distance: app.config.distance
                            };
                            myChart.setOption({
                                series: [
                                    {
                                        label: labelOption
                                    },
                                    {
                                        label: labelOption
                                    },
                                    {
                                        label: labelOption
                                    },
                                    {
                                        label: labelOption
                                    }
                                ]
                            });
                        }
                    };
                    const labelOption = {
                        show: true,
                        position: app.config.position,
                        distance: app.config.distance,
                        align: app.config.align,
                        verticalAlign: app.config.verticalAlign,
                        rotate: app.config.rotate,
                        formatter: '{c}  {name|{a}}',
                        fontSize: 16,
                        rich: {
                            name: {}
                        }
                    };
                    option = {
                        title: {
                            text: '销售数据'
                        },
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {
                                type: 'shadow'
                            }
                        },
                        legend: {
                            data: ['Forest', 'Steppe', 'Desert', 'Wetland']
                        },
                        toolbox: {
                            show: true,
                            orient: 'vertical',
                            left: 'right',
                            top: 'center',
                            feature: {
                                mark: { show: true },
                                dataView: { show: true, readOnly: false },
                                magicType: { show: true, type: ['line', 'bar', 'stack'] },
                                restore: { show: true },
                                saveAsImage: { show: true }
                            }
                        },
                        xAxis: [
                            {
                                type: 'category',
                                axisTick: { show: false },
                                data: arr_name,
                                axisLabel:{
                                    show:true,
                                    interval : 0
                                }
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value'
                            }
                        ],
                        series: [
                                                                                                                                                                                        {
                                        name: name_list[0],
                                        type: 'bar',
                                        barGap: 0,
                                        label: labelOption,
                                        emphasis: {
                                            focus: 'series'
                                        },
                                        data: arr1
                                    },
                                                                                                                                                                    {
                                        name: name_list[1],
                                        type: 'bar',
                                        barGap: 0,
                                        label: labelOption,
                                        emphasis: {
                                            focus: 'series'
                                        },
                                        data: arr2
                                    },
                                                                                                                                                                                    ]
                    };

                    if (arr_name.length>4){
                        option.axisLabel= {
                            interval: 0, //使x轴文字显示全
                            formatter: function (params) {
                                let newParamsName = '';
                                const paramsNameNumber = params.length; // 文字总长度
                                const provideNumber = 4; //一行显示几个字
                                const rowNumber = Math.ceil(paramsNameNumber / provideNumber);
                                if (paramsNameNumber > provideNumber) {
                                    for (let p = 0; p < rowNumber; p++) {
                                        const start = p * provideNumber;
                                        const end = start + provideNumber;
                                        const tempStr = p === rowNumber - 1 ? params.substring(start, paramsNameNumber) : params.substring(start, end) + '\n';
                                        newParamsName += tempStr;
                                    }
                                } else {
                                    newParamsName = params;
                                }
                                return newParamsName;
                            },
                        }
                    }
                    myChart.setOption(option);

                }
                query_str = query_str.substr(0,query_str.length-1);
                echartsFun1('sales_data', BaseUrl + '/api/sales_data/bar_group?field='+query_str+"&groupby="+group_by_value, '销售数据统计')
            }
                sales_data()

            

    let ii = document.querySelector('#i')
    let i

    async function axioss() {
        const {data: res} = await axios.get(BaseUrl + '/api/user/count')
        i = res.result
        ii.innerHTML = "用户数量" + i + "人"
    }

    axioss()
</script>
</body>

</html>
