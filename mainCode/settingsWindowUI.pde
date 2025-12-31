//draw main ui for settings window
void settingsUI() {
  frameSettings = new JFrame("Settings");
  frameSettings.setSize(500, 300);
  frameSettings.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
  frameSettings.setResizable(false);
  frameSettings.setIconImage(bufferedIcon);
  panelMainSettings = new JPanel();
  panelMainSettings.setBackground(Color.white);
  panelMainSettings.setLayout(layoutSettings);
  //add components here
  drawPortConfig(); //draw port config section ui
  drawDataConfig(); //draw data config section ui
  drawLogConfig();  //draw data logging section ui
  frameSettings.add(panelMainSettings);
  frameSettings.setLocationRelativeTo(null);

  //check if settings UI initialized successfully
  if (frameSettings != null && panelMainSettings != null && drawPortConfigInit == true && drawDataConfigInit == true && drawLogConfigInit == true) {
    systemPrintln("EDT settingsUI = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
    settingsUiInit = true;
    frameSettings.setVisible(true); //make settings window visible
  } else {
    settingsUiInit = false;
  }

  // end of settingsUI
}

//draw port config section ui
void drawPortConfig() {
  //draw (Port Config) label
  labelPortConfig = new JLabel("Port Configuration");
  labelPortConfig.setPreferredSize(new Dimension(120, 20));
  labelPortConfig.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelPortConfig, 10, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelPortConfig, 10, SpringLayout.NORTH, panelMainSettings);
  panelMainSettings.add(labelPortConfig);

  //draw (Port) label
  labelPort = new JLabel("Port");
  labelPort.setPreferredSize(new Dimension(80, 20));
  labelPort.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelPort, 10, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelPort, 30, SpringLayout.NORTH, labelPortConfig);
  panelMainSettings.add(labelPort);

  //draw (Baud Rate) label
  labelBaudRate = new JLabel("Baud Rate");
  labelBaudRate.setPreferredSize(new Dimension(80, 20));
  labelBaudRate.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelBaudRate, 10, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelBaudRate, 40, SpringLayout.NORTH, labelPort);
  panelMainSettings.add(labelBaudRate);

  //draw (Parity) label
  labelPortParity = new JLabel("Parity");
  labelPortParity.setPreferredSize(new Dimension(80, 20));
  labelPortParity.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelPortParity, 10, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelPortParity, 40, SpringLayout.NORTH, labelBaudRate);
  if (advancedOptions == true) {
    panelMainSettings.add(labelPortParity);
  }

  //draw (Data Bits) label
  labelPortDataBits = new JLabel("Data Bits");
  labelPortDataBits.setPreferredSize(new Dimension(80, 20));
  labelPortDataBits.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelPortDataBits, 10, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelPortDataBits, 40, SpringLayout.NORTH, labelPortParity);
  if (advancedOptions == true) {
    panelMainSettings.add(labelPortDataBits);
  }

  //draw (Stop Bits) label
  labelPortStopBits = new JLabel("Stop Bits");
  labelPortStopBits.setPreferredSize(new Dimension(80, 20));
  labelPortStopBits.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelPortStopBits, 10, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelPortStopBits, 40, SpringLayout.NORTH, labelPortDataBits);
  if (advancedOptions == true) {
    panelMainSettings.add(labelPortStopBits);
  }

  //draw COM port combo box
  comboBoxPort = new JComboBox(availableCOMs);
  comboBoxPort.setPreferredSize(new Dimension(110, 20));
  //comboBoxPort.setSelectedIndex(0); //throws error on startup when there are no available COM ports
  layoutSettings.putConstraint(SpringLayout.WEST, comboBoxPort, 80, SpringLayout.WEST, labelPort);
  layoutSettings.putConstraint(SpringLayout.NORTH, comboBoxPort, 0, SpringLayout.NORTH, labelPort);
  panelMainSettings.add(comboBoxPort);
  comboBoxPort.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent actionEvent) {
      systemPrintln("User selected " + comboBoxPort.getSelectedItem().toString());
    }
  }
  );

  //draw Baud Rate combo box
  comboBoxBaudRate = new JComboBox(baudRateList);
  comboBoxBaudRate.setPreferredSize(new Dimension(110, 20));
  comboBoxBaudRate.setSelectedIndex(2);
  comboBoxBaudRate.setEditable(true);
  layoutSettings.putConstraint(SpringLayout.WEST, comboBoxBaudRate, 80, SpringLayout.WEST, labelBaudRate);
  layoutSettings.putConstraint(SpringLayout.NORTH, comboBoxBaudRate, 0, SpringLayout.NORTH, labelBaudRate);
  panelMainSettings.add(comboBoxBaudRate);

  //add action listener to comboBoxBaudRate
  comboBoxBaudRate.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {

      systemPrintln("User selected " + comboBoxBaudRate.getSelectedItem().toString() + " @ " + millis());
    }
  }
  );

  //draw Parity combo box
  comboBoxPortParity = new JComboBox(parityList);
  comboBoxPortParity.setPreferredSize(new Dimension(110, 20));
  comboBoxPortParity.setSelectedIndex(0);
  layoutSettings.putConstraint(SpringLayout.WEST, comboBoxPortParity, 80, SpringLayout.WEST, labelPortParity);
  layoutSettings.putConstraint(SpringLayout.NORTH, comboBoxPortParity, 0, SpringLayout.NORTH, labelPortParity);
  if (advancedOptions == true) {
    panelMainSettings.add(comboBoxPortParity);
  }

  //add action listener to comboBoxPortParity
  comboBoxPortParity.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {

      systemPrintln("User selected " + comboBoxPortParity.getSelectedItem().toString() + " @ " + millis());
    }
  }
  );

  //draw Data Bits combo box
  comboBoxPortDataBits = new JComboBox(dataBitList);
  comboBoxPortDataBits.setPreferredSize(new Dimension(110, 20));
  comboBoxPortDataBits.setSelectedIndex(3);
  layoutSettings.putConstraint(SpringLayout.WEST, comboBoxPortDataBits, 80, SpringLayout.WEST, labelPortDataBits);
  layoutSettings.putConstraint(SpringLayout.NORTH, comboBoxPortDataBits, 0, SpringLayout.NORTH, labelPortDataBits);
  if (advancedOptions == true) {
    panelMainSettings.add(comboBoxPortDataBits);
  }

  //add action listener to comboBoxPortDataBits
  comboBoxPortDataBits.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {
      systemPrintln("User selected " + comboBoxPortDataBits.getSelectedItem().toString() + " @ " + millis());
    }
  }
  );

  //draw Stop Bits combo box
  comboBoxPortStopBits = new JComboBox(stopBitList);
  comboBoxPortStopBits.setPreferredSize(new Dimension(110, 20));
  comboBoxPortStopBits.setSelectedIndex(0);
  layoutSettings.putConstraint(SpringLayout.WEST, comboBoxPortStopBits, 80, SpringLayout.WEST, labelPortStopBits);
  layoutSettings.putConstraint(SpringLayout.NORTH, comboBoxPortStopBits, 0, SpringLayout.NORTH, labelPortStopBits);
  if (advancedOptions == true) {
    panelMainSettings.add(comboBoxPortStopBits);
  }

  //add action listener to comboBoxPortStopBits
  comboBoxPortStopBits.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {

      systemPrintln("User selected " + comboBoxPortStopBits.getSelectedItem().toString() + " @ " + millis());
    }
  }
  );

  //draw ok button
  buttonOk = new JButton("OK");
  buttonOk.setPreferredSize(new Dimension(60, 20));
  buttonOk.setMargin(new Insets(0, 0, 0, 0));
  buttonOk.setFocusPainted(false);
  layoutSettings.putConstraint(SpringLayout.EAST, buttonOk, -10, SpringLayout.EAST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.SOUTH, buttonOk, -10, SpringLayout.SOUTH, panelMainSettings);
  panelMainSettings.add(buttonOk);

  //add action listener to buttonOk
  buttonOk.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {
      if (connectedToCOM == false && portsFound == true) {
        selectedPort = comboBoxPort.getSelectedItem().toString();
        selectedBaudRate = comboBoxBaudRate.getSelectedItem().toString();

        switch (comboBoxPortParity.getSelectedItem().toString()) {
        case "None":
          selectedParity = 'N';
          break;
        case "Even":
          selectedParity = 'E';
          break;
        case "Odd":
          selectedParity = 'O';
          break;
        case "Mark":
          selectedParity = 'M';
          break;
        case "Space":
          selectedParity = 'S';
          break;
        default:
          selectedParity = 'N';
          break;
        }

        selectedDataBits = int(comboBoxPortDataBits.getSelectedItem().toString());
        selectedStopBits = float(comboBoxPortStopBits.getSelectedItem().toString());
        comboBoxPortSelectedIndex = comboBoxPort.getSelectedIndex();
        if (advancedOptions == true) {
          buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate + "," + selectedParity + "," + selectedDataBits + "," + selectedStopBits);
        } else {
          buttonConnect.setText("Disconnected-click to connect " + selectedPort + "@" + selectedBaudRate);
        }
        frameSettings.setVisible(false);
      } else {
        frameSettings.setVisible(false);
      }
      systemPrintln("buttonOk clicked" + " @ " + millis());
    }
  }
  );

  //draw ok button
  buttonCancel = new JButton("CANCEL");
  buttonCancel.setPreferredSize(new Dimension(60, 20));
  buttonCancel.setMargin(new Insets(0, 0, 0, 0));
  buttonCancel.setFocusPainted(false);
  layoutSettings.putConstraint(SpringLayout.EAST, buttonCancel, -65, SpringLayout.EAST, buttonOk);
  layoutSettings.putConstraint(SpringLayout.SOUTH, buttonCancel, -10, SpringLayout.SOUTH, panelMainSettings);
  panelMainSettings.add(buttonCancel);

  //add action listener to buttonCancel
  buttonCancel.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {
      frameSettings.setVisible(false);
      systemPrintln("buttonCancel clicked" + " @ " + millis());
    }
  }
  );

  //check if all components initialized successfully
  if (labelPortConfig != null && labelPort != null && labelBaudRate != null && labelPortParity != null && labelPortDataBits != null && labelPortStopBits != null && comboBoxPort != null && comboBoxBaudRate != null && comboBoxPortParity != null && comboBoxPortDataBits != null && comboBoxPortStopBits != null && buttonOk != null && buttonCancel != null) {
    drawPortConfigInit = true;
    systemPrintln("EDT drawPortConfig = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  } else {
    drawPortConfigInit = false;
  }

  // end of drawPortConfig
}

