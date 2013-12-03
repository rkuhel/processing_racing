class Car 
{
  //position and angle of wheels 
  float xPos;
  float yPos; 
  float zPos;
  float dx = 0.0;
  float dy = 0.0;
  float angle;
  float angleB;
  float speed; 
  
  boolean forwardHit = false;
  boolean rightHit = false;
  boolean leftHit = false;
  
  float red, blue, green; 
  
  float sensorX, sensorY, sensorLeftX, sensorLeftY, sensorRightX, sensorRightY;

  //car keep track of score and tracker 
  int score;
  int tracker; 
  
  int bounce; 

  //constructor 
  Car(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    zPos = z;
    
    red = random(255); 
    blue = random(255); 
    green = random(255);   
  
    sensorX = 0;
    sensorY = 0;    
  }
  void display()
  {
    pushMatrix();
    translate(xPos, yPos, zPos);
    rotate(radians(angle));
    
    // box on the other corner of the marker
    pushMatrix();
    lights();
    
    translate(5, 5, 5);
    fill(255, 0, 0);
    if (angleB < 360 )
    {
      rotate (radians (angleB) );
      angleB+=5;
    }
    else 
    {
      angleB=0;
    }
    sphereDetail(6);
    sphere(5);
    popMatrix();

    pushMatrix();
    noStroke();
    lights();
    translate(-15, 5, zPos+5);
    fill(255, 0, 0);
    if (angleB < 360 )
    {
      rotate (radians (angleB) );
      angleB+=5;
    }
    else 
    {
      angleB=0;
    }
    sphereDetail(6);
    sphere(5);
    popMatrix();

    pushMatrix();
    noStroke();
    lights();
    translate(-15, -5, 5);
    fill(255, 0, 0);
    if (angleB < 360 )
    {
      rotate (radians (angleB) );
      angleB+=5;
    }
    else 
    {
      angleB=0;
    }
    sphereDetail(6);
    sphere(5);
    popMatrix();

    pushMatrix();
    noStroke();
    lights();
    translate(5, -5, 5);
    if (angleB < 360 )
    {
      rotate (radians (angleB) );
      angleB+=5;
    }
    else 
    {
      angleB=0;
    }
    fill(255, 0, 0);
    sphere(5);
    popMatrix();


    pushMatrix();
    translate(0, 0, 10);
    fill(red, blue, green, 100);
    box(40, 10, 10);
    popMatrix();
    
    // now compute forward sensor position
    pushMatrix();
    fill(0,255,0);
    translate(30,0,0);
//    box(10,10,10);  // put back in to see the sensor
    sensorX = screenX(0,0,0);
    sensorY = screenY(0,0,0);
    popMatrix();

    // not compute the left sensor
    pushMatrix();
    fill(255,0,0);
    translate(30,-15,0);
    sensorLeftX = screenX(0,0,0);
    sensorLeftY = screenY(0,0,0);
//    box(10,10,10);
    popMatrix();


    pushMatrix();
    fill(0,0,255);
    translate(30,15,0);
    sensorRightX = screenX(0,0,0);
    sensorRightY = screenY(0,0,0);
//    box(10,10,10);
    popMatrix();


// screenX would go here

popMatrix();
                
}

  void moveRight()
  {
    this.angle+=15;
    this.dx = cos( radians(angle) );
    this.dy = sin( radians(angle) );
  }
  void moveLeft()
  {
    this.angle-=15;
    this.dx = cos( radians(angle) );
    this.dy = sin( radians(angle) );
 
  }
  void carReverse()
  {
    xPos--;
  }
  void move()
  {  
    this.xPos += (this.dx * speed);
    this.yPos += (this.dy * speed);
    println("xPos " + xPos); 
    println("yPos " + yPos); 

  }

  void keepScore()
  {
    if (tracker == 0)
    {
      if (xPos < 0 && yPos < 0)
      {
        tracker++;
      }
    }
    if (tracker == 1)
    {
      if (xPos > 0 && yPos < 0)
      {
        tracker++;
      }
    }
    if (tracker == 2)
    {
      if (xPos > 0 && yPos > 0)
      {
        tracker++;
      }
    }
    if (tracker == 3)
    {
      if (xPos < 0 && yPos > 0)
      {
        tracker++;
      }
    }
    if (tracker == 4)
    {
      if (xPos < 0 && yPos < 0)
      {
        tracker=0;
        if (xPos < 0 && (yPos < 0 && yPos > -10) )
        {
          score++;
        }
      }
    }
  }

  void winGame()
  {
    if (playerA.score > 0)
    {
      background(255, 204, 0);
      fill(255,255,255);
      playerB.score = 0;
      playerA.score = 0;
      state = 1; 
      println("playerA wins!");
    }
    else if (playerB.score > 0)
    {
      background(255, 204, 255);
      fill(255,255,255);
      playerB.score = 0;
      playerA.score = 0;
      state = 2; 
      println("playerB wins!");
    }
    else 
    {
      println("play mode - race is still going!");
    }
  }

  // checks to see if we hit anything 
  void bumper()
  {


    // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
    int xBumper = (int)sensorX;
    int yBumper = (int)sensorY;
    
    int xBumperRight = (int)sensorRightX;
    int yBumperRight = (int)sensorRightY;
    
    int xBumperLeft = (int)sensorLeftX;
    int yBumperLeft = (int)sensorLeftY;
    // ok, now we can use our xPos and yPos variables to grab the color value
    loadPixels();
    int locationForward = xBumper + yBumper*width;
    int locationRight = xBumperRight + yBumperRight*width;
    int locationLeft = xBumperLeft + yBumperLeft*width;

//    boolean forwardHit = false;
//    boolean rightHit = false;
//    boolean leftHit = false;
    
    // check forward
    if (locationForward < pixels.length && locationForward >= 0)
    {
      color sampleColorForward = color(pixels[locationForward]);

      float rednessForward = red(sampleColorForward);
      float greennessForward = green(sampleColorForward);
      float bluenessForward = blue(sampleColorForward);
      
      if ( rednessForward < 20 && bluenessForward < 20 && greennessForward < 20 )
      {
        forwardHit = true;
      }
      else
      {
        forwardHit = false;
      }
    }
    
    //right
    if (locationRight < pixels.length && locationRight >= 0)
    {
      color sampleColorRight = color(pixels[locationRight]);

      float rednessRight = red(sampleColorRight);
      float greennessRight = green(sampleColorRight);
      float bluenessRight = blue(sampleColorRight);
      
      if ( rednessRight < 20 && bluenessRight < 20 && greennessRight < 20 )
      {
        rightHit = true;
      }
      else
      {
        rightHit = false;
      }
    }
    
    //left
    if (locationLeft < pixels.length && locationLeft >= 0)
    {
      color sampleColorLeft = color(pixels[locationLeft]);

      float rednessLeft = red(sampleColorLeft);
      float greennessLeft = green(sampleColorLeft);
      float bluenessLeft = blue(sampleColorLeft);
      
      if ( rednessLeft < 20 && greennessLeft < 20 && bluenessLeft < 20 )
      {
        leftHit = true;
      }
      else
      {
        leftHit = false;
      }
    }
    
     
    
    if (forwardHit == true || rightHit == true || leftHit == true)
    {
      speed = 0;
    }
    else
    {
      speed= 4; 
    }
  }
}




