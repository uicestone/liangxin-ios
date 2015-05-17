var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

var fetch = bridge.fetch;
var itemTemplate = require('views/group-detail-item.ejs');
var imageTemplate = require('views/group-detail-album-item.ejs');

fetch({
	url: "/group/" + query.id
}).then(function(result){
	$(".avatar").attr("src", result.avatar);
	$activityList = $(".section-activity ul");
	$albumList = $(".section-album ul");

	$(".section-intro .content").html(result.description);

	result.posts.forEach(function(post){
		var html = itemTemplate(post);
		var li = $(html);
		$activityList.append(li);
	});

	result.images.forEach(function(image, i){
		if(i >= 2){return;}
		var html = imageTemplate(image);
		$albumList.append($(html));
	});
	console.log(JSON.stringify(result));
}).catch(function(){
	alert(err);
});