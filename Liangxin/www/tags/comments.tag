require('./comment.tag')
var bridge = require('bridge');
var fetch = bridge.fetch;
var query = require('query').parse();
var $ = require('zepto');


<comments>
  <div style="display:{(loaded && items.length)?'block':'none'}; margin-bottom: 20px;">
  <comment each={items} data={this}></comment>
  </div>

  <div style="display:{(loaded && !items.length)?'block':'none'};text-align:center;margin-top:90px">
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
  this.loaded = false;

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
        title:$('#input').val()
      }
    }).then(function(review){
      posting = false;
      // self.items.unshift(review);
      // window.scrollTo(0,0);
      bridge.hideProgress().then(function(){
        setTimeout(function(){
          location.reload();
        }, 200);
      });
      //bridge.showMessage('回应成功');
      //self.writing = false;
      //self.update();
    });
  }

  load(){
    self.items = [];

    fetch({
      url:"/post",
      data:{
        type:"评论",
        parent_id:id
      }
    }).then(function(items){
      self.loaded = true;
      self.items = items;
      self.update();
    });
  }

  this.load();
</comments>