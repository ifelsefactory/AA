package cls  {
	
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class cub extends MovieClip {
		
		public var front:patrat=new patrat();
		public var bottom:patrat=new patrat();
		public var top:patrat=new patrat();
		public var lft:patrat=new patrat();
		public var rgt:patrat=new patrat();
		
		public var valoare:int=0;
		public var a:Number;
		
		private var colArr:Array = new Array(0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF);

		public function cub(b:int,ax:Number,ay:Number) {			
			var fintext:TextField = new TextField();
			// fintext.autoSize = "center";
			 var txtF:TextFormat = new TextFormat();
			 txtF.font = "Verdana";
			 txtF.size = 24;
			 txtF.bold = true;
			 txtF.align = "center";
			
			var AcolArr:Array = new Array(0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 0x00FFFF);
			AcolArr.sort(randomSort);
			AcolArr.sort(randomSort);
			AcolArr.sort(randomSort);
			AcolArr.sort(randomSort);
			var arrr: Array = AcolArr.filter(function(param1: * , param2: int, param3: Array): Boolean {
				return(arrr ? arrr : arrr = new Array()).indexOf(param1) >= 0 ? false : arrr.push(param1) >= 0;
			}, this);
			AcolArr = arrr;
			
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
			
			txtF.color = AcolArr[0];
			fintext.defaultTextFormat = txtF;
			fintext.selectable = false;
			valoare = colArr.indexOf(AcolArr[0])-2;
			fintext.text = valoare.toString();
			//addChild(fintext);
			//fintext.width = fintext.height = 80;
			fintext.x = -fintext.width/2;
			fintext.y = -fintext.height/4;
			fintext.z = 0;//25;
			
			var trans:ColorTransform = lft.transform.colorTransform;
			trans.color = uint(AcolArr[0]);
			lft.transform.colorTransform = trans;
			//lft.alpha = .6;
			rgt.transform.colorTransform = trans;
			//rgt.alpha = .6;
			top.transform.colorTransform = trans;
			//top.alpha = .6;
			bottom.transform.colorTransform = trans;
			//bottom.alpha = .6;
			
			addChild(front);
			addChild(fintext);
			
			front.alpha = .4;
			
			if(valoare>0){
				a=b/2;
			} else {
				a=b*2;
			}
			
			bottom.width = bottom.height = a;
			lft.width = lft.height = a;
			rgt.width = rgt.height = a;
			top.width = top.height = a;
			front.width = front.height = a;
			
			bottom.rotationX = top.rotationX = 90;
			lft.rotationY = rgt.rotationY = 90;
			bottom.y = bottom.z = top.z = lft.z = rgt.z = a/2;
			top.y = -a/2;
			lft.x = -a/2;
			rgt.x = a/2;
			
		}

		private function randomSort(param1: Object, param2: Object): int {
			return Math.round(Math.random() * 2) - 1;
		}
		
		private var nrend:int=0;
		public function fin():void {
			nrend++;
			if(nrend==5){
				this.parent.removeChild(this);
			}
		}

	}
	
}
