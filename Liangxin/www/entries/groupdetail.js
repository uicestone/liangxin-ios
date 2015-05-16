var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

bridge.fetch({
	url: "/groups/" + query.id,
	success: function(result){
		$(".avatar").attr("src", result.avatar);
		alert(JSON.stringify(result));
	},
	fail: function(err){
		alert(err);
	}
});