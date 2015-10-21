package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.masks.Circle;
import entities.LifeCounter;



/**
 * ...
 * @author FloZone
 */
class PowerUp extends Entity
{
	private var speed:Int;
	private var lifeCounter:entities.LifeCounter;
	
	
	
	public function new(sprite:Image, lifeCounter:entities.LifeCounter) 
	{
		super();
		
		this.graphic     = sprite;
		this.lifeCounter = lifeCounter;

		// vitesse
		this.speed = 5;
		// position
		this.randomPosition();
		
		// hitbox
		this.mask = new Circle(12, 12, 12);
	}
	
	
	// a chaque frame
	override public function update() {
		// mouvement
		this.y += speed;
		
		// si le bonus sort de l'écran, le supprimer
		if (this.y > HXP.height) scene.remove(this);
		
		// si le bonus touche le joueur
		var collidedEntity = collide("playerShip", x, y);
		if (collidedEntity != null) {
			// le supprimer
			scene.remove(this);
			// ajouter une vie
			this.lifeCounter.updateLives(1);
		}
	}
	
	// générer une position aléatoire
	public function randomPosition() {
		this.x = Math.round(Math.random() * (HXP.width - 64));
		this.y = -50;
	}
	
	// générer un interval de spawn aléatoire
	public static function getSpawnInterval() {
		return Math.round(Math.random() * 250) + 250;
	}
}