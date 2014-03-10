class Salt {
  PVector location;
  PVector velocity;
  
  //variables for the helix methiod;
  float xx, yy;
  float angle;
  
  //helix oscillation stufffs
int tCycle =360*6;
int rcount=0;


  Salt(PVector l) {
    velocity = new PVector(random(-.5,.5),random(-.5,.5), random(-.5,.5));
    //velocity = new PVector(random(-2,2),random(-2,2), random(-2,2));
    location = l.get();
  }


  void run() {
    bound();
    update();
    helix();
//    display();
  }

PVector lookUp(){
  return location;
}

//PVector lookUpClosest(){
//  ArrayList<float> dists;
//  for (int i = 0; i < seeds.size(); i++) {
//    Seed seed = seeds.get(i);
//    PVector v1= salt.lookUp();
//    PVector v2= seed.lookUp();
//    float d = PVector.dist(v1, v2);
//    dists.add(d);
//  
//  
//  return location;
//
//}

  // Method to update location
  void update() {
    //brownian
    location.add(new PVector(random(-5,5),random(-5,5), random(-5,5)));
     //gravity
    location.add(new PVector(0,0, random(2*gravity,1*gravity)));
  }
  
 void bound(){
   
   if(location.z<minZ){
     location.add(new PVector(0,0,(maxZ+zBuffer)));
   }
 if(abs(location.x)>rad || abs(location.y)>rad){
     location = new PVector(random (-rad,rad),random (-rad,rad),(maxZ+zBuffer));
   }
 
 }
   
 
   void helix(){
  float ratioX = cos(4*PI*rcount/tCycle);
 float ratioY = sin(4*PI*rcount/tCycle); 
  //println(ratio);
  rcount++;
  if (rcount==tCycle-1) {
    rcount =0;
  }
  
  
    location.add(new PVector(oscScl*ratioX,oscScl*ratioY, 0));
  
    //radial config
    //get polar location
//    float rad=sqrt(sq(location.x)+sq(location.y));
//    angle=atan(location.y/location.x);
//
//    location.x = sin(angle) * 1*rad;
//    location.y = cos(angle) * 1*rad; 
//     
   }
  

  // Method to display
  void display() {
    strokeWeight(8);
    stroke(0);
    //fill(0);
    point(location.x,location.y,location.z);
    
   
  }
  
  void display3D() {
    noStroke();
//lights();
stroke(75,75,0,150);
    pushMatrix();
    translate(location.x, location.y, location.z);
   sphere(5);
    popMatrix();

  }
 
}
