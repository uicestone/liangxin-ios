var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

var fetch = bridge.fetch;
var itemTemplate = require('views/group-detail-item.ejs');
var imageTemplate = require('views/group-detail-album-item.ejs');

bridge.onerror = function(err){
	alert(err);
}

var group_id = query.id;

$(".section-intro").on("touchend", function(){
	location.href = "liangxin://groupintro/" + group_id;
});

$(".section-activity").on("touchend", function(){
	location.href = "liangxin://groupactivity/" + group_id;
});

$(".section-album").on("touchend", function(){
	location.href = "liangxin://groupalbum/" + group_id;
});

fetch({
	url: "/group/" + group_id
}).then(function(result){
	// 头像
	$(".avatar").attr("src", result.avatar);

	var $followBtn = $(".btn-follow");
	var following = result.following;
	var postFollowing = false;

	// 关注状态
	if(following){
		$followBtn.html("已关注");
	}else{
		$followBtn.html("关注");
		$followBtn.on("touchend", function(){
			if(following){return;}
			if(postFollowing){return;}
			var $btn = $(this);
			postFollowing = true;
			fetch({
				method: "post",
				url: "/follow/" + group_id
			}).then(function(result){
				following = true;
				postFollowing = false;
				$btn.html("已关注");
			}).catch(function(){
				postFollowing = false;
			});
		});
	}

	$activityList = $(".section-activity ul");
	$albumList = $(".section-album ul");

	// 简介
	$(".section-intro .content").html(result.description);

	// 动态
	result.posts.forEach(function(post){
		var html = itemTemplate(post);
		var li = $(html);
		$activityList.append(li);
	});

	// 相册
	result.images.forEach(function(image, i){
		if(i >= 2){return;}
		var html = imageTemplate(image);
		$albumList.append($(html));
	});
});