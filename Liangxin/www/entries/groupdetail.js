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

$(".section-intro .title").on("click", function(){
	location.href = "liangxin://groupintro/" + group_id;
});

$(".section-activity .title").on("click", function(){
	location.href = "liangxin://groupactivity/" + group_id;
});

$(".section-album .title").on("click", function(){
	location.href = "liangxin://groupalbum/" + group_id;
});

bridge.showProgress();

fetch({
	url: "/group/" + group_id
}).then(function(result){

	bridge.hideProgress();

	// 头像
	$(".avatar").attr("src", result.avatar);

	var $followBtn = $(".btn-follow");
	var following = result.following;
	var postFollowing = false;

	// 关注状态
	$followBtn.html(following ? "已关注" : "关注");
	$followBtn.on("touchend", function(){
		if(postFollowing){return;}
		var $btn = $(this);
		postFollowing = true;
		fetch({
			method: following ? "delete" : "post",
			url: "/follow/" + group_id
		}).then(function(result){
			following = !following;
			postFollowing = false;
			$btn.html(following ? "已关注" : "关注");
		}).catch(function(){
			postFollowing = false;
		});
	});

	$activityList = $(".section-activity ul");
	$albumList = $(".section-album ul");
	$(".meta .title").html(result.name);
	
	// 简介
	$(".section-intro .content").html(result.description);

	// 动态
	result.posts.forEach(function(post){
		var html = itemTemplate(post);
		var li = $(html);
		li.on("click", function(){
			bridge.open("liangxin://article/" + post.id);
		});
		$activityList.append(li);
	});

	// 相册
	result.images.forEach(function(image, i){
		if(i >= 2){return;}
		var html = imageTemplate(image);
		$albumList.append($(html));
	});
});