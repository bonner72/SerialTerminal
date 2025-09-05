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
  Serial.println("Enter ""start"" to start and ""stop"" to stop.");
}

void loop() {
  l++;
  x = millis();
  
  while (Serial.available() == 0) {}
  input = Serial.readString();
  input.trim();                      
  if (input == "start") {            
    Serial.println("Starting....");  
    start = true;
  } else if (input == "stop") {
    Serial.println("Stopping...");
    start = false;
  }

if (start == true) {
  Serial.print("hello world ");
  Serial.print(" @ ");
  Serial.print(l);
  Serial.print(" lines");
  Serial.print(" Scan Time = ");
  Serial.println(y);
  y = millis() - x;
}
}
