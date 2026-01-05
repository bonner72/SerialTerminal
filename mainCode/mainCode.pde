import processing.serial.*;          //import serial library
import java.awt.*;                   //import awt library
import java.awt.Font;                //import awt font library
import java.awt.event.*;             //import awt event library
import java.awt.event.KeyAdapter;    //import awt key adapter library
import java.awt.event.KeyEvent;      //import awt key event library
import java.awt.Dimension.*;         //import awt dimension library
import java.awt.image.BufferedImage; //import awt buffered image library
import javax.swing.*;                //import swing library
import javax.swing.event.*;          //import swing event library
import javax.swing.text.*;           //import swing text library
import java.io.File;                 //import file library
import java.io.FileWriter;           //import file writer library
import java.util.Collections;        //import collections library

javax.swing.JFrame frame; //create instance of JFrame
java.awt.Canvas canvas;   //create instance of Canvas

//append text to textAreaMain
public void textAreaMainMsg(String A, String MSG, String B) {
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

//generate default random file name
public String genFileName(String randomFileName) {
  if (lettersIndex == 26) {
    lettersIndex = 0;
  }
  randomFileName = "log_" + day() + "-" + month() + "-" + year() + letters[lettersIndex] + hour()+minute()+second();
  lettersIndex++;
  return randomFileName;
}

// get current operating system
public void getOS() {
  if (platform == MACOS) {
    OS = "mac";
    systemPrintln("OS = MACOS");
  } else if (platform == WINDOWS) {
    OS = "windows";
    OsDirChar = "\\";
    defaultLogDir = (System.getProperty("user.home") + OsDirChar + "Desktop"); //set default log directory to user's desktop
    systemPrintln("OS = WINDOWS" + " @ " + millis());
  } else if (platform == LINUX) {
    OS = "linux";
    OsDirChar = "/";
    defaultLogDir = (System.getProperty("user.home") + OsDirChar + "Desktop"); //set default log directory to user's desktop
    systemPrintln("OS = LINUX" + " @ " + millis());
  } else if (platform == OTHER) {
    OS = "other";
    systemPrintln("OS not recognized" + " @ " + millis());
  }
}

//initialize controls for search function
public void initSearch() {
  try {
    hilit = new DefaultHighlighter();
    painter = new DefaultHighlighter.DefaultHighlightPainter(Color.YELLOW);
    systemPrintln("initSearch complete @ " + millis());
  }
  catch (Exception e) {
    systemPrintln("initSearch failed @ " + millis());
  }
}

//search textAreaMain
public void getSearch(String searchText) {
  try { // try searching textAreaMain
    if (textFieldSearchHasText == true) { //textFieldSearch has text other than prompt text
      if (searchText.length() > 0) { //only run if search text is longer than zero
        String textAreaMainText = textAreaMain.getText();
        hilit = textAreaMain.getHighlighter();
        hilit.removeAllHighlights();
        int index = textAreaMainText.indexOf(searchText);
        while (index >= 0) { //search text
          int searchTextLength = searchText.length();
          hilit.addHighlight(index, index+searchTextLength, painter);
          index = textAreaMainText.indexOf(searchText, index + searchTextLength);
        }
      } else { //remove all highlights
        hilit.removeAllHighlights();
      }
    }
    systemPrintln("getSearch complete @ " + millis());
  }
  catch (Exception e) { //catch search exception
    systemPrintln("getSearch failed @ " + millis());
  }
}

//convert PImage to BufferedImage
BufferedImage convertToBufferedImage(PImage imgToConvert) {
  imgToConvert.loadPixels(); //load pixel data
  BufferedImage convertedImg = new BufferedImage(imgToConvert.width, imgToConvert.height, BufferedImage.TYPE_INT_ARGB);

  for (int y = 0; y < imgToConvert.height; y++) {
    for (int x = 0; x < imgToConvert.width; x++) {
      int loc = x + y * imgToConvert.width;
      convertedImg.setRGB(x, y, imgToConvert.pixels[loc]); // Copy pixel data
    }
  }
  return convertedImg;
}
// print to system console
public void systemPrintln(String msg) {
  if (showDebugStatements == true) {
    System.out.println(msg);
  } else {
    //do nothing
  }
}

// Processing setup function
public void setup() {
  icon = loadImage("icon.png");    //import software icon
  bufferedIcon = convertToBufferedImage(icon); //convert PImage to BufferedImage for use as JFrame icon
  frame = (javax.swing.JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
  canvas = (processing.awt.PSurfaceAWT.SmoothCanvas) ((processing.awt.PSurfaceAWT)surface).getNative();
  frame.setLocation(displayWidth/2 - wndMinW/2, displayHeight/2 - wndMinH/2);
  frame.remove(canvas);
  frame.setMinimumSize(new Dimension(wndMinW, wndMinH));
  frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
  frame.setIconImage(bufferedIcon); //set custom icon
  frame.setTitle(versionInfo); //set frame title
  frame.setResizable(true); //allow frame resizing
  frame.setVisible(true); //make frame visible
  //add component listener for main frame

  frame.addComponentListener(new java.awt.event.ComponentAdapter() {
    public void componentResized(ComponentEvent e) {
      if (mainUiInit == true) { //only run if main UI has been initialized
        panelMain.setBounds(0, 0, width, height);
        panelMain.repaint();
        panelMain.updateUI();

        textAreaMain.repaint();
        textAreaMain.updateUI();
        textAreaMain.setCaretPosition(textAreaMain.getDocument().getLength());
        textAreaMainScrollPane.setPreferredSize(new Dimension(width - 10, height - 75));
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
  loadTable();    //load preferences table
  getTableData(); //get preferences table data
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

  getOS();          //get operating system
  searchForPorts(); //search for available serial ports
  initSearch();     //initialize textAreaMain searching
  textAreaMainMsg("", " -------------------------------" + versionInfo +  "-------------------------------", "");
  textAreaMainMsg("\n", "Enter -h for help", "");
  systemPrintln("Startup complete" + " @ " + millis());
}

// Processing loop function
public void draw() {
}

//Processing settings function
public void settings() {
  size(wndMinW, wndMinH);
}
