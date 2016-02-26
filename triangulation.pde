//Some attempts to learn about triangulation.
//Daniel Hoare 2016

//Arrays
ArrayList<Point> points;
ArrayList<Triangle> triangles;

void setup(){
  size(500,500);
  ellipseMode(CENTER);
  frameRate(20);
  strokeWeight(3.5);
  
  //inits
  triangles = new ArrayList<Triangle>();
  points = new ArrayList<Point>();
  
  //generate points with initial positions
  for(int i = 0; i < 12; i++) {
      Point point = new Point(random(0,width), random(0,height));
      points.add(point);
  }
  
  //order horizontally
  java.util.Collections.sort(points);
}

void draw() {
  background(0);
  
  //move points with perlin noise for smoothness
  for(Point point:points){
    point.randomise(0.01*(frameCount)+1*points.indexOf(point));
  }
  
  //sort and retriangulate
  java.util.Collections.sort(points);
  triangles.clear();
  resetPoints(points);
  triangulate(points, triangles);
  
  //display the points
  noStroke();
  for(Point point:points){
    //fade colour by order in array - useful for debugging ordering
    color col = (int) map(points.indexOf(point),0,points.size(),55,255);
    point.display(col);
  }
  
  //display the triangles
  stroke(255,0,0);
  noFill();
  for(Triangle triangle:triangles) {
    int R = (int) map(triangles.indexOf(triangle),0,points.size(),55,255);
    color col = color(R, 0, 0);
    triangle.display(col);
  }
  
  //for animtions
  //saveFrame("image_###.png");
}

//uses an incremental basic triangulation, creating a set of triangles from points
void triangulate(ArrayList<Point> points, ArrayList<Triangle> triangles){
  Triangle triangle;
  //make first triangle from first 3 points
  triangle = new Triangle(points.get(0), points.get(1), points.get(2));
  triangles.add(triangle);
  
  //iterate from after these 3 points
  for( int i = 3; i < points.size(); i++) {
    //don't cluster points too much
    if(points.get(i).connections < 2 ) {
      triangle = new Triangle();
      triangle.addPoint(points.get(i));
      //grab the two nearest points to form a triangle
      while(triangle.points <3) {
        
        for(int j = i-1; j >0; j--) {   
          
          //don't make vertical lines - with many points closest points have the same x position
          if(points.get(i).pos.x != points.get(j).pos.x) {
            triangle.addPoint(points.get(j));
          }
          
        }
      }
      triangles.add(triangle);
    }
    
  }
}

void resetPoints(ArrayList<Point> points) {
  for(Point point:points){
    point.connections=0;
  }
}