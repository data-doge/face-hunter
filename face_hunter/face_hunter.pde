import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

int counter = 0;

void setup () {
  int screenWidth = 640;
  int screenHeight = 480;
  size(screenWidth, screenHeight);
  video = new Capture(this, screenWidth, screenHeight);
  opencv = new OpenCV(this, screenWidth, screenHeight);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void draw () {
  if (video.available() == true) {
    video.read();
    opencv.loadImage(video);
    image(video, 0, 0);
  }
}

void mousePressed () {
  noFill();
  stroke(255, 0, 0);
  Rectangle[] faces = opencv.detect();
  captureFaces(faces);
}

void captureFaces (Rectangle[] faces) {
  for (int i = 0; i < faces.length; i++) {
    Rectangle face = faces[i];
    captureFace(face);
  }
}

void captureFace (Rectangle face) {
  PImage faceImage = get(face.x, face.y, face.width, face.height);
  faceImage.save("./captures/face-" + counter + ".jpg");
  counter++;
}

void drawBoxesAround (Rectangle[] faces) {
  for (int i = 0; i < faces.length; i++) {
    Rectangle face = faces[i];
    drawBoxAround(face);
  }
}

void drawBoxAround (Rectangle face) {
  rect(face.x, face.y, face.width, face.height);
}

