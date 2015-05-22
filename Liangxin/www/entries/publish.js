var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

var fetch = bridge.fetch;

var type = query.type;


function init(type){
	if(type == 'image'){
		$('#input-row-album').show();
	}else if(type == 'public'){
		$('#input-row-content').show();
	}else if(type == 'article'){
		$('#input-row-content').show();
		$('#input-row-article-picture').show();
	}
}

function publish(type){
	fetch({
		url: "/post",
		method: "post",
		data: {
			type: "公告",
			title: $("#title").val(),
			content: $("#content").val()
		},
	}).then(function(data){
		console.log(data);
		alert("success");
	});
}

$('.btn').on('click', function(){
	publish(type);
});