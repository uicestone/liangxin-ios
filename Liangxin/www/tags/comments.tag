require('./comment.tag')
<comments>
  <comment each={items} data={this}>

  var self = this;
  load(){
    self.items = [];
    for(var i = 0; i < 10; i++){
      self.items.push({
       "id":0,
        "content":"lalalalala",
        "author": {
          "id":0,
          "name":"王大锤",
          "avatar":"http://avatar.fanfou.com/s0/00/43/3s.jpg"
        },
        "created_at":"2015-03-03 12:21",
        "likes": 46,
        "liked": false
      });
      self.update();
    }
  }

  this.load();
</comments>