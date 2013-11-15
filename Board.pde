class Board 
{
  float xPos;
  float yPos;
  

  void display()
  {
    pushMatrix();
    fill(255,0,0);
    translate(0,0,0);
    rect(0,0,100,100);
    popMatrix();
  }
}
