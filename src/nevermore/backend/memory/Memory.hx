package nevermore.backend.memory;

#if cpp
/**
 * Memory class to properly get accurate memory counts
 * for the program.
 * @author Leather128 (Haxe Bindings) - David Robert Nadeau (Original C Header)
 */
@:buildXml('
<files id="haxe">
	<compilervalue name="-I" value="${haxelib:nevermore}/src/nevermore/backend/memory" />
</files>
')
@:include("Memory.h")
extern class Memory {
	/**
	 * Returns the peak (maximum so far) resident set size (physical
	 * memory use) measured in bytes, or zero if the value cannot be
	 * determined on this OS.
	 */
	@:native("getPeakRSS")
	public static function getPeakUsage():Float;

	/**
 	 * Returns the current resident set size (physical memory use) measured
 	 * in bytes, or zero if the value cannot be determined on this OS.
	 */
	@:native("getCurrentRSS")
	public static function getCurrentUsage():Float;
}
#else
/**
 * Hxcpp only
 * @author Leather128
 */
class Memory {
	/**
	 * Fallback
	 * Returns 0.
	 */
	public static function getPeakUsage():Float return 0.0;

	/**
	 * Fallback
	 * Returns 0.
	 */
	public static function getCurrentUsage():Float return 0.0;
}
#end