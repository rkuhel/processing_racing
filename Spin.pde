class Spin
{
  float xPos;
  float yPos;
  float zPos;
  int counter = 150;
  
  Spin(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    zPos = z; 
  }
  boolean spinUp()
  {
    println("distance: to box " + dist(theCar.xPos, theCar.yPos, theCar.zPos, theSpin.xPos, theSpin.yPos, theSpin.zPos) );
    if( (dist(theCar.xPos, theCar.yPos, theCar.zPos, theSpin.xPos, theSpin.yPos, theSpin.zPos) < 50) || (counter < 150 && counter > 0) )
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
    sphere(20);
    popMatrix();
  }

}
