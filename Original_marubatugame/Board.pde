// === 盤面を表すクラス ===
class Board {
  Cell[] cells = new Cell[9];//Cellクラスの配列を作る(用意する領域は9)
  /* === 勝利判定の二次元配列(それぞれの升目に0～8までの数字を割り振り、それを羅列) === */
  int[][] lines = {
    {0,1,2},{3,4,5},{6,7,8},
    {0,3,6},{1,4,7},{2,5,8},
    {0,4,8},{2,4,6}
  };
  /* === Boardクラスのコンストラクタ(引数なし) === */
  Board() {
    char[] keys = {'q','w','e','a','s','d','z','x','c'};//文字型の配列でそれぞれの升目に割り振られるキーの羅列
    int[] xs = {50,150,250, 50,150,250, 50,150,250};//整数型の配列でそれぞれの升目のx座標の羅列
    int[] ys = {50, 50, 50,150,150,150,250,250,250};//整数型の配列でそれぞれの升目のy座標を羅列
    /* === 上3つで上げたそれぞれの情報をCellクラスのコンストラクタに代入 === */
    for (int i=0; i<9; i++) {
      cells[i] = new Cell(xs[i], ys[i], keys[i]);//cells変数は配列であるため、九つの情報を記憶できる
    }
  }
  /* === for (Cell c : cells)は配列やリストの中身を先頭から順番に取り出すプログラムfor-each構文と呼ばれる === */
  /*
  for (int i = 0; i < cells.length; i++) {
  Cell c = cells[i];
  }
  これと同意
  */
  /* === キーが押されたときに対応するキーがあるかどうかの探索プログラム === */
  Cell getCellByKey(char k) {
    for (Cell c : cells) if (c.key == k) return c;//見つけたらそれを返却
    return null;//無かったらnullを返却
  }
  /* === すべてのCellに対してtickプログラム(countを進め、countが0以下になったら対応する記号の情報を消すプログラム)を呼ぶ === */
  void tickAll() {
    for (Cell c : cells) c.tick();
  }
  /* === すべてのCellのdrawプログラムを呼んでいる === */
  void draw() {
    for (Cell c : cells) c.draw();
  }
  /* === 勝者の判定プログラム === */
  int checkWinner() {
    /* === line[]の各組に対して勝利条件lines[]がそろっていいるかどうかのチェック === */
    for (int[] line : lines) {
      int a = cells[line[0]].kigou;//始めに勝ち筋の先頭の升目に何か記号が入っているかどうかをチェックする
      if (a!=0 && a==cells[line[1]].kigou && a==cells[line[2]].kigou) {  //もし、勝ち筋の一番初めの升目に何か記号が入っていたら(a != 0)なら二つ目、三つ目の升目も見て、それが一番初めの記号(a)と同じなら、a(1or2)を返す
        return a;
      }
    }
    return 0;//無かった場合0を返す(何も変わんない)
  }
  /* === リセットプログラム(すべてのCellに対して、記号とcountを0にしている) === */
  void reset() {
    for (Cell c : cells) {
      c.kigou = 0;
      c.count = 0;
    }
  }
}
