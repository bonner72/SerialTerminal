public void processCommands() {
  if (enteredCommand.equals("-h")) {
    textAreaMainMsg("\n", "Available Commands:", "\n"); //display help message
    textAreaMainMsg("", "-h : Show this help message", "\n"); //list available commands
    textAreaMainMsg("", "-v : Show version information", "\n"); //shows version info
    textAreaMainMsg("", "-s : Show connection status", "\n"); //shows connection status
    textAreaMainMsg("", "-a=<true|false> : Enable advanced serial port options in settings window", "\n"); //toggle advanced options
    textAreaMainMsg("", "-connect : Connect to selected serial port", "\n"); //connect to serial port
    textAreaMainMsg("", "-disconnect : Disconnect from connected serial port", "\n"); //disconnect from serial port
    textAreaMainMsg("", "-clear : Clear the main text area", "\n"); //clears text area
    textAreaMainMsg("", "-lpause : Pause data logging", "\n"); //pause data logging
    textAreaMainMsg("", "-lresume : Resume data logging", "\n"); //resume data logging
    textAreaMainMsg("", "-settings : Open settings window", "\n"); //open settings window
    textAreaMainMsg("", "-tstamp=<true|false> : Enable/disable time stamp", "\n"); //toggle time stamp
  } else if (enteredCommand.equals("-clear")) { //clear main text area
    textAreaMain.setText(""); //clear main text area
  } else if (enteredCommand.equals("-v")) { //display version info
    textAreaMainMsg("\n", versionInfo, ""); //display version info
  } else if (enteredCommand.startsWith("-a")) { //toggle advanced options
    if (enteredCommand.contains("=")) {
      String enteredCommandSplit = enteredCommand.split("=")[1];
      if (enteredCommandSplit.equals("true")) {
        frameSettings = null; //reset settings frame to force rebuild with new advanced options
        advancedOptions = true; //enable advanced options
        textAreaMainMsg("\n", "Advanced serial port options enabled.", "");
      } else if (enteredCommandSplit.equals("false")) {
        frameSettings = null; //reset settings frame to force rebuild with removed advanced options
        advancedOptions = false;//disable advanced options
        textAreaMainMsg("\n", "Advanced serial port options disabled.", "");
      }
    } else {
      textAreaMainMsg("\n", "Invalid command parameter. Use -a=<true|false>", ""); //invalid format message
    }
  } else if (enteredCommand.startsWith("-tstamp")) { //toggle time stamp
    if (enteredCommand.contains("=")) {
      String enteredCommandSplit = enteredCommand.split("=")[1];
      if (enteredCommandSplit.equals("true")) {
        showTimeStamp = true; //enable time stamp
        checkBoxTimeStamp.setSelected(true); //update settings window checkbox
        textAreaMainMsg("\n", "Enabled time stamp.", "");
      } else if (enteredCommandSplit.equals("false")) {
        textAreaMainMsg("\n", "Disabled time stamp.", "");
        showTimeStamp = false; //disable time stamp
        checkBoxTimeStamp.setSelected(false); //update settings window checkbox
      }
    } else {
      textAreaMainMsg("\n", "Invalid command parameter. Use -tstamp=<true|false>", ""); //invalid format message
    }
  } else if (enteredCommand.equals("-settings")) { //open settings window
    if (frameSettings == null) { //if settings window has not been drawn
      settingsUI(); //draw settings window
      availableCOMs = processing.serial.Serial.list(); //get available serial ports
      comboBoxPort.setModel(new DefaultComboBoxModel(availableCOMs));
    } else { //otherwise if settings window has been drawn make it visible
      frameSettings.setVisible(true);
      availableCOMs = processing.serial.Serial.list();//get available serial ports
      comboBoxPort.setModel(new DefaultComboBoxModel(availableCOMs));
    }
  } else if (enteredCommand.equals("-connect")) { //connect to serial port
    connectPort(); //connect to serial port
  } else if (enteredCommand.equals("-disconnect")) { //disconnect from serial port
    disconnectPort(); //disconnect from serial port
  } else if (enteredCommand.equals("-lpause") && loggingData == true) { //pause data logging
    textAreaMainMsg("\n", "Paused data logging", "");
    dataLogPause = true; //pause data logging
  } else if (enteredCommand.equals("-lresume") && loggingData == true) { //resume data logging
    dataLogPause = false; //resume data logging
    textAreaMainMsg("\n", "Resumed data logging", "");
  } else if (enteredCommand.equals("-s")) { // print connection status
    if (connectedToCOM) {
      if (advancedOptions == true) {
        textAreaMainMsg("\n", "Connection Status: Connected to " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "");
      } else {
        textAreaMainMsg("\n", "Connection Status: Connected to " + selectedPort + "@" + selectedBaudRate, "");
      }
    } else {
      textAreaMainMsg("\n", "Connection Status: Not connected to any serial port.", "");
    }
  }
} // END processCommands