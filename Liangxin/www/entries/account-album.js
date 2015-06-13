var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

require('../tags/myalbum.tag');
require('../tags/mypic.tag');

var fetch = bridge.fetch;


var bus = riot.observable();
var all = false;

$('.pull-left').on('touchend', function(){
	all = !all;
	bus.trigger('toggle-all', all);
});

$('.pull-right').on('touchend', function(){
	bus.trigger('remove');
});

riot.mount('*', bus);