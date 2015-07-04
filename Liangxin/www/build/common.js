/******/ (function(modules) { // webpackBootstrap
/******/ 	// install a JSONP callback for chunk loading
/******/ 	var parentJsonpFunction = window["webpackJsonp"];
/******/ 	window["webpackJsonp"] = function webpackJsonpCallback(chunkIds, moreModules) {
/******/ 		// add "moreModules" to the modules object,
/******/ 		// then flag all "chunkIds" as loaded and fire callback
/******/ 		var moduleId, chunkId, i = 0, callbacks = [];
/******/ 		for(;i < chunkIds.length; i++) {
/******/ 			chunkId = chunkIds[i];
/******/ 			if(installedChunks[chunkId])
/******/ 				callbacks.push.apply(callbacks, installedChunks[chunkId]);
/******/ 			installedChunks[chunkId] = 0;
/******/ 		}
/******/ 		for(moduleId in moreModules) {
/******/ 			modules[moduleId] = moreModules[moduleId];
/******/ 		}
/******/ 		if(parentJsonpFunction) parentJsonpFunction(chunkIds, moreModules);
/******/ 		while(callbacks.length)
/******/ 			callbacks.shift().call(null, __webpack_require__);
/******/ 		if(moreModules[0]) {
/******/ 			installedModules[0] = 0;
/******/ 			return __webpack_require__(0);
/******/ 		}
/******/ 	};
/******/
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// object to store loaded and loading chunks
/******/ 	// "0" means "already loaded"
/******/ 	// Array means "loading", array contains callbacks
/******/ 	var installedChunks = {
/******/ 		6:0
/******/ 	};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/ 	// This file contains only the entry chunk.
/******/ 	// The chunk loading function for additional chunks
/******/ 	__webpack_require__.e = function requireEnsure(chunkId, callback) {
/******/ 		// "0" is the signal for "already loaded"
/******/ 		if(installedChunks[chunkId] === 0)
/******/ 			return callback.call(null, __webpack_require__);
/******/
/******/ 		// an array means "currently loading".
/******/ 		if(installedChunks[chunkId] !== undefined) {
/******/ 			installedChunks[chunkId].push(callback);
/******/ 		} else {
/******/ 			// start chunk loading
/******/ 			installedChunks[chunkId] = [callback];
/******/ 			var head = document.getElementsByTagName('head')[0];
/******/ 			var script = document.createElement('script');
/******/ 			script.type = 'text/javascript';
/******/ 			script.charset = 'utf-8';
/******/ 			script.async = true;
/******/ 			script.src = __webpack_require__.p + "" + chunkId + ".bundle.js";
/******/ 			head.appendChild(script);
/******/ 		}
/******/ 	};
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/ })
/************************************************************************/
/******/ ({

/***/ 2:
/***/ function(module, exports, __webpack_require__) {

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

	["fetch", "pickImage", "showProgress", "hideProgress", "close", "dismiss", "getUser"].forEach(function(method){
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

/***/ }

/******/ })