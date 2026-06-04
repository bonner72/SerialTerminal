public void searchForPortsDEV() {
    if (connectedToCOM == false) {
        commPorts = SerialPort.getCommPorts();                                 // get available comm ports
        systemPrintln("Found " + commPorts.length + " serial ports", "debug"); // print number of ports

        // iterate through port list and print detailed info
        for (SerialPort commPort : commPorts) {
            systemPrint("\n" + "System port name " + commPort.getSystemPortName() + ", ", "debug");
            systemPrint("Descriptive port name " + commPort.getDescriptivePortName() + ", ", "debug");
            systemPrint("Is Port opened ? " + commPort.isOpen() + "\n", "debug");
        }

        availableCOMs = new String[commPorts.length];
        // iterate through port list and add them to availableCOMs
        for (int i = 0; i < commPorts.length; i ++) {
            availableCOMs[i] = commPorts[i].getSystemPortName();
        }

        systemPrintln(java.util.Arrays.toString(availableCOMs), "debug");

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
        commPorts = SerialPort.getCommPorts();          // get available comm ports
        availableCOMs = new String[commPorts.length];   // resize COM list to match commPorts.length

        // iterate through port list and add them to availableCOMs
        for (int i = 0; i < commPorts.length; i ++) {
            availableCOMs[i] = commPorts[i].getSystemPortName();
        }

        if (availableCOMs[0].equals(selectedPort) == true || availableCOMs[comboBoxPortSelectedIndex].equals(selectedPort) == true) {
            systemPrintln("connected port found" + availableCOMs[0], "debug");
        } else {
        }
    }
}


    
    // if (connectedToCOM == false) {
    //     availableCOMs = Serial.list();
    //     if (availableCOMs.length > 0) {
    //     portsFound = true;
    //     selectedPort = availableCOMs[0];
    //     if (advancedOptions == true) {
    //         buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
    //     } else {
    //       buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate);
    //     }
    //     } else {
    //       portsFound = false;
    //       buttonConnect.setText("No serial ports found");
    //     }
    // } else if (connectedToCOM) {
    //     availableCOMs = Serial.list();
    //     if (availableCOMs[0].equals(selectedPort) == true || availableCOMs[comboBoxPortSelectedIndex].equals(selectedPort) == true) {
    //         systemPrintln("connected port found" + availableCOMs[0], "debug");
    //     } else {
    //     }
    // }





