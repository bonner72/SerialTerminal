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

public void connectPortDEV() {
    // if (COMPort == null) {
    //     //try {
    //         // print connecting statements
    //         textAreaMainMsg("\n", "Connecting to.. " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "");
    //         systemPrintln("Connecting to.. " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "debug");

    //         serialPort = SerialPort.getCommPort("COM3");
    //         serialPort.setComPortParameters(9600, 8, 1, SerialPort.EVEN_PARITY);

    //         serialPort.openPort();
    //         if (serialPort.isOpen()) {
    //             println("CONNECTED");
    //         }
        
    // }

    if (COMPort == null) {
        try {
            if (advancedOptions == true) {
                // print connecting statements
                textAreaMainMsg("\n", "Connecting to.. " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "");
                systemPrintln("Connecting to.. " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "debug");

                // initialize processing serial port
                //COMPort = new processing.serial. Serial(this, selectedPort, intBaudRate, selectedParity, selectedDataBits, selectedStopBits);
                serialPort = SerialPort.getCommPort(selectedPort);
                serialPort.setComPortParameters(selectedBaudRate, 8, 1, SerialPort.EVEN_PARITY);
                serialPort.openPort();
                systemPrintln("Connected to: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "debug");
                textAreaMainMsg("\n", "Connected to: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits, "\n");
                buttonConnect.setText("Connected to: " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
                buttonConnect.setBackground(buttonConnectGreen);
                connectedToCOM = true;
            } else {
                // print connecting statements
                textAreaMainMsg("\n", "Connecting to.. " + selectedPort + "@" + selectedBaudRate, "");
                systemPrintln("Connecting to.. " + selectedPort + "@" + selectedBaudRate, "debug");

                // initialize processing serial port
                serialPort = SerialPort.getCommPort(selectedPort);
                serialPort.setComPortParameters(9600, 8, 1, SerialPort.EVEN_PARITY);
                serialPort.openPort();                systemPrintln("Connected to: " + selectedPort + "@" + selectedBaudRate, "debug");
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
            systemPrintln(error.toString(), "error");
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





