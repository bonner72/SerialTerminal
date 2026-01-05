float selectedStopBits = 1.0; //serial port stop bits 1.0, 1.5, or 2.0 (1.0 is the default)


int lettersIndex = 0; //index for random file name letters

int wndMinH = 500; //minimum height of main window
int wndMinW = 700; //minimum width of main window
int serialInputDataInt;
int selectedDataBits = 8; //serial port data bits 5-6-7-8 (8 is default)
int comboBoxPortSelectedIndex = 0;
int tmr1_lastMillis = 0; //tmr1 last millis reading
int prevCommandsLimit = 10; //limit of previous entered commands stored
int prevCommandsIndex = 0; //count of up key presses for previous command retrieval

char selectedParity = 'N'; //serial port parity 'N' for none, 'E' for even, 'O' for odd, 'M' for mark, 'S' for space ('N' is the default)

boolean connectToCOM = false;          //if connecting to com port
boolean connectedToCOM = false;        //if connected to com port
boolean loggingData = false ;          //if logging succeeded
boolean logDataButtonPressed = false;
boolean stopLoggingDataButtonPressed = false;
boolean dataLogPause = false; //toggles data logging pause/resume
boolean logData = false;
boolean initLogFileOk = false; //if log file successfully initialized
boolean showTimeStamp = false;
boolean portsFound = false;
boolean textAreaMainMsgIsRunning = false;
boolean textFieldSearchHasText = false; //if textFieldSearch has text other than prompt text
boolean serialPortRemoved = false; //if serial port was removed while connected
boolean showDebugStatements = true; //if true show debug statements in console

boolean mainUiInit, settingsUiInit, drawPortConfigInit, drawDataConfigInit, drawLogConfigInit = false; //if UI has been initialized
boolean commandFound = false; //true if entered command is a valid command
boolean advancedOptions = false; //true if advanced serial port options are enabled


String versionInfo = "SerialTerminal 2.2.0";
String selectedPort = null;  // Name of selected COM port
String[] baudRateList = {"2400", "4800", "9600", "38400", "57600", "115200", "250000", "500000", "1000000", "2000000"};
String selectedBaudRate = baudRateList[2];
String[] availableCOMs;  // List of available COM ports
String oldFirstPort;
String serialInputData = "0";
String textFieldFileDirInput;          //Input from fileDirectoryTextField
String fileNameInput;           //Input from fileNameTextField
String fileDirectory;           //Directory for saving data table
String fileDirectoryReplaced;   //Directory \ set to /
String randomFileName;
String logOutputData;
String letters[] = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};
String months[] =  {"", "jan", "feb", "mar", "apr", "may", "jun", "jul", "aug", "sep", "oct", "nov", "dec"};
String OS;               //current operating system
String OsDirChar;  //os specific directory character e.g.(windows dir is \)(linux dir is /)
String defaultLogDir;   //os specific desktop directory
String parityList[] = {"None", "Even", "Odd", "Mark", "Space"};
String dataBitList[] = {"5", "6", "7", "8"};
String stopBitList[] = {"1.0", "1.5", "2.0"};
String serialPortList[];
String enteredCommand = ""; //command entered in textFieldMain updates on enter press
String validCommands[] = {//list of valid commands
  "-h", //help
  "-v", //version
  "-s", //connection status
  "-a", //advanced options
  "-a=true", //enable advanced options
  "-a=false", //disable advanced options
  "-connect", //connect
  "-disconnect", //disconnect
  "-clear", //clear
  "-lpause", //log pause
  "-lresume", //log resume
  "-settings", //settings
  "-tstamp", //timestamp
  "-tstamp=true", //enable timestamp
  "-tstamp=false", //disable timestamp
  "-lstart", //log start
  "-lstop" //log stop
}; //list of valid commands END

StringList previousEnteredCommands = new StringList(); //previous command entered in textFieldMain

PImage icon; //import software icon
Font labelFont = new Font("Arial", Font.PLAIN, 12); //font for labels
FileWriter Writer; //create object of FileWriter for data logging
int intBaudRate = int(selectedBaudRate); //integer value of selectedBaudRate for Serial constructor
processing.serial.Serial COMPort = null; //create object of Serial class

//Controls for main window
JPanel panelMain; //main window panel
JTextArea textAreaMain; //main window text area
JTextField textFieldMain; //main window text field
JTextField textFieldSearch; //main window search text field
JScrollPane textAreaMainScrollPane; //main window text area scroll pane
JButton buttonConnect; //main window connect button
JButton buttonClear; //main window clear button
JButton buttonSettings; //main window settings button
JButton buttonLogPauseResume; //main window log pause/resume button
Highlighter hilit;  //highlighter for textAreaMain search function
Highlighter.HighlightPainter painter;   //painter for textAreaMain search function

//Controls for settings window
JFrame frameSettings; //settings window frame
JLabel labelPortConfig; //settings window Port Configuration label
JLabel labelPort; //settings window Port label
JLabel labelBaudRate; //settings window Baud Rate label
JLabel labelDataConfig; //settings window Data Configuration label
JLabel labelLogConfig; //settings window Log Configuration label
JLabel labelSearchTf; //settings window Search TextField label
JLabel labelPortParity; //settings window Port Parity label
JLabel labelPortDataBits; //settings window Port Data Bits label
JLabel labelPortStopBits; //settings window Port Stop Bits label
JPanel panelMainSettings; //settings window main panel
JComboBox comboBoxPort; //settings window Port combo box
JComboBox comboBoxBaudRate; //settings window Baud Rate combo box
JComboBox comboBoxPortParity; //settings window Port Parity combo box
JComboBox comboBoxPortDataBits; //settings window Port Data Bits combo box
JComboBox comboBoxPortStopBits; //settings window Port Stop Bits combo box
JCheckBox checkBoxTimeStamp = new JCheckBox(); //settings window Time Stamp check box Initialized here due to cli dependencies
JButton buttonOk; //settings window OK button
JButton buttonCancel; //settings window Cancel button
JButton buttonStartLog; //settings window Start Log button
JButton buttonStopLog; //settings window Stop Log button
JButton buttonBrowse; //settings window Browse button
JTextField textFieldFileName; //settings window File Name text field
JTextField textFieldFileDir; //settings window File Directory text field
SpringLayout layoutSettings = new SpringLayout(); //settings window layout manager

BufferedImage bufferedIcon; //buffered image for icon
