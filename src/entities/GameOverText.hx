package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import flash.text.TextFormatAlign;



/**
 * ...
 * @author FloZone
 */
class GameOverText extends Entity
{
	private var text:Text;
	
	
	
	public function new() 
	{
		super();
		
		this.text       = new Text("Press ENTER to restart", 0, HXP.height / 2 - 50, HXP.width);
		this.text.size  = 32;
		this.text.align = TextFormatAlign.CENTER;
		this.text.y     = HXP.height / 2 - 50;
		this.graphic    = this.text;
		
		this.layer = -5;
	}
}