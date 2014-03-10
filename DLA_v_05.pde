import peasy.*;
import controlP5.*;
PeasyCam cam;
ControlP5 controlP5;


//v01 brownian motion
//02 gravity motion
//03 salt added back to the system when removed
//04 added debug settings and keypress options; added export keypress
//05 rotation of all the salts to create a helix

//continer (if out or in)
//emitter (gravity rotation)

//**NOTES
//if you DO NOT replace the salt translated above where it died, 
//then you will get a dead spot above the seeds which leads to fanlike growths

Salt salt, salty;
Seed seed;
Emitter emitter;

int dNum=1;
float gravity = -1;
float rad = 200;
int sNum=4000;
float maxZ,minZ=0;
float oscScl=1.00;
//buffer for SNAP of seeds if you DECREASE this 
//you have to increase the frequency of salt in the system
float maxRadius = 12; //should be 8ish

float zBuffer=300;

boolean debug=false;
boolean export=false;


PVector v1; //salt
PVector v2; //seed instanaeous


ArrayList<Salt> salts;
ArrayList<Seed> seeds;
ArrayList<Seed> seedsDorm;
int cntr=0;

// -------------------------- EXPORTER WRITER
PrintWriter OUTPUT;       // an instantiation of the JAVA PrintWriter object.

void setup()
{
  size(700, 900, OPENGL); 

  //CAMERA AT PERSPECTIVE
  cam = new PeasyCam(this, 0, 0, 1000, 2000);
  //cam.rotateZ(radians(-215));  // rotate around the z-axis passing through the subject
  cam.rotateX(radians(-75));  // rotate around the x-axis passing through the subject
  //cam.rotateY(radians(-0));  // rotate around the y-axis passing through the subject

  
  cam.setMinimumDistance( 0.001 );
  cam.setMaximumDistance(  32 * ( 1000) );
//  cam.setRotations(-1.0064192, 0.42937258, -0.32981357);

 emitter = new Emitter(new PVector(0, 0, zBuffer), rad );

  

  seeds = new ArrayList<Seed>();

  seed = new Seed(new PVector(0, 0, 0));
  seeds.add(seed);

seedsDorm = new ArrayList<Seed>();

}

void draw()
{

  //lights();
  //directionalLight(100, 100, 100, 0, 0, -1);
  //directionalLight(100, 100, 100, 0, 0, 1);
  //ambientLight(255, 255, 255);
  //lightSpecular(255, 255, 255)
  lightSpecular(255, 255, 255);
  directionalLight(51, 102, 126, 0, -1, 0);
  //directionalLight(255, 255, 255, 0, -1, 0);

  background(255);

 //rotate the solution space 
// rotateZ(frameCount/720.0);


  for (int i = 0; i < seeds.size(); i++) {
    Seed seed = seeds.get(i);
    v2= seed.lookUp();
    int cn = seed.cnt;

    for (int j =0; j< salts.size(); j++) {
      Salt salt = salts.get(j);
      v1= salt.lookUp();
      float d = PVector.dist(v1, v2);
      
      if (d<maxRadius) {
        seed = new Seed(new PVector(v1.x, v1.y, v1.z));
        seeds.add(seed);
        salts.remove(j);
        seed.xnect(v2);
        //
        salty = new Salt(new PVector(v1.x, v1.y, maxZ+zBuffer));
        salts.add(salty);
      }
    }


    seed.run();
    seed.bboxUpdate();

    //cap the seeds that  are running the simulation based upon lifespan  
        if (cn>=255){
            seedsDorm.add(seed);
            seeds.remove(seed);
            
          }
  }

  for (int i = 0; i < salts.size(); i++) {
    Salt salt = salts.get(i);
    salt.run();
    if (debug){
      salt.display();
  }
}

  for (int i = 0; i < seedsDorm.size(); i++) {
    Seed seed = seedsDorm.get(i);
     if (debug){
      seed.display3D();
     }
     else{seed.display2D();
     }
  }
  
  
 emitter.run();


  //EXPORT FRAMES
  //at 30frames per min 900 yileds 30sec clip mov 10 for setup cam 20 for still
  //every 15 sec rough equals full "x" direction; so wait 15 seconds for a transition; at 30 frames a sec==450 frames wait time...
  //      cntr++;
       if (export){
        if (frameCount % 5 == 0){
          
        saveFrame(frameCount+".png"); 
  ////      cntr=0;
        
        }
        
      if (frameCount % 250 == 0) { 
         OUTPUT = createWriter(frameCount+".txt");          //file name
      for (int i = 0; i < seeds.size(); i++) {
        Seed seed = seeds.get(i);
      v2= seed.lookUp();
      
          OUTPUT.println(v2.x+","+ v2.y+","+ v2.z);
       
      }
      OUTPUT.flush();
      OUTPUT.close();
  //    println("points have been exported"); //verification indicator
  //      
  //      
  //      
        }
       }
}


//if distance between seed and salt < maxRadius then 
//add salt to seed list
//remove from salt list


public void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
  
    if (key == 'f') {
    export = !export;
  }

}


