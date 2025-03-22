<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 新增/Add -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <link rel="stylesheet" href="../../css/diy.css">
    <script src="../../js/axios.min.js"></script>

    <style>
        img {
            width: 200px;
        }



    </style>
</head>

<body>
<article class="sign_in">
    <div class="warp">
        <div class="layui-container">
            <div class="layui-row">
                <form class="layui-form" action="">
                                                                                    <div class="layui-form-item" id="statistical_date_box">
                                        <div class="layui-inline">
                                            <label class="layui-form-label">统计日期</label>
                                            <div class="layui-input-inline">
                                                <input type="text" class="layui-input" id="statistical_date"
                                                       placeholder="yyyy-MM-dd">
                                            </div>
                                        </div>
                                    </div>
                                                                                                                        <div class="layui-form-item" id="sales_quantity_box">
                                            <label class="layui-form-label">售卖数量</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入售卖数量"
                                                       class="layui-input" id="sales_quantity">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="profit_amount_box">
                                            <label class="layui-form-label">利润金额</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入利润金额"
                                                       class="layui-input" id="profit_amount">
                                            </div>
                                        </div>
                                                                                                                    <div class="layui-form-item layui-form-text" id="notes_details_box">
                                        <label class="layui-form-label">备注详情</label>
                                        <div class="layui-input-block">
                                            <textarea placeholder="请输入备注详情" class="layui-textarea"
                                                      id="notes_details"></textarea>
                                        </div>
                                    </div>
                                                
        
    
    
    
    
                    </form>
                <div class="layui-btn-container">
                    <a href="#" type="button" class="layui-btn layui-btn-normal login" id="submit" >确认/Confirm</a>
                    <a href="./table.jsp" target="main_self_frame" type="button"
                       class="layui-btn layui-btn-normal login">取消/Cancel</a>
                </div>
            </div>
        </div>
    </div>
