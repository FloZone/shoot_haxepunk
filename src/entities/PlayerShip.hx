package entities ;

import com.haxepunk.Entity;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.EnemyShip;
import entities.LifeCounter;



/**
 * ...
 * @author FloZone
 */
class PlayerShip extends Entity
{
	private var speed:Int;
	private var atlas:TextureAtlas;
	private var shootSprite:Image;
	private var shootDelay:Int;
	private var currentDelay:Int;
	private var alternateCannon:Bool;
	private var lifeCounter:entities.LifeCounter;
	private var sfx_shoot:Sfx;
	
	
	
	public function new(atlas:TextureAtlas, lifeCounter:entities.LifeCounter)
	{
		super();

		// position
		this.width  = 64;
		this.height = 48;
		this.centerPosition();
		
		// vitesse
		this.speed = 8;
		
		// textures
		this.atlas       = atlas;
		this.graphic     = new Image(atlas.getRegion("playerShip"));
		this.shootSprite = new Image(atlas.getRegion("shoot"));
		
		// shoot
		this.shootDelay      = 10;
		this.currentDelay    = 0;
		this.alternateCannon = true;
		
		// vie
		this.lifeCounter = lifeCounter;
		
		// son
		this.sfx_shoot = new Sfx("audio/shoot.wav");
		
		// hitbox
		this.type = "playerShip";
		this.setHitbox(64, 48, 0, 0);
	}
	
	
	// centrer le joueur
	public function centerPosition() {
		this.x = HXP.width/2 - width/2;
		this.y = HXP.height - 80;
	}
	
	// à chaque frame
	override public function update() {
		// si collision avec le joueur
		var collidedEntity:Entity = collide("enemyShip", x, y);
		if (collidedEntity != null) {
			// détruire l'ennemi
			cast(collidedEntity, entities.EnemyShip).destroy();
			// réduire la vie
			this.lifeCounter.updateLives(-1);
		}
		
		// mouvement
		if (Input.check("down") && this.y < (HXP.height - height)) {
			moveBy(0, speed);
		}
		if (Input.check("up") && this.y > 0) {
			moveBy(0, -speed);
		}
		if (Input.check("right") && this.x < (HXP.width - width)) {
			moveBy(speed, 0);
		}
		if (Input.check("left") && this.x > 0) {
			moveBy(-speed, 0);
		}
		
		// si SPACE est appuyé
		if (Input.check(Key.SPACE)) {
			// si le temps d'attente est écoulé
			if (this.currentDelay == 0) {
				// son
				this.sfx_shoot.play(0.8, (x/HXP.width)*1.6 - 0.8);
				// reset le temps d'attente
				this.currentDelay = this.shootDelay;
				
				// faire apparaitre un shoot
				var shoot:entities.Shoot = new entities.Shoot(shootSprite);
				scene.add(shoot);
				
				// tirs alternés droite/gauche
				if (alternateCannon) shoot.x = x;
				else shoot.x = x + 50;
				
				shoot.y = y;
				this.alternateCannon = !this.alternateCannon;
			}
		}
		
		// réduire le temps d'attente du shoot
		if (this.currentDelay > 0) {
			--this.currentDelay;
		}
	}
}