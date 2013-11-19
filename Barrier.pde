class Barrier 
{
  // position translate 
  float xPos;
  float yPos;
  float zPos; 
  

  
 Barrier(float x, float y, float z)
 {
    xPos = x;
    yPos = y;
    zPos = z; 
 } 
 
 
 void display()
 {
   pushMatrix();
   fill(0,0,0);
   translate(xPos,yPos,zPos);
   box(150,100,100);
   popMatrix(); 
 }
 
// void hit()
// {  
//   println("distance " + dist(theCar.xPos, theCar.yPos, theCar.zPos, theBarrier.xPos, theBarrier.yPos, theBarrier.zPos)); 
//   
//   if ( dist(theCar.xPos, theCar.yPos, theCar.zPos, theBarrier.xPos, theBarrier.yPos, theBarrier.zPos) < 100 )
//   {
//    println("HIT!!!!");
//    if (theCar.speed > 0)
//    {
//    theCar.speed*=-1;
//    }
//    
//    
//    println("speed"); 
//   }
//   else
//   {
//     theCar.speed = 7; 
//   }
// } 
}
