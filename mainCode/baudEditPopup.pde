/*
    TODO: Set baudedit and settings dialogs to always on top respectively
 TODO: disable main and settings when above window is open param = frame.setEnabled(false) and frame.setEnabled(true) on close of above windows
 
 */

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
  textAreaBaudEdit = new JTextArea("9600\n" + "14400\n");
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
  buttonEditBaud.addActionListener( new ActionListener() {
    public void actionPerformed(ActionEvent actionEvent) {
      //comboBoxBaudRate.setModel(new DefaultComboBoxModel<>(textAreaBaudEdit.getText().split("\n")));
      dialogBaudEdit.setVisible(false);
      systemPrintln("buttonBaudEditOk clicked @ " + millis());
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
      dialogBaudEdit.setVisible(false);
    }
  }
  );

  //dialogBaudEdit.pack();

  if (dialogBaudEdit != null && textAreaBaudEdit != null && buttonBaudEditOk != null && buttonBaudEditCancel != null) {
    dialogBaudEditIsInit = true;
    dialogBaudEdit.setVisible(true);
  } else {
    dialogBaudEditIsInit = false;
  }
}

