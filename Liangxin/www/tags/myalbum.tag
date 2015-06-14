var bridge = require('bridge');
var fetch = bridge.fetch;


<myalbum class="album">
	<mypic each={ items } title="{ this.title }" url="{ this.url }" likes="{ this.likes }" comments="{ this.comments }"></mypic>

	var self = this;
		
	loadData(){
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
				});
			});
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
		bridge.showProgress();
		fetch({
			url:"/post",
			method:"delete",
			data: {
				ids: ids
			}
		}).then(function(){
			removing = false;
			self.loadData();
		}).catch(function(){
			removing = false;
			bridge.popMessage("删除失败");
		});
	});

	this.loadData();
</myalbum>