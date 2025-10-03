class Segment {
  float x1, y1, x2, y2; // 線分の始点(x1,y1)と終点(x2,y2)の座標を保持する変数

  // コンストラクタ：線分を作るときに座標を受け取って代入する
  Segment(float x1, float y1, float x2, float y2) {
    this.x1 = x1; // 引数x1をフィールドx1に代入（始点X座標）
    this.y1 = y1; // 引数y1をフィールドy1に代入（始点Y座標）
    this.x2 = x2; // 引数x2をフィールドx2に代入（終点X座標）
    this.y2 = y2; // 引数y2をフィールドy2に代入（終点Y座標）
  }
}
