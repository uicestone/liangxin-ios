var fetch = require('bridge').fetch;

<followinggroup>
	<div class="inner">
		<img class="avatar" src="{opts.data.avatar}" />
		<div class="main">
			<div class="author">{opts.data.name}</div>
			<div class="follow-btn" onclick={toggleFollowing}>{following?"已关注":"未关注"}</div>	
		</div>
	</div>
	
	var self = this;
	var id = opts.data.id;
	self.following = opts.data.following;
	self.postFollowing = false;
	toggleFollowing(){
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

	
</followinggroup>