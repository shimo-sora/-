class Stroke {
  // 1本のストロークを構成する「線分（Segment）」を順番に保存するリスト
  ArrayList<Segment> segments = new ArrayList<Segment>();

  // このストロークの色情報（RGB）
  int r, g, b;

  // このストロークの線の太さ
  float w;
  
  // コンストラクタ：色(r,g,b)と太さwを指定して新しいストロークを作成する
  Stroke(int r, int g, int b, float w) {
    this.r = r;   // 赤成分
    this.g = g;   // 緑成分
    this.b = b;   // 青成分
    this.w = w;   // 線の太さ
  }
  
  // 線分を追加するメソッド
  void addSegment(float x1, float y1, float x2, float y2) {
    segments.add(new Segment(x1, y1, x2, y2)); // 新しいSegmentを作ってリストに入れる
  }
  
  // このストロークを画面に描画するメソッド
  void display() {
    stroke(r, g, b);     // ペンの色をセット
    strokeWeight(w);     // ペンの太さをセット
    // 含まれているすべての線分を順番に描画する
    for (Segment s : segments) {
      line(s.x1, s.y1, s.x2, s.y2);
    }
  }
}
