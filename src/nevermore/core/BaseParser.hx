package nevermore.core;

#if moonchart
import moonchart.backend.FormatData;
import moonchart.formats.BasicFormat;
import moonchart.formats.*;

// IM A DUMBASS !!!!!!!! I FORGOT HOW TO USE MOONCHART
//
// FUCK
class BaseParser {
	public function new() {}

	public function load(path:String, ?diff:String):Chart {
		var result:Chart = Song.dummyData();

		return result;
	}
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