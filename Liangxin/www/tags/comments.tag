require('./comment.tag')
var bridge = require('bridge');
var fetch = bridge.fetch;
var query = require('query').parse();
var $ = require('zepto');


<comments>
  <div style="display:{items.length?'block':'none'}">
  <comment each={items} data={this}></comment>
  </div>

  <div style="display:{items.length?'none':'block'};text-align:center;margin-top:90px">
    <img src="./image/nocomments.png" height="136" width="91" />
  </div>

  <div class="mbox" style="display:{writing?'block':'none'}">
    <div class="inner">
      <div class="close" onclick="{closepopup}"></div>
      <div class="title">评论</div>
      <div class="content">
        <textarea name="" id="input" cols="30" rows="10"></textarea>
      </div>
      <div class="btn" onclick="{submit}">提交</div>
    </div>
  </div>

  <div class="write" onclick="{showpopup}">
    <i class="icon-pencil"></i>
    <span>写评论</span>
  </div>



  var self = this;
  var id = query.id;
  this.writing = false;

  showpopup(){
    self.update({writing:true})
  }

  closepopup(){
    self.update({writing:false})
  }

  var posting = false;
  submit(){
    posting = true;
    bridge.showProgress();
    fetch({
      method:"post",
      url:"/post",
      data:{
        type:"评论",
        parent_id:id,
        content:$('#input').val()
      }
    }).then(function(){
      posting = false;
      self.update({writing:false});
      bridge.popMessage('回应成功');
    });
  }

  load(){
    self.items = [];
    for(var i = 0; i < 0; i++){
      self.items.push({
       "id":0,
        "content":"参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖参加学雷锋爱心义卖",
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