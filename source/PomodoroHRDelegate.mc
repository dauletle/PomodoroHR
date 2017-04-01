using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class PomodoroHRDelegate extends Ui.BehaviorDelegate {

	var logic;

	//Simply initializes the delegation, 
	//which also points to the PomodoroHRLogic class
	//@_logic: pointer to the logic class
    function initialize(_logic) {
        logic=_logic;
        BehaviorDelegate.initialize();
    }

    //Function to call when menu button is pressued
    //Calls PomodoroHRMenuDelegate class with logic input
    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new PomodoroHRMenuDelegate(logic), Ui.SLIDE_UP);
        return true;
    }

    //Gets called whe a physical button is pressed
	function onKey(key) {
		//If the "Enter" key is pressed...
		if (key.getKey() == Ui.KEY_ENTER) {
			//Goes to logic.startPressed fucntion, 
			//and will return true if it excecutes properly
			if (logic.startPressed()) {
				//Updates screen if the logic.startPressed function works properly
				Ui.requestUpdate();
			}
			return true;
		}
		return false;
	}
    
    //Gets called when the screen is tapped
    function onTap(key) {
    	//Goes to logic.startPressed fucntion, 
		//and will return true if it excecutes properly
    	if (logic.startPressed()) {
    		//Updates screen if the logic.startPressed function works properly
			Ui.requestUpdate();
		}
    	return true;
    }

}