// function to load the preferences table
public void loadTable () {
    preferenceTable = loadTable("data/preferences.csv", "header");
    systemPrintln("loadTable complete @ " + millis());
}

// function to get data from preferences table
public void getTableData() {
    advancedOptions = boolean(preferenceTable.getInt(0, "mode"));
}

public void setTableData() {
    preferenceTable.setInt(0, "mode", int(advancedOptions));
    saveTable(preferenceTable, "data/preferences.csv");
    systemPrintln("setTableData complete @ " + millis());
}