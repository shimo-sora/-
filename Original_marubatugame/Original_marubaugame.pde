import ddf.minim.*;  // Minimライブラリをインポート
/* === グローバル変数 === */
Board board;//Bordのインスタンス変数を宣言
boolean maruTurn = true;//ターン判別
boolean win = false;//勝敗判定
int winner = 0;//勝者判定(〇 = 1,× = 2,)
Minim minim;//Minimのインスタンス変数を宣言
AudioPlayer win_sound,effect,start;//クラス"AudioPlayer"の変数三つ
/* === セットアップ(一回だけ走る) === */
void setup() {
  size(300,300);//画面サイズ設定
  textSize(20);//フォントサイズ設定
  rectMode(CENTER);//座標の基準が中心になる。座標指定がやりやすくなる。
  board = new Board();//盤面の準備
  minim = new Minim(this);//音準備
  win_sound = minim.loadFile("win_sound.mp3");//win_soundのファイル指定 
  effect = minim.loadFile("effect.mp3"); //effectのファイル指定
  start = minim.loadFile("start.mp3"); //startのファイル指定
  start.play();//startを鳴らす
}
/* === drawプログラム(毎フレームごとに走る) === */
void draw() {
  background(255);//背景色の設定
  board.draw();//マスを描く(Bordクラスのdraw参照)
  /* === 勝敗が決されたかどうかを判断するプログラム(win = falseの時に走る) === */
  if (!win) {
    int result = board.checkWinner();//勝敗判定。〇の勝ちなら1を、×の勝ちなら2を返却する。(Boardクラスのcheckwinner参照)
    /* === 勝敗が決されていた場合に走る === */
    if (result != 0) {
      win = true;//勝利判定変数をtrueに
      winner = result; // 勝者を記録
      win_sound.rewind();  // 音を巻き戻す
      win_sound.play();  //音鳴らす
    }
  }

  /* === 勝利画面を表示するプログラム(win = trueの時に走る) === */
  if (win) {
    fill(255,0,0);//表示するものを赤に
    textSize(75);//テキストサイズの設定
    text("finish!!",50,200);//表示内容及び表示場所
    textSize(20);//テキストサイズを元の大きさに戻す(これをしないと次から表示されるテキストが永遠にでかいままになる)
    text("Reset with 'R'",100,250);//リセット方法の案内
  }
}
/* === キーが押されたときに走るプログラム === */
void keyPressed() {
  /* === 勝敗が決されていない(win = false)時にキーが押されたときに記号ごとを置くプログラム === */
  if (!win) {
    Cell target = board.getCellByKey(key);//Cellクラスの変数targetに押されたキーお覚えさせておく(BordクラスのgetCellByKey参照)
    /* === 該当セルが存在し、空であるなら走る === */
    if (target != null && target.kigou==0) {
      board.tickAll();  // ターンが進んだらカウントを進める
      target.put(maruTurn);//ターンに合わせた(〇or×)記号を置く
      maruTurn = !maruTurn;//ターンの譲渡
    }
  }
  /* === 勝敗が決された(win = true)の時にrキーを押された場合のみリセットするプログラム === */
  else {
    if (key == 'r') {
      board.reset();//リセットを行う(Boardクラスのreset参照)
      maruTurn = true;//ターンを初期化
      win = false;//勝敗判定を初期化
      winner = 0;//勝者の記録を初期化
      start.rewind();  // 音を巻き戻す
      start.play();  //音鳴らす
    }
  }
}

