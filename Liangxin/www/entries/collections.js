var $ = require('zepto');
var bridge = require('bridge');
var fetch = bridge.fetch;
$('.item .head').on('touchend', function(){
	$(this).parent().toggleClass('expand');	
});


function renderPosts(posts){
	var articles = [];
	var events = [];
	var classes = [];
	function renderInContainer(posts, container){
		posts.forEach(function(post){
			container.append($('<li class="post"><a href="liangxin://article/' + post.id + '">' + post.title + '</a></li>'));
		});
	}
	posts.forEach(function(post){
		if(post.type == '文章'){
			articles.push(post);
		}else if(post.type == '活动'){
			events.push(post);
		}else if(post.type == '课堂'){
			classes.push(post);
		}
	});

	renderInContainer(articles, $("#item-articles ul"));
	renderInContainer(events, $("#item-events ul"));
	renderInContainer(classes, $("#item-classes ul"));
}


bridge.getUser()
.then(function(user){
	fetch({
		url:"/post?favored_user_id=" + user.id
	}).then(function(posts){
		renderPosts(posts);
	}).catch(function(){
	});
});