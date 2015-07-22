var $ = require('zepto');
var query = require('query').parse();
var bridge = require('bridge');
var fetch = bridge.fetch;
var id = query.id;

fetch({
    url:"/post/" + id
}).then(function(post){
    bridge.setTitle(post.title);
    $('.section-intro .content').html((post.excerpt + '\n' + post.content).replace(/\n/g, '<br />'));
});