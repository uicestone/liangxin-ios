var bridge = require('bridge');
var fetch = bridge.fetch;

<comment>
	<div class="inner">
		<img class="avatar" src="{opts.data.author.avatar || './image/default-avatar.png'}" />
		<div class="main">
			<div class="author">{opts.data.author.name}</div>
			<div class="time">{opts.data.created_at}</div>
			<div class="content">{opts.data.title}</div>
		</div>
		<div class="likes {liked?'liked':''}" onclick='{togglelike}'>
			<i class="icon-likes"></i>
			<span class="count">{likes}</span>
		</div>
	</div>

	var self = this;
	this.likes = opts.data.likes;
	this.liked = opts.data.liked;
	this.id = opts.data.id;
	var posting = false;
	togglelike(){
		var posting = true;
		fetch({
			method: self.liked ? "delete" : "post",
			url: "/like/" + self.id
		}).then(function(result){
			self.liked = !self.liked;
			if(self.liked){
				self.likes++;
			}else{
				self.likes--;
			}
			posting = false;
			self.update();
		}).catch(function(){
			posting = false;
		});
	}
</comment>