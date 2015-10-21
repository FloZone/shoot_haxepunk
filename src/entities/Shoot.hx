package entities ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;



/**
 * ...
 * @author FloZone
 */
class Shoot extends Entity
{
	private var speed:Int;
	
	
	
	public function new(sprite:Image) 
	{
		super();
		
		this.graphic = sprite;
		this.speed   = 10;
		
		// hitbox
		this.type    = "shoot";
		this.setHitbox(14, 24, 0, 0);
	}
	
	
	override public function update() {
		// déplacement
		this.y -= speed;
		
		// si le shoot sort de l'écran, le supprimer
		if (this.y < -30) {
			scene.remove(this);
		}
	}
}