<myalbum class="album">
	<mypic each={ items } title="{ this.title }" pic="{ this.pic }" likes="{ this.likes }" comments="{ this.comments }"></mypic>

	var self = this;
	
	loadData(){
		var data = [{
			id: 1,
			title: "希望城党建",
			selected: true,
			likes: 41,
			comments: 14,
			pic: "http://ww4.sinaimg.cn/bmiddle/894a033agw1et1evvh6jmj21hc0u017v.jpg"
		},{
			id: 2,
			title: "希望城党建",
			selected: true,
			likes: 41,
			comments: 14,
			pic: "http://ww4.sinaimg.cn/bmiddle/894a033agw1et1evvh6jmj21hc0u017v.jpg"
		},{
			id: 3,
			title: "希望城党建",
			selected: false,
			likes: 41,
			comments: 14,
			pic: "http://ww4.sinaimg.cn/bmiddle/894a033agw1et1evvh6jmj21hc0u017v.jpg"
		},{
			id: 4,
			title: "希望城党建",
			selected: true,
			likes: 41,
			comments: 14,
			pic: "http://ww4.sinaimg.cn/bmiddle/894a033agw1et1evvh6jmj21hc0u017v.jpg"
		},{
			id: 5,
			title: "希望城党建",
			selected: true,
			likes: 41,
			comments: 14,
			pic: "http://ww4.sinaimg.cn/bmiddle/894a033agw1et1evvh6jmj21hc0u017v.jpg"
		},{
			id: 6,
			title: "希望城党建",
			selected: true,
			likes: 41,
			comments: 14,
			pic: "http://ww4.sinaimg.cn/bmiddle/894a033agw1et1evvh6jmj21hc0u017v.jpg"
		}];
		opts.trigger('data', data);
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