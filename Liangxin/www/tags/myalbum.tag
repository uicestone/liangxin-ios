var bridge = require('bridge');
var fetch = bridge.fetch;


<myalbum class="album">
	<div class="mypic" each={items}>
	<div class="inner" style="background-image:url({this.url})" ontouchend="{parent.toggle}">
		<div class="select {selected?'selected':''}"></div>
		<div class="title">{this.title}</div>
		<div class="like">
			<i class="icon-like"></i>
			<span class="count">{this.likes}</span>
		</div>
		<div class="comment">
			<i class="icon-comment"></i>
			<span class="count">{this.comments}</span>
		</div>
	</div>
	</div>

	var self = this;
		
	loadData(){
		bridge.showProgress();
		bridge
			.getUser()
			.then(function(user){
				fetch({
					url: "/post",
					data: {
						author_id: user.id,
						type: "图片"
					}
				}).then(function(data){
					opts.trigger('data', data);
					bridge.hideProgress();
				}).catch(function(){
					bridge.popMessage("发生错误");
				});
			});
	}

	toggle(e){
		var item = e.item
		item.selected = !item.selected
		return true;
		self.update();
	}

	opts.on('toggle-all', function(selected){
		self.items.forEach(function(el, i){
			el.selected = selected;
		});
		self.update();
	});

	opts.on('data', function(pics){
		self.items = pics;
		self.update();
	});

	var removing = false;
	opts.on('remove', function(){
		if(removing){return};
		removing = true;
		var ids = self.items.filter(function(el){
			return el.selected;
		}).map(function(el){
			return el.id;
		}).join(',');
		if(!ids){return;}
		console.log(ids);
		bridge.showProgress();
		fetch({
			url:"/post?id=" + ids,
			method:"delete"
		}).then(function(){
			removing = false;
			bridge.hideProgress();
			self.loadData();
		}).catch(function(){
			removing = false;
			bridge.popMessage("删除失败");
		});
	});

	this.loadData();
</myalbum>