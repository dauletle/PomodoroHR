using Toybox.Timer as Timer;
using Toybox.Time as Time;
using Toybox.Attention as Attention;
using Toybox.Application as App;
using Toybox.System as Sys;

class PomodoroHRLogic {
	var view;
	var state;
	var timer;
	var started = null; // Moment object to save time started
	var debug = false;
	
	enum {
		STATE_IDLE,
		STATE_WORKING,
		STATE_REST
	}
	
	//Initializes by setting the state to STATE_IDLE and intitializing the timer
	function initialize() {
		state = STATE_IDLE;
		timer = new Timer.Timer();
	}
	
	// Sets the view by calling the PomodoroHRView class
	// @_view: view class
	function setView(_view) {
		view = _view;
	}
	
	//Gets the text for the specified state
	function stateLabel() {
		if (state == STATE_IDLE) {
			return "Waiting to begin";
		}
		else if (state == STATE_WORKING) {
			return "Let's work";
		}
		else if (state == STATE_REST) {
			return "Take a break";
		}
		return "unknown";	
	}
	
	//Gets the text color for the specific state
	function stateColor() {
		if (state == STATE_IDLE) {
			return Graphics.COLOR_GREEN;
		}
		else if (state == STATE_WORKING) {
			return Graphics.COLOR_RED;
		}
		else if (state == STATE_REST) {
			return Graphics.COLOR_BLUE;
		}
		return Graphics.COLOR_WHITE;
	}
	
	// return duration left. If timer isn't running, return null
	function duration() {
		//Don't return a duration if the state is not working or at rest
		if (state != STATE_WORKING && state != STATE_REST) {
			return null;
		}

		var seconds;
		//If debug mode, set timer for ten seconds
		if (debug) {
			seconds = 10;
		}
		else {
			//Set seconds to 25 minutes at working state, or 5 minutes at rest state
			seconds = state == STATE_WORKING ? 25*60 : 5*60;
		}
		//Set duration to seconds, formatted in time format
		//Then, set rest to amount of time that has passed since start time and now
		//Lasty, return seconds subtracted by time passed
		var duration = new Time.Duration(seconds);
		var rest = Time.now().subtract(started);
		return duration.subtract(rest);
	}
	
	function getState() {
		return state;
 	}
 	
	function setState(new_state) {
		vibrateOnState(new_state);
		state = new_state;
	}
	
	function vibrateOnState(state) {
		var vibes = [];
		if (state == STATE_WORKING) {
			vibes = [new Attention.VibeProfile(50, 100), new Attention.VibeProfile(10, 100)];
		}
		else if (state == STATE_REST) {
			vibes = [new Attention.VibeProfile(70, 100), new Attention.VibeProfile(50, 100)];
		}
		else if (state == STATE_IDLE) {
			vibes = [new Attention.VibeProfile(10, 100), new Attention.VibeProfile(20, 200),
					 new Attention.VibeProfile(30, 100)];
		}
		Attention.vibrate(vibes);
	}
	
	function startTimer() {
		if (started == null) {
        	timer.start(method(:onTimer), 500, true);
		}
        started = Time.now();
	}
	
	function stopTimer() {
		timer.stop();
		started = null;
	}
	
	//Function to run while timer is running
	function onTimer() {
		//Gets number for time to display
		var left = duration();
		
		if (left == null) {
			return;
		}
		
		// update countdown timer in view's label
		if (left.value() <= 0) {
			// timer overdue, shift to next state
			if (state == STATE_WORKING) {
				setState(STATE_REST);
				startTimer();
			}
			else {
				setState(STATE_IDLE);
				stopTimer();
			}
		}
		view.update();	
	}
	
	//Function for when enter or tap pressed
	//Returns true if state is change and actions are implemented
	//Returns false otherwise
	function startPressed() {
		if (state == STATE_IDLE) {
			setState(STATE_WORKING);
			startTimer();
			return true;
		}
		else if (state == STATE_WORKING) {
			// go to rest state
			setState(STATE_REST);
			startTimer();
			return true;
		}
		else {
			setState(STATE_IDLE);
			stopTimer();
		}
		
		return false;
	}
	
	function cancelPressed() {
		if (state != STATE_IDLE) {
			setState(STATE_IDLE);
			stopTimer();
		}
		return true;
	}
}