var Bridge = {

	exec: function(method, params, callback){
		var callbackName = "LiangxinJSCallback_" + (+new Date()) + "_" + Math.floor(Math.random() * 50);
		var iframe = document.createElement('iframe');
		window[callbackName] = callback;
    iframe.src = "js://_?method=" + method + "&params=" + encodeURIComponent(JSON.stringify(params)) + "&callback=" + callbackName;
		
		document.body.appendChild(iframe);
		iframe.style.display = "none";
		function removeNode(){
      iframe.onload = iframe.onerror = null;
      iframe.parentNode && iframe.parentNode.removeChild(iframe);
    }
    iframe.onload = iframe.onerror = removeNode;
		setTimeout(removeNode, 1000);
	}

};

["fetch"].forEach(function(method){
	Bridge[method] = function(params){
		params = params || {};
		this.exec(method, params, function(result){
			var error = result.error;
			var fail = params.fail;
			var success = params.success;
			if(error){
				fail && fail(new Error(error));
			}else{
				success && success(result);
			}
		});
	}
});

module.exports = Bridge;