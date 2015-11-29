<textareactrl>
	<div class="input-row">
		<textarea type="text" placeholder="{opts.title}"  maxlength="{opts.limit}" class="input input-textarea" onkeyup="{edit}"></textarea>
	</div>

	var self = this;
	this.value = "";
	this.model = opts.model;

	edit(e){
		this.value = e.target.value;
		this.parent.edit(this);
	}

	val(){
		var textarea = self.root.getElementsByTagName('textarea')[0];
		return textarea ? (textarea.value ? textarea.innerHTML : '') : '';
	}

	this.parent.edit(this);
</textareactrl>
