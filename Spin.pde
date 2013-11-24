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
  
    if( ( (dist(playerA.xPos, playerA.yPos, playerA.zPos, theSpin.xPos, theSpin.yPos, theSpin.zPos) < 50) || (dist(playerB.xPos, playerB.yPos, playerB.zPos, theSpin.xPos, theSpin.yPos, theSpin.zPos) < 50) ) || (counter < 150 && counter > 0) )
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
