<textareactrl>
	<div class="input-row">	
		<textarea id="title" type="text" placeholder="{opts.title}"  maxlength="{opts.limit}" class="input input-textarea"></textarea>
	</div>
	
	this.value = "";
	this.model = opts.model;

	edit(e){
		this.value = e.target.value;
		this.parent.edit(this);
	}

	val(){
		return this.value;
	}

	this.parent.edit(this);
</textareactrl>
