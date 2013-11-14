// live video libraries
import processing.video.*;

// AR library - find the 'NyAR4psg' folder that came with today's downloadable
// code package and put it into the 'libraries' folder of your Processing sketchbook
import jp.nyatla.nyar4psg.*;

// video object
Capture video;

// AR marker object - this keeps track of all of the patterns you wish to look for
MultiMarker augmentedRealityMarkers;

//car object
Car theCar;

// rotation value for spinning our pikachus
int angle = 0;

void setup() 
{
  // make sure to render your sketch using a 3D renderer.  OPENGL or P3D will both work.
  size(640, 480, OPENGL);
  smooth();
  
  // create our video object
  video = new Capture(this, 640, 480);
  video.start();
  
  // create a new AR marker object
  // note that "camera_para.dat" has to be in the data folder of your sketch
  // this is used to correct for distortions in your webcam
  augmentedRealityMarkers = new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);

  // attach the pattern you wish to track to this marker.  this file also needs to be in the data folder
  // 80 is the width of the pattern
  augmentedRealityMarkers.addARMarker("patt.hiro", 80);
  
  theCar = new Car(40,40,20);

}

void draw()
{
  // we only really want to do something if there is fresh data from the camera waiting for us
  if (video.available())
  {
    // read in the video frame and display it
    video.read();
    imageMode(CORNER);
    image(video, 0, 0);

    // ask the AR marker object to attempt to find our patterns in the incoming video stream
    augmentedRealityMarkers.detect(video);

    // if they exists then we will be given information about their location
    // note that we only have one pattern that we are looking for, so it will be pattern 0
    if (augmentedRealityMarkers.isExistMarker(0))
    {
      // set the AR perspective
      augmentedRealityMarkers.setARPerspective();
      
      // next, remember the current transformation matrix
      pushMatrix();

      // change the transformation matrix so that we are now drawing in 3D space on top of the marker
      setMatrix(augmentedRealityMarkers.getMarkerMatrix(0));

      // flip the coordinate system around so that we can draw in a more intuititve way (if you don't do this
      // then the x & y axis will be flipped)     
      scale(-1, -1);


      if (keyPressed && key == CODED )
      {
        if (keyCode == RIGHT)
        {
        theCar.right();
        }
        if (keyCode == LEFT)
        {
        theCar.left();
        }
        if (keyCode == UP)
        {
        theCar.forward();
        }
      }
      theCar.display();
      
      // reset to the default perspective
      perspective();

      // restore the 2D transformation matrix
      popMatrix();
    }
  }
}

