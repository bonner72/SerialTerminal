// function to load the preferences table
public void loadTable () {
  preferenceTable = loadTable("data/preferences.csv", "header");
  systemPrintln("loadTable complete @ " + millis());
}

// function to get data from preferences table
public void getTableData() {
  advancedOptions = boolean(preferenceTable.getInt(0, "mode"));
  selectedFont = preferenceTable.getString(0, "font");
  selectedFontSize = preferenceTable.getInt(0, "fontSize");
  systemPrintln("getTableData complete @ " + millis());
}

public void setTableData() {
  preferenceTable.setInt(0, "mode", int(advancedOptions)); //save advanced options mode to preferences table
  preferenceTable.setString(0, "font", selectedFont);      //save selected font to preferences table
  preferenceTable.setInt(0, "fontSize", selectedFontSize); //save selected font size to preferences table
  saveTable(preferenceTable, "data/preferences.csv");
  systemPrintln("setTableData complete @ " + millis());
}
