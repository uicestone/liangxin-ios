webpackJsonp([0],[
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var $ = __webpack_require__(2);
	var bridge = __webpack_require__(3);
	var query = __webpack_require__(4).parse();

	var fetch = bridge.fetch;

	bridge.onerror = function(err){
		alert(err);
	}

	var group_id = query.id;

	fetch({
		url: "/group/" + group_id
	}).then(function(result){
		// 头像
		$(".avatar").attr("src", result.avatar);

		$(".item-members .value").html(result.members + "人");
		$(".item-address .value").html(result.address);
		$(".item-contact .value").html(result.contact);
		$(".item-leader .value").html(result.leader);
		$(".section-intro .content").html(result.description);
		$(".item-members").click(function(){
			location.href = "liangxin://groupmembers/" + group_id;
		});
	});

/***/ }
]);