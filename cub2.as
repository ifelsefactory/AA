package cls  {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	public class cub extends MovieClip {
		
		private var front:patrat=new patrat();
		private var bottom:patrat=new patrat();
		private var top:patrat=new patrat();
		private var lft:patrat=new patrat();
		private var rgt:patrat=new patrat();

		public function cub(a:int,ax:Number,ay:Number) {
			if(ax<0 && ay<0){
				addChild(top);
				addChild(lft);
				addChild(rgt);
				addChild(bottom);
			} else if(ax>0 && ay<0){
				addChild(top);
				addChild(rgt);
				addChild(lft);
				addChild(bottom);
			} else if(ax>0 && ay>0){
				addChild(bottom);
				addChild(rgt);
				addChild(lft);
				addChild(top);
			} else if(ax<0 && ay>0){
				addChild(bottom);
				addChild(lft);
				addChild(rgt);
				addChild(top);
			}
			var transL:ColorTransform = lft.transform.colorTransform;
			transL.color = uint(0xFF0000);
			lft.transform.colorTransform = transL;
			lft.alpha = .6;
			
			var transR:ColorTransform = rgt.transform.colorTransform;
			transR.color = uint(0x00FF00);
			rgt.transform.colorTransform = transR;
			rgt.alpha = .6;
			
			var transT:ColorTransform = top.transform.colorTransform;
			transT.color = uint(0x00FFFF);
			top.transform.colorTransform = transT;
			top.alpha = .6;
			
			var transB:ColorTransform = bottom.transform.colorTransform;
			transB.color = uint(0xFFFF00);
			bottom.transform.colorTransform = transB;
			bottom.alpha = .6;
			
			
			addChild(front);
			
			front.alpha = .6;
			
			bottom.rotationX = top.rotationX = 90;
			lft.rotationY = rgt.rotationY = 90;
			bottom.y = bottom.z = top.z = lft.z = rgt.z = 25;
			top.y = -25;
			lft.x = -25;
			rgt.x = 25;
			
		}

	}
	
}
