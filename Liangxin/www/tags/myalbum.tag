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

	opts.on('remove', function(){

		var ids = self.items.filter(function(el){
			return el.selected;
		}).map(function(el){
			return el.id;
		}).join(',');

		console.log(ids);

		setTimeout(function(){

			self.items = self.items.filter(function(el){
				return !el.selected;
			});
			self.update();
			self.loadData();
		});
	});

	this.loadData();
</myalbum>