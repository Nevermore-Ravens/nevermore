package nevermore.core;

// basically just a wrapper for HitWindows
// so you don't have to write it yourself
@:structInit
class Judgement {
	public static var list:Map<String, Array<Judgement>> = [
		'StepMania' => [
			{name: 'Fantastic'},
			{name: 'Perfect'},
			{name: 'Great'},
			{name: 'Good'},
			{name: 'Bad'}
		]
	];
	public static var current:Array<Judgement>;

	public static function register(name:String, judges:Array<Judgement>) {
		list.set(name, judges);
	}

	public static function resetHits() {
		for (judges in list) {
			for (judge in judges) judge.hits = 0;
		}
	}

	public static var min(get, never):Judgement;
	static function get_min():Judgement return current[0];

	public static var max(get, never):Judgement;
	static function get_max():Judgement return current[current.length - 1];

	public static var type(default, set):String;
	static function set_type(v:String):String {
		if (!list.exists(v)) return type;

		current = list[v];
		return type = v;
	}

	public static function reset() {
		type = 'StepMania';
	}

	public static function get(deviation:Float):Judgement {
		for (i => judge in current) {
			if (Math.abs(deviation) > HitWindows.current[i]) continue;
			return judge;
		}

		return max;
	}

	public var name:String = 'Unknown';
	public var causesMisses:Bool = false;
	public var hits:Int = 0;
}