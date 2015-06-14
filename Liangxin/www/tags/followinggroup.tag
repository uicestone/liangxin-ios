var bridge = require('bridge');
var fetch = bridge.fetch;

<followinggroup>
	<div class="inner" ontouchend='{togroup}'>
		<img class="avatar" src="{opts.data.avatar}?imageView2/1/w/50/h/50" />
		<div class="main">
			<div class="name">{opts.data.name}</div>
			<div class="follow-btn" onclick={toggleFollowing}>已关注</div>	
		</div>
	</div>
	
	var self = this;
	var id = opts.data.id;
	self.following = false;
	self.postFollowing = false;
	toggleFollowing(e){
		e.stopPropagation();
		if(self.postFollowing){return;}
		self.postFollowing = true;
		fetch({
			method: self.following ? "delete" : "post",
			url: "/follow/" + id
		}).then(function(result){
			self.following = !self.following;
			self.postFollowing = false;
			self.update();
		}).catch(function(){
			self.postFollowing = false;
		});
	}

	togroup(){
		bridge.open("liangxin://group/detail/" + id);
	}


	
</followinggroup>