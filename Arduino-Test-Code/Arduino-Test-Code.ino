void setup() {
  Serial.begin(9600);  //initialize serial at 9600 baud rate
}

void loop() {
  if (Serial.available()) {          // if serial port is connected and has data
    if (Serial.availableForWrite()){ // if serial port can be written to        
      Serial.write(Serial.read());   // echo received data
    }
  }


  
}
