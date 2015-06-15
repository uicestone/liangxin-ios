<datepicker>
	<div class="input-row" style="position:relative">	
		<label class="input input-text" style="position:absolute;top:0px;left:0px">{ value || opts.title }</label>
		<input id="title" type="date" maxlength="{opts.limit}" style="opacity:0;position:relative;z-index:9" class="input input-text" onchange={edit} onkeyup={edit} data-model={opts.model} />
	</div>

	this.value = "";
	this.model = opts.model;

	edit(e){
		this.value = e.target.value;
		this.parent.edit(this);
		this.update();
	}

	val(){
		return this.value;
	}

	this.parent.edit(this);
</datepicker>
