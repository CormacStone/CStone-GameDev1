class Map {
  int[][] map;
  int cellSize = 10;
  int rows;
  int cols;

  Map() {
    rows = height / cellSize;
    cols = width / cellSize;
    map = new int[cols][rows];
  
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (i<cols-10 && j<rows -10) {
          map[i][j] = 1;
        } else if (i<cols && j>=rows-10) {
          map[i][j] = 3;
        }
      }
    }
  }

  void drawMap() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        fill(50);
        if (map[i][j] == 1) {
          fill(0, 150, 255);
        }
        if (map[i][j] == 2) {
          fill(255, 0, 0);
        }
        if (map[i][j] == 3) {
          fill(0, 255, 0);
        }
        if (map[i][j] == 4) {
          fill(255, 255, 255);
        }
        square(i * cellSize, j * cellSize, cellSize);
      }
    }
  }
}
