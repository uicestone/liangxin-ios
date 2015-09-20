var bridge = require('bridge');
var pickImage = bridge.pickImage;
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
		pickImage()
			.then(function(result){
				var data = result.url;
				self.images.push(data);
				self.parent.edit(self);
				self.update();
			});
	}

	val(){
		return this.images;
	}

	this.parent.edit(this);
</imgctrl>
