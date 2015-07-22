var Bridge = {

	_exec: function(method, params, callback){
		var callbackName = "LiangxinJSCallback_" + (+new Date()) + "_" + Math.floor(Math.random() * 50);
		var iframe = document.createElement('iframe');
		window[callbackName] = callback;
    iframe.src = "js://_?method=" + method + "&params=" + encodeURIComponent(JSON.stringify(params)) + "&callback=" + callbackName;
		console.log("iframe src", iframe.src);
		document.body.appendChild(iframe);
		iframe.style.display = "none";
		function removeNode(){
      iframe.onload = iframe.onerror = null;
      iframe.parentNode && iframe.parentNode.removeChild(iframe);
    }
    iframe.onload = iframe.onerror = removeNode;
		setTimeout(removeNode, 1000);
	},
	exec: function(method, params){
		return new Promise(function(resolve, reject){
				Bridge._exec(method, params, function(result){
					var error = result && result.error;
					var fail = params.fail;
					var success = params.success;
					if(error){
						error = new Error(error);
						fail && fail(error);
						reject(error);
						Bridge.onerror && Bridge.onerror(error);
					}else{
						success && success(result);
						resolve(result);
					}
				});
			});
	}
};

["fetch", "pickImage", "pickAvatar", "showProgress", "hideProgress", "close", "dismiss", "getUser", "login"].forEach(function(method){
	Bridge[method] = function(params){
		params = params || {};
		return Bridge.exec(method, params);
	};
});

Bridge.setTitle = function(title){
	return Bridge.exec("setTitle", {title: title});
};

Bridge.open = function(url){
	return Bridge.exec("open", {url: url});
};

Bridge.showMessage = function(message){
	return Bridge.exec("showMessage", {message:message});
};

module.exports = Bridge;