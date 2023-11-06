/**
 Rokkaku Calculator
 Rob Lloyd
 https://github.com/rwlloyd/
 --
 Generates the dimensions for a Rokkaku typel kite for a
 given main_spar length and a ratio of three numbers, r1, r2 and r3.
 
 Common ratios are 6:5:4 and 5:4:3
 **/

int main_spar = 2000;
float r1 = 6;
float r2 = 5;
float r3 = 4;

// ------
float[] ratio; // for calculating base dimensions
PVector[] rok; // for rokkaku corners and spar crossing points
float unit;    // calculted unit distance for kite
float area;
float rectArea;
float trigArea;

void setup() {
  size(2000, 1500);
  background(50);
  ratio = new float[3];
  ratio[0] = r1;//5;
  ratio[1] = r2;//4;
  ratio[2] = r3;//3;
  unit = main_spar/ratio[0];

  /**
   going clockwise around the kite,
   from the top as the origin,
   then top to bottom for the remaining two points,
   calculate the x,y position,
   then save it to the array
   **/
  rok = new PVector[8];
  rok[0] = new PVector(0, 0);
  rok[1] = new PVector( (ratio[1]/2)*unit, ( (ratio[0]-ratio[2])/2)*unit );
  rok[2] = new PVector( (ratio[1]/2)*unit, main_spar-((ratio[0]-ratio[2])/2)*unit );
  rok[3] = new PVector(  0, main_spar);
  rok[4] = new PVector( -(ratio[1]/2)*unit, main_spar-((ratio[0]-ratio[2])/2)*unit );
  rok[5] = new PVector( -(ratio[1]/2)*unit, ((ratio[0]-ratio[2])/2)*unit );
  rok[6] = new PVector(  0, ((ratio[0]-ratio[2])/2)*unit);
  rok[7] = new PVector(  0, main_spar-((ratio[0]-ratio[2])/2)*unit);
};

void draw() {
  calculateArea();
  float scale_factor = height/(1.5*main_spar);
  println("Scale Factor: " + scale_factor);
  translate((width/2), ((height)/6));
  scale(scale_factor);
  drawSpars();
  drawSquares();
  drawTriangles();
  drawPockets();
  drawDimensions();
};

void drawSpars() {
  stroke(255);
  //Main Spar
  line(rok[0].x, rok[0].y, 0, main_spar);
  //Upper Spar
  line(rok[5].x, rok[5].y, rok[1].x, rok[1].y);
  //Lower Spar
  line(rok[4].x, rok[4].y, rok[2].x, rok[2].y);
}

void drawPockets() {
  fill(255, 0, 0);
  for (int i=0; i<rok.length; i++) {
    ellipse(rok[i].x, rok[i].y, 16, 16);
  }
}

void drawSquares() {
  fill(50, 125, 234);
  rect(rok[5].x, rok[5].y, (ratio[1]/2)*unit, ratio[2]*unit);
  fill(60, 225, 24);
  rect(rok[6].x, rok[6].y, (ratio[1]/2)*unit, ratio[2]*unit);
}

void drawTriangles() {
  //triangle(x1, y1, x2, y2, x3, y3)
  fill(70, 115, 124);
  triangle(rok[0].x, rok[0].y, rok[1].x, rok[1].y, rok[6].x, rok[6].y);
  fill(80, 130, 111);
  triangle(rok[0].x, rok[0].y, rok[5].x, rok[5].y, rok[6].x, rok[6].y);
  fill(90, 115, 95);
  triangle(rok[3].x, rok[3].y, rok[4].x, rok[4].y, rok[7].x, rok[7].y);
  fill(110, 130, 34);
  triangle(rok[3].x, rok[3].y, rok[2].x, rok[2].y, rok[7].x, rok[7].y);
}

void calculateArea() {
  float a = (rok[6].y - rok[0].y);
  float b = (rok[1].x - rok[6].x);
  float x = (rok[1].x);
  float y = (rok[7].y - rok[6].y);
  rectArea = x * y;
  trigArea = (a*b)/2;
  area = (2 * rectArea) + (4 * trigArea);
  textSize(100);
  textAlign(LEFT);
  fill(255);
  text("Area: "+area/1000000 + "m2", 48, height -50);  // Default depth, no z-value specified
  text(ratio[0] + " : " + ratio[1] + " : " + ratio[2], 48, 150 );
  println(a, b, x, y, rectArea, trigArea, unit/1000, area);
}

void drawDimensions() {

  //overall height
  line(rok[0].x-50, rok[0].y, rok[5].x-200, rok[0].y);
  line(rok[3].x-50, rok[3].y, rok[5].x-200, rok[3].y);
  line(rok[5].x-150, rok[0].y, rok[5].x-150, rok[3].y);
  textAlign(CENTER);
  textSize(48);
  fill(255);
  text(round(rok[3].y-rok[0].y) + "mm", rok[5].x-300, (rok[3].y-rok[0].y)/2);
  //overall width
  line(rok[4].x, rok[4].y+50, rok[4].x, rok[3].y+100);
  line(rok[2].x, rok[2].y+50, rok[2].x, rok[3].y+100);
  line(rok[4].x, rok[3].y+50, rok[2].x, rok[3].y+50);
  textSize(48);
  fill(255);
  text(round(ratio[1]*unit) + "mm", 0, (rok[3].y+100));
  //triangle height
  line(rok[0].x+50, rok[0].y, rok[1].x+150, rok[0].y);
  line(rok[1].x+50, rok[1].y, rok[1].x+150, rok[1].y);
  textAlign(LEFT);
  text(round(rok[1].y) + "mm", rok[1].x+125, rok[1].y/2);
  //halfpanel height
  line(rok[2].x+50, rok[2].y, rok[2].x+150, rok[2].y);
  line(rok[1].x+100, rok[0].y, rok[1].x+100, rok[2].y);
  text(round(rok[2].y-rok[1].y) + "mm", rok[1].x+125, rok[3].y/2);
  //halfpanel width
  line(rok[0].x, rok[0].y-50, rok[0].x, rok[0].y-100);
  line(rok[1].x, rok[1].y-50, rok[1].x, rok[0].y-100);
  line(rok[0].x, rok[0].y-75, rok[1].x, rok[0].y-75);
  textSize(48);
  fill(255);
  text(round(ratio[1]/2*unit) + "mm", (ratio[1]*unit)/4, (rok[0].y-100));
}
