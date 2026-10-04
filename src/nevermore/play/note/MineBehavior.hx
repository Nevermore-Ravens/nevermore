package nevermore.play.note;

import nevermore.core.timing.BaseClock;
import nevermore.skins.Noteskin;

class MineBehavior extends NoteBehavior {
	public function new() {
		super();

		ignore = true;
		punishable = true;
		missHealth = -10;
	}

	override function applySkin(note:BaseNote, type:ObjectType) {
		Noteskin.get("mine").applyToNote(note, "note");
	}

	override function setupData(data:NoteData) {
		data.length = 0;
	}

	override function update(delta:Float, notes:Array<Note>) {
		for (i in 0...notes.length) {
			var note:Note = notes[i];
			var clock:BaseClock = note.field.scrollVelocities ? note.field.velocityClock : note.field.clock;
			var timeDist:Float = (clock.usesScrollVelocities ? note.visualTime : note.adjustedTime) - clock.time;
			note.angle = timeDist * (Util.crotchet(note.field.clock.timingMap.tempo) * 0.001);
		}
	}

	override function setup(note:BaseNote) {
		note.quantization = false;
		note.color = 0xFFFFFFFF;
	}
}