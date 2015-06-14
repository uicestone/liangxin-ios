var $ = require('zepto');
var bridge = require('bridge');
var fetch = bridge.fetch;
require('./inputctrl.tag')
require('./textareactrl.tag')
require('./imgctrl.tag')
require('./btn.tag')
require('./datepicker.tag')
require('./selectctrl.tag')

<publish class="input-container">
	<!-- 发布课堂 -->
	<div show={ opts.type=='class' }>
		<imgctrl icon='plus' size='small' placeholder='为你的课堂上传海报' model='poster' />
		<inputctrl title='请输入课堂标题（字数限制50字）' limit='50' model='title' />
		<textareactrl title='添加课堂文字描述（字数限制500字）' limit='500' model='describe'></textareactrl>
		<textareactrl title='添加课堂文字资料' model='content'></textareactrl>
		<imgctrl icon='upload'size='small' model='files' placeholder='添加课堂文件' />
		<imgctrl icon='plus' size='small' model='images' placeholder='添加课堂图片资料' />
		<imgctrl icon='link' size='small' model='videos' placeholder='添加课堂视频链接' />
	</div>

	<!-- 发布活动 -->
	<div show={ opts.type=='activity' }>
		<imgctrl icon='plus' size='small' placeholder='为你的活动上传海报' model='poster' />
		<datepicker title='请输入活动时间' model='event_date' />
		<inputctrl title='请输入活动地点' limit='50' model='event_address' />
		<textareactrl title='添加活动文字详情（字数限制1000字）' limit='500' model='describe'></textareactrl>
		<selectctrl title='请选择活动类型' choices={choices} model='event_type' />
		<datepicker title='请输入报名截止日期' model='due_date' />	
	</div>
	
	<!-- 发布公告 -->
	<div show={ opts.type=='notice' }>
		<inputctrl title='请输入公告标题（字数限制50字）' limit='50' model='title' />
		<textareactrl title='添加公告内容（字数限制1000字）' limit='1000' model='content'></textareactrl>
	</div>

	<!-- 发布文章 -->
	<div show={ opts.type=='article' }>
		<inputctrl title='请输入文章标题（字数限制50字）' limit='50' model='title' />
		<textareactrl title='添加文章内容（字数限制1000字）' limit='1000' model='content'></textareactrl>
		<imgctrl icon='plus' size='big' model='images' placeholder='上传图片' />
	</div>

	<!-- 发布照片 -->
	<div show={ opts.type=='image' }>
		<inputctrl title='请输入图片标题（字数限制50字）' limit='50' model='title' />
		<imgctrl icon='plus' size='big' model='images' placeholder='上传图片' />
	</div>

	

	<btn title='发布' onclick='{submit}' />
	
	this.choices = ({
		"event": ['爱摄影','做公益','文艺迷','体育狂','长知识','学环保'],
		"class": ['党建', '青年', '宣传', '妇女', '工会', '廉政']
	})[opts.type];

	var type = ({
		"notice": "公告",
		"article": "文章",
		"image": "照片",
		"event": "活动",
		"class": "课程"
	})[opts.type];
	var keys = ({
		"notice": ["title", "content"],
		"article": ["title", "content", "images"],
		"image": ["title", "images"],
		"event": ["poster", ""],
		"class": ["poster","title","describe","content","title","attachments","images","videos"]
	})[opts.type];

	edit(field){
		this[field.model] = field.val();
	}

	submit(){
		var self = this;
		var data = {};
		
		keys.forEach(function(k){
			data[k] = self[k];
		});

		bridge.showProgress();
		data['type'] = type;

		var config = {
			url: "/post",
			method:"post",
			data: data
		};

		var files = [];
		["attachments", "images"].forEach(function(key){
			if(data[key]){
				data[key].forEach(function(data){
					files.push({
						name: key + "[]",
						data: data.split("base64,")[1]
					});
				});
				delete data[key];
			}
		});

		config.files = files;
		console.log(config);
		fetch(config).then(function(data){
			bridge.hideProgress();
			bridge.dismiss({type:"publish",message:"发布成功"});
		}).catch(function(err){
			bridge.hideProgress();
			bridge.showMessage(err.message);
		});
	}
</publish>