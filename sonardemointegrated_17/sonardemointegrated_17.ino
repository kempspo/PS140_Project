int i;
int gnd1 = 11;
int echo = 10;
int trig = 9;
int vcc1 = 8;
int cnt = 1;
float f;
int to = 25000; //max time

#include <SoftwareSerial.h> //Software Serial Port

#define RxD 6// This is the pin that the Bluetooth (BT_TX) will transmit to the Arduino (RxD)
#define TxD 7// This is the pin that the Bluetooth (BT_RX) will receive from the Arduino (TxD)
#define DEBUG_ENABLED 1

SoftwareSerial blueToothSerial(RxD,TxD);

int pos = 0;    // variable to store the servo position 
int mode = 0;
void setup() {     
  Serial.begin(9600);
  blueToothSerial.begin(9600);
  pinMode(vcc1,OUTPUT);  //to connect to Vcc
  pinMode(echo, INPUT);      
  pinMode(trig, OUTPUT);   
  pinMode(gnd1, OUTPUT);
  pinMode(RxD, INPUT); // receive INPUT from the bluetooth shield on Digital Pin 6
  pinMode(TxD, OUTPUT); //send data (OUTPUT) to the bluetooth shield on Digital Pin 7
  setupBlueToothConnection(); //Used to initialise the Bluetooth shield
  digitalWrite(gnd1,LOW); //to ground sonar gnd pin
  digitalWrite(vcc1,HIGH); //to Vcc=+5V
  digitalWrite(trig,0); //init trig = 0
}

int ch;
void loop() {
  digitalWrite(trig,0);
  delay(50);  
  digitalWrite(trig,HIGH);
  delayMicroseconds(10);
  digitalWrite(trig,LOW);
  
  cnt = pulseIn(echo,1,to); //measures t in us
  f= (cnt/2000.0)*346; //distance in mm
  
    if (cnt > 0) {
      Serial.write( 0xaa);
      Serial.write( (cnt >> 8) & 0xff);
      Serial.write( cnt & 0xff); 
    }
}

void setupBlueToothConnection()
{
 blueToothSerial.begin(38400); //Set BluetoothBee BaudRate to default baud rate 38400
 blueToothSerial.print("\r\n+STWMOD=0\r\n"); //set the bluetooth work in slave mode
 blueToothSerial.print("\r\n+STNA=SeeedBTSlave\r\n"); //set the bluetooth name as "SeeedBTSlave"
 blueToothSerial.print("\r\n+STOAUT=1\r\n"); // Permit Paired device to connect me
 blueToothSerial.print("\r\n+STAUTO=0\r\n"); // Auto-connection should be forbidden here
 delay(2000); // This delay is required.
 blueToothSerial.print("\r\n+INQ=1\r\n"); //make the slave bluetooth inquirable 
 Serial.println("The slave bluetooth is inquirable!");
 delay(2000); // This delay is required.
 blueToothSerial.flush();
}



