using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

var clock_string;
var timer_string;
var action_string;


class PomodoroHRView extends Ui.View {

    var clock_label;
    var timer_label;
    var state_label;
    var logic;

    //function initialize() { //without logic declaration
    function initialize(_logic) {
        logic=_logic;
        logic.setView(self);
        View.initialize();
    }


    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        clock_label = View.findDrawableById("clockLabel");
        timer_label = View.findDrawableById("timerLabel");
        state_label = View.findDrawableById("stateLabel");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        Ui.requestUpdate();
    }

    // Update the view
    function onUpdate(dc) {
        getClockLabel();
        setTimerLabel(logic.duration(),logic.getState());
        setStateLabel(logic.stateLabel());
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    //function onHide() {
    //}
    

    function setStateLabel(value){
        state_label.setText(value);
    }

    function setTimerLabel(duration, state){
        if (duration == null) {
            timer_label.setText("25:00");
        }
        else {
            var val = duration.value();
            timer_label.setText(Lang.format("$1$:$2$", [val / 60, (val % 60).format("%02d")]));
        }
        timer_label.setColor(logic.stateColor());
    }

    //Sets clock in 24hr format
    function getClockLabel(){
        var clockTime = Sys.getClockTime();
        clock_label.setText(Lang.format("$1$:$2$", [clockTime.hour, clockTime.min.format("%02d")]));
    }

    function update() {
        Ui.requestUpdate();
    }

}
