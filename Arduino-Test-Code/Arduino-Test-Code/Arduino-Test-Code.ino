String input;

void setup() {
Serial.begin(9600); //initialize serial
Serial.println("Startup");
}

void loop() {
  if (Serial.available() > 0) {  //check if serial is connected
   input = Serial.readString();  //read serial data
    if (input = "hello"){ //if hello is entered in Serial-Monitor
      Serial.println("hello world!"); //send a response
    }
    Serial.println("TEST");
  }    


}
