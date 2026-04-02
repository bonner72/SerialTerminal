//append text to textAreaMain
public void textAreaMainMsg(String A, String MSG, String B) {
  try {
    textAreaMainMsgIsRunning = true;
    if (showTimeStamp == true && A == "\n") {
      textAreaMain.append(A + hour() + ":" + minute() + ":" + second() + " " + MSG + B);
      textAreaMain.setCaretPosition(textAreaMain.getDocument().getLength());
      logOutputData = A + hour() + ":" + minute() + ":" + second() + " " + MSG + B;
      if (initLogFileOk) {
        writeToFile(logOutputData);
      }
    } else if (showTimeStamp == true && MSG.startsWith("\n")) {
      textAreaMain.append(A + MSG + hour() + ":" + minute() + ":" + second() + " " + B);
      textAreaMain.setCaretPosition(textAreaMain.getDocument().getLength());
      logOutputData = A + MSG + hour() + ":" + minute() + ":" + second() + " " + B;
      if (initLogFileOk) {
        writeToFile(logOutputData);
      }
    } else {
      textAreaMain.append(A + MSG + B);
      textAreaMain.setCaretPosition(textAreaMain.getDocument().getLength());
      logOutputData = A + MSG + B;
      //print(logOutputData);
      if (initLogFileOk) {
        writeToFile(logOutputData);
      }
    }
  }
  catch (Exception error) {
    systemPrintln("textAreaMainMsg failed @ " + millis() + "error = " + error, "error");
  }
}

//generate default random file name
public String genFileName(String randomFileName) {
  try {
    if (lettersIndex == 26) {
      lettersIndex = 0;
    }
    randomFileName = "log_" + day() + "-" + month() + "-" + year() + letters[lettersIndex] + hour()+minute()+second();
    lettersIndex++;
  }
  catch (Exception error) {
    systemPrintln("genFileName failed @ " + millis() + "error = " + error, "error");
  }
  systemPrintln("textAreaMainMsg complete @ " + millis(), "debug");
  return randomFileName;
}

// get current operating system
public String getOS() {
  if (platform == MACOS) {
    OS = "mac";
    systemPrintln("OS = MACOS", "debug");
  } else if (platform == WINDOWS) {
    OS = "windows";
    OsDirChar = "\\";
    defaultLogDir = (System.getProperty("user.home") + OsDirChar + "Desktop"); //set default log directory to user's desktop
    systemPrintln("OS = WINDOWS" + " @ " + millis(), "debug");
  } else if (platform == LINUX) {
    OS = "linux";
    OsDirChar = "/";
    defaultLogDir = (System.getProperty("user.home") + OsDirChar + "Desktop"); //set default log directory to user's desktop
    systemPrintln("OS = LINUX" + " @ " + millis(), "debug");
  } else if (platform == OTHER) {
    OS = "other";
    systemPrintln("OS not recognized" + " @ " + millis(), "debug");
  }
  systemPrintln("getOS complete @ " + millis(), "debug");
  return OS;
}

//initialize controls for search function
public void initSearch() {
  try {
    highlighter = new DefaultHighlighter();                                 // create new DefaultHighlighter
    painter = new DefaultHighlighter.DefaultHighlightPainter(Color.YELLOW); // create new DefaultHighlightPainter
    systemPrintln("initSearch complete @ " + millis(), "debug");                     // print debug statement
  }
  catch (Exception error) {
    systemPrintln("initSearch failed @ " + millis() + "error = " + error, "error"); //print debug statement
  }
}

//search textAreaMain
public void getSearch(String searchText) {
  try {                                                                           // try searching textAreaMain
    if (textFieldSearchHasText == true) {                                         // textFieldSearch has text other than prompt text
      if (searchText.length() > 0) {                                              // only run if search text is longer than zero
        String textAreaMainText = textAreaMain.getText();                         // get text from textAreaMain
        highlighter = textAreaMain.getHighlighter();                              // get textAreaMain's highlighter
        highlighter.removeAllHighlights();                                        // remove old highlights
        int index = textAreaMainText.indexOf(searchText);                         // position of first index of search text
        while (index >= 0) {                                                      // search for text
          int searchTextLength = searchText.length();                             // get length of search text
          highlighter.addHighlight(index, index+searchTextLength, painter);       // add highlight to textAreaMain
          index = textAreaMainText.indexOf(searchText, index + searchTextLength); // update index to next search text
        }
      } else {
        highlighter.removeAllHighlights(); // remove all highlights
      }
    }
    systemPrintln("getSearch complete @ " + millis(), "debug"); // print debug statement
  }
  catch (Exception error) { //catch search exception
    systemPrintln("getSearch failed @ " + millis() + "error = " + error, "error"); // print debug statement
  }
}

