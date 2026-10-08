package nevermore.play;

import flixel.group.FlxSpriteGroup;

class UnderlayGroup extends FlxTypedSpriteGroup<LaneUnderlay> {
	public function new(?lines:Array<Strumline>) {
		super();
		for (line in lines ?? []) add(new LaneUnderlay(line));
	}

	override function update(_) {
		for (underlay in members) {
			var strumline:Strumline = underlay.strumline;

			underlay.x = strumline.x - 20;
			underlay.visible = this.visible && strumline.visible;
			underlay.alpha = strumline.alpha * this.alpha;
		}
	}
}

class LaneUnderlay extends FlxSprite {
	public var strumline:Strumline;
	public function new(strumline:Strumline) {
		super();
		this.strumline = strumline;
		active = false;
		moves = false;

		makeGraphic(1, 1, FlxColor.WHITE); // set to white so you can set your own colours
		scale.set(strumline.width + 40, FlxG.height);
		updateHitbox();
	}
}