webpackJsonp([2],[
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var $ = __webpack_require__(2);
	var bridge = __webpack_require__(3);
	var query = __webpack_require__(4).parse();

	var fetch = bridge.fetch;
	var itemTemplate = __webpack_require__(1);
	var imageTemplate = __webpack_require__(7);

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

/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	module.exports = function (obj) {
	obj || (obj = {});
	var __t, __p = '';
	with (obj) {
	__p += '<li>\n	<div class="item-title">' +
	((__t = ( title )) == null ? '' : __t) +
	'</div>\n	<div class="detail">\n		<div class="author">' +
	((__t = ( obj.author && author.name )) == null ? '' : __t) +
	'</div>\n		<div class="date">' +
	((__t = ( created_at )) == null ? '' : __t) +
	'</div>\n	</div>\n</li>';

	}
	return __p
	}

/***/ },
/* 2 */,
/* 3 */,
/* 4 */,
/* 5 */,
/* 6 */,
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	module.exports = function (obj) {
	obj || (obj = {});
	var __t, __p = '';
	with (obj) {
	__p += '<li>\n	<img src="' +
	((__t = ( url )) == null ? '' : __t) +
	'" alt="">\n	<div class="pic-title">' +
	((__t = ( title )) == null ? '' : __t) +
	'</div>\n</li>';

	}
	return __p
	}

/***/ }
]);