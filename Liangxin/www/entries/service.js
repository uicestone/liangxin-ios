var $ = require('zepto');
var query = require('query').parse();
var bridge = require('bridge');
var fetch = bridge.fetch;
var image = require('image');
var id = query.id;

fetch({
  url: "/post/" + id
}).then(function(data) {
  var $images = $('.section-album ul');
  data.images.forEach(function(article) {
    article.poster = {
      url: image.clip(article.url, 400, 300)
    };
    var $template = require('channel-image-item.ejs');
    var html = $template(article);
    var $li = $(html);
    $li.appendTo($images);
  });

  bridge.setTitle(data.title);
  $('.section-intro .content').html((data.excerpt + '\n' + data.content).replace(/\n/g, '<br />'));
});