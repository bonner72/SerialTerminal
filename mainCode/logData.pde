// initialize data logging file
public void initLogFile() {
  fileNameInput = textFieldFileName.getText();
  textFieldFileDirInput = textFieldFileDir.getText() + OsDirChar;
  fileDirectory = textFieldFileDirInput + fileNameInput + ".log";
  fileDirectoryReplaced = fileDirectory.replace("\\", "/");
  try {
    File logFile = new File(fileDirectoryReplaced);
    // Creating File
    if (logFile.createNewFile()) {
      textAreaMainMsg("\n", "File created: " + textFieldFileDirInput + logFile.getName(), "");
      systemPrintln("File created: " + textFieldFileDirInput + logFile.getName());
    } else {
      textAreaMainMsg("\n", "File already exists. ", "");
      systemPrintln("File already exists.");
    }
  }
  catch (IOException e) {
    textAreaMainMsg("\n", "Failed to create log file. " + e, "");
    systemPrintln("Failed to create log file. " + e);
    initLogFileOk = false;
  }

  try {
    //create file writer
    Writer = new FileWriter(fileDirectoryReplaced);
    initLogFileOk = true;
    logData = true;
    textAreaMainMsg("\n", "Logging data to. " + fileDirectory, "");
  }
  catch(Exception e) {
    textAreaMainMsg("\n", "Failed to init writer." + e, "");
    initLogFileOk = false;
  }
}

// write data to log file
public void writeToFile(String data) {
  if (logData == true && dataLogPause == false) {
    try {
      Writer.write(data);
      Writer.flush();
      loggingData = true;
    }
    catch(Exception e) {
      textAreaMainMsg("\n", "Failed to log data." + e, "");
    }
  }
}
