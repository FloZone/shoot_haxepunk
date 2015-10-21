package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Data;
import flash.text.TextFormatAlign;
import com.haxepunk.HXP;



/**
 * ...
 * @author FloZone
 */
class Score extends Entity
{
	private var score:Text;
	private var points:Int;
	private var highscore:Int;
	
	
	
	public function new() 
	{
		super();
	
		this.score       = new Text("", 0, 10, HXP.width);
		this.score.align = TextFormatAlign.CENTER;
		this.score.size  = 24;
		this.graphic     = this.score;
		
		// charger le highscore
		Data.load("shootData");
		this.highscore = Data.read("highscore", 0);

		// mettre à 0 le score
		this.reset();
		
		this.layer = -2;
	}
	

	// mettre à jour le texte affiché
	private function updateText() {
		this.score.text = "Score: " + this.points;
	}
	
	// mettre à 0 le score
	public function reset() {
		this.points = 0;
		this.updateText();
	}
	
	// incrémenter et afficher le score
	public function add(num:Int) {
		this.points += num;
		// si le score est meilleur que le highscore
		if (this.points > this.highscore) {
			// le mettre à jour
			this.highscore = points;
			// sauvegarder le nouveau highscore
			Data.write("highscore", this.highscore);
			Data.save("shootData");
		}
		this.updateText();
	}
	
	// afficher le score et le highscore
	public function displayScores() {
		this.score.text = "Score: " + this.points + "\nHighscore: " + this.highscore;
	}
}