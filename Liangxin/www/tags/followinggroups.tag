require('./followinggroup.tag')
var bridge = require('bridge');
var fetch = bridge.fetch;
<followinggroups>
	<followinggroup each={items} data={this}></followinggroup>
	
	var self = this;
	var loading = false;
	loadData(){
		if(loading){return;}
		loading = true;
		bridge.showProgress();
		bridge.getUser()
			.then(function(user){
				fetch({
					url:"/user/" + user.id
				}).then(function(user){
					self.items = user.following_groups;
					bridge.hideProgress();
					self.update();
					loading = false;
				}).catch(function(){
					loading = false;
				});
			});
	}

	this.loadData();
</followinggroups>

