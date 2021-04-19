// 2020 Calculator | Programming 1
//Joanna Bromka| Senior Year, Nov 2020

//i have asked multiple times how to keep the text from going off the screen and i never got an answer :')

Button [] numButtons = new Button[10];
Button [] opButtons = new Button[11];
String dVal, op;
boolean left;
float l;
float r;
float result;
int currentNum;




void setup() {
  size (305, 460);
  dVal = "0";
  op = "";
  left = true;
  r = 0.0;
  l = 0.0;
  result = 0.0;
  currentNum = 0;

  numButtons[0] = new Button(20, 340, 130, 50, "0", true);

  numButtons[1] = new Button(21, 280, 50, 50, "1", true);
  numButtons[2] = new Button(96, 280, 50, 50, "2", true);
  numButtons[3] = new Button(173, 280, 50, 50, "3", true);

  numButtons[4] = new Button(21, 160, 50, 50, "9", true);
  numButtons[5] = new Button(96, 160, 50, 50, "8", true);
  numButtons[6] = new Button(173, 160, 50, 50, "7", true);

  numButtons[7] = new Button(21, 220, 50, 50, "6", true);
  numButtons[8] = new Button(96, 220, 50, 50, "5", true);
  numButtons[9] = new Button(173, 220, 50, 50, "4", true);

  opButtons[0] = new Button(250, 100, 40, 50, "c", false);
  opButtons[1] = new Button(250, 160, 40, 50, "+", false);
  opButtons[2] = new Button(250, 220, 40, 50, "-", false);
  opButtons[3] = new Button(250, 280, 40, 50, "*", false);
  opButtons[4] = new Button(250, 340, 40, 50, "/", false);
  opButtons[5] = new Button(250, 400, 40, 50, "=", false);

  opButtons[6] = new Button(173, 340, 50, 50, ".", false);

  opButtons[7] = new Button(21, 400, 40, 50, "±", false);
  opButtons[8] = new Button(75, 400, 40, 50, " ", false);
  opButtons[9] = new Button(129, 400, 40, 50, " ", false);
  opButtons[10] = new Button(183, 400, 40, 50, " ", false);
}




void draw() {
  background(127);

  updateDisplay();

  for (int i=0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover();
  }
  for (int i=0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].hover();
  }
}




void updateDisplay() {
  rectMode(CORNER);
  strokeWeight(2);
  fill(80);
  rect(20, 20, width-90, 120);
  fill(255);
  textSize(40);
  text(dVal, width-270, 120);
  textAlign(LEFT);
  text("L:" + l + " R:" + r + " Op:" + op, 500, 263);
  text("Result:" + result + " Left:" + left, 500, 275);


  if (dVal.length()<12) {
    textSize(40);
  } else if (dVal.length()<13) {
    textSize(38);
  } else if (dVal.length()<14) {
    textSize(36);
  } else if (dVal.length()<15) {
    textSize(34);
  } else if (dVal.length()<17) {
    textSize(32);
  } else if (dVal.length()<18) {
    textSize(30);
  } else if (dVal.length()<19) {
    textSize(28);
  } else if (dVal.length()<20) {
    textSize(26);
  }
}





void mousePressed() {
  println("L:"+ l + "R:" + r + "Op;" + op);
  println("Result:" + result + "Left:" + left);

  for (int i=0; i<numButtons.length; i++) {
    if (numButtons[i].hover && dVal.length()<20) {
      handleEvent(numButtons[i].val, true);
    }
  }
  for (int i=0; i<opButtons.length; i++) {
    if (opButtons[i].hover) {
      handleEvent(opButtons[i].val, false);
    }
  }
}




void keyPressed() {
  println("Key:" + key+ "KeyCode:" +keyCode);
  if (key == '0') {
    handleEvent("0", true);
  } else if (key == '1') {
    handleEvent("1", true);
  } else if (key == '2') {
    handleEvent("2", true);
  } else if (key == '3') {
    handleEvent("3", true);
  } else if (key == '4') {
    handleEvent("4", true);
  } else if (key == '5') {
    handleEvent("5", true);
  } else if (key == '6') {
    handleEvent("7", true);
  } else if (key == '8') {
    handleEvent("8", true);
  } else if (key == '9') {
    handleEvent("9", true);
  } else if (key == '+') {
    handleEvent("+", false);
  } else if (key == '-') {
    handleEvent("-", false);
  } else if (key == '*') {
    handleEvent("*", false);
  } else if (key == '/') {
    handleEvent("/", false);
  } else if (key == '.') {
    handleEvent(".", false);
  } else if (key == 27 || key =='c') {
    handleEvent("c", false);
  } else if (key == 10) {
    if (keyCode == ENTER || keyCode == RETURN)
      handleEvent("=", false);
  }
}
String handleEvent(String val, boolean num) {
  if (left && num) {
    if (dVal.equals("0") || result == 1) {
      dVal = (val);
      l = float(dVal);
    } else {
      dVal += val;
      l = float(dVal);
    }
  } else if (!left && num) { //numbers right of op
    if (dVal.equals("0.0")) {
      dVal = val;
      r = float(dVal);
    } else {
      dVal += val;
      r = float(dVal);
    }
  } else if (val.equals("c")) {
    dVal = "0";
    op = "";
    left = true;
    r = 0.0;
    l = 0.0;
    result = 0.0;
  } else  if (val.equals("+")) {
    if (!left) {
      performCalculation();
    } else {
      op = "+";
      left = false;
      dVal = "";
    }
  } else  if (val.equals("-")) {
    if (!left) {
      performCalculation();
    } else {
      op = "-";
      left = false;
      dVal = "";
    }
  } else  if (val.equals("*")) {
    if (!left) {
      performCalculation();
    } else {
      op = "*";
      left = false;
      dVal = "";
    }
  } else  if (val.equals("/")) {
    if (!left) {
      performCalculation();
    } else {
      op = "/";
      left = false;
      dVal = "";
    }
   } else if (val.equals("±")) {
    if (left) {
      l *= -1;
      dVal = str(l);
    } else {
      r *= -1;
      dVal = str(r);
    }
  } else if (val.equals("=")) {
      performCalculation();
      
  } else if (val.equals(".") && !dVal.contains("."))  {
      dVal += (val);
    }
  return val;
}





void performCalculation() {
  if (op.equals("+")) {
    result = l + r;
  } else if (op.equals("-")) {
    result = l- r;
  } else if (op.equals("*")) {
    result = l * r;
  } else if (op.equals("/")) {
    result = l / r;
  } 
  l = result;
  dVal = str(result);
  left = true;
}
