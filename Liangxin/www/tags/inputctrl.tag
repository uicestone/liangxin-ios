<inputctrl>
	<div class="input-row">	
		<input id="title" type="text" placeholder="{ opts.title }"  maxlength="{opts.limit}" class="input input-text" onkeyup={edit} onblur={edit} data-model={opts.model} />
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
</inputctrl>
