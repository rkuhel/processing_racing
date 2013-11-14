class Car 
{
  float xPos;
  float yPos; 
  float zPos;
  int angle; 
 
  //constructor 
  Car(float x, float y, float z)
  {
    xPos = x;
    yPos = y;
    xPos = z; 
  }
  void display()
  {
      // box on the other corner of the marker
      pushMatrix();
      translate(xPos,yPos,zPos);
      fill(0,0,255,100);
      box(20,20,20);
      popMatrix();
  
  }
  void right()
  {
    xPos+=5;
    angle+=3; 
    rotate(radians(angle) );
    println("xPos " + xPos);
    println("yPos " + yPos);
    
      
  }
  void left()
  {
    xPos-=5; 
    angle-=3; 
    rotate( radians(angle) );
    println("xPos " + xPos);

  }
  void forward()
  {
   yPos++; 
   xPos++;
   println("yPos " + yPos);
  }

  

   
}
