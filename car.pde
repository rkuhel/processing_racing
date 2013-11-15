class Car 
{
  float xPos;
  float yPos; 
  float zPos;
  int angle = 0; 
  

 
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
      float Cx = constrain(xPos, -190, 320);  
      float Cy = constrain(yPos, -180, 170);
      lights();
      translate(Cx+5,Cy+5,zPos+5);
      fill(255,0,0);
      if (angle < 360 )
      {
        rotate (radians (angle) );
        angle+=5; 
      }
      else 
      {
        angle=0;
      }
      sphereDetail(6);
      sphere(5);
      popMatrix();
      
      pushMatrix();
      noStroke();
      lights();
      translate(Cx-15,Cy+5,zPos+5);
      fill(255,0,0);
      if (angle < 360 )
      {
        rotate (radians (angle) );
        angle+=5; 
      }
      else 
      {
        angle=0;

      }
      sphereDetail(6);
      sphere(5);
      popMatrix();
      
      pushMatrix();
      noStroke();
      lights();
      translate(Cx-15,Cy-5,zPos+5);
      fill(255,0,0);
      if (angle < 360 )
      {
        rotate (radians (angle) );
        angle+=5; 
      }
      else 
      {
        angle=0;
      }
      sphereDetail(6);
      sphere(5);
      popMatrix();
      
      pushMatrix();
      noStroke();
      lights();
      translate(Cx+5,Cy-5,zPos+5);
      fill(255,0,0);
      sphere(5);
      popMatrix();



      pushMatrix();
      translate(Cx,Cy,zPos+10);
      fill(0,0,255,100);
      box(40,10,10);
      popMatrix();
  
  }
  void right()
  {
    xPos+=5;
    println("xPos " + xPos);
  }
  void left()
  {
    xPos-=5; 
    println("xPos " + xPos);
//    angle-=3; 
//    rotate( radians(angle) );
  }
  void up()
  {
   yPos-=5; 
   println("yPos " + yPos);
  }
  void down()
  {
   yPos+=5; 
   println("yPos " + yPos);
  }

  

   
}
