import processing.serial.*;

Serial myPort;
boolean screen = false;
int val;
float f;
ArrayList <slot> parking;
int x;
String name;
int hour;
int minute;
int second;
int occupied;
PImage car;

void setup()
{
  size(500,500);
  String portName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600);
  
  slot A1 = new slot("A1");
  slot A2 = new slot("A2");
  slot A3 = new slot("A3");
  slot B1 = new slot("B1");
  slot B2 = new slot("B2");
  slot B3 = new slot("B3");
  slot B4 = new slot("B4");
  
  parking = new ArrayList<slot>();
  parking.add(A1);
  parking.add(A2);
  parking.add(A3);
  parking.add(B1);
  parking.add(B2);
  parking.add(B3);
  parking.add(B4);
  
  car = loadImage("car.png");
  }

void draw()
{
  background(155);
  if(screen)
  {
    while(myPort.available() >= 3)
    {
       if(myPort.read() == 0xaa)
      {
          val = (myPort.read() << 8 | (myPort.read()));
      }
    }
    
    f = (val/2000.0)*346;
      println(f);
      
    if(f < 455)
     parking.get(x).setOccupied(true);
    else{
     parking.get(x).setOccupied(false);
     parking.get(x).setIn(false);
    }
    
    switch(x)
    {
      case 0:
        name = parking.get(x).getName();
        break;
      case 1:
        name = parking.get(x).getName();
        break;
      case 2:
        name = parking.get(x).getName();
        break;
      case 3:
        name = parking.get(x).getName();
        break;
      case 4:
        name = parking.get(x).getName();
        break;
      case 5:
        name = parking.get(x).getName();
        break;
      case 6:
        name = parking.get(x).getName();
        break;
    }
    
    //strokeWeight(4); 
    int i = int(f);
    car.resize(200,400);
    image(car,150,150-i/2);
    //fill(0,0,255);
    //rect(150,150-f/2,200,400,20);  //car simulator
    
    strokeWeight(0);
    fill(255);
    rect(0,0,500,30);  //top bar
    
    fill(0);
    textSize(12);
    text("time in:",10,20);  //time in text
    if(!parking.get(x).getIn() && !parking.get(x).getOccupied())
    {
      hour = hour();
      minute = minute();
      second = second();
     parking.get(x).setTimeStamp(hour(),minute(),second());
    }
    String time = hour + ":" + minute + ":" + second;
    text(time,60,20);  //time stamp
    
    int price = 0;
    if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 60)
      price = 10;
    else if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 120)
      price = 20;
    else if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 180)
      price = 30;
    else if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 240)
      price = 40;
    else
      price = 40;
      
    text("price: " + price,180,20);    // price text
    
    text("slot: " + name,325,20);  //slot indicator
    
    text("occupied:",400,20);  //occupied text
    
    fill(0,255,0);
    if(parking.get(x).getOccupied())
      adjustColor(x);
    ellipse(470,15,15,15);  //occupied indicator
    
    strokeWeight(10);
    line(100,100,100,500);  //left parking grid
    line(400,100,400,500);  //right parking grid
    
   if(f < 200)
   {   
      strokeWeight(0);
      fill(255,255,0);
      ellipse(450,450,50,50);  //caution sign
    
      textSize(32);
      fill(0);
      text("!",445,460);  //caution text
    }
    
      strokeWeight(2);
      fill(255,255,255);
      rect(10,450,80,30,10);
      fill(0);
      textSize(18);
      text("BACK",28,472);
  }
  
  else
  {
    strokeWeight(0);
    fill(255);
    rect(0,430,500,70);  //index field
    
    strokeWeight(5);
    fill(0);
    line(0,430,500,430);
    
    strokeWeight(0);
    fill(255,0,0);
    ellipse(50,450,20,20);

    fill(215,0,0);
    ellipse(150,450,20,20);
    
    fill(175,0,0);
    ellipse(250,450,20,20);
    
    fill(135,0,0);
    ellipse(350,450,20,20);
    
    fill(95,0,0);
    ellipse(450,450,20,20);
    
    textSize(12);
    fill(0);
    text("0-1 min.", 30,480);
    text("Cost: Php 10",20,495);
    text("1-2 min.", 130,480);
    text("Cost: Php 20",120,495);
    text("2-3 min.", 230,480);
    text("Cost: Php 30",220,495);
    text("4-5 min.", 330,480);
    text("Cost: Php 40",320,495);
    text("5+ min.", 430,480);
    text("Cost: Php 50",420,495);
    
    
    fill(70);
    rect(75,210,10,100);  //entrance thing
    
    fill(0);
    ellipse(80,220,5,5);  //exit pole
    ellipse(80,300,5,5); //enterance pole
    
    strokeWeight(2);
    line(80,220,140,220); //exit gate
    line(80,300,20,300);  //entrance gate
    
    strokeWeight(1);
    noFill();
    arc(300,100,75,75,PI+HALF_PI, PI+PI); //door swing
    line(300,100,300,62.5);
    
    strokeWeight(4);
    
    line(160,0,160,310); //entrance wall
    
    line(160,100,500,100);    //"mall" wall
    
    line(160,170,260,170);  //A1 parking slot
    line(160,240,260,240);  //A2 parking slot
    line(160,310,260,310);  //A3 parking slot
    
    line(400,170,500,170);  //B1 parking slot
    line(400,240,500,240);  //B2 parking slot
    line(400,310,500,310);  //B3 parking slot
    line(400,380,500,380);  //B4 parking slot
    
    
    
    
    //parking slot labels
    textSize(12);
    text("A1",165,150,185,150);
    text("A2",165,220,185,220);
    text("A3",165,290,185,290);
    
    text("B1",485,150,495,150);
    text("B2",485,220,495,220);
    text("B3",485,290,495,290);
    text("B4",485,360,495,360);
    
    strokeWeight(0);
   
    if(parking.get(0).getOccupied())
    adjustColor(0);
    else
    fill(0,255,0);
    ellipse(210,135,20,20);  //A1 indicator
   
    if(parking.get(1).getOccupied())
    adjustColor(1);
    else
    fill(0,255,0);
    ellipse(210,205,20,20);  //A2 indicator
    
    if(parking.get(2).getOccupied())
    adjustColor(2);
    else
    fill(0,255,0);
    ellipse(210,275,20,20);  //A3 indicator
    
    if(parking.get(3).getOccupied())
    adjustColor(3);
    else
    fill(0,255,0);
    ellipse(450,135,20,20);  //B1 indicator
    
    if(parking.get(4).getOccupied())
    adjustColor(4);
    else
    fill(0,255,0);
    ellipse(450,205,20,20);  //B2 indicator
    
    if(parking.get(5).getOccupied())
    adjustColor(5);
    else
    fill(0,255,0);
    ellipse(450,275,20,20);  //B3 indicator
    
    if(parking.get(6).getOccupied())
    adjustColor(6);
    else
    fill(0,255,0);
    ellipse(450,345,20,20);  //B4 indicator
  }
}

