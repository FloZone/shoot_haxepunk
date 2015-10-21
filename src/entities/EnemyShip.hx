package entities ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import entities.Explosion;
import entities.LifeCounter;



/**
 * ...
 * @author FloZone
 */
class EnemyShip extends Entity
{
	private var speedMin: Float = 2.5;
	private var speedMax: Float = 3.5;
	private var speed:Float;
	private var health:Int;
	private var explosion:entities.Explosion;
	private var score:Score;
	private var sfx_explosion:Sfx;
	private var sfx_hit:Sfx;
	private var lifeCounter:entities.LifeCounter;
	
	
	
	
	public function new(sprite:Image, explosion:entities.Explosion, score:Score, lifeCounter:entities.LifeCounter) 
	{
		super();
		
		this.graphic     = sprite;
		this.explosion   = explosion;
		this.score       = score;
		this.lifeCounter = lifeCounter;
		
		// vitesse
		speed = (Math.random() * (speedMax - speedMin)) + speedMin;
		// position
		randomPosition();
		
		// vie
		health = 4;
		
		// hitbox
		type = "enemyShip";
		setHitbox(64, 48, 0, 0);
		
		// sons
		sfx_explosion = new Sfx("audio/explosion.wav");
		sfx_hit       = new Sfx("audio/hit.wav");
	}
	
	
	// à chaque frame
	override public function update() {
		// mouvement
		this.y += speed;
		// si l'ennemi sort de l'écran
		if (this.y > HXP.height) {
			scene.remove(this);
		}

		// si collision avec un shoot
		var collidedEntity:Entity = collide("shoot", x, y);
		if (collidedEntity != null) {
			// son
			sfx_hit.play(1, (x/HXP.width)*1.6 - 0.8);
			// 1 explosion
			explosion.explode(x, y, 1);
			// supprimer le shoot
			scene.remove(collidedEntity);
			// réduire la vie
			--health;
			
			
			// si plus de vie
			if (health <= 0) {
				// détruire l'ennemi
				this.destroy();
				// incrémenter le score
				score.add(1);
				//si on atteint un palier, ajouter une vie
				//if (score.add(1)) lifeCounter.updateLives(1);
			}
		}
	}
	
	// détruire l'ennemi
	public function destroy() {
		// son
		sfx_explosion.play(1, (x/HXP.width)*1.6 - 0.8);
		// supprimer l'ennemi
		scene.remove(this);
		// 2 explosions
		explosion.explode(x, y, 2);
	}
	
	// générer une position aléatoire
	public function randomPosition() {
		this.x = Math.round(Math.random() * HXP.width - 64);
		this.y = -50;
	}
	
	// générer un interval de spawn aléatoire
	public static function getSpawnInterval() {
		return Math.round(Math.random() * 20) + 20;
	}
}