// live video libraries
import processing.video.*;

// AR library - find the 'NyAR4psg' folder that came with today's downloadable
// code package and put it into the 'libraries' folder of your Processing sketchbook
import jp.nyatla.nyar4psg.*;

// video object
Capture video;

// AR marker object - this keeps track of all of the patterns you wish to look for
MultiMarker augmentedRealityMarkers;

//car object
Car playerA;
Car playerB;

//board object
Board theBoard;

//create barrier
Barrier theBarrier;

Power[] thePower = new Power[3];
Spin[] theSpin = new Spin[3];



boolean thisSwitch = true; 

//race track image
PImage background; 

// rotation value for spinning our pikachus
int angle = 0;
int state; 

int extra = 0; 


void setup() 
{
  // make sure to render your sketch using a 3D renderer.  OPENGL or P3D will both work.
  size(640, 480, OPENGL);
  smooth();
  
  String[] cameras = Capture.list();
  
  //no camera objects - no need to continue! 
  if ( cameras.length == 0 )
  {
    println("there are no cameras");
    exit();
  }
  else 
  {

    // The camera can be initialized directly using an element
    // from the array returned by list() - this will access the camera
    // using its default width and height
    video = new Capture(this, cameras[0]);

    // Or, the settings can be defined based on the text in the list
    //video = new Capture(this, 640, 480, "Built-in iSight", 30);

    // Or, you can just ask the Camera object to open up the last 
    // used camera based on your system's Quicktime preferences
    //video = new Capture(this, 640, 480);

    // Start capturing the images from the camera
    video.start();
  
  }
  
  
  // create a new AR marker object
  // note that "camera_para.dat" has to be in the data folder of your sketch
  // this is used to correct for distortions in your webcam
  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);

  // attach the pattern you wish to track to this marker.  this file also needs to be in the data folder
  // 80 is the width of the pattern
  augmentedRealityMarkers.addARMarker("patt.hiro", 80);
  
  playerB = new Car(-250, 0, 0);
  playerA = new Car(-270, 0, 0);

  theBarrier = new Barrier(50,0,0); 
  
  // 3 power ups and spin ups 
  thePower[0] = new Power(100,100,20);
  theSpin[0] = new Spin ( 150,150, 0);
  
  thePower[1] = new Power(-10,-27,20);
  theSpin[1] = new Spin( -170,-141, 0);
  
  
  thePower[2] = new Power(154,-3,20);
  theSpin[2] = new Spin (-72,127,0);
  
  background = loadImage("racetrack.png");
}

