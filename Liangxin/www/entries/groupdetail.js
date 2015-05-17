var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();
var fetch = bridge.fetch;

fetch({
	url: "/group/" + query.id
}).then(function(result){
	$(".avatar").attr("src", result.avatar);
	alert(JSON.stringify(result));
}).catch(function(){
	alert(err);
});