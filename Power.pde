class Power 
{
  float xPos;
  float yPos;
  float zPos;
  int counterA = 150;
  int counterB = 150;

  
  Power(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    zPos = z; 
  }
  boolean powerUp()
  {
    if( ( dist(playerA.xPos, playerA.yPos, playerA.zPos, thePower.xPos, thePower.yPos, thePower.zPos) < 50) || (counterA < 150 && counterA > 0) )
    {
      counterA--;
      return true; 
    }
    else  
    {
      counterA = 150;
      return false; 
    }

  }
  
  void display()
  {
    pushMatrix();
    fill(0,255,0,100);
    translate(xPos,yPos,zPos);
    sphere(20);
    popMatrix();
  }

}