//draw data config ui
void drawDataConfig() {
  //draw (Data Configuration) label
  labelDataConfig = new JLabel("Data Configuration");
  labelDataConfig.setPreferredSize(new Dimension(150, 20));
  labelDataConfig.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelDataConfig, 255, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelDataConfig, 10, SpringLayout.NORTH, panelMainSettings);
  panelMainSettings.add(labelDataConfig);

  //draw TimeStamp checkbox
  checkBoxTimeStamp = new JCheckBox("Time Stamp");
  checkBoxTimeStamp.setPreferredSize(new Dimension(120, 20));
  checkBoxTimeStamp.setFont(labelFont);
  checkBoxTimeStamp.setOpaque(false);
  checkBoxTimeStamp.setFocusPainted(false);
  layoutSettings.putConstraint(SpringLayout.WEST, checkBoxTimeStamp, 255, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, checkBoxTimeStamp, 40, SpringLayout.NORTH, panelMainSettings);
  panelMainSettings.add(checkBoxTimeStamp);

  //add action listener to checkBoxTimeStamp
  checkBoxTimeStamp.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {
      if (checkBoxTimeStamp.isSelected() == true) {
        showTimeStamp = true;
        textAreaMainMsg("\n", "Enabled time stamp.", "");
      } else {
        textAreaMainMsg("\n", "Disabled time stamp.", "");
        showTimeStamp = false;
      }
      systemPrintln("checkBoxTimeStamp clicked" + " @ " + millis());
    }
  }
  );

  //check if all components initialized successfully
  if (labelDataConfig != null && checkBoxTimeStamp != null) {
    drawDataConfigInit = true;
    systemPrintln("EDT drawDataConfig = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  } else {
    drawDataConfigInit = false;
  }
  // end of drawDataConfig
}

