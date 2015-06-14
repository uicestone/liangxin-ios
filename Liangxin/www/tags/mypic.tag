<mypic>
	<div class="inner" style="background-image:url({opts.url})" ontouchend="{toggle}">
	<div class="select {selected?'selected':''}"></div>
	<div class="title">{opts.title}</div>
	<div class="like">
		<i class="icon-like"></i>
		<span class="count">{opts.likes}</span>
	</div>
	<div class="comment">
		<i class="icon-comment"></i>
		<span class="count">{opts.comments}</span>
	</div>
	</div>
	
	var self = this;
	this.selected = opts.selected;
	toggle(){
		this.selected = !this.selected;
	}
</mypic>

