#include <Servo.h>

Servo servoMotor;
long tiempo;
int distancia;

const int pin_motor = 10;
const int echo = 3;
const int trigger = 2;

void setup() {
  Serial.begin(9600);
  servoMotor.attach(pin_motor);
  pinMode(echo, INPUT);
  pinMode(trigger, OUTPUT);
}

void loop() {
  //SENTIDO NORMAL
  for(int ang=3;ang<=177;ang++){
    servoMotor.write(ang);
    delay(30);
    distancia = getDistancia();
    Serial.print(ang); //ANGULO
    Serial.print("-"); 
    Serial.print(distancia); //DISTANCIA
    //Back
    Serial.print("B");
  }
  
  //SENTIDO CONTRARIO
  for(int ang=177;ang>2;ang--){  
    servoMotor.write(ang);
    delay(30);
    distancia = getDistancia();
    Serial.print(ang); //ANGULO
    Serial.print("-"); 
    Serial.print(distancia); //DISTANCIA
    //Back
    Serial.print("B");
  }
}
int getDistancia(){ 
  // ENVIAR PULSO DE DISPARO EN EL PIN "TRIGGER"
  digitalWrite(trigger, LOW); 
  delayMicroseconds(2);
  digitalWrite(trigger, HIGH); 
  // EL PULSO DURA AL MENOS 10 uS EN ESTADO ALTO
  delayMicroseconds(10);
  digitalWrite(trigger, LOW);
  // MEDIR EL TIEMPO EN ESTADO ALTO DEL PIN "ECHO" EL PULSO ES PROPORCIONAL A LA DISTANCIA MEDIDA
  tiempo = pulseIn(echo, HIGH);
  // LA VELOCIDAD DEL SONIDO ES DE 340 M/S O 29 MICROSEGUNDOS POR CENTIMETRO
  // DIVIDIMOS EL TIEMPO DEL PULSO ENTRE 58, TIEMPO QUE TARDA RECORRER IDA Y VUELTA UN CENTIMETRO LA ONDA SONORA
  distancia= tiempo/58;
  
  return distancia;
}
