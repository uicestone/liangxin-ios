<selectctrl>
	<div class="input-row">
		<div class="input input-select">{this.value || opts.title}
			<select onchange='{edit}'>
				<option each={sel in opts.choices}>{sel}</option>
			</select>
		</div>
	</div>

	this.value = '';
	edit(e){
		this.value = e.target.value;
		this.parent.edit(this);
	}

	val(){
		return this.value;
	}
</selectctrl>