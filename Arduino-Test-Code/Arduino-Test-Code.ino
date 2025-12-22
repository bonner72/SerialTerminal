int l = 0;

void setup() {
  Serial.begin(9600);  //initialize serial
}

void loop() {
  l++; //count program scans

    Serial.print("hello world ");
    //Serial.print(" @ ");
   // Serial.print(l); //print program scan count
    //Serial.print(" scans");
    //Serial.write(10);

  
}
