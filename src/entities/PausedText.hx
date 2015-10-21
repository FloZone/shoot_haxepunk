package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import flash.text.TextFormatAlign;



/**
 * ...
 * @author FloZone
 */
class PausedText extends Entity
{
	private var text:Text;
	
	
	
	public function new(message:String) 
	{
		super();
		
		this.text       = new Text(message, 0, HXP.height / 3 - 20, HXP.width);
		this.text.align = TextFormatAlign.CENTER;
		this.text.size  = 30;
		this.graphic = this.text;
		
		this.layer = -3;
	}
	
	
	public function setText(message:String) {
		this.text.text = message;
	}
}