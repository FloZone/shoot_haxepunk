package scenes;

import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.graphics.Image;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import entities.EnemyShip;
import entities.Explosion;
import entities.GameOverText;
import entities.LifeCounter;
import entities.PausedText;
import entities.PlayerShip;
import entities.PowerUp;
import entities.Score;



/**
 * ...
 * @author FloZone
 */
class MainScene extends Scene
{
	private var playerShip:entities.PlayerShip;
	
	private var enemySprite:Image;
	private var powerupSprite:Image;
	private var spawnInterval:Int;
	private var powerupInterval:Int;
	private var explosion:entities.Explosion;
	private var score:entities.Score;
	private var playing:Bool;
	private var paused:Bool;
	private var pausedText:entities.PausedText;
	private var lifeCounter:entities.LifeCounter;
	private var gameOverText:entities.GameOverText;
	
	
	
	public function new()
	{
		super();
		// définir les touches de déplacement
		Input.define("up",    [Key.UP, Key.Z]);
		Input.define("down",  [Key.DOWN, Key.S]);
		Input.define("left",  [Key.LEFT, Key.Q]);
		Input.define("right", [Key.RIGHT, Key.D]);
		
		this.newGame();
	}
	
	
	// initialisation du jeu
	public function newGame() {
		// charger la texture
		var atlas:TextureAtlas = TextureAtlas.loadTexturePacker("atlas/atlas.xml");
		
	
		// vies
		this.lifeCounter = new entities.LifeCounter(new Image(atlas.getRegion("heart")));
		this.add(lifeCounter);
		
		// créer le vaisseau joueur avec sa spritesheet
		this.playerShip = new entities.PlayerShip(atlas, this.lifeCounter);
		this.add(playerShip);
		
		// ennemis
		this.enemySprite   = new Image(atlas.getRegion("enemyShip"));
		this.spawnInterval = entities.EnemyShip.getSpawnInterval();
		
		// explosion
		this.explosion = new entities.Explosion(atlas.getRegion("explosion"));
		this.add(explosion);
		
		// bonus
		this.powerupSprite   = new Image(atlas.getRegion("powerup"));
		this.powerupInterval = entities.PowerUp.getSpawnInterval();
		
		// score
		this.score = new entities.Score();
		this.add(score);
		
		// playing/paused
		this.paused = false;
		this.pausedText = new entities.PausedText("Game paused\n'P' to continue");
		this.add(pausedText);
		this.pausedText.visible = false;
		
		// Game Over
		this.playing = true;
		this.gameOverText = new entities.GameOverText();
		this.add(gameOverText);
		this.gameOverText.visible = false;
	}
	
	// à chaque frame
	override public function update() {		
		// si on appuie sur P, activer/désactiver la pause
		if (this.playing && Input.pressed(Key.P)) {
			this.togglePause();
		}
		
		// si le jeu n'est pas lancé ou en pause, ne rien faire de plus
		if (this.paused) return;
		
		super.update();
		
		// si on est sur l'écran Game Over et qu'on appuie sur ENTER, redémarrer
		if (!this.playing && Input.pressed(Key.ENTER)) this.restart();
		
		if (!this.playing) return;
		
		
		// réduire le compteur interval de spawn
		// si le compteur est à 0
		if (--this.spawnInterval == 0) {
			// spawn un ennemis
			var enemy:entities.EnemyShip = new entities.EnemyShip(enemySprite, explosion, score, lifeCounter );
			add(enemy);
			// générer un nouvel interval
			this.spawnInterval = entities.EnemyShip.getSpawnInterval();
		}
		
		
		// réduire le compteur interval de bonus
		// si le compteur est à 0
		if (--this.powerupInterval == 0) {
			// spawn un bonus
			var powerup:entities.PowerUp = new entities.PowerUp(powerupSprite, lifeCounter);
			add(powerup);
			
			this.powerupInterval = entities.PowerUp.getSpawnInterval();
		}
		
	}
	
	// activer ou désactiver la pause
	private function togglePause() {
		this.paused = !this.paused;
		this.pausedText.visible = !this.pausedText.visible;
	}
	
	// Game Over
	public function gameOver() {
		// arrêter le jeu
		this.playing = false;
		// faire exploser le joueur
		this.explosion.explode(playerShip.x, playerShip.y, 30);
		// désactiver le joueur
		this.playerShip.active     = false;
		this.playerShip.collidable = false;
		this.playerShip.visible    = false;
		// afficher les scores
		this.score.displayScores();
		// afficher le Game Over
		this.gameOverText.visible = true;
	}
	
	// redémarrer le jeu
	public function restart() {
		// lancer le jeu
		this.playing = true;
		// activer le joueur
		this.playerShip.active     = true;
		this.playerShip.collidable = true;
		this.playerShip.visible    = true;
		// donner 3 vies au joueur
		this.lifeCounter.updateLives(3);
		// repositionner le joueur au centre
		this.playerShip.centerPosition();
		// cacher le Game Over
		this.gameOverText.visible = false;
		// réinitialiser le score
		this.score.reset();
	}
}