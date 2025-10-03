import controlP5.*; // GUIライブラリControlP5をインポート（ボタン作成などに使う）
ControlP5 cp5; // ControlP5のインスタンス変数を宣言

int[] mousecolor = {0, 0, 0}; // マウスで描く色の配列
int size = 10; // ペンの太さ
boolean drawing = false; // 現在描画中かどうかのフラグ

// 描画履歴を保存するリスト
ArrayList<Stroke> strokes = new ArrayList<Stroke>();
Stroke currentStroke; // 現在描画中のストローク（1本の線）

void setup() {
  size(1000, 400); // ウィンドウサイズを横1000, 縦400に設定
  background(255); // 背景を白で塗りつぶす
  /* ==== ボタン設定 ==== */
  cp5 = new ControlP5(this); // ControlP5の初期化
  cp5.addButton("RESET") // RESETボタンを追加
     .setPosition(500,100) // ボタンの位置
     .setSize(100, 30) // ボタンのサイズ
     .setLabel("reset"); // 表示ラベル（小文字）

  cp5.addButton("UNDO") // UNDOボタンを追加
     .setPosition(500,140) // ボタンの位置
     .setSize(100,30) // ボタンのサイズ
     .setLabel("undo"); // 表示ラベル
}

void draw() {
  // 左側（描画領域）を毎フレーム白で塗り直す（400×400のエリア）
  noStroke();
  fill(255);
  rect(0, 0, 400, 400);

  // 過去に描いたストロークをすべて描画
  for (Stroke s : strokes) {
    s.display();
  }
  // 今描いている途中のストロークも表示
  if (drawing && currentStroke != null) {
    currentStroke.display();
  }

  /* === 右側のパレット表示 === */
  stroke(0); // 枠線の色
  strokeWeight(1); // 枠線の太さ
  fill(255); // 塗り白
  rect(height,-1,width - height + 1,height + 1); // パレット領域を描画
 /* ==== ペンサイズを設定するための三角形 ====*/
  fill(mousecolor[0],mousecolor[1],mousecolor[2]);
  triangle(950,325,950,350,750,337);

  // 色選択のバーを描画（R/G/B/Grayの4本）
  noStroke();
  for(int i = 0 ; i <= 255 ; i++){
    fill(0,0,i); rect(850,300-i,50,1); // Blue
    fill(0,i,0); rect(800,300-i,50,1); // Green
    fill(i,0,0); rect(750,300-i,50,1); // Red
    fill(i);     rect(900,300-i,50,1); // Gray
  }

  // ペンのプレビュー（円で表示）
  noStroke();
  fill(mousecolor[0],mousecolor[1],mousecolor[2]);
  ellipse(550,200,size,size);

  // 情報テキストの表示
  textSize(24);
  fill(0);
  text("preview",450,205); // プレビューラベル
  text("X:" + mouseX ,500,300); // マウスのX座標
  text("Y:" + mouseY ,500,320); // マウスのY座標
  text("mousecolor[0]:" + mousecolor[0] ,500,340); // R
  text("mousecolor[1]:" + mousecolor[1] ,500,360); // G
  text("mousecolor[2]:" + mousecolor[2] ,500,380); // B
  text("size" + size ,500,400); // ペンサイズ
}

void mousePressed() {
  // 左の描画エリア内でマウスを押したら描画開始
  if (mouseX < 400 && mouseY < 400) {
    drawing = true; // 描画中フラグON
    currentStroke = new Stroke(mousecolor[0], mousecolor[1], mousecolor[2], size); // 新しいストロークを作成
  }
}

void mouseDragged() {
  // ドラッグ中に線を追加
  if (drawing && currentStroke != null) {
    currentStroke.addSegment(pmouseX, pmouseY, mouseX, mouseY); // 1区間追加
  }
}

void mouseReleased() {
  // マウスを離したとき、描画中ならストロークを保存
  if (drawing && currentStroke != null) {
    strokes.add(currentStroke); // 完成したストロークを履歴に追加
    currentStroke = null; // 現在のストロークをリセット
  }

  // 色選択バーがクリックされたときの処理
  if ((750 <= mouseX && mouseX <= 1000) && (45 <= mouseY && mouseY < 300)) {
    if ((750 <= mouseX && mouseX < 800) && (45 <= mouseY && mouseY < 300)) {
      mousecolor[0] = 300 - mouseY; // 赤成分を決定
    }
    if ((800 <= mouseX && mouseX < 850) && (45 <= mouseY && mouseY < 300)) {
      mousecolor[1] = 300 - mouseY; // 緑成分を決定
    }
    if ((850 <= mouseX && mouseX < 900) && (45 <= mouseY && mouseY < 300)) {
      mousecolor[2] = 300 - mouseY; // 青成分を決定
    }
    if ((900 <= mouseX && mouseX < 950) && (45 <= mouseY && mouseY < 300)) {
      for(int i = 0 ; i < 3 ; i++ ){
        mousecolor[i] = 300 - mouseY; // グレーバーならRGBすべて同じ値に
      }
    }
  }

  // ペンサイズ調整バー（三角形領域）
  if ((750 <= mouseX && mouseX <= 950) && (325 <= mouseY && mouseY < 350)) {
    size = (mouseX - 750)/10; // マウス位置に応じてサイズ変更
  } 

  drawing = false; // 描画終了
}

// RESETボタン押下時の処理
void RESET() {
  strokes.clear(); // 描画履歴をすべて削除（左キャンバスをクリア）
}

// UNDOボタン押下時の処理
void UNDO() {
  if (strokes.size() > 0) {
    strokes.remove(strokes.size()-1); // 最後に描いたストロークだけ消去
  }
}
/*
絵を描くプログラム。
一つ戻る処理のために描写したものの履歴をリストに突っ込んで記録している。
この機能がなければこんな複雑にはならない。
*/

