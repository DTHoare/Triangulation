class Triangle {
  Point p1, p2, p3;
  int points = 0;
  
  Triangle(Point p1_, Point p2_, Point p3_){
    this.addPoint(p1_);
    this.addPoint(p2_);
    this.addPoint(p3_);
  }
  
  //base init
  Triangle(){
    
  }
  
   //add points with counter
  void addPoint(Point p){
    points += 1;
    p.connections += 1;
    if(p1 == null) p1=p;
    else if(p2 == null) p2=p;
    else if(p3 == null) p3=p;
    else {
      //remove counter increments if add failed
      points -= 1;
      p.connections -= 1;
    }
  }
  
  void display(color col_){
    stroke(col_);
    triangle(p1.pos.x, p1.pos.y, p2.pos.x, p2.pos.y, p3.pos.x, p3.pos.y);
  }
}