var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

require('../tags/myalbum.tag');
require('../tags/mypic.tag');

var fetch = bridge.fetch;


var bus = riot.observable();
var all = false;

$('.pull-left').on('click', function(){
	all = !all;
	bus.trigger('toggle-all', all);
});

$('.pull-right').on('click', function(){
	bus.trigger('remove');
});

riot.mount('*', bus);