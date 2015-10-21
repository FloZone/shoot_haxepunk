package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.atlas.AtlasRegion;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;



/**
 * ...
 * @author FloZone
 */
class Explosion extends Entity
{
	private var particles:Emitter;

	
	
	public function new(sprite:AtlasRegion) 
	{
		super();
		
		// texture
		this.particles = new Emitter(sprite, 22, 24);
		// créer une animation appelée explosion
		this.particles.newType("explosion", [0]);
		// mouvement des particules
		this.particles.setMotion("explosion", 0, 10, 1, 360, 50, 1, Ease.quadOut);
		this.graphic = particles;
		
		this.layer   = -1;
	}
	
	
	// émettre un nombre donné de particules à une position donnée
	public function explode(x:Float, y:Float, count:Int) {
		var i:Int;
		for (i in 0...count)
			this.particles.emitInRectangle("explosion", x, y, 64, 48);
	}
	
}