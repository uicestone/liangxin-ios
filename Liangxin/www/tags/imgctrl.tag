var bridge = require('bridge');
var pickimage = bridge.pickimage;
<imgctrl>
	<div class="input-row input-row-image size-{opts.size}">
		<div class="image-item" each={image, i in images}><img src='{image}' /></div>
		<div class="add-image" onclick="{add}">
			<img src="./icons/{opts.icon}.png" />
		</div>
		<div class="text-hint">{ opts.placeholder }</div>
	</div>
	
	this.images = [];
	this.model = opts.model;
	add(){
		var self = this;
		pickimage()
			.then(function(data){
				self.images.push(data);
				self.parent.edit(self);
			});
	}

	val(){
		return this.images;
	}

	this.parent.edit(this);
</imgctrl>
