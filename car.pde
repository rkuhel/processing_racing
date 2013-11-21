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
  
  float sensorX, sensorY;

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
    
    sensorX = 0;
    sensorY = 0;    
  }
  void display()
  {

    float Cx = constrain(xPos, -190, 320);  
    float Cy = constrain(yPos, -180, 170);
    
    pushMatrix();
    translate(Cx, Cy, zPos);
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



    translate(0, 0, 10);
    fill(0, 0, 255, 100);
    box(40, 10, 10);


    // now draw the sensor
    fill(0,255,0);
    translate(40,0,0);
//    box(10,10,10);  // put back in to see the sensor
    
    sensorX = screenX(0,0,0);
    sensorY = screenY(0,0,0);
    
//    println("This should be it!!! " + sensorX + ", " + sensorY);

    popMatrix();
    
    
    
    
//    // box on the other corner of the marker
//    pushMatrix();
//    float Cx = constrain(xPos, -190, 320);  
//    float Cy = constrain(yPos, -180, 170);
//    lights();
//    
//    translate(Cx+5, Cy+5, zPos+5);
//    rotate(radians(angle));
//    fill(255, 0, 0);
//    if (angleB < 360 )
//    {
//      rotate (radians (angleB) );
//      angleB+=5;
//    }
//    else 
//    {
//      angleB=0;
//    }
//    sphereDetail(6);
//    sphere(5);
//    popMatrix();
//
//    pushMatrix();
//    noStroke();
//    lights();
//    translate(Cx-15, Cy+5, zPos+5);
//    rotate(radians(angle));
//    fill(255, 0, 0);
//    if (angleB < 360 )
//    {
//      rotate (radians (angleB) );
//      angleB+=5;
//    }
//    else 
//    {
//      angleB=0;
//    }
//    sphereDetail(6);
//    sphere(5);
//    popMatrix();
//
//    pushMatrix();
//    noStroke();
//    lights();
//    translate(Cx-15, Cy-5, zPos+5);
//    rotate(radians(angle));
//    fill(255, 0, 0);
//    if (angleB < 360 )
//    {
//      rotate (radians (angleB) );
//      angleB+=5;
//    }
//    else 
//    {
//      angleB=0;
//    }
//    sphereDetail(6);
//    sphere(5);
//    popMatrix();
//
//    pushMatrix();
//    noStroke();
//    lights();
//    translate(Cx+5, Cy-5, zPos+5);
//    rotate(radians(angle));
//    if (angleB < 360 )
//    {
//      rotate (radians (angleB) );
//      angleB+=5;
//    }
//    else 
//    {
//      angleB=0;
//    }
//    fill(255, 0, 0);
//    sphere(5);
//    popMatrix();
//
//
//
//    pushMatrix();
//    translate(Cx, Cy, zPos+10);
//    rotate(radians(angle));
//    fill(0, 0, 255, 100);
//    box(40, 10, 10);
//    popMatrix();    
    
      
  }

  void moveRight()
  {
    this.angle+=5;
    this.dx = cos( radians(angle) );
    this.dy = sin( radians(angle) );
     
    sensorX = xPos + 20;
    sensorY = yPos;  
  }
  void moveLeft()
  {
    this.angle-=5;
    this.dx = cos( radians(angle) );
    this.dy = sin( radians(angle) );
    
    sensorX = xPos - 20;
    sensorY = yPos; 
  }
  void carReverse()
  {
    xPos--;
  }



  void move()
  {  
    this.xPos += (this.dx * speed);
    this.yPos += (this.dy * speed);
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
    if (score > 0)
    {
      fill(255, 0, 0); 
      text("GAME OVER YOU WIN", 50, 50);
    }
  }

  // checks to see if we hit anything 
  void bumper()
  {


    // grab the 2D position here - this is what we will use to look at the video stream to see what color is behind this pixel
    int xBumper = (int)sensorX;
    int yBumper = (int)sensorY;
    // ok, now we can use our xPos and yPos variables to grab the color value
    loadPixels();
    int location = xBumper + yBumper*width;
    
    if (location < pixels.length && location >= 0)
    {
      color sampleColor = color(pixels[location]);

      // let's look at the color value in terms of how much red it has.
      // remember that white = 255,255,255
      // so if we see a high red value we can probably assume the color here is white
      // and a low value will be less than white
      float redness = red(sampleColor);
      float greenness = green(sampleColor);
      float blueness = blue(sampleColor);

      if (redness < 20)
      {
         speed = 0;   
      }  

      else
      {
        if (thePower.powerUp() == true)
        {
          println("hit the box!"); 
          speed = 15.0; 
          println("speed " + speed);
        }
        else 
        { 
          speed = 5.0; 
        }
        if (theSpin.spinUp() == true )
        {
          speed = 1; 
        }
        else
        {
          speed = 5; 
        }
      }
    }
  }
}

