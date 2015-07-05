var $ = require('zepto');

$('.item .head').on('touchend', function(){
	$(this).parent().toggleClass('expand');	
});