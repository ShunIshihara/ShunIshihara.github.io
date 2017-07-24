enchant();

var time = new Label();		// 計測タイム
var myHp = 0;
var windowSize = {x:640, y:640}

window.onload = function() {
    game = new Game(windowSize.x, windowSize.y); // 表示領域の大きさを設定(横，縦)
    game.fps = 30;                 // ゲームの進行スピードを設定
    game.preload('img/chara.png', 'img/map1.png', 'img/gameover.png', 'img/clear.png', 'img/planet.png', 'img/effect0.png', 'img/icon0.png', 'img/map0.png');
    game.keybind(90, 'z');
    game.onload = function() {     // ゲームの準備が整ったらメインの処理を実行します
	
        /**
         * タイトルシーンを作り、返す関数
         */
        var createTitleScene = function() {
            var scene = new Scene();                // 新しいシーンを作る
	    var stage = new Sprite(windowSize.x, windowSize.y);
	    stage.image = game.assets['img/planet.png'];
            scene.addChild(stage);	    
            var labelTitle = new Label('タイトル！');   // 新しいラベル(文字)を作る
	    labelTitle.x = 280;
	    labelTitle.y = 50;
	    labelTitle.font = "24px cursive";	    
	    labelTitle.color = 'black'
            scene.addChild(labelTitle);                  // シーンにラベルに追加
	    var labelrule = new Label('操作方法：矢印で移動！zで弾を撃つ！');
	    labelrule.x = 180;
	    labelrule.y = 280;
	    labelrule.font = "18px cursive";
	    labelrule.color = 'black'
            scene.addChild(labelrule);                  // シーンにラベルに追加
	    var labelrule = new Label('敵をなるべく早くすべて倒せ！');
	    labelrule.x = 180;
	    labelrule.y = 400;
	    labelrule.font = "18px cursive";
	    labelrule.color = 'black'
            scene.addChild(labelrule);                  // シーンにラベルに追加
	    var labelrule = new Label('クリックでスタート！');
	    labelrule.x = 180;
	    labelrule.y = 480;
	    labelrule.font = "18px cursive";
	    labelrule.color = 'black'
            scene.addChild(labelrule);                  // シーンにラベルに追加	    

            scene.addEventListener('touchstart', function(e) { // シーンにタッチイベントを設定
                //現在表示しているシーンをゲームシーンに置き換えます
                game.pushScene(createGameScene());
            });
            // この関数内で作ったシーンを呼び出し元に返します(return)
            return scene;
        };

	
    	/**
         * ゲームシーンを作り、返す関数
         */
        var createGameScene = function() {
	    myHp = 3;	 // hpの初期化
	    game.frame = 0;	     // 時間の初期化のため
            scene = new Scene();                // 新しいシーンを作る
	    var stage = new Sprite(windowSize.x, windowSize.y); // 背景の作成
	    stage.image = game.assets['img/planet.png'];
            scene.addChild(stage);

	    //障害物の設置
	    obstacles = [];
	    var cnt1 = 0, cnt2 = 0, cnt3 = 0;
	    for(var j = 0; j < 10; j++){
		cnt1 = j;
		cnt2 = j + 10;
		cnt3 = j + 20;
	    	obstacles[cnt1] = new Obstacle(100 + 16 * j, 200); // 場所だけ指定
	    	obstacles[cnt2] = new Obstacle(400 + 16 * j, 200); // 場所だけ指定
	    	obstacles[cnt3] = new Obstacle(250 + 16 * j, 400); // 場所だけ指定		
	    }

	    //体力表示
	    hearts = [];
	    for(var k = 0; k < 3; k++){
		hearts[k] = new Heart(550 + 16 * k, 600);
	    }
	    
	    //キャラ生成
            chara = new Sprite(32, 32);
            chara.image = game.assets['img/chara.png'];
            chara.x = 310;
            chara.y = 600;
	    chara.frame = 18;
            scene.addChild(chara);
	    var chara_dir = 0, chara_con = 0, count = 0;
	    
	    //キャラ操作
	    chara.on('enterframe', function() {
		if(myHp <= 0){
		    scene.removeChild(hearts[2]);
		    game.pushScene(createGameoverScene());
		}
		if(myHp == 2) scene.removeChild(hearts[0]);
		if(myHp == 1) scene.removeChild(hearts[1]);
		chara_con++;
		//障害物のキャラと弾の当たり判定
		var x = 0, y = 0;
		x = this.x;
		y = this.y;
	    	if (game.input.left){
		    this.x -= 5;
		    this.frame = 6;
		    chara_dir = 1;
		    
		}
	    	if (game.input.right){
		    this.x += 5;
		    this.frame = 12;
		    chara_dir = 2;
		}		    
	    	if (game.input.up){
		    this.y -= 5;
		    this.frame = 18;
		    chara_dir = 3;
		}
		if (game.input.down){
		    this.y += 5;
		    this.frame = 0;
		    chara_dir = 4;
		}
		for(var i = 0; i < 30; i++){
		    if(chara.intersect(obstacles[i])){
		    	this.x = x;
		    	this.y = y;
		    }
		}
	    	if(this.y > 605) this.y = 605;
		if(this.y < 5) this.y = 5;
	    	if(this.x > 605) this.x = 605;
		if(this.x < 5) this.x = 5;

		if(chara_con > 30){ // 1秒に1つ弾が出る
		    if(game.input.z){
			new Bullet(this.x, this.y, chara_dir, 1);
			chara_con = 0;
		    }
		}
		//戦車同士の当たり判定
		count++;
		if(count > 30){
		    for(var i = 0; i < 3; i++){
			if(enemies[i].intersect(chara) && enemies[i].alive == 1){
			    count = 0;
			    hitEffect(chara.x, chara.y);
				console.log("hp = " + myHp);
				myHp--;
			}
		    }
		}	

	    });
	    

	    var enemy_dir = 0;
	    //敵生成クラス
	    Enemy = Class.create(Sprite, {
		initialize:function(x, y){
		    var move = 0, enemy_con = 0;
		    Sprite.call(this, 32, 32);
		    this.x = x;
		    this.y = y;
		    this.image = game.assets['img/chara.png'];
		    this.frame = 3;
		    this.on('enterframe', function(){ // 1秒に一回行動し弾を撃つ
			enemy_con++;
			if(move == 0){ // 左
			    this.x -= 1;
			    this.frame = 9;
			    enemy_dir = 1;
			}
			if(move == 1){ // 右
			    this.x += 1;
			    this.frame = 15;
			    enemy_dir = 2;
			}
			if(move == 2){ // 上
  			    this.y -= 1;
			    this.frame = 21;
			    enemy_dir = 3;
			}
			if(move == 3){ // 下
			    this.y += 1;
			    this.frame = 3;
			    enemy_dir = 4;
			}
			//1秒に1つ敵の弾生成
			if(enemy_con == 15)new Bullet(this.x, this.y, enemy_dir, 2);
			//1秒に1回方向をランダムに変える
			if(enemy_con == 30){
			    move = rand(3);
			    enemy_con = 0;
			}
			for(var i = 0; i < 30; i++){
			    if(chara.intersect(obstacles[i])){
		    		this.x = x;
		    		this.y = y;
			    }
			}			
			if(this.y > 605) this.y = 605; // 画面外へ行かないため
			if(this.y < 5) this.y = 5;
	    		if(this.x > 605) this.x = 605;
			if(this.x < 5) this.x = 5;
			//敵の死ぬ判定
			for(var j = 0; j < 3; j++){
			    if(enemies[j].hp == 0){
				scene.removeChild(enemies[j]);
				enemies[j].alive = 0; // 死亡
			    }
			    //敵をすべて倒したら
			    if(enemies[0].alive == 0 && enemies[1].alive == 0 && enemies[2].alive == 0) game.pushScene(createGameclearScene());
			}
		    });
		    scene.addChild(this);
		}
	    });
	    //敵の作成
	    enemies = [];
	    for (var i = 0; i < 3; i++){
	    	enemies[i] = new Enemy(150 * (i + 1), 100);
		enemies[i].hp = 3;
		enemies[i].alive = 1; // 1が生きてる 0で死んだ
	    }

	    //ランダム関数　0~nまで この関数は外部からの引用
	    function rand(n) {
		return Math.floor(Math.random() * (n + 1));
	    }
	    
	    //時間表示
	    time.x = 600;
	    time.y = 5;
	    time.color = 'blue';
	    time.font = '14px "Arial"';
	    time.text = '0';
	    time.on('enterframe', function() {
	    	time.text = (game.frame / game.fps).toFixed(1); // toFixedで小数点以下
	    });
	    scene.addChild(time);

	    // シーンにタッチイベントを設定
            // scene.addEventListener('touchstart', function(e) {
            //     //現在表示しているシーンの上にゲームクリアシーンを重ねて表示します
            //     game.pushScene(createGameclearScene());
            // });
            // この関数内で作ったシーンを呼び出し元に返します(return)
            return scene;
        };

	
        /**
         * ゲームオーバーシーンを作り、返す関数
         */
        var createGameoverScene = function() {
            var scene = new Scene();                // 新しいシーンを作る
            scene.backgroundColor = 'rgba(0, 0, 0, 0.2)';      // シーンの背景色を設定
            var label = new Label('クリックでタイトルに戻るよ！');      // 新しいラベル(文字)を作る
            label.x = 240;                            // 横位置調整
	    label.y = 400;                           // 縦位置調整
	    label.color = 'blue';
            scene.addChild(label);                  // シーンにラベルに追加
	    var sprite = new Sprite(188, 96);			 // ゲームオーバーの画像
	    sprite.image = game.assets['img/gameover.png'];
	    sprite.x = 220;
	    sprite.y = 240;
	    scene.addChild(sprite);
            scene.addEventListener('touchstart', function(e) { // シーンにタッチイベントを設定
                //現在表示しているシーンを外し、直前のシーンを表示します
                game.popScene();
                game.popScene();		
            });
            // この関数内で作ったシーンを呼び出し元に返します(return)
            return scene;
        };


        /**
         * ゲームクリアシーンを作り、返す関数
         */
        var createGameclearScene = function() {
            var scene = new Scene();                // 新しいシーンを作る
            scene.backgroundColor = 'rgba(255, 255, 255, 0.2)';      // シーンの背景色を設定
            var label = new Label('クリックでタイトルに戻るよ！');      // 新しいラベル(文字)を作る
            label.x = 250;                            // 横位置調整
	    label.y = 420;                           // 縦位置調整
	    label.color = 'blue';
            scene.addChild(label);                  // シーンにラベルに追加
	    var sprite = new Sprite(268, 48);			 // ゲームクリアの画像
	    sprite.image = game.assets['img/clear.png'];
	    sprite.x = 190;
	    sprite.y = 240;
	    scene.addChild(sprite);
	    var labelTime = new Label(); // クリアタイムの表示
	    labelTime.text = time.text;
	    labelTime.x = 280;
	    labelTime.y = 350;
	    labelTime.font = "24px cursive";	    
	    scene.addChild(labelTime);
	    var labelSecond = new Label('秒！');
	    labelSecond.x = 360;
	    labelSecond.y = 350;
	    labelSecond.font = "24px cursive";	    	    
	    scene.addChild(labelSecond);

	    
            scene.addEventListener('touchstart', function(e) { // シーンにタッチイベントを設定
                //現在表示しているシーンを外し、直前のシーンを表示します
                game.popScene();
                game.popScene();		
            });
            // この関数内で作ったシーンを呼び出し元に返します(return)
            return scene;
        };

	
        // ゲームの_rootSceneをタイトルシーンに置き換えます
        game.replaceScene(createTitleScene());
        // このようにcreateTitleScene() と書くと、シーンが関数内で作成されて
        // createTitleScene()と書かれた場所に代入されます


    }
    
    game.start(); // ゲームをスタートさせます
};

