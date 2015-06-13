<comment>
	<div class="inner">
		<img class="avatar" src="{opts.data.author.avatar}" />
		<div class="main">
			<div class="author">{opts.data.author.name}</div>
			<div class="content">{opts.data.content}</div>
			<div class="time">{opts.data.created_at}</div>
		</div>
		<div class="likes {liked?'liked':''}" onclick='{togglelike}'>
			<i class="icon-likes"></i>
			<span class="count">{likes}</span>
		</div>
	</div>

	var self = this;
	this.likes = opts.data.likes;
	this.liked = opts.data.liked;
	togglelike(){
		self.liked = !self.liked;
	}
</comment>