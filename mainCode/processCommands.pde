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
    textAreaMainMsg("", "-font=<fontNumber> : Set font for main text area and input field" + "\n" + "available font types:" + "\n \t" + "1. Courier" + "\n \t" + "2. Cascadia Code" + "\n \t" + "3. JetBrains Mono(default)" + "\n \t" + "4. Liberation Mono", "\n"); //set font
    textAreaMainMsg("", "-fontsize=<size> : Set font size for main text area and input field" + "\n" + "available font sizes:" + "\n \t" + "10" + "\n \t" + "12" + "\n \t" + "14(Default)" + "\n \t" + "16" + "\n \t" + "18", "\n"); //set font size
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
        setTableData(); //save advanced options to preferences table
        textAreaMainMsg("\n", "Advanced serial port options enabled.", "");
      } else if (enteredCommandSplit.equals("false")) {
        frameSettings = null; //reset settings frame to force rebuild with removed advanced options
        advancedOptions = false;//disable advanced options
        setTableData(); //save advanced options to preferences table
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
  } else if (enteredCommand.startsWith("-font") && !enteredCommand.startsWith("-fontsize")) { //set font
    if (enteredCommand.contains("=")) {
      String enteredCommandSplit = enteredCommand.split("=")[1];
      int fontIndex = int(enteredCommandSplit) - 1;
      if (fontIndex >= 0 && fontIndex < fontList.length) {
        selectedFont = fontList[fontIndex]; //set selected font
        setTableData(); //save selected font to preferences table
        setFont(selectedFont, selectedFontSize); //apply selected font
        textAreaMainMsg("\n", "Set font to " + selectedFont + ".", "");
      } else {
        textAreaMainMsg("\n", "Invalid font number. Use -font=<fontNumber> where fontNumber is between 1 and " + fontList.length + ".", ""); //invalid font number message
      }
    } else {
      textAreaMainMsg("\n", "Invalid command parameter. Use -font=<fontNumber> e.g. -font=1", ""); //invalid format message
    }
  } else if (enteredCommand.startsWith("-fontsize")) { //set font size
    if (enteredCommand.contains("=")) {
      String enteredCommandSplit = enteredCommand.split("=")[1];
      int fontSize = int(enteredCommandSplit);
      if (fontSize == 10 || fontSize == 12 || fontSize == 14 || fontSize == 16 || fontSize == 18) {
        selectedFontSize = fontSize; //set selected font size
        setTableData(); //save selected font size to preferences table
        setFont(selectedFont, selectedFontSize); //apply selected font size
        textAreaMainMsg("\n", "Set font size to " + selectedFontSize + ".", "");
      } else {
        textAreaMainMsg("\n", "Invalid font size. Use -fontsize=<size> where size is 12, 14, 16, or 18.", ""); //invalid font size message
      }
    } else {
      textAreaMainMsg("\n", "Invalid command parameter. Use -fontsize=<size>", ""); //invalid format message
    }
  }
} // END processCommands
