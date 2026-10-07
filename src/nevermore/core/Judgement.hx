package nevermore.core;

// basically just a wrapper for HitWindows
// so you don't have to write it yourself
@:structInit
class Judgement {
	public static var list:Map<String, Array<Judgement>> = [];
	public static var current:Array<Judgement>;

	public static function register(name:String, judges:Array<Judgement>) {
		list.set(name, judges);
	}

	public static function resetHits() {
		for (judge in current) judge.hits = 0;
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

	public static function init() {
		HitWindows.init();

		register('Default', [
			{
				name: 'Fantastic',
				window: HitWindows.current[0]
			},
			{
				name: 'Perfect',
				window: HitWindows.current[1]
			},
			{
				name: 'Great',
				window: HitWindows.current[2]
			},
			{
				name: 'Good',
				window: HitWindows.current[3]
			},
			{
				name: 'Bad',
				breaksCombo: true,
				window: HitWindows.current[4]
			}
		]);
		type = 'Default';
	}

	// test
	public static function getID(deviation:Float):Int {
		for (i => judge in current) {
			if (Math.abs(deviation) > judge.window) continue;
			return i;
		}

		return current.length - 1;
	}

	public static function get(deviation:Float):Judgement {
		for (judge in current) {
			if (Math.abs(deviation) > judge.window) continue;
			return judge;
		}

		return max;
	}

	public var name:String = 'Unknown';
	public var breaksCombo:Bool = false;
	public var window:Float = 0.0;
	public var color:Int = 0xFFFFFFFF;
	public var hits:Int = 0;
}