// === マスを表すクラス ===
class Cell {
  int x, y;       // 座標（中心）
  char key;       // 対応キー
  int kigou = 0;  // 0=なし,1=○,2=×
  int count = 0;  // 残りターン数
  /* === Cellクラスのコンストラクタ(整数型の座標x,y、文字型の"押されたキー"によって構成される) === */
  Cell(int x, int y, char key) {
    /* === this."変数"を使うとローカル変数扱いとなる。(同じ文字が使える) === */
    this.x = x;//座標xの記憶
    this.y = y;//座標yの記憶
    this.key = key;//押されたキーの記憶
  }
  /* === 記号を置き、消えるまでのターンカウントを設定 === */
  void put(boolean maruTurn) {
    if (kigou != 0) return;   // 既に置かれていたら無視
    kigou = maruTurn ? 1 : 2;//今のターンが〇(maruTurn = ture)ならば1を、×(maruTurn = false)ならば2をkigouに代入
    count = 6;//ターンカウントを6に設定(これによって4個目の自分の記号が置かれた際に一番古い自分の記号は消去される)
  }
  /* === カウントダウンとそれがゼロになった際の初期化設定 === */
  void tick() {
    effect.rewind();  // 音を巻き戻す
    effect.play();  //音鳴らす
    /* === countが0出ないのなら走る === */
    if (kigou != 0) {
      count--;//count = count - 1と同意
      /* === countが0以下なら(4個目の自分の記号が置かれたなら)走る === */
      if (count <= 0) {
        kigou = 0;//マスにおいてある記号の初期化
        count = 0;//countの初期化
      }
    }
  }
  /* === 升目の描写プログラム(毎フレームごとに走る) === */
  void draw() {
    /* === 升目の設定 === */
    fill(255);//背景白
    stroke(0);//線黒
    strokeWeight(1);//線の細さの設定
    rect(x, y, 100, 100);//どこに置くかとそのマス目の大きさ

    /* === 升目に置くキー名の設定 === */
    fill(0);//黒に設定
    text(str(key).toUpperCase(), x-10, y+40);//升目に対応するキー名を描写

    /* === 記号描写の設定 === */
    if (kigou == 1) { // ○
      noFill();//色で埋めない
      stroke(0);//縁を黒に
      strokeWeight(3);//線を太めに
      ellipse(x, y, 50, 50);//置く位置とその大きさ
    } else if (kigou == 2) { // ×
      stroke(0);//線を黒に
      strokeWeight(3);//線を太めに
      /* === ×の描写 === */
      line(x-25, y-25, x+25, y+25);
      line(x-25, y+25, x+25, y-25);
    }

    strokeWeight(1);//線の太さを戻す(これをしないと以降ずっと太いままになる)

    /* === カウントが1になった(次の描写で記号が消える)時の警告プログラム === */
    if (count == 1) {
      fill(255,0,0);//赤で埋める
      text(str(key).toUpperCase(), x-10, y+40);//文字を赤に
      fill(0);//黒に戻す(これがないと以降ずっと赤色になる)
    }
  }
}
