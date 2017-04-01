# PomodoroHR
PomodoroHR is a Pomodoro timer made for the Garmin VivoactiveHR.  

According to the [Wikipedia page](https://en.wikipedia.org/wiki/Pomodoro_Technique), Pomodoro uses a timer to break down work into intervals, traditionally 25 minutes in length, separated by short 5 minute breaks. 

The app works the same way, where it displays the 24-hr clock on top, the timer in the middle, and a status message at the bottom.  The timer starts counting down when the enter key is pressed, or the touch screen is tapped.  While uninterrupted, the timer will count down for 25 minutes, then will countdown for 5 minutes.  It will then reset when the 5 minute timer is stopped.  If the enter key or the screen is tapped during a running timer, then the state will change to the next state.  Specifically, if the user hits the enter key or taps the screen while the 25 minute timer is running, it will start running the 5 minute timer. If the user hits the enter key or taps the screen while the 5 minute timer is running, it will sstop the timer, and stay in the idle state.  The user can view menu options by holding the enter key, and they can immediately take a 5 minute break, or start the whole pomodoro cycle over.

This is the first attempt at a Garmin Watch App.  This builds on top of an app that was made by [Shumua on Github](https://github.com/Shmuma/garmin-public/tree/master/pomodoro), except some items were added and removed from their version.  

Along with this, there were the following issues found with this version
- Circular references were detected, which causes a leak in memory.  This will need to be fixed for better efficiency
- Warnings were detected.  The first warning was that the launcher icon was not large enough, so padding was added.  The other warnings were indicating that the 'clockLabel', 'timerLabel', and 'stateLabel' strings should be defined as a string resource and referenced in the strings.xml file.  However, since this was a dynamic variable, I wasn't able to figure out how to do this yet.

Here are some features I would like to add in the future:
- Add a pause function, which simply pauses the timer
- Add a progress bar graphic that shows how much time left
- Change clock to 12-hr format

Feel free to make changes, or provide any suggestions.  Hope you enjoy.
