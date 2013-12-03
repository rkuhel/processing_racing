class Spin
{
  float xPos;
  float yPos;
  float zPos;
  int counter = 150;
  boolean spinSwitch = true; 
  int i =0; 
  
  Spin(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    zPos = z; 
  }
  
  boolean spinUp(float x, float y, float z, Car c)
  {

      if (spinSwitch == true || (counter < 150 && counter > 0) )
      {
        if( ( dist(x, y, z, theSpin[0].xPos, theSpin[0].yPos, theSpin[0].zPos) < 50) || (counter < 150 && counter > 0) )
        {
          counter--;
          if (c.forwardHit == false && c.rightHit == false && c.leftHit == false)
          {
            c.speed = 1; 
          }
          spinSwitch = false; 
          println("hit the spin up");
          return true; 
        }
        else  
        {
          counter = 150;
          println("spin ended");
          return false; 
        }
      }
      else 
      {
        println("spin was hit and switchSpin is now false");
        return false; 
      }
    }
 
  void display()
  {
    if (spinSwitch == true )
    {
      pushMatrix();
      fill(255,255,255);
      translate(xPos,yPos,zPos);
      sphere(20);
      noFill(); 
      popMatrix();
    }
  }
}