//draw data logging ui
void drawLogConfig() {
  //draw (Log Configuration) label
  labelLogConfig = new JLabel("Log Configuration");
  labelLogConfig.setPreferredSize(new Dimension(120, 20));
  labelLogConfig.setFont(labelFont);
  layoutSettings.putConstraint(SpringLayout.WEST, labelLogConfig, 255, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, labelLogConfig, 100, SpringLayout.NORTH, panelMainSettings);
  panelMainSettings.add(labelLogConfig);

  // draw textFieldFileDir TextField
  textFieldFileDir = new JTextField(defaultLogDir);
  textFieldFileDir.setPreferredSize(new Dimension(155, 20));
  textFieldFileDir.setFont(new Font("Monospaced", Font.PLAIN, 12));
  textFieldFileDir.setForeground(Color.GRAY);
  layoutSettings.putConstraint(SpringLayout.WEST, textFieldFileDir, 255, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, textFieldFileDir, 30, SpringLayout.NORTH, labelLogConfig);
  panelMainSettings.add(textFieldFileDir);

  //add focus listener to textFieldFileDir
  textFieldFileDir.addFocusListener(new FocusListener() {

    // add focusGained event listener to textFieldFileDir
    @Override
      public void focusGained(FocusEvent fe) {
      //if (textFieldFileDir.getText().equals("file directory")) {
      //  textFieldFileDir.setText("");
      textFieldFileDir.setForeground(Color.BLACK);
      //}
      systemPrintln("textFieldFileDir focus gained" + " @ " + millis());
    }

    //add focusLost event listener to textFieldFileDir
    @Override
      public void focusLost(FocusEvent fe) {
      //if (textFieldFileDir.getText().isEmpty()) {
      //textFieldFileDir.setText("file directory");
      textFieldFileDir.setForeground(Color.GRAY);
      //}
      systemPrintln("textFieldFileDir focus lost" + " @ " + millis());
    }
  }
  );

  //draw textFieldFileName TextField
  textFieldFileName = new JTextField(genFileName(randomFileName));
  textFieldFileName.setPreferredSize(new Dimension(155, 20));
  textFieldFileName.setFont(new Font("Monospaced", Font.PLAIN, 12));
  textFieldFileName.setForeground(Color.GRAY);
  layoutSettings.putConstraint(SpringLayout.WEST, textFieldFileName, 255, SpringLayout.WEST, panelMainSettings);
  layoutSettings.putConstraint(SpringLayout.NORTH, textFieldFileName, 30, SpringLayout.NORTH, textFieldFileDir);
  panelMainSettings.add(textFieldFileName);

  //add focus listener to textFieldFileName
  textFieldFileName.addFocusListener(new FocusListener() {

    //focus gained event handler
    @Override
      public void focusGained(FocusEvent fe) {
      //if (textFieldFileName.getText().equals("file name")) {
      //textFieldFileName.setText("");
      textFieldFileName.setForeground(Color.BLACK);
      //}
      systemPrintln("textFieldFileName focus gained" + " @ " + millis());
    }

    //focus lost event handler
    @Override
      public void focusLost(FocusEvent fe) {
      //if (textFieldFileName.getText().isEmpty()) {
      //textFieldFileName.setText("file name");
      textFieldFileName.setForeground(Color.GRAY);
      //}
      systemPrintln("textFieldFileName focus lost" + " @ " + millis());
    }
  }
  );


  //draw buttonBrowse Button
  buttonBrowse = new JButton("Browse");
  buttonBrowse.setPreferredSize(new Dimension(60, 20));
  buttonBrowse.setMargin(new Insets(0, 0, 0, 0));
  buttonBrowse.setFocusPainted(false);
  layoutSettings.putConstraint(SpringLayout.WEST, buttonBrowse, 160, SpringLayout.WEST, textFieldFileName);
  layoutSettings.putConstraint(SpringLayout.NORTH, buttonBrowse, 0, SpringLayout.NORTH, textFieldFileDir);
  panelMainSettings.add(buttonBrowse);

  //add action listener to buttonBrowse
  buttonBrowse.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {

      JFileChooser fileChooser = new JFileChooser();                     //initialize new JFileChooser
      fileChooser.setFileSelectionMode( JFileChooser.DIRECTORIES_ONLY);  //set JFileChooser to only select directories
      int i = fileChooser.showOpenDialog(fileChooser);                   //show JFileChooser

      //if user selected a valid directory and logData is false
      if (i == JFileChooser.APPROVE_OPTION && logData == false) {
        File file = fileChooser.getSelectedFile();
        systemPrintln("User selected " + file.toString());
        textFieldFileDir.setText(file.toString());
        textAreaMainMsg("\n", "Log path set to: " + file.toString(), "");
      } else if (i == JFileChooser.APPROVE_OPTION && logData == true) {
        textAreaMainMsg("\n", "Data logging must be stopped to change log directory.", "");
      }

      systemPrintln("buttonBrowse clicked" + " @ " + millis());
    }
  }
  );

  //draw buttonStartLog Button
  buttonStartLog = new JButton("Start");
  buttonStartLog.setPreferredSize(new Dimension(60, 20));
  buttonStartLog.setMargin(new Insets(0, 0, 0, 0));
  buttonStartLog.setFocusPainted(false);
  layoutSettings.putConstraint(SpringLayout.WEST, buttonStartLog, 0, SpringLayout.WEST, buttonBrowse);
  layoutSettings.putConstraint(SpringLayout.NORTH, buttonStartLog, 30, SpringLayout.NORTH, buttonBrowse);
  panelMainSettings.add(buttonStartLog);
  //add action listener to buttonStartLog
  buttonStartLog.addActionListener(new ActionListener() {
    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {
      if (loggingData == false) {
        initLogFile();
      }
      systemPrintln("buttonStartLog clicked" + " @ " + millis());
    }
  }
  );

  //draw buttonStopLog Button
  buttonStopLog = new JButton("Stop");
  buttonStopLog.setPreferredSize(new Dimension(60, 20));
  buttonStopLog.setMargin(new Insets(0, 0, 0, 0));
  buttonStopLog.setFocusPainted(false);
  layoutSettings.putConstraint(SpringLayout.WEST, buttonStopLog, 0, SpringLayout.WEST, buttonStartLog);
  layoutSettings.putConstraint(SpringLayout.NORTH, buttonStopLog, 30, SpringLayout.NORTH, buttonStartLog);
  panelMainSettings.add(buttonStopLog);

  //add action listener to buttonStopLog
  buttonStopLog.addActionListener(new ActionListener() {

    //action performed event handler
    public void actionPerformed(ActionEvent actionEvent) {
      try {
        if (loggingData) {
          Writer.flush();
          Writer.close();
          Writer = null;
          logData = false;
          textAreaMainMsg("\n", "Stopped logging data to: " + fileDirectory, "");
          loggingData = false;
        }
      }
      catch (IOException e) {
        textAreaMainMsg("\n", "Failed to stop logging data. " + e, "");
      }
      systemPrintln("buttonStopLog clicked" + " @ " + millis());
    }
  }
  );

  //check if all components initialized successfully
  if (labelLogConfig != null && textFieldFileDir != null && textFieldFileName != null && buttonBrowse != null && buttonStartLog != null && buttonStopLog != null) {
    drawLogConfigInit = true;
    systemPrintln("EDT drawLogConfig = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  } else {
    drawLogConfigInit = false;
  }

  // end of drawLogConfig
}
