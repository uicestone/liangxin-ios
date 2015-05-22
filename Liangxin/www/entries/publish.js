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

function uploadedImages(container){
	var results = [];
	container.find("img").each(function(i, img){
		results.push({
			url: img.src,
			title: img.alt
		});
	});
	return results;
}

function publish(type){
	var data = {type: type};

	if(type == 'image'){
		$('#input-row-album').show();
		data.title = $("#title").val();
		data.images = uploadedImages($("#input-row-album"));
	}else if(type == 'public'){
		$('#input-row-content').show();
		data.title = $("#title").val();
		data.content = $("#content").val();
	}else if(type == 'article'){
		data.title = $("#title").val();
		data.content = $("#content").val();
		data.image = uploadedImages($("#input-row-article-picture"));
	}

	fetch({
		url: "/post",
		method: "post",
		data: data,
	}).then(function(data){
		console.log(data);
		alert("success");
	});
}

$('.btn').on('click', function(){
	publish(type);
});