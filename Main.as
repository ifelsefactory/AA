package  {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import cls.world;
	import cls.cub;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;
	
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	
	public class Main extends MovieClip {
		
		private var wr:world = new world();
		
		private var keyPressUP:Boolean;
		private var keyPressLEFT:Boolean;
		private var keyPressRIGHT:Boolean;
		private var keyPressDOWN:Boolean;
		
		private var fr:int;//=0;
		private var frn:int;//=10;
		private var zSpeed:int;
		private var xySpeed:int;//=5;
		private var cbVec:Vector.<MovieClip>;// = new Vector.<MovieClip>();
		
		private var scor:int;//=5;
		private var hiscor:int=0;
		
		private var tel:Number;//=10;
		private var tmp:int;//=121;
		private var min:int;//=0;
		private var sec:int;//=0;
		
		private var timp:Timer = new Timer(1000);
		
		//////////////// SOUNDS //////////////////////
		private var bgT:bg;
		private var myChannel: SoundChannel;
		private var trans: SoundTransform;
		private var volume: Number = 1;
		public var soundOK:Boolean = true;		
		private var pausePosition:int;
		
		public function Main() {
			meniu.playbut.buttonMode=true;
			meniu.playbut.addEventListener(MouseEvent.MOUSE_DOWN, startGame);
			tot.more_but.buttonMode=true;
			
			
			tot.sound_but.buttonMode = true;
			tot.sound_but.addEventListener(MouseEvent.MOUSE_DOWN, soundButFUNC);
			
			tot.more_but.buttonMode = true;
			tot.more_but.addEventListener(MouseEvent.MOUSE_DOWN, moreButFUNC);
			
			tot.logo_but.buttonMode = true;
			tot.logo_but.addEventListener(MouseEvent.MOUSE_DOWN, logoFUNC);
			
			meniu.fb_but.buttonMode = true;
			meniu.fb_but.addEventListener(MouseEvent.MOUSE_DOWN, fbFUNC);
			//////////////////////////// SOUNDS //////////////////
			bgT = new bg();			
			trans = new SoundTransform(volume, 0);
			myChannel = new SoundChannel();
			playBgSound();
		}
		
		private function startGame(e:MouseEvent):void {
			fr=0;
			frn=10;
			xySpeed=5;
			scor=5;
			tel=10;
			tmp=121;
			min=0;
			sec=0;
			
			meniu.visible = false;
			cbVec = new Vector.<MovieClip>();
			zSpeed = xySpeed*2;
			this.setChildIndex(ship,this.numChildren-1);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpListener);
			
			addEventListener(Event.ENTER_FRAME, update);
			tot.teltxt.text = "Your goal: "+tel.toString();
			tot.scortxt.text = "Your score: "+scor.toString();
			
			min = Math.floor(tmp/60);
			sec = tmp - min*60;
			restTimp();
			timp.addEventListener(TimerEvent.TIMER, restTimp);
			timp.start();
		}
		
		private function restTimp(e:TimerEvent=null):void {
			tmp--;
			var sectxt:String="";
			var mintxt:String="";
			sec--;
			if(sec==-1){
				sec=59;
				min--;
			}
			if(sec<10){
				sectxt = "0"+sec.toString();
			} else {
				sectxt = sec.toString();
			}
			if(min<10){
				mintxt = "0"+min.toString();
			} else {
				mintxt = min.toString();
			}
			tot.timetxt.text = mintxt+":"+sectxt;
			
			if(min==0 && sec==0){
				endGame(false);
			}
		}
		
		private function keyDownListener(event: KeyboardEvent): void {
			var keyCode: uint = event.keyCode;
			switch(keyCode) {
				// if pressed key UP 
				case Keyboard.UP:
				case Keyboard.W:
					keyPressUP = true;
					break;
					// if pressed key LEFT 	
				case Keyboard.LEFT:
				case Keyboard.A:
					keyPressLEFT = true;
					break;
					// if pressed key RIGHT 	
				case Keyboard.RIGHT:
				case Keyboard.D:
					keyPressRIGHT = true;
					break;
					// if pressed key DOWN
				case Keyboard.DOWN:
				case Keyboard.S:
					keyPressDOWN = true;
					break;
					// if pressed key DOWN
				/*case Keyboard.ENTER:
					replayfunc();*/
			}
		}

		private function keyUpListener(event: KeyboardEvent): void {
			var keyCode: uint = event.keyCode;
			switch(keyCode) {
				// If key released UP
				case Keyboard.UP:
				case Keyboard.W:
					keyPressUP = false;
					break;
					// If key released LEFT
				case Keyboard.LEFT:
				case Keyboard.A:
					keyPressLEFT = false;
					break;
					// If key released RIGHT
				case Keyboard.RIGHT:
				case Keyboard.D:
					keyPressRIGHT = false;
					break;
					// If key released DOWN
				case Keyboard.DOWN:
				case Keyboard.S:
					keyPressDOWN = false;
					break;
			}
		}
		
		private function update(e:Event):void {
			
			this.setChildIndex(ship,this.numChildren-1);
			if(keyPressRIGHT){
				//wr.x -= 5;
				if(ship.rotationZ<30){
					ship.rotationZ += 1;
				}
			} else {
				if(ship.rotationZ>0){
					ship.rotationZ -= 1;
				}
			}
			if(keyPressLEFT){
				//wr.x += 5;
				if(ship.rotationZ>-30){
					ship.rotationZ -= 1;
				}
			} else {
				if(ship.rotationZ<0){
					ship.rotationZ += 1;
				}
			}
			if(keyPressUP){
				//wr.y += 5;
				if(ship.rotationX>50){
					ship.rotationX -= 1;
				}
			} else {
				if(ship.rotationX<70){
					ship.rotationX += 1;
				}
			}
			if(keyPressDOWN){
				if(ship.rotationX<90){
					ship.rotationX += 1;
				}
			} else {
				if(ship.rotationX>70){
					ship.rotationX -= 1;
				}
			}
			
			fr++;
			if(fr==frn){
				fr=0;
				var ax:Number = 400 + (400 - Math.floor(Math.random()*800));
				var ay:Number = 300 + (300 - Math.floor(Math.random()*600));
				
				var cb:cub = new cub(100,ax,ay);
				cb.x = ax;;
				cb.y = ay;
				cb.z = 3000;
				addChildAt(cb,1);
				cbVec.push(cb);
			}
			
			for(var i:int=0; i<cbVec.length; i++){
				cbVec[i].z -= zSpeed;
				if(keyPressRIGHT){
					cbVec[i].x -= xySpeed;
				}
				if(keyPressLEFT){
					cbVec[i].x += xySpeed;
				}
				if(keyPressUP){
					cbVec[i].y += xySpeed;
				}
				if(keyPressDOWN){
					cbVec[i].y -= xySpeed;
				}
				var dx:Number = ship.x-cbVec[i].x;
				var dy:Number = ship.y-cbVec[i].y;
				var dist:Number = dx*dx + dy*dy;
				if(cbVec[i].z<-475 && cbVec[i].z>-500 && dist<cbVec[i].a/2*cbVec[i].a/2){
					cbVec[i].front.play();
					cbVec[i].bottom.play();
					cbVec[i].top.play();
					cbVec[i].lft.play();
					cbVec[i].rgt.play();
					scor += cbVec[i].valoare;
					tot.scortxt.text = "Your score: "+scor.toString();
					//removeChild(cbVec[i]);
					cbVec.splice(i,1);
					if(scor>=tel){
						tmp = tmp + Math.round(tel*1.5);
						min = Math.floor(tmp/60);
						sec = tmp - min*60;
						restTimp();
						xySpeed++;
						zSpeed = xySpeed*2;
						tel = Math.floor(tel*1.5);
						tot.teltxt.text = "Your new goal: "+tel.toString();
						if(frn>5){
							frn--;
						}
						trace(frn);
					}
					if(scor<0){
						endGame(false);
					}
				}
				
				if(cbVec[i].z < -500){
					this.setChildIndex(cbVec[i],this.numChildren-1);
				}
				if(cbVec[i].z < -800){
					removeChild(cbVec[i]);
					cbVec.splice(i,1);
				}
			}
			this.setChildIndex(tot,this.numChildren-1);
		}
		
		private function endGame(b:Boolean):void {
			timp.stop();
			timp.removeEventListener(TimerEvent.TIMER, restTimp);
			removeEventListener(Event.ENTER_FRAME, update);
			for(var i:int=0; i<cbVec.length; i++){
				removeChild(cbVec[i]);
			}
			cbVec.length=0;
			meniu.visible=true;
			meniu.playbut.gotoAndStop(2);
			if(hiscor<scor){
				hiscor=scor;
			}
			meniu.txt.text=hiscor.toString();
		}
		/*SOUND*/
		public function stpSound(): void {
			soundOK = false;
			stpSnd();
		}

		private function stpSnd(): void {
			volume = 0;
			pausePosition = myChannel.position; 
			SoundMixer.stopAll();
		}

		public function strSound(): void {
			soundOK = true;
			strSnd();
		}

		private function strSnd(): void {
			volume =1;
			playBgSound();			
		}

		private function playBgSound(): void {
			if (soundOK) {
				myChannel = bgT.play(pausePosition, 99999, trans);
			}
		}
		/*endSOUND*/
		private function soundButFUNC(e:MouseEvent):void {
			if(tot.sound_but.currentFrame==1){
				stpSound();
				tot.sound_but.gotoAndStop(2);
			} else if(tot.sound_but.currentFrame==2){
				strSound();
				tot.sound_but.gotoAndStop(1);
			} 
		}

		private function logoFUNC(e:MouseEvent):void {			
			var hostingdomain: * = this.loaderInfo.loaderURL.replace("http://", "").replace("https://", "").split("/");
			hostingdomain = hostingdomain[0];
			var gamename: String = "Flying Test";
			var toCategID: String = "more_games";
			var website: String = "at7games.com";
			var request: URLRequest = new URLRequest("http://" + website + "/?g_n=" + toCategID + "&g_s=" + hostingdomain + "&g_c=" + gamename);
			try {
				navigateToURL(request, "_blank");
			} catch (e: Error) {
				trace("Error occurred!");
			}
		}
		private function moreButFUNC(e:MouseEvent):void {			
			var hostingdomain: * = this.loaderInfo.loaderURL.replace("http://", "").replace("https://", "").split("/");
			hostingdomain = hostingdomain[0];
			var gamename: String = "Flying Test";
			var toCategID: String = "Flying Test";
			var website: String = "at7games.com";
			var request: URLRequest = new URLRequest("http://" + website + "/?g_n=" + toCategID + "&g_s=" + hostingdomain + "&g_c=" + gamename);
			try {
				navigateToURL(request, "_blank");
			} catch (e: Error) {
				trace("Error occurred!");
			}
		}
		private function fbFUNC(e:MouseEvent):void {
			var share_url:String = "https://www.facebook.com/dialog/feed?app_id=641944079267899";
			share_url += "&link=http://at7games.com/index.php/game/Flying_Test/112";
			share_url += "&picture=http://at7games.com/system/data/pagini/image/PRODUCTS/FlyingTest/250.png";
			share_url += "&name=Flying Test";
			share_url += "&description=I just played! Try it!";
			share_url += "&redirect_uri=http://at7games.com/index.php/game/Flying_Test/112";
			var request: URLRequest = new URLRequest(share_url);
			try {
				navigateToURL(request, "_blank");
			} catch (e: Error) {
				trace("Error occurred!");
			}
		}

	}
	
}
