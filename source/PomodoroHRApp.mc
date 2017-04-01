using Toybox.Application as App;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

var logic;

class PomodoroHRApp extends App.AppBase {

    function initialize() {
        //Declare logic object, which points to the PomodoroHR class
        logic=new PomodoroHRLogic();
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ new PomodoroHRView(logic), new PomodoroHRDelegate(logic) ];
    }

}
