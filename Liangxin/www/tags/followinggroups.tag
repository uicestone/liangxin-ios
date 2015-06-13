require('./followinggroup.tag')
var fetch = require('bridge').fetch;
<followinggroups>
	<followinggroup each={items} data={this}></followinggroup>
	
	var self = this;
	loadData(){
		self.items = [{
			id: "3",
			name: "樊家村党总支",
			members: "0",
			avatar: "http://dangqun.malu.gov.cn/images/樊家村党总支-1.jpg",
			leader: "赵静",
			contact: "39906095",
			address: "东宝路86号",
			parent_id: "54",
			has_children: false,
			following: true
		},
		{
			id: "4",
			name: "彭赵村党总支",
			members: "0",
			avatar: "http://dangqun.malu.gov.cn/images/彭赵村党总支-1.jpg",
			leader: "彭蓓蓉",
			contact: "59106653",
			address: "嘉新公路1109号",
			parent_id: "54",
			has_children: false,
			following: true
		},
		{
			id: "5",
			name: "包桥村党总支",
			members: "0",
			avatar: "http://dangqun.malu.gov.cn/images/包桥村党总支-1.jpg",
			leader: "孙晨燕",
			contact: "69155326",
			address: "宝安公路2888弄369号",
			parent_id: "54",
			has_children: false,
			following: false
		}];
		self.update();
	}

	this.loadData();
</followinggroups>