//convert PImage to BufferedImage
BufferedImage convertToBufferedImage(PImage imgToConvert) {
  BufferedImage convertedImg = new BufferedImage(imgToConvert.width, imgToConvert.height, BufferedImage.TYPE_INT_ARGB);
  try {
    imgToConvert.loadPixels(); //load pixel data

    for (int y = 0; y < imgToConvert.height; y++) {
      for (int x = 0; x < imgToConvert.width; x++) {
        int loc = x + y * imgToConvert.width;
        convertedImg.setRGB(x, y, imgToConvert.pixels[loc]); // Copy pixel data
      }
    }
  }
  catch (Exception error) {
    systemPrintln("convertToBufferedImage failed @ " + millis() + "error = " + error, "error");
  }
  systemPrintln("convertToBufferedImage complete @ " + millis(), "debug");
  return convertedImg;
}
// print to system console
public void systemPrintln(String msg, String type) {
  try {
    if (showDebugStatements == true) {
      if (type.equals("debug")) {
        System.out.println(msg);
      } else if (type.equals("error")) {
        System.err.println(msg);
      }
    } else {
      //do nothing
    }
  }
  catch (Exception error) {
  }
}

// set terminal text fonts
public void setFont(String fontName, float fontSize) {
  try {
    // Path to your font file (TTF or OTF)
    File fontFile = new File(dataPath("") + OsDirChar + fontName); //get font file
    //println(fontFile.getAbsolutePath());
    if (!fontFile.exists()) {
      throw new IOException("Font file not found: " + fontFile.getAbsolutePath());
    }

    // Load the font
    Font customFont = Font.createFont(Font.TRUETYPE_FONT, fontFile)
      .deriveFont(Font.PLAIN, fontSize); // Set style and size

    textAreaMain.setFont(customFont);  // set textAreaMain font
    textFieldMain.setFont(customFont); // set textFieldMain font
    systemPrintln("setFont complete @ " + millis(), "debug");
  }
  catch (FontFormatException e) {
    System.err.println("Invalid font format: " + e.getMessage());
  }
  catch (IOException e) {
    System.err.println("Error loading font: " + e.getMessage());
  }
}

// set software theme
public void setTheme(String theme) {
  try {
    if (theme.equals("light")) {
      UIManager.setLookAndFeel(new FlatLightLaf());              // set theme to light
      FlatLightLaf.setup();
      FlatLaf.updateUI();
      systemPrintln("setTheme complete @ " + millis(), "debug"); // print debug statement
    } else if (theme.equals("dark")) {
      UIManager.setLookAndFeel(new FlatDarkLaf());               // set theme to dark
      FlatDarkLaf.setup();
      FlatLaf.updateUI();
      systemPrintln("setTheme complete @ " + millis(), "debug"); // print debug statement
    } else if (theme.equals("intellij")) {
      UIManager.setLookAndFeel(new FlatIntelliJLaf());               // set theme to dark
      FlatIntelliJLaf.setup();
      FlatLaf.updateUI();
      systemPrintln("setTheme complete @ " + millis(), "debug"); // print debug statement
    } else if (theme.equals("darcula")) {
      UIManager.setLookAndFeel(new FlatDarculaLaf());               // set theme to dark
      FlatDarculaLaf.setup();
      FlatLaf.updateUI();
      systemPrintln("setTheme complete @ " + millis(), "debug"); // print debug statement
    } else {
      systemPrintln("Theme not recognized, defaulting to light theme @ " + millis(), "debug"); // print debug statement
      UIManager.setLookAndFeel(new FlatLightLaf());                                            // default theme to light
      FlatLightLaf.setup();
      FlatLaf.updateUI();
    }
  }
  catch (UnsupportedLookAndFeelException error) {
    systemPrintln("Error setting theme: " + error.getMessage(), "error"); // print error statement
  }
}

