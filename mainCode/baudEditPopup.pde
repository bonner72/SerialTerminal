// TODO(mbahler): Add custom baud rate read/write handler to preferences.csv
public void initDialogBaudEdit() {
  dialogBaudEdit = new JDialog(dialogSettingsMain, "Baud Rate list");
  dialogBaudEdit.setSize(new Dimension(300, 300));
  dialogBaudEdit.setResizable(false);
  dialogBaudEdit.setAlwaysOnTop(true);
  dialogBaudEdit.setLocationRelativeTo(dialogSettingsMain);
  dialogBaudEdit.setLayout(layoutBaudEdit);
  dialogBaudEdit.getContentPane().setBackground(Color.WHITE);
  dialogBaudEdit.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
  dialogBaudEdit.addWindowListener(new WindowAdapter() {
    @Override
      public void windowClosing(WindowEvent e) {
      buttonBaudEditCancel.doClick(); //simulate cancel button click
    }
  }
  );

  // initialize and add text area to dialogBaudEdit
  textAreaBaudEdit = new JTextArea(java.util.Arrays.toString(baudRateList).replace(",", "\n").replace("[", "").replace("]", "").replace(" ", "").trim());
  scrollPaneBaudEdit = new JScrollPane(textAreaBaudEdit);
  scrollPaneBaudEdit.setPreferredSize(new Dimension(274, 226));
  textAreaBaudEdit.setBackground(Color.WHITE);
  textAreaBaudEdit.setLineWrap(true);
  textAreaBaudEdit.setAutoscrolls(true);

  layoutBaudEdit.putConstraint(SpringLayout.WEST, scrollPaneBaudEdit, 5, SpringLayout.WEST, dialogBaudEdit);
  layoutBaudEdit.putConstraint(SpringLayout.NORTH, scrollPaneBaudEdit, 5, SpringLayout.NORTH, dialogBaudEdit);
  dialogBaudEdit.add(scrollPaneBaudEdit);


  // initialize and add OK button to dialogBaudEdit
  buttonBaudEditOk = new JButton("OK");
  buttonBaudEditOk.setPreferredSize(new Dimension(60, 20));
  buttonBaudEditOk.setFocusPainted(false);
  layoutBaudEdit.putConstraint(SpringLayout.EAST, buttonBaudEditOk, 0, SpringLayout.EAST, scrollPaneBaudEdit);
  layoutBaudEdit.putConstraint(SpringLayout.NORTH, buttonBaudEditOk, 5, SpringLayout.SOUTH, scrollPaneBaudEdit);
  dialogBaudEdit.add(buttonBaudEditOk);
  buttonBaudEditOk.addActionListener( new ActionListener() {
    public void actionPerformed(ActionEvent actionEvent) {
      /*Process TextArea Get text from textArea and append it to string array*/
      int textAreaBaudEditLineCount = textAreaBaudEdit.getLineCount();
      String[] textAreaBaudEditArray = {};
      try {// Traverse the text in the JTextArea line by line
        for (int i = 0; i < textAreaBaudEditLineCount; i ++) {
          int start = textAreaBaudEdit.getLineStartOffset(i);
          int end = textAreaBaudEdit.getLineEndOffset(i);
          //processLine(textArea.getText(start, end-start));
          // Step 1: Create a new array with length = original length + 1
          textAreaBaudEditArray = Arrays.copyOf(textAreaBaudEditArray, textAreaBaudEditArray.length + 1);

          // Step 2: Add the new element to the last index of the new array
          textAreaBaudEditArray[textAreaBaudEditArray.length - 1] = textAreaBaudEdit.getText(start, end-start).trim();
          systemPrintln(textAreaBaudEdit.getText(start, end-start).trim());
        }
      }
      catch(BadLocationException e) {
        // Handle exception as you see fit
      }
      //end Process TextArea
      baudRateList = textAreaBaudEditArray;
      newBaudRateModel = new DefaultComboBoxModel(baudRateList); // populate newBaudRateModel with textAreaBaudEdit's text
      comboBoxBaudRate.setModel(newBaudRateModel);                        // set comboBoxBaudRate's model to currBaudRateModel
      dialogSettingsMain.setEnabled(true);                                // enable settings window
      dialogBaudEdit.setVisible(false);                                   // hide baud edit window
      systemPrintln("buttonBaudEditOk clicked @ " + millis());            // print debug statement
    }
  }
  );

  // initialize and add CANCEL button to dialogBaudEdit
  buttonBaudEditCancel = new JButton("CANCEL");
  buttonBaudEditCancel.setPreferredSize(new Dimension(60, 20));
  buttonBaudEditCancel.setMargin(new Insets(0, 0, 0, 0));
  buttonBaudEditCancel.setFocusPainted(false);
  layoutBaudEdit.putConstraint(SpringLayout.EAST, buttonBaudEditCancel, -5, SpringLayout.WEST, buttonBaudEditOk);
  layoutBaudEdit.putConstraint(SpringLayout.NORTH, buttonBaudEditCancel, 5, SpringLayout.SOUTH, scrollPaneBaudEdit);
  dialogBaudEdit.add(buttonBaudEditCancel);
  buttonBaudEditCancel.addActionListener(new ActionListener() {
    public void actionPerformed (ActionEvent actionEvent) {
      /*Process TextArea Get text from textArea and append it to string array*/
      int textAreaBaudEditLineCount = textAreaBaudEdit.getLineCount();
      String[] textAreaBaudEditArray = {};
      try {// Traverse the text in the JTextArea line by line
        for (int i = 0; i < textAreaBaudEditLineCount; i ++) {
          int start = textAreaBaudEdit.getLineStartOffset(i);
          int end = textAreaBaudEdit.getLineEndOffset(i);
          //processLine(textArea.getText(start, end-start));
          // Step 1: Create a new array with length = original length + 1
          textAreaBaudEditArray = Arrays.copyOf(textAreaBaudEditArray, textAreaBaudEditArray.length + 1);

          // Step 2: Add the new element to the last index of the new array
          textAreaBaudEditArray[textAreaBaudEditArray.length - 1] = textAreaBaudEdit.getText(start, end-start).trim();
          systemPrintln(textAreaBaudEdit.getText(start, end-start).trim());
        }
      }
      catch(BadLocationException e) {
        // Handle exception as you see fit
      }
      //end Process TextArea
      if (!textAreaBaudEditArray.equals(baudRateList)) {
        textAreaBaudEdit.setText(java.util.Arrays.toString(baudRateList).replace(",", "\n").replace("[", "\n").replace("]", "\n").replace(" ", "").trim());
      }
      dialogSettingsMain.setEnabled(true); //enable settings window
      dialogBaudEdit.setVisible(false);    //hide baud edit window
    }
  }
  );

  //dialogBaudEdit.pack();

  if (dialogBaudEdit != null && textAreaBaudEdit != null && buttonBaudEditOk != null && buttonBaudEditCancel != null) {
    dialogBaudEditIsInit = true;
    dialogBaudEdit.setVisible(true);      // show baud rate edit window
    dialogSettingsMain.setEnabled(false); // disable setting window
  } else {
    dialogBaudEditIsInit = false;
  }
}

