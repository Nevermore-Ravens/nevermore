package nevermore.play.note;

import nevermore.skins.Noteskin;

class MineBehavior extends NoteBehavior {
	public function new() {
		super();

		ignore = true;
		punishable = true;
		missHealth = -10;
	}

	override function applySkin(note:BaseNote, type:ObjectType) {
		// Noteskin.get("mine").applyToNote(note, "note");
		// inline for now, we gotta figure out a multi-assethandler thing

		note.frames = Assets.dependency.sparrowAtlas("mine");
		note.antialiasing = true;
		note.scale.set(0.65, 0.65);

		note.animation.addByPrefix("standard", "blue");
		note.animation.play("standard", true);

		note.updateHitbox();
	}

	override function setupData(data:NoteData) {
		data.length = 0;
	}

	override function update(delta:Float, notes:Array<Note>) {
		for (i in 0...notes.length) {
			var note:Note = notes[i];
			note.angle = (note.field.velocityClock.map.getPosition(note.field.clock.time) - note.visualTime) * (Util.crotchet(note.field.clock.timingMap.tempo)/1000);
		}
	}

	override function setup(note:BaseNote) {
		note.quantization = false;
		note.color = 0xFFFFFFFF;
	}
}