// software main setup function
public void setupMain() {
  OS = getOS();     // get operating system             
  loadTable();      // load preferences table           
  getTableData();   // get preferences table data    
  setTheme(theme);  // set software theme               
  iconMain = loadImage("icon.png");                            // import software icon
  iconRefresh = loadImage("refresh.png");                      // import refresh button icon
  iconEditBaud = loadImage("editBaud.png");                    // import edit baud rate button icon
  bufferedIconMain = convertToBufferedImage(iconMain);         // convert PImage to BufferedImage for use as JFrame icon
  bufferedIconRefresh = convertToBufferedImage(iconRefresh);   // convert PImage to BufferedImage for use as refresh button icon
  bufferedIconEditBaud = convertToBufferedImage(iconEditBaud); // convert PImage to BufferedImage for use as edit baud rate button icon
  frameMainWindow = (javax.swing.JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
  canvasMainWindow = (processing.awt.PSurfaceAWT.SmoothCanvas) ((processing.awt.PSurfaceAWT)surface).getNative();
  frameMainWindow.setLocation(displayWidth/2 - wndMinW/2, displayHeight/2 - wndMinH/2);
  frameMainWindow.setSize(wndMinW, wndMinH);
  frameMainWindow.remove(canvasMainWindow);
  frameMainWindow.setMinimumSize(new Dimension(wndMinW, wndMinH));
  frameMainWindow.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
  frameMainWindow.setIconImage(bufferedIconMain);                    // set custom icon
  frameMainWindow.setTitle(versionInfo);                             // set frame title
  frameMainWindow.setResizable(true);                                // allow frame resizing
  frameMainWindow.setVisible(true);                                  // make frame visible

  //add component listener for main frame
  frameMainWindow.addComponentListener(new java.awt.event.ComponentAdapter() {
    public void componentResized(ComponentEvent e) {
      if (mainUiInit == true) { //only run if main UI has been initialized
        panelMain.setBounds(0, 0, width, height);
        panelMain.repaint();
        panelMain.updateUI();

        textAreaMain.repaint();
        textAreaMain.updateUI();
        textAreaMain.setCaretPosition(textAreaMain.getDocument().getLength());
        textAreaMainScrollPane.setPreferredSize(new Dimension(width - 10, height - 106));
        textAreaMainScrollPane.repaint();

        textFieldMain.setPreferredSize(new Dimension(width - 215, 30));
        textFieldMain.repaint();
        textFieldMain.updateUI();

        buttonConnect.setPreferredSize(new Dimension(width - 251, 25));
        buttonConnect.repaint();
        buttonConnect.updateUI();

        buttonLogPauseResume.setPreferredSize(new Dimension(75, 25));
        buttonLogPauseResume.updateUI();
        buttonLogPauseResume.repaint();

        buttonClear.setPreferredSize(new Dimension(75, 25));
        buttonClear.repaint();
        buttonClear.updateUI();

        buttonSettings.setPreferredSize(new Dimension(75, 25));
        buttonSettings.repaint();
        buttonSettings.updateUI();

        textFieldSearch.setPreferredSize(new Dimension(200, 30));
        textFieldSearch.repaint();
        textFieldSearch.updateUI();
      }
    }
  }
  );


  //build main UI on event dispatch thread
  javax.swing.SwingUtilities.invokeLater(new Runnable() {
    public void run() {
      buildMainUI();
    }
  }
  );

  //wait for main UI to initialize before continuing
  while (mainUiInit == false) {
    delay(1);
  }   
  setFont(selectedFont, selectedFontSize);
  searchForPorts(); // search for available serial ports
  initSearch();     // initialize textAreaMain searching
  //set startup message length based on selected font size
  if (selectedFontSize == 12) {
    textAreaMainMsg("", " -------------------------------------" + versionInfo +  "-------------------------------------", "");
  } else   if (selectedFontSize == 14) {
    textAreaMainMsg("", " -------------------------------" + versionInfo +  "-------------------------------", "");
  } else   if (selectedFontSize == 16) {
    textAreaMainMsg("", " -----------------------" + versionInfo +  "----------------------", "");
  } else   if (selectedFontSize == 18) {
    textAreaMainMsg("", " -------------------" + versionInfo +  "--------------------", "");
  }
  textAreaMainMsg("\n", "Enter -h for help", ""); //print help message
  systemPrintln("Startup complete" + " @ " + millis(), "debug");
}

// Processing setup function
public void setup() {
  setupMain(); // software setup function

  // enter code here
}

// Processing loop function
public void draw() {
  // enter code here
}

//Processing settings function
public void settings() {
  size(wndMinW, wndMinH); // set main window size
}

