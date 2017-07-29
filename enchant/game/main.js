enchant();

var time = new Label();		//計測タイム
var myHp = 0;			//charaのHP
var windowSize = {x:640, y:640} //表示領域の数値

window.onload = function() {
    game = new Game(windowSize.x, windowSize.y); //表示領域の大きさを指定(横，縦)
    game.fps = 30;                 //fpsを指定
    game.preload('img/chara.png', 'img/map1.png', 'img/gameover.png', 'img/clear.png', 'img/planet.png', 'img/effect0.png', 'img/icon0.png', 'img/map0.png');
    game.keybind(90, 'z');
    game.onload = function() {     
	//タイトルシーン作成関数
        var createTitleScene = function() {	    
            var scene = new Scene();                //新しいシーンを作る
	    var stage = new Sprite(windowSize.x, windowSize.y);
	    stage.image = game.assets['img/planet.png'];
            scene.addChild(stage);
	    
            var labelTitle = new Label('GO！GO！戦車！');   //新しいラベルを作る
	    labelTitle.x = 200;
	    labelTitle.y = 100;
	    labelTitle.font = "32px cursive";	    
	    labelTitle.color = 'black'
            scene.addChild(labelTitle);
            
	    var labelrule = new Label('操作方法：矢印で移動！zで弾を撃つ！');
	    labelrule.x = 170;
	    labelrule.y = 280;
	    labelrule.font = "18px cursive";
	    labelrule.color = 'black'
            scene.addChild(labelrule);
            
	    var labelrule = new Label('敵をなるべく早くすべて倒せ！');
	    labelrule.x = 200;
	    labelrule.y = 400;
	    labelrule.font = "18px cursive";
	    labelrule.color = 'black'
            scene.addChild(labelrule);
	    
	    var labelrule = new Label('クリックでスタート！');
	    labelrule.x = 230;
	    labelrule.y = 480;
	    labelrule.font = "18px cursive";
	    labelrule.color = 'black'
            scene.addChild(labelrule);                 	    

	    //クリックでゲームシーンへ
            scene.addEventListener('touchstart', function(e) {
                //現在表示しているシーンをゲームシーンに置き換える
                game.pushScene(createGameScene());
            });
	    
            //シーンを返す
            return scene;
        };

	//ゲームシーン作成関数
        var createGameScene = function() {
	    myHp = 3;	 // キャラhpの初期化
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
	    	obstacles[cnt1] = new Obstacle(90 + 16 * j, 400); // 場所だけ指定
	    	obstacles[cnt2] = new Obstacle(390 + 16 * j, 400); // 場所だけ指定
	    	obstacles[cnt3] = new Obstacle(240 + 16 * j, 200); // 場所だけ指定		
	    }

	    //キャラの体力表示
	    myHearts = [];
	    for(var k = 0; k < 3; k++){
		myHearts[k] = new Heart(550 + 16 * k, 615);
	    }

	    //キャラ生成
            chara = new Sprite(32, 32);
            chara.image = game.assets['img/chara.png'];
            chara.x = 310;
            chara.y = 550;
	    chara.frame = 18;
            scene.addChild(chara);
	    
	    var chara_dir = 0, chara_con = 0, count = 0;
	    //キャラ操作や各種判定
	    chara.on('enterframe', function() {
		//残りHPを表示に反映
		if(myHp <= 0){
		    scene.removeChild(myHearts[2]);
		    game.pushScene(createGameoverScene());
		}
		if(myHp == 2) scene.removeChild(myHearts[0]);
		if(myHp == 1) scene.removeChild(myHearts[1]);
		chara_con++;
		
		//障害物のキャラと弾の当たり判定
		var x = 0, y = 0;
		x = this.x;
		y = this.y;
	    	if (game.input.left){
		    this.x -= 4;
		    this.frame = 6;
		    chara_dir = 1;
		}
	    	if (game.input.right){
		    this.x += 4;
		    this.frame = 12;
		    chara_dir = 2;
		}		    
	    	if (game.input.up){
		    this.y -= 4;
		    this.frame = 18;
		    chara_dir = 3;
		}
		if (game.input.down){
		    this.y += 4;
		    this.frame = 0;
		    chara_dir = 4;
		}
		
		//戦車同士の当たり判定
		count++;
		if(count > 30){
		    for(var i = 0; i < 3; i++){
			if(enemies[i].intersect(chara) && enemies[i].alive == 1){ //衝突判定にはintersectメソッドを使用
			    count = 0;
			    hitEffect(chara.x, chara.y);
				console.log("hp = " + myHp);
				myHp--;
			}
		    }
		}
		
		//移動先に障害物があるなら元の座標に戻る
		for(var i = 0; i < 30; i++){
		    if(chara.intersect(obstacles[i])){
		    	this.x = x;
		    	this.y = y;
		    }
		}
		
		//移動先に敵戦車があるなら元の座標に戻る
		for(var j = 0; j < 3; j++){
		    if(chara.intersect(enemies[j]) && enemies[j].alive == 1){
		    	this.x = x;
		    	this.y = y;
		    }
		}

		//場外に出るのを防ぐ
	    	if(this.y > 580) this.y = 580;
		if(this.y < 36) this.y = 36;
	    	if(this.x > 604) this.x = 604;
		if(this.x < 4) this.x = 4;
		
		// 1秒に1つ弾を出せる
		if(chara_con > 30){
		    if(game.input.z){
			new Bullet(this.x, this.y, chara_dir, 1);
			chara_con = 0;
		    }
		}
		
		//敵をすべて倒したらクリアシーンへ
		if(enemies[0].alive == 0 && enemies[1].alive == 0 && enemies[2].alive == 0) game.pushScene(createGameclearScene());
	    });

	    //敵の体力表示
	    enemy1 = [];
	    for(var l = 0; l < 3; l++){
	    	enemy1[l] = new Heart(50 + 16 * l, 20);
	    }

	    enemy2 = [];
	    for(var m = 0; m < 3; m++){
	    	enemy2[m] = new Heart(300 + 16 * m, 20);
	    }

	    enemy3 = [];
	    for(var n = 0; n < 3; n++){
	    	enemy3[n] = new Heart(550 + 16 * n, 20);
	    }	  
	    
	    
	    var enemy_dir = 0;
	    var enemy_x = 0, enemy_y = 0;
	    //敵生成クラス
	    Enemy = Class.create(Sprite, {
		initialize:function(x, y){
		    var move = 0, enemy_con = 0;
		    Sprite.call(this, 32, 32);
		    this.x = x;
		    this.y = y;	    
		    this.image = game.assets['img/chara.png'];
		    this.frame = 3;
		    //敵の行動や各種判定
		    this.on('enterframe', function(){
			//敵HPを表示に反映
			for(var l = 0; l < 3; l++){
			    if(enemies[0].hp == l) scene.removeChild(enemy1[2 - l]);
			}
			for(var m = 0; m < 3; m++){
			    if(enemies[1].hp == m) scene.removeChild(enemy2[2 - m]);
			}
			for(var n = 0; n < 3; n++){
			    if(enemies[2].hp == n) scene.removeChild(enemy3[2 - n]);
			}

			//障害物判定のために現在の座標を保存
			enemy_x = this.x;
			enemy_y = this.y;

			//敵の移動
			enemy_con++;
			if(move == 0){ // 左
			    this.x -= 2;
			    this.frame = 9;
			    enemy_dir = 1;
			}
			if(move == 1){ // 右
			    this.x += 2;
			    this.frame = 15;
			    enemy_dir = 2;
			}
			if(move == 2){ // 上
  			    this.y -= 2;
			    this.frame = 21;
			    enemy_dir = 3;
			}
			if(move == 3){ // 下
			    this.y += 2;
			    this.frame = 3;
			    enemy_dir = 4;
			}
			
			//2秒に3回方向転換と1秒に1回弾を撃つ
			if(enemy_con == 20) move = rand(3);
			if(enemy_con == 30) new Bullet(this.x, this.y, enemy_dir, 2);
			if(enemy_con == 40) move = rand(3);
			if(enemy_con == 60){
			    new Bullet(this.x, this.y, enemy_dir, 2);
			    move = rand(3);
			    enemy_con = 0;
			}
			
			//移動先に障害物があるなら元の座標に戻る
			for(var i = 0; i < 30; i++){
			    if(enemies[0].intersect(obstacles[i]) || enemies[1].intersect(obstacles[i]) || enemies[2].intersect(obstacles[i])){
		    		this.x = enemy_x;
		    		this.y = enemy_y;
			    }
			}
			
			//移動先に生存している敵戦車があるなら元の座標に戻る
			if((enemies[0].intersect(enemies[1]) && enemies[0].alive == 1 && enemies[1].alive == 1) || (enemies[0].intersect(enemies[2]) && enemies[0].alive == 1 && enemies[2].alive == 1) || (enemies[1].intersect(enemies[2]) && enemies[1].alive == 1 && enemies[2].alive == 1)){
		    		this.x = enemy_x;
		    		this.y = enemy_y;
			}
			
			//移動先にキャラがいたら元の座標に戻る
			for(var k = 0; k < 3; k++){
			    if(enemies[k].intersect(chara) && enemies[k].alive == 1){
		    		this.x = enemy_x;
		    		this.y = enemy_y;
			    }
			}

			// 画面外へ行かないため
			if(this.y > 580) this.y = 580;
			if(this.y < 36) this.y = 36;
	    		if(this.x > 604) this.x = 604;
			if(this.x < 4) this.x = 4;
			
			//敵の死ぬ判定
			for(var j = 0; j < 3; j++){
			    if(enemies[j].hp == 0){
				scene.removeChild(enemies[j]);
				enemies[j].alive = 0; // 死亡
			    }
			}
		    });
		    //敵の表示
		    scene.addChild(this);
		}
	    });
	    
	    //敵の生成、初期位置
	    enemies = [];
	    enemies[0] = new Enemy(150, 300);
	    enemies[1] = new Enemy(300, 100);
	    enemies[2] = new Enemy(450, 300);
	    for (var i = 0; i < 3; i++){
		enemies[i].hp = 3;
		enemies[i].alive = 1; // 1が生きてる 0で死んでる
	    }

	    //ランダム関数　0~nまで
	    function rand(n) {
		return Math.floor(Math.random() * (n + 1));
	    }
	    
	    //タイムの計算
	    time.x = 600;
	    time.y = 5;
	    time.color = 'blue';
	    time.font = '14px "Arial"';
	    time.text = '0';
	    time.on('enterframe', function() {
	    	time.text = (game.frame / game.fps).toFixed(1); // toFixedで小数点以下
	    });
	    //タイムの表示
	    scene.addChild(time);

	    //シーンを返す
            return scene;
        };

	//ゲームオーバーシーン作成関数
        var createGameoverScene = function() {
            var scene = new Scene();                //新しいシーンを作る
            scene.backgroundColor = 'rgba(0, 0, 0, 0.2)';      //白の半透明を重ねる
	    
            var label = new Label('クリックでタイトルに戻るよ！');      //新しいラベルを作る
            label.x = 240;                            //横位置調整
	    label.y = 440;                           //縦位置調整
	    label.color = 'blue';
            scene.addChild(label);                  //シーンにラベルに追加
	    
	    var sprite = new Sprite(188, 96);			 //ゲームオーバーの画像
	    sprite.image = game.assets['img/gameover.png'];
	    sprite.x = 220;
	    sprite.y = 240;
	    scene.addChild(sprite);

	    //クリックしたら2回ポップしタイトルシーンに戻る
            scene.addEventListener('touchstart', function(e) {
                game.popScene();
                game.popScene();		
            });
	    
            //シーンを返す
            return scene;
        };

	//ゲームクリアシーン作成関数
        var createGameclearScene = function() {
            var scene = new Scene();                // 新しいシーンを作る
            scene.backgroundColor = 'rgba(255, 255, 255, 0.2)';      //黒の半透明を重ねる
	    
            var label = new Label('クリックでタイトルに戻るよ！');      //新しいラベルを作る
            label.x = 250;                            //横位置調整
	    label.y = 420;                           //縦位置調整
	    label.color = 'blue';
            scene.addChild(label);                  //シーンにラベルに追加
	    
	    var sprite = new Sprite(268, 48);			 //ゲームクリアの画像
	    sprite.image = game.assets['img/clear.png'];
	    sprite.x = 190;
	    sprite.y = 240;
	    scene.addChild(sprite);
	    
	    var labelTime = new Label(); //クリアタイムの表示
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

	    //クリックしたら2回ポップしタイトルシーンに戻る
            scene.addEventListener('touchstart', function(e) {
                game.popScene();
                game.popScene();		
            });
	    
            //シーンを返す
            return scene;
        };
	
        //rootSceneをタイトルシーンに置き換える
        game.replaceScene(createTitleScene());
    }
    game.start(); //ゲームスタート
};


