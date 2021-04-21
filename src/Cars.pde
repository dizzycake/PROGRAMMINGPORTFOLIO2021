Car[] cars = new Car [100];

void setup() {
  size (600,600);
  for(int i=0; i<cars.length; i++) {
    cars[i] = new Car(color(random(255),random(255),random(50)), random(1,5));
  }
}

void draw() {
  background(255);
  for(int i=0; i<cars.length; i++){
    cars[i].display();
    cars[i].drive();
  }
}













//Car c1;
//Car c2;
//Car c3;
//Car c4;

//void setup() {
//  size (400,400);
//  c1 = new Car(#3DE896,random(5));
//  c2 = new Car(#2FE601,random(10));
//  c3 = new Car(#9CA994,random(10));
//  c3 = new Car(#9CA994,random(10));
//}

//void draw() {
//  background (255);
//  c1.display ();
//  c1.drive();
//  c2.display ();
//  c2.drive();
//  c3.display ();
//  c3.drive();
//}
