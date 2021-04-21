void setup () {
  size(400, 400);
}

void draw () {
  background(#FFE5E5);
  
  //Name and Date
  fill(#FA9595);
  textSize(20);
  text("Joanna Bromka", 250,50,100,100);
  textSize(12);
  text("Oct. 7. 20",255,112,100,100);
  
  //Instructions on how to use converter
  text("Instructions",255,180);
  text("Drag your mouse up and",218,200);
  text("down to view the tempature",210,215);
  
  
  
  //Vertical Line 2
  //line(100, 0, 100, height);
  //for (int i=height; i>0; i-=20) {
  //  line(96, i, 104, i);
  //  textSize(8);
  //  text(i, 85, height-i);


  //Vertical Line
  stroke(#4FD3D8);
  strokeWeight(2);
  line(100,0,100,height);
    for (int i=0; i<height; i+=20) {
    line(96,i, 104, i);
    fill(#FA9595);
    textSize(10);
    text(i, 70, i);
  }
    fill(255);
    rect(97,mouseY,6,6);
  text("Cel;" + convertToCel (mouseY),100-80,mouseY);
  text("Far;" + convertToFar (mouseY),100+20,mouseY);



  //Horizantal line
  //line(0, 100, width, 100);
  //for (int i=0; i<width; i+=20) {
  //  line(i, 96, i, 104);
  //  textSize(8);
  //  text(i, i-4, 94);
  //}
  //ellipse(mouseX,100,5,5);
  //text("Cel;" + convertToCel (mouseX),mouseX,115);
  //text("Far;" + convertToFar (mouseX),mouseX,85);
}

float convertToCel(float val) {
  val = (val-32)*(5.0/9.0);
  return val;
}  

float convertToFar(float val) {
  val = val*(9.0/5.0) +32;
  return val;
}
