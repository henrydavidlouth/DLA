class Seed {
  PVector location;
  PVector xnectLoc;
  int cnt=0;
  int r=255;
  int g=255;
  int b= 255 ;

  Seed(PVector l) {
    location = l.get();
    xnectLoc = location;
    
  }

  void run() {
   cnt++;
  //if (cnt % 1 == 0){
    r--;
  g--;
  b--;
  if(r<51){r=51;}
   if(g<102){g=102;}
    if(b<126){b=126;}
  //}
  
  
  
  
    display3D();
  }
  PVector lookUp(){
  return location;
}
 
  
 //method to move the bounding box upward
void bboxUpdate (){
if (location.z>maxZ){
maxZ=location.z;
}

if(location.z>minZ && cnt==2*255){
minZ=location.z;
}
} 

void xnect(PVector _loc){
xnectLoc = _loc;

}

  // Method to display
  void display2D() {
     strokeWeight(2);
    stroke(150,150,150);
    line(location.x,location.y,location.z,xnectLoc.x,xnectLoc.y,xnectLoc.z); 
    strokeWeight(6);
    //magenta
    
    stroke(143,55,143);
    //fill(0,0,255);
    point(location.x,location.y,location.z);
    //float scl = map (cnt, 0,500, 0,10);
   
  }
  
   void display3D() {
    noStroke();
    sphereDetail(4, 4);
//ambientLight(128, 128, 128);
//stroke(255,0,0,150);
    pushMatrix();
    translate(location.x, location.y, location.z);
    specular(r, g, b);
   sphereDetail(10);
   sphere(5);
   
    popMatrix();
//strokeWeight(10);
//stroke(0,0,0,75);
//point(location.x, location.y, location.z);

  }
 
}
 

