
//search for available serial ports
public void searchForPorts() {

  if (connectedToCOM == false) {
    availableCOMs = Serial.list();
    if (availableCOMs.length > 0) {
      portsFound = true;
      selectedPort = availableCOMs[0];
      if (advancedOptions == true) {
        buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
      } else {
        buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate);
      }
    } else {
      portsFound = false;
      buttonConnect.setText("No serial ports found");
    }
  } else if (connectedToCOM) {
    availableCOMs = Serial.list();
    if (availableCOMs[0].equals(selectedPort) == true || availableCOMs[comboBoxPortSelectedIndex].equals(selectedPort) == true) {
      systemPrintln("connected port found" + availableCOMs[0]);
    } else {
    }
  }
}

// connect to serial port
public void connectPort() {
  if (COMPort == null) {
    try {
      if (advancedOptions == true) {
        // print connecting statements
        textAreaMainMsg("\n", "Connecting to.. " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "");
        systemPrintln("Connecting to.. " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);

        // initialize processing serial port
        COMPort = new processing.serial. Serial(this, selectedPort, intBaudRate, selectedParity, selectedDataBits, selectedStopBits);
        systemPrintln("Connected to: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
        textAreaMainMsg("\n", "Connected to: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "\n");
        buttonConnect.setText("Connected to: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
        buttonConnect.setBackground(buttonConnectGreen);
        connectedToCOM = true;
      } else {
        // print connecting statements
        textAreaMainMsg("\n", "Connecting to.. " + selectedPort + "@" + selectedBaudRate, "");
        systemPrintln("Connecting to.. " + selectedPort + "@" + selectedBaudRate);

        // initialize processing serial port
        COMPort = new processing.serial. Serial(this, selectedPort, intBaudRate);
        systemPrintln("Connected to: " + selectedPort + "@" + selectedBaudRate);
        textAreaMainMsg("\n", "Connected to: " + selectedPort + "@" + selectedBaudRate, "\n");
        buttonConnect.setText("Connected-click to disconnect " + selectedPort + "@" + selectedBaudRate);
        buttonConnect.setBackground(buttonConnectGreen);
        connectedToCOM = true;
      }
    }
    catch (Exception error) {
      connectToCOM = false;
      connectedToCOM = false;
      COMPort = null;
      textAreaMainMsg("\n", error.toString(), "");
      systemPrintln(error.toString());
    }
  }
}

//disconnect serial port
public void disconnectPort() {
  if (COMPort != null) {
    try {
      COMPort.clear();
      COMPort.stop();
      COMPort.dispose();
      COMPort = null;
      connectedToCOM = false;
      if (advancedOptions == true) {
        systemPrintln("Disconnected from: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
        textAreaMainMsg("\n", "Disconnected from: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "");
        buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
        buttonConnect.setBackground(buttonConnectRed);
      } else {
        systemPrintln("Disconnected from: " + selectedPort + "@" + selectedBaudRate);
        textAreaMainMsg("\n", "Disconnected from: " + selectedPort + "@" + selectedBaudRate, "");
        buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate);
        buttonConnect.setBackground(buttonConnectRed);
      }
    }
    catch (Exception error) {
      textAreaMainMsg("\n", error.toString(), "");
      systemPrintln(error.toString());
    }
  }
}

//write data to serial port
public void writeToPort(String i) {
  try {
    if (i.length() > 0) {
      COMPort.write(i);
      textAreaMainMsg("\n", i, "\n");
    } else {
      COMPort.write('\n');
      textAreaMainMsg("", "\n", "");
    }
  }
  catch (Exception error) {

    if (!connectedToCOM) {
      textAreaMainMsg("\n", "ERROR--Failed to send data... Not connected to serial port.", "");
      systemPrintln("ERROR--Failed to send data... Not connected to serial port.");
    } else {
      textAreaMainMsg("\n", "ERROR--Failed to send data..." + '\n' + error, "");
      systemPrintln("ERROR--Failed to send data..." + '\n' + error);
    }
  }
}

//read data from serial port
public void serialEvent(Serial p) {
  serialInputData = p.readString();
  textAreaMainMsg("", serialInputData, "");
  textAreaMain.setCaretPosition(textAreaMain.getDocument().getLength()); //set textAreaMain to autoscroll
}