//弾生成クラス
var Bullet = Class.create(Sprite, {
    initialize: function(x, y, dir, type){
	Sprite.call(this, 16, 16);
	this.dir = dir;		// onenterframeで使うため
	this.type = type;
	var hit = 0;
	this.hit = hit;
	if(dir == 3){ // 上
	    this.x = x + 8;
	    this.y = y - 8;
	    this.by = this.y;
	    if(type == 1) this.frame = 56;
	    if(type == 2) this.frame = 48;
	}
	if(dir == 4){ // 下
	    this.x = x + 8;
	    this.y = y + 24;
	    this.by = this.y;
	    if(type == 1) this.frame = 60;
	    if(type == 2) this.frame = 52;	    
	}
	if(dir == 1){ // 左
	    this.x = x - 10;
	    this.y = y + 9;
	    this.bx = this.x;
	    if(type == 1) this.frame = 58;
	    if(type == 2) this.frame = 50;
  
	}
	if(dir == 2){ // 右
	    this.x = x + 24;
	    this.y = y + 9;
	    this.bx = this.x;
	    if(type == 1) this.frame = 62;
	    if(type == 2) this.frame = 54;
	}		    
	this.image = game.assets['img/icon0.png'];
	scene.addChild(this);
    },
    onenterframe: function(){	// 弾を一定距離で消す
	if(this.dir == 3){	// 上
    	    this.y -= 10;
	    if(this.by - this.y >= 100){
		scene.removeChild(this);
	    }
	}
	if(this.dir == 4){	// 下
	    this.y += 10;
	    if(this.y - this.by >= 100){
		scene.removeChild(this);
	    }
	}	    
	if(this.dir == 1){	// 左
	    this.x -= 10;
	    if(this.bx - this.x >= 100){
		scene.removeChild(this);
	    }
	}	    
	if(this.dir == 2){	// 右
	    this.x += 10;
	    if(this.x - this.bx >= 100){
		scene.removeChild(this);
	    }
	}
	if(this.intersect(chara) && this.hit == 0 && this.type == 2){ // 連続ヒットしないため キャラに弾があたるとき
	    this.hit++;
	    hitEffect(this.x, this.y);
	    myHp--;
	    if(this.hit > 30 ) this.hit = 0;
	}
	for(var i = 0; i < 3; i++){
	    if(this.intersect(enemies[i]) && this.hit == 0 && this.type == 1){ // 連続ヒットしないため 敵に弾が当たるとき
		this.hit++;
		hitEffect(this.x, this.y);
		enemies[i].hp--;
		console.log(enemies[i].hp);
		if(this.hit > 30) this.hit = 0;
	    }
	}
    }	
});


//障害物の設置
var Obstacle = Class.create(Sprite, {
    initialize:function(x, y){
	Sprite.call(this, 16, 16);
	this.x = x;
	this.y = y;
	this.image = game.assets['img/map0.png'];
	this.frame = 22;
	scene.addChild(this);
    }
});

//体力表示
var Heart = Class.create(Sprite, {
    initialize:function(x, y){
	Sprite.call(this, 16, 16);
	this.x = x;
	this.y = y;
	this.image = game.assets['img/icon0.png'];
	this.frame = 70;
	scene.addChild(this);
    }
});

//弾や戦車が当たったときのエフェクト
var hitEffect = function(x, y){
    var effect = new Sprite(16, 16);
    var i = 0;
    effect.image = game.assets['img/effect0.png'];
    effect.x = x + 8;
    effect.y = y + 8;
    effect.frame = 0;
    scene.addChild(effect);
    effect.addEventListener('enterframe', function(){
	effect.frame = i;
	i++;
	scene.addChild(effect);
	if(i > 4){
	    scene.removeChild(effect);
	    i = 0;
	}
    });
}
