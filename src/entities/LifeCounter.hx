package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import scenes.MainScene;



/**
 * ...
 * @author FloZone
 */
class LifeCounter extends Entity
{
	private var text:Text;
	private var lives:Int;

	
	
	public function new(icon:Image) {
		super();
		
		this.lives = 0;
		
		this.text = new Text("", 30);
		this.text.color = 0xff0000;
		this.text.size  = 24;
		
		this.addGraphic(icon);
		this.addGraphic(text);

		this.updateLives(3);

		this.x = 10;
		this.y = 10;
		
		this.layer = -4;
	}
	
	
	// mettre à jour les vies
	public function updateLives(num:Int):Void {
		this.lives    += num;
		this.text.text = lives + "";
		
		// si le joueur n'a plus de vies, gameover
		if (this.lives == 0) cast(scene, scenes.MainScene).gameOver();
	}
}