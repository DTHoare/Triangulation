class Point implements Comparable<Point>{
  PVector pos;
  int connections = 0;
  int size = 15;
  
  Point(float x_, float y_){
    pos = new PVector((int)x_, (int)y_);
  }
  
  void display(color col){
    fill(col);
    ellipse(pos.x, pos.y, size, size);
  }
  
  //pure random repositioning
  void randomise(){
    pos.x = (int)random(0, width);
    pos.y = (int)random(0, height);
  }
  
  //reposition using perlin noise
  void randomise(float t){
    pos.x = (int)map(noise(t), 0, 1, 0, width);
    pos.y = (int)map(noise(t+1), 0, 1, 0, height);
  }
  
  //include a comparison in order to list in order for triangulation
  //allows for listing points by horizontal position
  int compareTo(Point p){
    if(p.pos.x > this.pos.x) return 1;
    else if(p.pos.x < this.pos.x) return -1;
    //equal x
    else if(p.pos.x == this.pos.x) {
      if(p.pos.y > this.pos.y) return 1;
      else if(p.pos.y < this.pos.y) return -1;
      else return 0;
    }
    //identical
    else return 0;
  }
}