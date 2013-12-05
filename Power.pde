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
  boolean powerUp(Car c)
  {
      if (powerSwitch == true || (counter < 150 && counter > 0) )
      {
        if( ( dist(xPos, yPos, zPos, c.xPos, c.yPos, c.zPos) < 50) || (counter < 150 && counter > 0) )
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
  }
  
  
  void display()
  {
    if (powerSwitch == true)
    {   
      pushMatrix();
      fill(0,255,0,100);
      translate(xPos,yPos,zPos);
      sphere(20);
//      noFill(); 
      popMatrix();
    }
  }
}
