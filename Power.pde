class Power 
{
  float xPos;
  float yPos;
  float zPos;
  int counter = 150;
  
  Power(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    zPos = z; 
  }
  boolean powerUp()
  {
//    println("distance: to box " + dist(theCar.xPos, theCar.yPos, theCar.zPos, thePower.xPos, thePower.yPos, thePower.zPos) );
    if( (dist(theCar.xPos, theCar.yPos, theCar.zPos, thePower.xPos, thePower.yPos, thePower.zPos) < 50) || (counter < 150 && counter > 0) )
    {
      counter--;
      return true; 
    }
    else 
    {
      counter = 150;
      return false; 
    }

  }
  void display()
  {
    pushMatrix();
    fill(255,255,255);
    translate(xPos,yPos,zPos);
    box(20,20,20);
    popMatrix();
  }

}
