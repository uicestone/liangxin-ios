var $ = require('zepto');
var bridge = require('bridge');
var query = require('query').parse();

require('../tags/comments.tag');
var type = query.type;

riot.mount('*');