</article>
</body>
<script src="../../layui/layui.js"></script>
<script src="../../js/base.js"></script>
<script src="../../js/index.js"></script>
<script>
    var BaseUrl = baseUrl()
    let sales_data_id = location.search.substring(1)
    layui.use(['upload', 'element', 'layer', 'laydate', 'layedit'], function () {
        var $ = layui.jquery
                , upload = layui.upload
                , element = layui.element
                , layer = layui.layer
                , laydate = layui.laydate
                , layedit = layui.layedit
                , form = layui.form;

        let url

        let token = sessionStorage.token || null
        let personInfo = JSON.parse(sessionStorage.personInfo)
        let user_group = personInfo.user_group
        let use_id = personInfo.user_id


        function  $get_stamp() {
            return new Date().getTime();
        }

        function  $get_rand(len) {
            var rand = Math.random();
            return Math.ceil(rand * 10 ** len);
        }

        
            // 权限判断
            /**
             * 获取路径对应操作权限 鉴权
             * @param {String} action 操作名
             */
            function $check_action(path1, action = "get") {
                var o = $get_power(path1);
                if (o && o[action] != 0 && o[action] != false) {
                    return true;
                }
                return false;
            }

            /**
             * 是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             */
            function $check_field(action, field, path1) {
                var o = $get_power(path1);
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 获取权限
             * @param {String} path 路由路径
             */
            function $get_power(path) {
                var list_data = JSON.parse(sessionStorage.list_data)
                var list = list_data;
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

        let submit = document.querySelector('#submit')
        // 提交按钮校验权限
        // if (   user_group == "管理员" ||$check_action('/sales_data/view', 'add') || $check_action('/sales_data/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "sales_data_id";
            let url_add = "sales_data";
            let url_set = "sales_data";
            let url_get_obj = "sales_data";
            let url_upload = "sales_data"
            let query = {
                "sales_data_id": 0,
            }

            let form_data2 = {
                                        "statistical_date":  '', // 统计日期
                            "sales_quantity":  '', // 售卖数量
                            "profit_amount":  '', // 利润金额
                            "notes_details":  '', // 备注详情
                                    "sales_data_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/sales_data/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/sales_data/table") {
                        path1 = o.path
                            $get_power(o.path)
                    }
                }
            }

            getpath()

            /**
             * 注册时是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             * @param {String} path 路径
             */
            function $check_register_field(action, field, path1) {
                var o = $get_power(path1);
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 是否有显示或操作字段的权限
             * @param {String} action 操作名
             * @param {String} field 查询的字段
             */
            function $check_field(action, field) {
                var o = $get_power("/sales_data/view");
                var auth;
                if (o && o[action] != 0 && o[action] != false) {
                    auth = o["field_" + action];
                }
                if (auth) {
                    return auth.indexOf(field) !== -1;
                }
                return false;
            }

            /**
             * 获取路径对应操作权限 鉴权
             * @param {String} action 操作名
             */
            function $check_exam(path1, action = "get") {
                var o = $get_power(path1);
                if (o) {
                    var option = JSON.parse(o.option);
                    if (option[action])
                        return true
                }
                return false;
            }

            /**
             * 是否有审核字段的权限
             */
            function $check_examine() {
                var url = window.location.href;
                var url_ = url.split("/")
                var pg_url = url_[url_.length - 2]
                let path = "/"+ pg_url + "/table"
                var o = $get_power(path);
                if (o){
                    var option = JSON.parse(o.option);
                    if (option.examine)
                        return true
                }
                return false;
            }

                            if (user_group === '管理员') {
                    $("#statistical_date_box").show()
                } else {
                    if ($check_field('add', 'statistical_date')){
                        $("#statistical_date_box").show()
                    }else {
                        $("#statistical_date_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#sales_quantity_box").show()
                } else {
                    if ($check_field('add', 'sales_quantity')){
                        $("#sales_quantity_box").show()
                    }else {
                        $("#sales_quantity_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#profit_amount_box").show()
                } else {
                    if ($check_field('add', 'profit_amount')){
                        $("#profit_amount_box").show()
                    }else {
                        $("#profit_amount_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#notes_details_box").show()
                } else {
                    if ($check_field('add', 'notes_details')){
                        $("#notes_details_box").show()
                    }else {
                        $("#notes_details_box").hide()
                    }
                }
            
                                                                                                                                        
            
            
            
            
    
                                                                                        // 日期选择
                    laydate.render({
                        elem: '#statistical_date'
                        , format: 'yyyy-MM-dd'
                        , done: function (value) {
                            form_data2.statistical_date = value + ' 00:00:00'
                        }
                    });
                
                            
                            
                            
                    
    
                    
                            
                            
                            
                    
                                                                            //文本
                    let sales_quantity = document.querySelector("#sales_quantity")
                        sales_quantity.onkeyup = function (event) {
                        form_data2.sales_quantity = event.target.value
                    }
                    //文本
                                                                                //文本
                    let profit_amount = document.querySelector("#profit_amount")
                        profit_amount.onkeyup = function (event) {
                        form_data2.profit_amount = event.target.value
                    }
                    //文本
                                                                                                        //多文本
                    let notes_details = document.querySelector("#notes_details")
                    //多文本
                                                                                                                                                                            var data = sessionStorage.data || ''
            if (data !== '') {
                var data2 = JSON.parse(data)
                Object.keys(form_data2).forEach(key => {
                    Object.keys(data2).forEach(dbKey => {
                        if (key === dbKey) {
                            if (key!=='examine_state' && key!=='examine_reply'){
                                $('#' + key).val(data2[key])
                                form_data2[key] = data2[key]
                                $('#' + key).attr('disabled', 'disabled')
                                        
                                    
                                    
                                    
                                                        }
                        }
                    })
                })
                sessionStorage.removeItem("data");
            }
                                                                

            if (sales_data_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/sales_data/get_obj', {
                        params: {
                                sales_data_id: sales_data_id
                        }, headers: {
                            'x-auth-token': token
                        }
                    })

                    let data = rese.result.obj
                    Object.keys(form_data2).forEach((key) => {
                        form_data2[key] = data[key];
                        $("#"+key).val(form_data2[key])
                    });

                    

            
            
            
            
                                    if (user_group === '管理员') {
                            $("#statistical_date_box").show()
                        } else {
                            if ($check_field('set', 'statistical_date') || $check_field('get', 'statistical_date')){
                                $("#statistical_date_box").show()
                            }else {
                                $("#statistical_date_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#sales_quantity_box").show()
                        } else {
                            if ($check_field('set', 'sales_quantity') || $check_field('get', 'sales_quantity')){
                                $("#sales_quantity_box").show()
                            }else {
                                $("#sales_quantity_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#profit_amount_box").show()
                        } else {
                            if ($check_field('set', 'profit_amount') || $check_field('get', 'profit_amount')){
                                $("#profit_amount_box").show()
                            }else {
                                $("#profit_amount_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#notes_details_box").show()
                        } else {
                            if ($check_field('set', 'notes_details') || $check_field('get', 'notes_details')){
                                $("#notes_details_box").show()
                            }else {
                                $("#notes_details_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                
                                if (user_group === '管理员' || (form_data2['sales_data_id'] && $check_field('set', 'statistical_date')) || (!form_data2['sales_data_id'] && $check_field('add', 'statistical_date'))) {
                            }else {
                                $("#statistical_date").attr("disabled", true);
                                $("#statistical_date > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                sales_quantity.value = form_data2.sales_quantity
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['sales_data_id'] && $check_field('set', 'sales_quantity')) || (!form_data2['sales_data_id'] && $check_field('add', 'sales_quantity'))) {
                            }else {
                                $("#sales_quantity").attr("disabled", true);
                                $("#sales_quantity > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                profit_amount.value = form_data2.profit_amount
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['sales_data_id'] && $check_field('set', 'profit_amount')) || (!form_data2['sales_data_id'] && $check_field('add', 'profit_amount'))) {
                            }else {
                                $("#profit_amount").attr("disabled", true);
                                $("#profit_amount > input[name='file']").attr('disabled', true);
                            }
                                                                //多文本
                                notes_details.value = form_data2.notes_details
                            //多文本
                        
                                if (user_group === '管理员' || (form_data2['sales_data_id'] && $check_field('set', 'notes_details')) || (!form_data2['sales_data_id'] && $check_field('add', 'notes_details'))) {
                            }else {
                                $("#notes_details").attr("disabled", true);
                                $("#notes_details > input[name='file']").attr('disabled', true);
                            }
                                                                            statistical_date.value = layui.util.toDateString(form_data2.statistical_date, "yyyy-MM-dd")
                                                                                                                                                            layui.form.render("select");
                }
                axios_get_3()
            }


            

            submit.onclick = async function () {
                try {
                                                                form_data2.statistical_date = layui.util.toDateString(form_data2.statistical_date, "yyyy-MM-dd")
                                                                                    //文本
                            form_data2.sales_quantity = sales_quantity.value
                            //文本
                                                                    //文本
                            form_data2.profit_amount = profit_amount.value
                            //文本
                                                                    //多文本
                            form_data2.notes_details = notes_details.value
                            //多文本
                                            } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({
                            "field_name": "统计日期",
                            "field_value": form_data2.statistical_date,
                            "type": "date"
                        });
                                                customize_field.push({"field_name": "售卖数量", "field_value": form_data2.sales_quantity});
                                                customize_field.push({"field_name": "利润金额", "field_value": form_data2.profit_amount});
                                                customize_field.push({"field_name": "备注详情", "field_value": form_data2.notes_details});
                    
    
                if (sales_data_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/sales_data/add?',
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                                        if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                                    } else {
                                        console.log("详情/Details")
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/sales_data/set?sales_data_id=' + sales_data_id,
                            form_data2, {
                                headers: {
                                    'x-auth-token': token,
                                    'Content-Type': 'application/json'
                                }
                            })
                    if (res.result == 1) {
                        layer.msg('确认/Confirm完毕');
                        setTimeout(function () {
                            window.location.replace("./table.jsp");
                        }, 1000)
                    }else {
              layer.msg(res.error.message);
            }
                }
            }
        
    })
    ;
</script>

</html>
