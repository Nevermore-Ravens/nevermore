package nevermore.core;

#if moonchart
import moonchart.backend.FormatData;
import moonchart.formats.BasicFormat;
import moonchart.formats.*;

class BaseParser {
	public function new() {}

	// sm = StepMania
	// ssc = Spinal Shark Collective
	// osu = osu!mania (no std/taiko/catch sorry)
	// qua = Quaver
	// chart = Guitar/Clone Hero
	static var extensions:Array<String> = ['sm', 'ssc', 'osu', 'qua', 'chart'];

	// supports 2 methods
	// load('songs/Fuck/Fuck.sm', 'hard');
	// load('songs/Fuck/hard.osu');
	//
	// first method will load the file and use the diff specified
	// second method will just load the path specified
	// if the file doesn't exist for either, `result` gets thrown instead
	public function load(path:String, ?diff:String):Chart {
		var result:Chart = Song.dummyData();

		var singleDiff:Bool = diff.length == 0;
		var file:String = path;

		// osu/quaver/fnf legacy
		if (singleDiff) {
			if (!FileSystem.exists(file)) return result;
		} else {
		// sm/ssc/(guitar/clone) hero
			file = findInFolder(folder, diff);
			if (file.length == 0) return result;
		}

		var format = FormatDetector.instanceFromFiles([file]);
		var meta:BasicMetaData = format.getChartMeta();

		result.title = meta.title;
		result.offset = meta.offset;
		result.speed = meta.scrollSpeeds[singleDiff ? format.diffs[0] : diff];
		result.keyCount = meta.extraData[STRUMLINE_KEYS];

		result.timingPoints = [
			for (change in meta.bpmChanges) {
				{
					time: change.time,
					tempo: change.bpm,
					beatsPerMeasure: change.beatsPerMeasure
				}
			}
		];

		result.notes = [
			for (note in format.getNotes()) {
				{
					time: note.time,
					lane: note.lane,
					length: note.length,
					type: note.type
				}
			}
		];

		// moonchart doesn't support scroll velocities at the moment
		result.scrollVelocities = [];
		
		// TODO: figure out how to not apply this for osu/quaver only ?
		result.snapRelativeToChanges = true;

		return result;
	}

	static function findInFolder(folder:String, diff:String):String {
		var directory:String = 'assets/' + folder;
		if (!FileSystem.exists(directory)) return '';

		var path = new Path(directory);
		path.dir = directory;

		for (file in FileSystem.readDirectory(directory)) {
			path.file = Path.withoutExtension(file);
			path.ext = Path.extension(file);

			if (!extensions.contains(path.ext)) continue;
			if (path.file != Util.format(diff)) continue;

			// this is probably the file we're looking for
			return path.toString();
		}

		return '';
	}

	public function exists(path:String, ?diff:String):Bool return false;
}

#else

class BaseParser {
	public function new() {}

	public function load(path:String, ?diff:String):Chart {
		return Song.dummyData();
	}

	public function exists(path:String, ?diff:String):Bool return false;
}
#end