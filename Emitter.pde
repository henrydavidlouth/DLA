class Emitter {
  PVector loc;
  PVector vel;
  
  float rad;

  Emitter(PVector _loc, float _rad) {
  
    loc=_loc;
    rad=_rad;
    
    init();
    
  }

void run(){
  update();
  
  if (debug){
    display();
  }
}


void init(){
  salts = new ArrayList<Salt>();
  for (int i=0; i<sNum; i++) {
    salt = new Salt(new PVector(random (-rad,rad), random (-rad,rad), random (-(maxZ+zBuffer),maxZ+zBuffer)));
    salts.add(salt);
  }

}
void update(){


}


void display(){
//strokeWeight(30);
//stroke(0,0,0);
//point(loc.x,loc.y,loc.z);
   
  //line
    translate(0,0,maxZ+zBuffer); 
strokeWeight(1);
stroke(150,150,150);
box(rad*2, rad*2, 0);
//fill();
   
  

}
}