void draw()
{  
  
  if(state == 0)
  {
    background(0,255,0);
    fill(100,100,100);
    text("Welcome to the game",200,200);
    if (keyPressed)
    {
      state = 3; 
    }
  }
  else if ( state == 1)
  {
    background(31,182,20);
    fill(100,100,100);
    text("player A wins!", 200,200);
    if (mousePressed)
    {
      state = 0; 
      playerB = new Car(-250, 0, 0);
      playerA = new Car(-270, 0, 0);
    }
  }
  else if (state == 2)
  {
     background(31,182,20);
     fill(100,100,100);
     text("player B wins!", 200,200);
    if (mousePressed)
    {
      state = 0; 
      playerB = new Car(-250, 0, 0);
      playerA = new Car(-270, 0, 0);
    }
  }
  else 
  {

    // we only really want to do something if there is fresh data from the camera waiting for us
    if (video.available())
    {
      
     
      //update score 
      playerA.keepScore(); 
      playerA.winGame(); 
      playerB.keepScore(); 
      playerB.winGame(); 
      // read in the video frame and display it
      video.read();
      imageMode(CORNER);
      image(video, 0, 0);
      
      // DRAW ON TOP OF VIDEO
      hint(DISABLE_DEPTH_TEST);
  
      // GO RIGHT BACK INTO DRAWING IN 3D
      hint(ENABLE_DEPTH_TEST);
  
      // ask the AR marker object to attempt to find our patterns in the incoming video stream
      augmentedRealityMarkers.detect(video);
  
      // if they exists then we will be given information about their location
      // note that we only have one pattern that we are looking for, so it will be pattern 0
      if (augmentedRealityMarkers.isExistMarker(0))
      {
        // set the AR perspective
        augmentedRealityMarkers.setARPerspective();
        
        // next, remember the current transformation matrix
        pushMatrix();
  
        // change the transformation matrix so that we are now drawing in 3D space on top of the marker
        setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));
  
        // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
        // then the x & y axis will be flipped)     
        scale(-1, -1);
  
        // player A
        if (keyPressed && key == CODED )
        {
          if (keyCode == RIGHT)
          {
          playerA.moveRight();
          }
          if (keyCode == LEFT)
          {
          playerA.moveLeft();
          }
        }
        
        // Player B
        if (keyPressed && key == CODED )
        {
          if (keyCode == DOWN)
          {
          playerB.moveRight();
          }
          if (keyCode == UP)
          {
          playerB.moveLeft();
          }
          if (key == 'n')
          {
            playerA.carReverse(); 
          }
        }
       
        if (keyPressed && key == 'w' )
        {
             playerB.move(); 
        }
        if (keyPressed && key == 's' )
        {
          playerB.carReverse();
        }
        playerA.display();
        playerB.display();

   
        // power up detects if it hits player 
        thePower[0].powerUp(playerA.xPos,playerA.yPos,playerA.zPos, playerA);
        thePower[0].powerUp(playerB.xPos,playerB.yPos,playerB.zPos, playerB);
        thePower[0].display();
        
        // spin detects if it hits the player 
        theSpin[1].spinUp(playerA.xPos,playerA.yPos,playerA.zPos, playerA);
        theSpin[1].spinUp(playerA.xPos,playerA.yPos,playerA.zPos, playerB);
        theSpin[1].display();
        
        extra++;  
        
        if ( extra > 100 )
        {
          // power up detects if it hits player 
          thePower[2].powerUp(playerA.xPos,playerA.yPos,playerA.zPos, playerA);
          thePower[2].powerUp(playerB.xPos,playerB.yPos,playerB.zPos, playerB);
          thePower[2].display();
        }
        
        else if ( extra > 150 )
        {
          // spin detects if it hits the player 
          theSpin[2].spinUp(playerA.xPos,playerA.yPos,playerA.zPos, playerA);
          theSpin[2].spinUp(playerA.xPos,playerA.yPos,playerA.zPos, playerB);
          theSpin[2].display();
        
        }
        else if (extra > 200)
        {         
          // power up detects if it hits player 
          thePower[3].powerUp(playerA.xPos,playerA.yPos,playerA.zPos, playerA);
          thePower[3].powerUp(playerB.xPos,playerB.yPos,playerB.zPos, playerB);
          thePower[3].display(); 
          
          // spin detects if it hits the player 
          theSpin[3].spinUp(playerA.xPos,playerA.yPos,playerA.zPos, playerA);
          theSpin[3].spinUp(playerA.xPos,playerA.yPos,playerA.zPos, playerB);
          theSpin[3].display();
   
          
        }
        else 
        {
            if (extra > 400)
            {
              extra = 0; 
            }
        }



        
        // move the player 
        playerA.move(); 
        playerB.move(); 
  
        // display the background 
        pushMatrix();
        imageMode(CENTER);
        translate(-700,-500,-40);
        image(background, width,height);
        popMatrix();  
        
        // see if the player hits a border 
        playerA.bumper(); 
        playerB.bumper();
  
        // reset to the default perspective
        perspective();
  
        // restore the 2D transformation matrix
        popMatrix();
        
        int seconds = int( millis()/1000 );
        fill(255,255,255);
        hint(DISABLE_DEPTH_TEST);
        text("Time: " + seconds, 10,10);
        text("Player A: " + playerA.score, 10,20);
        text("Player B: " + playerB.score, 10,30);
    
      }
    }
  }
}


