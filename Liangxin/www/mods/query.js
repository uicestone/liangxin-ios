exports.parse = function(){
	var query = location.search.slice(1);
  var ret = {};
  query.split("&").forEach(function(pair){
    var splited = pair.split("=");
    ret[splited[0]] = splited[1];
  });
  return ret;
}