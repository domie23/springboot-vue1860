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
                                                                                                        <div class="layui-form-item" id="book_name_box">
                                            <label class="layui-form-label">书籍名称</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入书籍名称"
                                                       class="layui-input" id="book_name">
                                            </div>
                                        </div>
                                                                                                                    <div class="layui-form-item" id="types_of_books_box">
                                        <label class="layui-form-label">书籍种类</label>
                                        <div class="layui-input-block">
                                            <select name="interest" lay-filter="types_of_books" id="types_of_books">
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                                                                                                        <div class="layui-form-item" id="book_prices_box">
                                            <label class="layui-form-label">书籍价格</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入书籍价格"
                                                       class="layui-input" id="book_prices">
                                            </div>
                                        </div>
                                                                                                                                        <div class="layui-form-item" id="inventory_quantity_box">
                                            <label class="layui-form-label">库存数量</label>
                                            <div class="layui-input-block">
                                                <input type="text" name="title" lay-verify="title" autocomplete="off"
                                                       placeholder="请输入库存数量"
                                                       class="layui-input" id="inventory_quantity">
                                            </div>
                                        </div>
                                                                                                                    <div class="layui-form-item layui-form-text" id="notes_details_box">
                                        <label class="layui-form-label">备注详情</label>
                                        <div class="layui-input-block">
                                            <textarea placeholder="请输入备注详情" class="layui-textarea"
                                                      id="notes_details"></textarea>
                                        </div>
                                    </div>
                                                                                                    <div class="layui-upload" id="book_images_box">
                                        <button type="button" class="layui-btn" id="book_images">上传图片</button>
                                        <div class="layui-upload-list">
                                            <img class="layui-upload-img" id="book_images_img">
                                            <p id="demoText"></p>
                                        </div>
                                        <div style="width: 95px;">
                                            <div class="layui-progress layui-progress-big" lay-showpercent="yes"
                                                 lay-filter="book_images">
                                                <div class="layui-progress-bar" lay-percent=""></div>
                                            </div>
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
    let book_information_id = location.search.substring(1)
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
        // if (   user_group == "管理员" ||$check_action('/book_information/view', 'add') || $check_action('/book_information/view', 'set')) {
        //    submit.style.display = "block"
        // }
        // style="display: none"

        
            let field = "book_information_id";
            let url_add = "book_information";
            let url_set = "book_information";
            let url_get_obj = "book_information";
            let url_upload = "book_information"
            let query = {
                "book_information_id": 0,
            }

            let form_data2 = {
                                        "book_name":  '', // 书籍名称
                            "types_of_books":  '', // 书籍种类
                            "book_prices":  '', // 书籍价格
                            "inventory_quantity":  '', // 库存数量
                            "notes_details":  '', // 备注详情
                            "book_images":  '', // 书籍图片
                                    "book_information_id": 0, // ID
                                            }

            layui.layedit.set({
      uploadImage: {
        url: BaseUrl + '/api/book_information/upload?' //接口url
        , type: 'post' //默认post
      }
    });


            var path1

            function getpath() {
                var list_data = JSON.parse(sessionStorage.list_data)
                for (var i = 0; i < list_data.length; i++) {
                    var o = list_data[i];
                    if (o.path === "/book_information/table") {
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
                var o = $get_power("/book_information/view");
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
                    $("#book_name_box").show()
                } else {
                    if ($check_field('add', 'book_name')){
                        $("#book_name_box").show()
                    }else {
                        $("#book_name_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#types_of_books_box").show()
                } else {
                    if ($check_field('add', 'types_of_books')){
                        $("#types_of_books_box").show()
                    }else {
                        $("#types_of_books_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#book_prices_box").show()
                } else {
                    if ($check_field('add', 'book_prices')){
                        $("#book_prices_box").show()
                    }else {
                        $("#book_prices_box").hide()
                    }
                }
                            if (user_group === '管理员') {
                    $("#inventory_quantity_box").show()
                } else {
                    if ($check_field('add', 'inventory_quantity')){
                        $("#inventory_quantity_box").show()
                    }else {
                        $("#inventory_quantity_box").hide()
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
                            if (user_group === '管理员') {
                    $("#book_images_box").show()
                } else {
                    if ($check_field('add', 'book_images')){
                        $("#book_images_box").show()
                    }else {
                        $("#book_images_box").hide()
                    }
                }
            
                                                                                                                                                                                                                //常规使用 - 普通图片上传
                        var uploadInst = upload.render({
                            elem: '#book_images'
                            , url: BaseUrl + '/api/book_information/upload?' //此处用的是第三方的 http 请求演示，实际使用时改成您自己的上传接口即可。
                            , headers: {
                                'x-auth-token': token
                            }, before: function (obj) {
                                //预读本地文件示例，不支持ie8
                                obj.preview(function (index, file, result) {
                                    $('#book_images_img').attr('src', fullUrl(BaseUrl,result)); //图片链接（base64）
                                });

                                element.progress('book_images', '0%'); //进度条复位
                                layer.msg('上传中', {icon: 16, time: 0});
                            }
                            , done: function (res) {
                                //如果上传失败
                                if (res.code > 0) {
                                    return layer.msg('上传失败');
                                }
                                //上传成功的一些操作
                                //……
                                form_data2.book_images = res.result.url
                                $('#demoText').html(''); //置空上传失败的状态
                            }
                            , error: function () {
                                //演示失败状态，并实现重传
                                var demoText = $('#demoText');
                                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                                demoText.find('.demo-reload').on('click', function () {
                                    uploadInst.upload();
                                });
                            }
                            //进度条
                            , progress: function (n, elem, e) {
                                element.progress('book_images', n + '%'); //可配合 layui 进度条元素使用
                                if (n == 100) {
                                    layer.msg('上传完毕', {icon: 1});
                                }
                            }
                        });
                                    
            
                                // 书籍种类选项列表
                    let types_of_books_data = [""];
                
            
            
            
            
    
                                                                                            
                            
                            
                            
                            
                            
                    
    
                    
                                        async function types_of_books() {
                        var types_of_books = document.querySelector("#types_of_books")
                        var op1 = document.createElement("option");
                        op1.value = '0'
                            types_of_books.appendChild(op1)
                        // 收集数据 长度
                        var count
                        // 收集数据 数组
                        var arr = []
                        let {data: res} = await axios.get(BaseUrl + '/api/types_of_books/get_list')
                        count = res.result.count
                        arr = res.result.list
                        for (var i = 0; i < arr.length; i++) {
                            var op = document.createElement("option");

                            // 给节点赋值
                            op.innerHTML = arr[i].types_of_books
                            op.value = i + 1
                            // 新增/Add节点
                            types_of_books.appendChild(op)
                            if (form_data2.types_of_books==arr[i].types_of_books){
                                op.selected = true
                            }
                            layui.form.render("select");
                        }
                    }

                    layui.form.on('select(types_of_books)', function (data) {
                        form_data2.types_of_books = data.elem[data.elem.selectedIndex].text;
                    })
                        types_of_books()
                        
                            
                            
                            
                            
                    
                                //文本
                    let book_name = document.querySelector("#book_name")
                        book_name.onkeyup = function (event) {
                        form_data2.book_name = event.target.value
                    }
                    //文本
                                                                                                                            //文本
                    let book_prices = document.querySelector("#book_prices")
                        book_prices.onkeyup = function (event) {
                        form_data2.book_prices = event.target.value
                    }
                    //文本
                                                                                //文本
                    let inventory_quantity = document.querySelector("#inventory_quantity")
                        inventory_quantity.onkeyup = function (event) {
                        form_data2.inventory_quantity = event.target.value
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
                                        
                                                                            for (let key in form_data2) {
                                            if (key == 'types_of_books') {
                                                let alls = document.querySelector('#types_of_books').querySelectorAll('option')
                                                let test = form_data2[key]
                                                for (let i = 0; i < alls.length; i++) {
                                                    if (alls[i].innerHTML == test) {
                                                        alls[i].selected = true
                                                        form_data2.types_of_books = alls[i].text
                                                        console.log(222)
                                                        layui.form.render("select");
                                                    }
                                                }
                                            }
                                        }
                                    
                                    
                                    
                                    
                                    
                                                        }
                        }
                    })
                })
                sessionStorage.removeItem("data");
            }
                                                                                        

            if (book_information_id !== '') {
                async function axios_get_3() {
                    const {data: rese} = await axios.get(BaseUrl + '/api/book_information/get_obj', {
                        params: {
                                book_information_id: book_information_id
                        }, headers: {
                            'x-auth-token': token
                        }
                    })

                    let data = rese.result.obj
                    Object.keys(form_data2).forEach((key) => {
                        form_data2[key] = data[key];
                        $("#"+key).val(form_data2[key])
                    });

                    

            
                                        for (let key in data) {
                                if (key == 'types_of_books') {
                                    let alls = document.querySelector('#types_of_books').querySelectorAll('option')
                                    let test = data[key]
                                    for (let i = 0; i < alls.length; i++) {
                                        if (alls[i].innerHTML == test) {
                                            alls[i].selected = true
                                            form_data2.types_of_books = alls[i].text
                                            console.log(222)
                                            layui.form.render("select");
                                        }
                                    }
                                }
                            }
                        
            
            
            
            
                                    if (user_group === '管理员') {
                            $("#book_name_box").show()
                        } else {
                            if ($check_field('set', 'book_name') || $check_field('get', 'book_name')){
                                $("#book_name_box").show()
                            }else {
                                $("#book_name_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#types_of_books_box").show()
                        } else {
                            if ($check_field('set', 'types_of_books') || $check_field('get', 'types_of_books')){
                                $("#types_of_books_box").show()
                            }else {
                                $("#types_of_books_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#book_prices_box").show()
                        } else {
                            if ($check_field('set', 'book_prices') || $check_field('get', 'book_prices')){
                                $("#book_prices_box").show()
                            }else {
                                $("#book_prices_box").hide()
                            }
                        }
                                            if (user_group === '管理员') {
                            $("#inventory_quantity_box").show()
                        } else {
                            if ($check_field('set', 'inventory_quantity') || $check_field('get', 'inventory_quantity')){
                                $("#inventory_quantity_box").show()
                            }else {
                                $("#inventory_quantity_box").hide()
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
                                            if (user_group === '管理员') {
                            $("#book_images_box").show()
                        } else {
                            if ($check_field('set', 'book_images') || $check_field('get', 'book_images')){
                                $("#book_images_box").show()
                            }else {
                                $("#book_images_box").hide()
                            }
                        }
                    
                    // Array.prototype.slice.call(document.getElementsByTagName('input')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('select')).map(i => i.disabled = true)
                    // Array.prototype.slice.call(document.getElementsByTagName('textarea')).map(i => i.disabled = true)
                                                    //文本
                                book_name.value = form_data2.book_name
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['book_information_id'] && $check_field('set', 'book_name')) || (!form_data2['book_information_id'] && $check_field('add', 'book_name'))) {
                            }else {
                                $("#book_name").attr("disabled", true);
                                $("#book_name > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['book_information_id'] && $check_field('set', 'types_of_books')) || (!form_data2['book_information_id'] && $check_field('add', 'types_of_books'))) {
                            }else {
                                $("#types_of_books").attr("disabled", true);
                                $("#types_of_books > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                book_prices.value = form_data2.book_prices
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['book_information_id'] && $check_field('set', 'book_prices')) || (!form_data2['book_information_id'] && $check_field('add', 'book_prices'))) {
                            }else {
                                $("#book_prices").attr("disabled", true);
                                $("#book_prices > input[name='file']").attr('disabled', true);
                            }
                                                        //文本
                                inventory_quantity.value = form_data2.inventory_quantity
                            //文本
                                
                                if (user_group === '管理员' || (form_data2['book_information_id'] && $check_field('set', 'inventory_quantity')) || (!form_data2['book_information_id'] && $check_field('add', 'inventory_quantity'))) {
                            }else {
                                $("#inventory_quantity").attr("disabled", true);
                                $("#inventory_quantity > input[name='file']").attr('disabled', true);
                            }
                                                                //多文本
                                notes_details.value = form_data2.notes_details
                            //多文本
                        
                                if (user_group === '管理员' || (form_data2['book_information_id'] && $check_field('set', 'notes_details')) || (!form_data2['book_information_id'] && $check_field('add', 'notes_details'))) {
                            }else {
                                $("#notes_details").attr("disabled", true);
                                $("#notes_details > input[name='file']").attr('disabled', true);
                            }
                                    
                                if (user_group === '管理员' || (form_data2['book_information_id'] && $check_field('set', 'book_images')) || (!form_data2['book_information_id'] && $check_field('add', 'book_images'))) {
                            }else {
                                $("#book_images").attr("disabled", true);
                                $("#book_images > input[name='file']").attr('disabled', true);
                            }
                                                                                                                                                                                                                                                            let book_images_img = document.querySelector("#book_images_img")
                                    book_images_img.src = fullUrl(BaseUrl,form_data2.book_images)
                                                            layui.form.render("select");
                }
                axios_get_3()
            }


            

            submit.onclick = async function () {
                try {
                                                                    //文本
                            form_data2.book_name = book_name.value
                            //文本
                                                                                        //文本
                            form_data2.book_prices = book_prices.value
                            //文本
                                                                    //文本
                            form_data2.inventory_quantity = inventory_quantity.value
                            //文本
                                                                    //多文本
                            form_data2.notes_details = notes_details.value
                            //多文本
                                                                        } catch (err) {
                    console.log(err)
                }
                            
            
                let customize_field = []
                                            customize_field.push({"field_name": "书籍名称", "field_value": form_data2.book_name});
                                                customize_field.push({"field_name": "书籍种类", "field_value": form_data2.types_of_books});
                                                customize_field.push({"field_name": "书籍价格", "field_value": form_data2.book_prices});
                                                customize_field.push({"field_name": "库存数量", "field_value": form_data2.inventory_quantity});
                                                customize_field.push({"field_name": "备注详情", "field_value": form_data2.notes_details});
                                                customize_field.push({
                            "field_name": "书籍图片",
                            "field_value": form_data2.book_images,
                            "type": "image"
                        });
                    
    
                if (book_information_id == '') {
                                        console.log("新增/Add")
                    const {data: res} = await axios.post(BaseUrl + '/api/book_information/add?',
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
                    
                    const {data: res} = await axios.post(BaseUrl + '/api/book_information/set?book_information_id=' + book_information_id,
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
