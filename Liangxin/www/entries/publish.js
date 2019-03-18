var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

var fetch = bridge.fetch;

var type = query.type;

require('../tags/publish.tag');

riot.mount('*', {type:type});