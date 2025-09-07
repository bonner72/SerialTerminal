String input;
float i = 1;
int l = 0;
int x;
int y;
bool start = false;

void setup() {
  Serial.begin(9600);  //initialize serial
  //Serial.println("Startup");
  int x = millis();
}

void loop() {
  l++;
  x = millis();
  if (Serial.available() > 0) {        //check if serial is connected
    input = Serial.readString();       //read serial data
 
  }
    Serial.print("hello world ");
    Serial.print(" @ ");
    Serial.print(l);
    Serial.print(" lines");
    Serial.print(" Scan Time = ");
    Serial.println(y);
    y = millis() - x;
  
}
