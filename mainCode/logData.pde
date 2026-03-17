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
      logFileExists = false;
      textAreaMainMsg("\n", "File created: " + textFieldFileDirInput + logFile.getName(), "");
      systemPrintln("File created: " + textFieldFileDirInput + logFile.getName());
    } else if (logFile.exists()) {
      logFileExists = true;
      textAreaMainMsg("\n", "File already exists: " + textFieldFileDirInput + logFile.getName(), "");
      systemPrintln("File already exists: " + textFieldFileDirInput + logFile.getName());
    }
  }
  catch (IOException e) {
    textAreaMainMsg("\n", "Failed to create log file. " + e, "");
    systemPrintln("Failed to create log file. " + e);
    initLogFileOk = false;
  }

  try {
    Writer = new FileWriter(fileDirectoryReplaced, true);
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
      Writer.append(data);
      //Writer.write(data);
      Writer.flush();
      loggingData = true;
    }
    catch(Exception e) {
      textAreaMainMsg("\n", "Failed to log data." + e, "");
    }
  }
}