//弾生成クラス 敵は1秒に1回、キャラはzを押した時に呼び出す
var Bullet = Class.create(Sprite, {
    initialize: function(x, y, dir, type){ //x, yで座標、dirで方向、typeでcharaか敵かを示す
	Sprite.call(this, 16, 16);
	this.dir = dir;		// onenterframeで使うため
	this.type = type;
	this.hit_chara = 0;
	this.hit_enemy = 0;

	//弾を出す方向、適切な画像フレーム、表示位置を指定する
	if(dir == 3){ // 上
	    this.x = x + 8;
	    this.y = y - 8;
	    this.by = this.y;
	    if(type == 1) this.frame = 56;     //charaの弾
	    if(type == 2) this.frame = 48;     //敵の弾
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

	//画像を指定し表示
	this.image = game.assets['img/icon0.png'];
	scene.addChild(this);
    },
    onenterframe: function(){
	//障害物に弾が当たったらエフェクトを出し消す
	for(var j = 0; j < 30; j++){	
	    if(this.intersect(obstacles[j])){
		hitEffect(this.x, this.y);
		scene.removeChild(this);
	    }
	}

	//弾を一定距離進め、消す
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

	//キャラへの当たり判定
	if(this.intersect(chara) && this.hit_chara == 0 && this.type == 2){
	    this.hit_chara++;
	    hitEffect(this.x, this.y);
	    myHp--;
	    scene.removeChild(this);	    
	}

	//敵への当たり判定
	for(var i = 0; i < 3; i++){
	    if(this.intersect(enemies[i]) && this.hit_enemy == 0 && this.type == 1 && enemies[i].alive == 1){
		this.hit_enemy++;
		hitEffect(this.x, this.y);
		enemies[i].hp--;
		scene.removeChild(this);
	    }
	}
    }	
});


//障害物クラス
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

//体力クラス
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

//弾が戦車や障害物に当たったときのエフェクト
var hitEffect = function(x, y){
    var effect = new Sprite(16, 16);
    var i = 0;
    effect.image = game.assets['img/effect0.png'];
    effect.x = x + 8;
    effect.y = y + 8;
    effect.frame = 0;
    scene.addChild(effect);

    //爆発に見せるため1フレームごとに表示画像を変える
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
