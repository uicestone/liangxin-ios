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
		<imgctrl icon='plus' placeholder='为你的课堂上传海报' model='poster' />
		<inputctrl title='请输入课堂标题（字数限制50字）' limit='50' model='title' />
		<textareactrl title='添加课堂文字描述（字数限制500字）' limit='500' model='describe'></textareactrl>
		<textareactrl title='添加课堂文字资料' model='content'></textareactrl>
		<imgctrl icon='upload' model='files' placeholder='添加课堂文件' />
		<imgctrl icon='plus' model='images' placeholder='添加课堂图片资料' />
		<imgctrl icon='link' model='videos' placeholder='添加课堂视频链接' />
		<btn title='发布' onclick='{submit}' />
	</div>

	<!-- 发布活动 -->
	<div show={ opts.type=='activity' }>
		<imgctrl icon='plus' placeholder='为你的活动上传海报' model='poster' />
		<datepicker title='请输入活动时间' limit='50' model='title' />
		<inputctrl title='请输入活动地点' limit='50' model='title' />
		<textareactrl title='添加活动文字详情（字数限制1000字）' limit='500' model='describe'></textareactrl>
		<selectctrl title='请选择活动类型' choices={choices} />
		<imgctrl icon='upload' model='files' placeholder='添加活动文件' />
		<imgctrl icon='plus' model='images' placeholder='添加活动图片资料' />
		<imgctrl icon='link' model='videos' placeholder='添加活动视频链接' />
		<btn title='发布' onclick='{submit}' />
	</div>

	
	if(opts.type == 'activity'){
		this.choices = ['爱摄影','做公益','文艺迷','体育狂','长知识','学环保'];
	}

	edit(field){
		this[field.model] = field.val();
	}

	submit(){
		var self = this;
		var data = {};
		var keys = ["poster","title","describe","content","title","files","images","videos"]
		
		keys.forEach(function(k){
			data[k] = self[k];
		});
		console.log(data);
	}
</publish>