//build main window controls
void buildMainUI() {
  drawPanelMain();
  drawButtonConnect();
  drawButtonClear();
  drawButtonLogPauseResume();
  drawButtonSettings();
  drawTextAreaMain();
  drawTextFieldMain();
  drawTextFieldSearch();
  if (panelMain != null && textAreaMain != null && textFieldMain != null && textFieldSearch != null && buttonConnect != null && buttonClear != null && buttonSettings != null && buttonLogPauseResume != null) {
    mainUiInit = true;
    systemPrintln("Main UI initialized @ " + millis());
  } else {
    mainUiInit = false;
  }
}

void drawPanelMain() {
  panelMain = new JPanel();
  panelMain.setLocation(0, 0);
  panelMain.setBounds(0, 0, width, height);
  panelMain.setBackground(Color.WHITE);
  panelMain.setLayout(new FlowLayout());
  frame.add(panelMain); //add panel to main frame
  systemPrintln("EDT panelMain = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  panelMain.repaint();
}
//draw main window textarea
void drawTextAreaMain() {
  textAreaMain = new JTextArea();
  textAreaMainScrollPane = new JScrollPane(textAreaMain);
  textAreaMainScrollPane.setPreferredSize(new Dimension(width - 10, height - 75));
  textAreaMain.setFont(new Font(selectedFont, Font.PLAIN, selectedFontSize));
  textAreaMain.setEditable(false);
  textAreaMain.setLineWrap(true);
  panelMain.add(textAreaMainScrollPane);
  systemPrintln("EDT txtAreaMain = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  textAreaMain.repaint();
}

//draw main window textfield
void drawTextFieldMain() {
  textFieldMain = new JTextField();
  textFieldMain.setPreferredSize(new Dimension(width - 215, 30));
  textFieldMain.setFont(new Font(selectedFont, Font.PLAIN, selectedFontSize));
  textFieldMain.setText("Press return key to send text...");
  textFieldMain.setForeground(Color.GRAY);
  panelMain.add(textFieldMain);
  textFieldMain.setEditable(true);
  textFieldMain.setFocusTraversalKeys(KeyboardFocusManager.FORWARD_TRAVERSAL_KEYS, Collections.EMPTY_SET);
  //add focus listener for textFieldMain
  textFieldMain.addFocusListener(new FocusListener() {

    //focus gained event handler
    @Override
      public void focusGained(FocusEvent fe) {
      if (textFieldMain.getText().equals("Press return key to send text...")) {
        textFieldMain.setText("");
        textFieldMain.setForeground(Color.BLACK);
        systemPrintln("textFieldMain focus gained" + " @ " + millis());
      }
    }

    //focus lost event handler
    @Override
      public void focusLost(FocusEvent fe) {
      if (textFieldMain.getText().isEmpty()) {
        textFieldMain.setText("Press return key to send text...");
        textFieldMain.setForeground(Color.GRAY);
        systemPrintln("textFieldMain focus lost" + " @ " + millis());
      }
    }
  }
  );

  //add action listener for textFieldMain
  textFieldMain.addActionListener(new ActionListener() {
    @Override

      public void actionPerformed(ActionEvent e) {
      prevCommandsIndex = 0;  //reset up key press count on enter keyPress
      commandFound = false; //reset commandFound variable

      // check if entered data is a valid command
      for (int i = 0; i < validCommands.length; i ++) {
        if (textFieldMain.getText().equals(validCommands[i])) {
          commandFound = true;
          enteredCommand = textFieldMain.getText(); //update enteredCommand variable
          processCommands();                        //process entered command
        }
      }
      // if entered data is not a command, send to serial port
      if (!commandFound && !textFieldMain.getText().startsWith("-")) {
        writeToPort(textFieldMain.getText());     //send entered text to serial port write process
      } else if (!commandFound && textFieldMain.getText().startsWith("-")) {
        textAreaMainMsg("\n", "Invalid command entered. Type -h for help.", ""); //invalid command message
      }

      previousEnteredCommands.append(textFieldMain.getText()); //store entered command

      //limit previous commands to a set amount of entries
      if (previousEnteredCommands.size() > prevCommandsLimit) {
        previousEnteredCommands.remove(0); //remove oldest entry
      }
      systemPrintln(previousEnteredCommands.toString()); //print previous commands size and content to console

      textFieldMain.setText("");                //clear text field after enter pressed
      systemPrintln("textFieldMain keyPressed Enter" + " @ " + millis());
    }
  }
  );

  textFieldMain.addKeyListener(new KeyAdapter() {
    @Override
      public void keyPressed(KeyEvent evt) {
      //handle up arrow keyPress
      if (evt.getKeyCode() == KeyEvent.VK_UP) {

        if (prevCommandsIndex < previousEnteredCommands.size()) {
          prevCommandsIndex++; // decrement previous commands index
        }
        // if up key press count is less than or equal to previous commands size, get previous command
        if (previousEnteredCommands.size() > 0) {
          String lastCommand = previousEnteredCommands.get(previousEnteredCommands.size() - prevCommandsIndex); // get last entered command
          textFieldMain.setText(lastCommand); // print last entered command to textFieldMain
        }
        systemPrintln("Up arrow key pressed");
      }

      // //handle down arrow keyPress
      if (evt.getKeyCode() == KeyEvent.VK_DOWN) {
        if (prevCommandsIndex > 1) {
          prevCommandsIndex--; // decrement previous commands index
        } else {
          prevCommandsIndex = 0; // set previous commands index to zero which clears textFieldMain's text
        }
        // if previous commands length an previous commands index is greater than zero, get next command
        if (previousEnteredCommands.size() > 0 && prevCommandsIndex > 0) {
          String nextCommand = previousEnteredCommands.get(previousEnteredCommands.size() - prevCommandsIndex); // get next entered command
          textFieldMain.setText(nextCommand); // print next entered command to textFieldMain
        } else {
          textFieldMain.setText(""); // clear textFieldMain if at the most recent command
        }
        systemPrintln("Down arrow key pressed"); // debug print
      }
      systemPrintln("Key pressed: " + evt.getKeyCode() + " " + prevCommandsIndex); // debug print
    }
  }
  );
  systemPrintln("EDT txtAreaMain = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis()); // debug print
  textFieldMain.repaint(); // repaint textFieldMain
}

// draw main window textFieldSearch textfield
void drawTextFieldSearch() {
  textFieldSearch = new JTextField();
  textFieldSearch.setPreferredSize(new Dimension(200, 30));
  textFieldSearch.setFont(new Font("Monospaced", Font.PLAIN, 14));
  textFieldSearch.setText("Enter search text.");
  textFieldSearch.setForeground(Color.GRAY);
  panelMain.add(textFieldSearch);
  textFieldSearch.setEditable(true);

  //add focus listener for textFieldSearch
  textFieldSearch.addFocusListener(new FocusListener() {

    //focus gained event handler
    @Override
      public void focusGained(FocusEvent fe) {
      if (textFieldSearch.getText().equals("Enter search text.")) {
        textFieldSearch.setText("");
        textFieldSearch.setForeground(Color.BLACK);
        textFieldSearchHasText = false;
        systemPrintln("textFieldSearch focus gained" + " @ " + millis());
      }
      textFieldSearchHasText = true;
    }

    //focus lost event handler
    @Override
      public void focusLost(FocusEvent fe) {
      if (textFieldSearch.getText().isEmpty()) {
        textFieldSearch.setText("Enter search text.");
        textFieldSearch.setForeground(Color.GRAY);
        textFieldSearchHasText = false;
        systemPrintln("textFieldSearch focus lost" + " @ " + millis());
      }
      textFieldSearchHasText = true;
    }
  }
  );

  //add action listener for textFieldSearch
  textFieldSearch.addActionListener(new ActionListener() {
    //action performed event handler
    @Override
      public void actionPerformed(ActionEvent e) {
      textFieldSearchHasText = true;
      getSearch(textFieldSearch.getText());
      systemPrintln("textFieldSearch keyPressed Enter" + " @ " + millis());
    }
  }
  );

  //add document listener for textFieldSearch
  textFieldSearch.getDocument().addDocumentListener(new DocumentListener() {
    //insert text update event handler
    @Override
      public void insertUpdate(DocumentEvent e) {
      getSearch(textFieldSearch.getText());
    }

    //remove text update handler
    @Override
      public void removeUpdate(DocumentEvent e) {
      getSearch(textFieldSearch.getText());
    }

    //text changed event handler
    @Override
      public void changedUpdate(DocumentEvent e) {
    }
  }
  );

  systemPrintln("EDT textFieldSearch = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  textFieldSearch.repaint();
}

//draw main window connect button
void drawButtonConnect() {
  buttonConnect = new JButton();
  buttonConnect.setPreferredSize(new Dimension(width - 251, 25));
  buttonConnect.setBackground(bConnectRed);
  buttonConnect.setFocusPainted(false);
  panelMain.add(buttonConnect);

  //add action listener for buttonConnect
  buttonConnect.addActionListener(new ActionListener() {
    @Override
      public void actionPerformed(ActionEvent actionEvent) {
      if (connectedToCOM == false) {
        //connectToCOM = true;
        connectPort();
      } else if (connectedToCOM == true) {
        //connectToCOM = false;
        disconnectPort();
      }
      systemPrintln("buttonConnect clicked" + " @ " + millis());
    }
  }

  );
  systemPrintln("EDT buttonConnect = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  buttonConnect.repaint();
}

//draw main window clear button
void drawButtonClear() {
  buttonClear = new JButton();
  buttonClear.setPreferredSize(new Dimension(75, 25));
  buttonClear.setMargin(new Insets(5, 5, 5, 5));
  buttonClear.setText("Clear");
  buttonClear.setFocusPainted(false);
  panelMain.add(buttonClear);

  //add action listener for buttonClear
  buttonClear.addActionListener(new ActionListener() {
    public void actionPerformed(ActionEvent actionEvent) {
      textAreaMain.setText("");

      systemPrintln("buttonClear clicked" + " @ " + millis());
    }
  }
  );
  systemPrintln("EDT buttonClear = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  buttonClear.repaint();
}

//draw main window settings button
void drawButtonSettings() {
  buttonSettings = new JButton();
  buttonSettings.setPreferredSize(new Dimension(75, 25));
  buttonSettings.setMargin(new Insets(5, 5, 5, 5));
  buttonSettings.setText("Settings");
  buttonSettings.setFocusPainted(false);
  panelMain.add(buttonSettings);

  buttonSettings.addActionListener(new ActionListener() {
    @Override
      public void actionPerformed(ActionEvent actionEvent) {
      if (frameSettings == null) { //if settings window has not been drawn
        settingsUI(); //draw settings window
        availableCOMs = processing.serial.Serial.list(); //get available serial ports
        comboBoxPort.setModel(new DefaultComboBoxModel(availableCOMs));
      } else { //otherwise if settings window has been drawn make it visible
        frameSettings.setVisible(true);
        availableCOMs = processing.serial.Serial.list();//get available serial ports
        comboBoxPort.setModel(new DefaultComboBoxModel(availableCOMs));
      }
      systemPrintln("buttonSettings clicked" + " @ " + millis());
    }
  }
  );
  systemPrintln("EDT buttonSettings = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  buttonSettings.repaint();
}

//draw main window data logging pause/resume button
void drawButtonLogPauseResume() {
  buttonLogPauseResume = new JButton();
  buttonLogPauseResume.setPreferredSize(new Dimension(75, 25));
  buttonLogPauseResume.setMargin(new Insets(0, 0, 0, 0));
  buttonLogPauseResume.setText("Log On/Off");
  buttonLogPauseResume.setFocusPainted(false);
  panelMain.add(buttonLogPauseResume);

  //add action listener for buttonLogPauseResume
  buttonLogPauseResume.addActionListener(new ActionListener() {
    @Override
      public void actionPerformed(ActionEvent actionEvent) {
      if (loggingData == true) {
        if (dataLogPause == false) {
          textAreaMainMsg("\n", "Paused data logging", "");
          dataLogPause = true;
        } else {
          dataLogPause = false;
          textAreaMainMsg("\n", "Resumed data logging", "");
        }
      }
      systemPrintln("buttonLogPauseResume clicked" + " @ " + millis());
    }
  }
  );
  systemPrintln("EDT buttonLogPauseResume = " + javax.swing.SwingUtilities.isEventDispatchThread() + " @ " + millis());
  buttonLogPauseResume.repaint();
}
