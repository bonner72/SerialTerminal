float i = 1;
int l = 0;
int x;
int y;
bool start = false;

void setup() {
  Serial.begin(9600);  //initialize serial
  int x = millis();
}

void loop() {
  l++;

    Serial.print("hello world ");
    Serial.print(" @ ");
    Serial.print(l);
    Serial.print(" scans");
    Serial.write(10);
  
}
