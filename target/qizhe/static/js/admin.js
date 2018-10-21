
//点击取得要搜索的日期 
//附加数据为  风控监控-到期    1天 3天 7天 —— day1  day3  day7   
//            统计管理-库存    按天 按周 按月 —— day  week  month   
$(':submit').click(function(){
      result=$(this).data('search')
})



//普通搜索提交,表单添加id #form
    $('#form').validator({
      submit: function () {
        var formValidity = this.isFormValid();
        
        var From=$('#dateFrom').val()
        var To=$('#dateTo').val()

        if (From != '' &&  To != '' && From > To)  {
           alert('开始日期不能大于结束日期')
        }
        else if( formValidity ){

                    // 验证成功提交
          $.ajax({
            type: 'post',
            url: '/common.php',
            dataType: new FormData($('#form')),
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
              data = JSON.parse(data);
              if (data.code == 200) {
                 $('form').serializeArray()
                 {search:result}   //提交日期
              }
              else {
                alert('提交失败，请重试')
              }
            },
            error: function (data) {
              alert('提交失败，请重试')
              
            }
          })



        }

      }
    })  






//  系统配置-产品管理-新增 中点击添加表格,注意设置name名称
$('#tpl-add').click(function(){

    var tpl='<tbody class="tpl-tb"><tr><td style="text-align: center; line-height: 33px;" class="tpl-num"></td><td><input type="text" class="am-form-field"></td><td><input type="text" class="am-form-field"></td><td><input type="text" class="am-form-field"></td><td style="text-align: center; line-height: 33px;"><a title="删除" class="tpl-del"><i class="fa fa-trash"></i></a></td></tr></tbody>'

    $('#target').append(tpl).find('.tpl-num').each(function(n,v){
            $(this).html(n+1)
    })

   
})

//  系统配置-产品管理-新增 中点删除表格
$(document).on('click','.tpl-del',function(){
     $(this).parents('.tpl-tb').remove()
     $('#target').find('.tpl-num').each(function(n,v){
            $(this).html(n+1)
      })
})





/*
*
*以下为页面 业务管理-业务查询-新增资产 中的JS
*
*/

    //图片上传,图片上传参数在html5uploader.js 设置
 
	$('#upload1').html5uploader({auto:false,multi:true,removeTimeout:9999999,url:'upload.php',});
	$('#upload21').html5uploader({auto:false,multi:true,removeTimeout:9999999,url:'upload.php',});
	$('#upload22').html5uploader({auto:false,multi:true,removeTimeout:9999999,url:'upload.php',});
	$('#upload3').html5uploader({auto:false,multi:true,removeTimeout:9999999,url:'upload.php',});
	$('#upload4').html5uploader({auto:false,multi:true,removeTimeout:9999999,url:'upload.php',});


 //评估-是否违章——是否显示
$('#radio-rule .radio-value').click(function(){

  var rad=$('#radio-rule').find(':checked').val()

  if (rad == 1) {
      $('#display1,#display2').removeClass('am-hide')
  }
  else {
    $('#display1,#display2').addClass('am-hide')
  }

})



//GPS
$('#my-close').click(function(){

 $('#my-add').modal('close')
 $('#my-add form').find('input').val('').removeClass('am-field-error')
 $('#my-add form').find('div').removeClass('am-form-error')
})


 
  $('#my-add form').validator({
      submit: function () {
        var formValidity = this.isFormValid();
        if (formValidity) {
          $.ajax({
            type: 'post',
            url: '/common.php',
            dataType: new FormData($('#my-add form')),
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
              data = JSON.parse(data);
              if (data.code == 200) {
                 $('#my-add form').serializeArray()
              }
              else {
                alert('提交失败，请重试')
              }
            },
            error: function (data) {
              alert('提交失败，请重试')
            }
          })


        $('#my-add').modal('close')
        $('#my-add form').find('input').val('').removeClass('am-field-error')
        $('#my-add form').find('div').removeClass('am-form-error')
          
        }
      }
    })



 


//提交
   
   var check='#tab1,#tab2,#tab3,#tab4,#tab5,#tab8'
    $(check).validator({
      submit: function () {
        var formValidity = this.isFormValid();
        if (formValidity) {
          // 验证成功提交
          $.ajax({
            type: 'post',
            url: '/common.php',
            dataType: new FormData($('.am-in  form')),
            cache: false,
            processData: false,
            contentType: false,
            success: function (data) {
              data = JSON.parse(data);
              if (data.code == 200) {
                 $('.am-in  form').serializeArray()
              }
              else {
                alert('提交失败，请重试')
              }
            },
            error: function (data) {
              alert('提交失败，请重试')
            }
          })
          
        }

      }
    })
 
//暂存

var save = "#tab1 .am-icon-save,#tab2 .am-icon-save,#tab3 .am-icon-save,#tab4 .am-icon-save,#tab5 .am-icon-save,#tab8 .am-icon-save"
$(save).click(function(){
          // 不验证提交
      $.ajax({
          type: 'post',
          url: '/common.php',
          dataType: new FormData($('.am-in  form')),
          cache: false,
          processData: false,
          contentType: false,
          success: function (data) {
            data = JSON.parse(data);
            if (data.code == 200) {
              $('.am-in  form').serializeArray()
              {暂存:'1'}  
            }
            else {
              alert('提交失败，请重试')
            }
          },
          error: function (data) {
            alert('提交失败，请重试')
          }
        })
})

//返回
$('.am-icon-reply').click(function(){
  window.history.go(-1)
})




  





             //幻灯片
            var  mySwiper = new Swiper('.swiper-container', {
              pagination: '.swiper-pagination',
              paginationClickable: true,
              preventClicks:false,
              nextButton: '.swiper-button-next',
              prevButton: '.swiper-button-prev',
              loop:'true',
              autoplayDisableOnInteraction : false,
              observer:true,//修改swiper自己或子元素时，自动初始化swiper
              observeParents:true,//修改swiper的父元素时，自动初始化swiper
              // autoplay : 5000,   //自动播放
              // onInit: function(swiper){  //鼠标划过暂停幻灯片
              //       $('.swiper-container').hover(function(){
              //     swiper.stopAutoplay();
              // },function(){
              //     swiper.startAutoplay();
              //   });
              //   }
            });




//附件,数据使用mock.js模拟,数据格式关闭ajax中的console.log 在开发者工具中查看


//Mock.js 
Mock.mock('http://g.cn', {
    'list|1-10': [{name: "@ctitle(3, 8)"}],
    'image|1-5': [{name: "@dataImage('300x200', 'Hello Mock.js!')"}]
})



$("#attach").change(function () {
  
$('#attachlist,#attachslider .swiper-wrapper').html('')


  $("#attach option:selected").is(function () {
        val = $(this).val()  
      });


  
      $.ajax({
          type: 'post',
          url: 'http://g.cn',
          cache: false,
          dataType:'json',
          success: function (data) {
//                  console.log(data.list.length)   //文件列表
//                  console.log(data.image.length)  //图片数量
//                  console.log(JSON.stringify(data, null, 4))  //json数据格式

       //插入文件列表
      for (var x=0;x<data.list.length;x++ ) {
          $('#attachlist').append('<li>'+data.list[x].name+'</li>')
        }
       //插入幻灯片  
      for (var i=0;i<data.image.length;i++ ) {
          $('#attachslider .swiper-wrapper').append('<div class="swiper-slide"><img src='+data.image[i].name+' style="display: block;max-width: 100%;height: auto;"></div>')
        }
            mySwiper.update()  //更新Swiper
            }
          })
    
})

