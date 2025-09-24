int l = 0;

void setup() {
  Serial.begin(9600);  //initialize serial
}

void loop() {
  l++;

    Serial.print("hello world ");
    Serial.print(" @ ");
    Serial.print(l);
    Serial.print(" scans");
    Serial.write(10);
  
}
