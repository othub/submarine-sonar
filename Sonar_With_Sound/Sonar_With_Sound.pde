import processing.serial.*;
import ddf.minim.*;

final int DIMENSION_X = 960;
final int DIMENSION_Y = 1000;

Serial arduino; 
int angulo;
int distancia;

//sonido
Minim minim;
AudioPlayer sonar;
AudioSample danger;

void setup() {

  fullScreen();
  smooth();
  textFont(createFont("Arial", 30));

  //arduino
  arduino = new Serial(this, "COM6", 9600);
  arduino.bufferUntil('B');

  //sonido
  minim = new Minim(this);
  sonar = minim.loadFile("sonar.mp3");
  sonar.loop();

  danger = minim.loadSample("alarm.mp3");
}

void draw() {
  fill(29, 84, 249);
  noStroke();
  fill(0, 15); 
  rect(0, 0, width, DIMENSION_Y + 10); 
  
  //_______P A N T A L L A_______//
  pushMatrix();

  translate(DIMENSION_X, DIMENSION_Y);
  noFill();
  strokeWeight(6);
  stroke(29, 84, 249);

  //los arcos
  for ( int pos = 1780; pos >= 225; pos -= 205) {
    arc(0, 0, pos, pos, PI, TWO_PI);
  }

  //linea principal
  line(-890, 0, 890, 0);  // ___\/___

  //linea de los grados
  for (int grado = 20; grado < 180; grado += 20 ) {
    line(0, 0, getCosLine(-890, grado), getSinLine(-890, grado));
  }

  popMatrix();
  
  //___________________ANGULOS Y MENSAJES_____________//
  pushMatrix();
  fill(0);
  noStroke();
  rect(0, DIMENSION_Y + 10, width, 1080);
  fill(255, 67, 20);

  //_______________ M E N S A J E ____________________//
  textSize(35);
  fill(112, 127, 150);
  text("Hay algo/alguien a una distancia de : " + distancia +" cm", 600, 50);

  //_______________ D I S T A N C I A __ L I N E A __ H O R I Z O N T A L ____________________//
  textSize(20);
  //-->
  text("5cm", 1090, 992);
  text("10cm", 1190, 992);
  text("15cm", 1290, 992);
  text("20cm", 1390, 992);
  text("25cm", 1490, 992);
  text("30cm", 1590, 992);
  text("35cm", 1690, 992);
  text("40cm", 1790, 992);
  //<--
  text("5cm", 790, 992);
  text("10cm", 690, 992);
  text("15cm", 590, 992);
  text("20cm", 490, 992);
  text("25cm", 390, 992);
  text("30cm", 290, 992);
  text("35cm", 190, 992);
  text("40cm", 90, 992);

  //_______________ A N G U L O S  ____________________//
  textSize(25);
  fill(112, 127, 150);

  //0 grados
  translate(908+getCosLine(DIMENSION_X, 0), DIMENSION_Y-getSinLine(DIMENSION_X, 0));
  rotate(-radians(-90));
  text("0°", 0, 0);
  resetMatrix();

  //20 grados
  translate(910+getCosLine(DIMENSION_X, 20), 1010-getSinLine(DIMENSION_X, 20));
  rotate(-radians(-70));
  text("20°", 0, 0);
  resetMatrix();

  //40 grados
  translate(920+getCosLine(DIMENSION_X, 40), 1020-getSinLine(DIMENSION_X, 40));
  rotate(-radians(-50));
  text("40°", 0, 0);
  resetMatrix();

  //60 grados
  translate(930+getCosLine(DIMENSION_X, 60), 1040-getSinLine(DIMENSION_X, 60));
  rotate(-radians(-30));
  text("60°", 0, 0);
  resetMatrix();

  //80 grados
  translate(945+getCosLine(DIMENSION_X, 80), 1050-getSinLine(DIMENSION_X, 80));
  rotate(-radians(-10));
  text("80°", 0, 0);
  resetMatrix();

  //100 grados
  translate(950+getCosLine(DIMENSION_X, 100), 1050-getSinLine(DIMENSION_X, 100));
  rotate(radians(-10));
  text("100°", 0, 0);
  resetMatrix();

  //120 grados
  translate(970+getCosLine(DIMENSION_X, 120), 1050-getSinLine(DIMENSION_X, 120));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();

  //140 grados
  translate(990+getCosLine(DIMENSION_X, 140), 1045-getSinLine(DIMENSION_X, 140));
  rotate(radians(-50));
  text("140°", 0, 0);
  resetMatrix();

  //160 grados
  translate(1000+getCosLine(DIMENSION_X, 160), 1035-getSinLine(DIMENSION_X, 160));
  rotate(radians(-70));
  text("160°", 0, 0);
  resetMatrix();

  //180 grados
  translate(1005+getCosLine(DIMENSION_X, 180), 1015-getSinLine(DIMENSION_X, 180));
  rotate(radians(-90));
  text("180°", 0, 0);
  resetMatrix();

  popMatrix();
}

void serialEvent (Serial p) {
  //angulo - distancia B
  String datos = p.readStringUntil('B').substring(0, p.readStringUntil('B').length()-1);

  //angulo - distancia
  int conjunto = datos.indexOf("-");

  //angulo
  angulo = int((datos.substring(0, conjunto)));
  
  //distancia
  distancia = int((datos.substring(conjunto+1, datos.length())));
}

float getCosLine(int longitud, int angulo) { 
  return longitud*cos(radians(angulo));
}

float getSinLine(int longitud, int angulo) { 
  return longitud*sin(radians(angulo));
}
