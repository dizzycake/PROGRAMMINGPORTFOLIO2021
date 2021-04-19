class Button {

  //member variables
  int x, y, w, h;
  String val;
  boolean hover, isNumber;
  color c1, c2;

  //constructor
  Button(int tempX, int tempY, int tempW, int tempH, String tempVal, boolean isNumber) {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    val = tempVal;
    hover = false;
    c1 = #00CB16;
    c2 = #03FF1D;

    this.isNumber = isNumber;
  }



  //display the button
  void display() { //NUMBER BUTTONS
    if (isNumber == true) {
      //backhround rect
      fill(37);
      rect(x-2, y+5, w+4, h, 13);
      noStroke();
      fill(255);
      rect(x-1, y-1, w+3, h+3, 12);


      if (hover) {
        fill (c2);
        stroke(0);
        strokeWeight(5);
      } else {
        fill(c1);
        stroke(2);
        strokeWeight(2);
      }

      //rectMode(CENTER);
      rect(x, y, w, h, 10);

      fill(255);
      textSize(20);
      textAlign(CENTER);
      text(val, x+w/2, y+32);
      fill(255);
    } else { //NON NUMBER BUTTONS
      //backhround rect
    fill(37);
    rect(x-2, y+5, w+4, h, 13);
    noStroke();
    fill(255);
    rect(x-1, y-1, w+3, h+3, 12);


    if (hover) {
      fill (#007616);
      stroke(0);
      strokeWeight(5);
    } else {
      fill(#015210);
      stroke(2);
      strokeWeight(2);
    }
    
    //rectMode(CENTER);
    rect(x, y, w, h, 10);

    fill(255);
    textSize(20);
    textAlign(LEFT);
    text(val, x+w/2, y+32);
    fill(255);
    }
  }
  // edge detection
  void hover () {
    hover = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y+h;
  }
}
