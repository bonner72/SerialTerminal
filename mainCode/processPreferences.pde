// function to load the preferences table
public void loadTable () {
  preferenceTable = loadTable("data/preferences.csv", "header");
  systemPrintln("loadTable complete @ " + millis(), "debug");
}

// function to get data from preferences table
public void getTableData() {
  advancedOptions = boolean(preferenceTable.getInt(0, "mode"));
  selectedFont = preferenceTable.getString(0, "font");
  selectedFontSize = preferenceTable.getInt(0, "fontSize");
  String tempBaudRates = preferenceTable.getString(0, "baudRateList").replace("]", "").replace("[", "").replace(" ", "").trim();
  baudRateList = tempBaudRates.split(",");
  theme = preferenceTable.getString(0, "theme");
  currBaudRateModel = new DefaultComboBoxModel(baudRateList);
  systemPrintln("getTableData complete @ " + millis(), "debug");
}

public void setTableData(String mode) {
  if (mode.equals("advanced")) {
    preferenceTable.setInt(0, "mode", int(advancedOptions)); //save advanced options mode to preferences table
    preferenceTable.setString(0, "font", selectedFont);      //save selected font to preferences table
    preferenceTable.setFloat(0, "fontSize", selectedFontSize); //save selected font size to preferences table
    preferenceTable.setString(0, "baudRateList", java.util.Arrays.toString(baudRateList)); //save baud rate list to preferences table
  } else if (mode.equals("basic")) {
    preferenceTable.setString(0, "baudRateList", java.util.Arrays.toString(baudRateList)); //save baud rate list to preferences table
  }
  preferenceTable.setString(0, "theme", theme);
  saveTable(preferenceTable, "data/preferences.csv");
  systemPrintln("setTableData complete @ " + millis(), "debug");
}

