package nevermore.input;

class Input {
	public function new(binds:Map<Int, Array<InputType>>, kGroups:Array<Array<Int>>) {
		default_binds = binds.copy();
		this.kGroups = kGroups.copy();
		this.binds = [
			for (bind in binds.keys()) {
				bind => binds[bind].copy();
			}
		];
	}

	public var default_binds(default, null):Map<Int, Array<InputType>>;
	public var kGroups:Array<Array<Int>>;
	public var binds:Map<Int, Array<InputType>>;

	public var direction:Array<Map<InputType, Int>> = [];
	public function bind() {
		direction.resize(0);
		for (kg in kGroups) {
			var list:Map<InputType, Int> = [];
			var it = 0;
			for (k in kg) {
				for (i in binds.get(k)) {
					list.set(i, it);
				}
				it++;
			}
			direction.push(list);
		}
	}

	public inline function get(keyCount:Int = 4, key:InputType):Int{
		return direction[keyCount-1][key] ?? -1;
	}
}