using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class PomodoroHRMenuDelegate extends Ui.MenuInputDelegate {

    var logic;
    var view;

    //Initializes by continuing logic class
    function initialize(_logic) {
        logic=_logic;
        MenuInputDelegate.initialize();
    }

    //Function to run when menu item is selected
    function onMenuItem(item) {
        if (item == :item_1) {
            // go to rest state
            logic.setState(logic.STATE_REST);
            logic.startTimer();
        } else if (item == :item_2) {
            //Reset timer
            logic.setState(logic.STATE_IDLE);
            logic.stopTimer();
        }
    }

}