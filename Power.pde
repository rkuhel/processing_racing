class Power 
{
  float xPos;
  float yPos;
  float zPos;
  int counter = 150;
  boolean powerSwitch = true; 

  
  Power(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    zPos = z; 
  }
  boolean powerUp(float x, float y, float z, Car c)
  {
//    for (int i = 0; i < 3; i++)
//    {
      if (powerSwitch == true || (counter < 150 && counter > 0) )
      {
        if( ( dist(x, y, z, thePower[0].xPos, thePower[0].yPos, thePower[0].zPos) < 50) || (counter < 150 && counter > 0) )
        {
          counter--;
          powerSwitch = false;
          if (c.forwardHit == false && c.rightHit == false && c.leftHit == false)
          { 
            c.speed = 6; 
          }
          println("hit the power up");
          return true; 
        }
        else  
        {
          counter = 150;
          println("power up ended");
          return false; 
        }
      }
      else 
      {
        return false; 
      }
//    }
  }
  
  
  void display()
  {
    if (powerSwitch == true)
    {   
      pushMatrix();
      fill(0,255,0,100);
      translate(xPos,yPos,zPos);
      sphere(20);
      noFill(); 
      popMatrix();
    }
  }
}