void adjustColor(int x)
{
     if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 60)
      fill(255,0,0);
    else if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 120)
      fill(215,0,0);
    else if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 180)
      fill(175,0,0);
    else if(Math.abs(minute() - parking.get(x).getMinute())*60 + Math.abs(second() - parking.get(x).getSecond()) < 240)
      fill(135,0,0);
    else
      fill(95,0,0);
}

void mouseClicked()
{
  
 if(!screen){ 
   if(mouseX > 210 && mouseX < 230)
   {
    if(mouseY > 135 && mouseY < 155)
    {
      x = 0;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = true;
    }
    else if(mouseY > 205 && mouseY < 225)
    {
      x = 1;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = true;
    }
    else if(mouseY > 275 && mouseY < 295)
    {
      x = 2;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = true;
    }
   }
  else if(mouseX > 450 && mouseX < 470)
  {
    if(mouseY > 135 && mouseY < 155)
    {
      x = 3;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = true;
    }
    else if(mouseY > 205 && mouseY < 225)
    {
      x = 4;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = true;
    }
    else if(mouseY > 275 && mouseY < 295)
    {
      x = 5;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = true;
    }
    else if(mouseY > 345 && mouseY < 365)
    {
      x = 6;
      hour = parking.get(x).getHour();
      minute = parking.get(x).getMinute();
      second = parking.get(x).getSecond();
      screen = false;
    }
  }
 }
 else
 {
  if(mouseX > 10 && mouseX < 90 && mouseY > 450 && mouseY < 480)
  {
   screen = false; 
  }
 }
}

class slot
{
   private String name;
   private int hour;
   private int minute;
   private int second;
   private boolean occupied;
   private boolean in;
   
   slot(String n)
   {
     name = n;
     hour = 0;
     minute = 0;
     second = 0;
     occupied = false;
     in = false;
   }
   
   public String getName()
   {
     return name; 
   }
   
   public void setTimeStamp(int h, int m, int s)
   {
      hour = h;
      minute = m;
      second = s;
   }
   
   public int getHour()
   {
      return hour; 
   }
   
   public int getMinute()
   {
      return minute; 
   }
   
   public int getSecond()
   {
      return second; 
   }
   
   public void setOccupied(boolean o)
   {
    occupied = o; 
   }
   
   public boolean getOccupied()
   {
     return occupied; 
   }
   
   public void setIn(boolean i)
   {
    in = i; 
   }
   
   public boolean getIn()
   {
    return in; 
   }
     
}