package nevermore.core.timing;

class VelocityMap {
	public var list:Array<ScrollVelocity>;
	public var length:Int = 0;

	public function new(?list:Array<ScrollVelocity>) {
		reset(list);
	}

	public function reset(?list:Array<ScrollVelocity>) {
		list ??= [];
		
		length = list.length;

		for (i in 1...list.length) {
			list[i].visualTime = list[i - 1].toPixels(list[i].time);
		}

		this.list = list;
	}

	public function destroy() {
		list.resize(0);
		list = null;
	}

	public function get(time:Float):ScrollVelocity {
		if (length == 0) return {};
		var last:ScrollVelocity = list[0];

		for (i in 0...list.length) {
			var point = list[i];

			if (time >= point.time) last = point;
			else break;
		}

		return last;
	}

	public function getPosition(time:Float):Float {
		if (length == 0) return -1;
		return get(time).toPixels(time);
	}
}