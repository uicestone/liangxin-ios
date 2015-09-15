exports.clip = function(url, w, h){
    var result = url + "?imageView2/1/w/" + parseInt(w) + "/h/" + parseInt(h);
    return result;
}