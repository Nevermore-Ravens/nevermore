package nevermore.macros;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.macro.ExprTools;

class ScreenCenterMacro {
	// allow overriding bc FlxSpriteGroup expects top left which.... is not handy.
	public static macro function uninlineScreenCenter():Array<Field> {
		var fields = Context.getBuildFields();

		for (field in fields) {
			if (field.name == "screenCenter") {
				field.access.remove(AInline);
				return fields;
			}
		}

		return fields;
	}

	public static macro function extendScreenCenter():Array<Field> {
		var fields = Context.getBuildFields();

		fields.push({
			name: "screenCenter",
			access: [AOverride],
			pos: Context.currentPos(),
			kind: FFun({
				args: [{
					name: "axes",
					type: macro:flixel.util.FlxAxes,
					value: macro XY
				}],
				ret: macro:flixel.FlxObject,
				expr: macro {
					if (axes.x) {
						var minX = findMinX();
						var maxX = findMaxX();
						var offset = x - minX;
						x = (FlxG.width - (maxX - minX)) * 0.5 + offset;
					}
			
					if (axes.y) {
						var minY = findMinY();
						var maxY = findMaxY();
						var offset = y - minY;
						y = (FlxG.height - (maxY - minY)) * 0.5 + offset;
					}
			
					return this;
				}
			})
		});

		return fields;
	}
}
#end