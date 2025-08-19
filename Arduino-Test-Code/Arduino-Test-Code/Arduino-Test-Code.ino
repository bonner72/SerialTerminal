String input;
float i = 1;
int l;
int x;
int y;

void setup() {
  Serial.begin(9600);  //initialize serial
  Serial.println("Startup");
  int x = millis();
}

void loop() {
  x = millis();
  if (Serial.available() > 0) {        //check if serial is connected
    input = Serial.readString();       //read serial data
    if (input = "hello") {             //if hello is entered in Serial-Monitor
      Serial.println("hello world!");  //send a response
    }
  }
  l++;
  Serial.print("hello world ");
  Serial.print(" @ ");
  Serial.print(l);
  Serial.print(" lines");
  Serial.print(" Scan Time = ");
  Serial.println(y);
  y = millis() - x;

}
