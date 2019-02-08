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
