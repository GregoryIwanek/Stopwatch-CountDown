//What does it do?
//CALCULATION CODE
//variables for calculation time are represented by using date().getTime() function ( we get time in miliseconds since 1970something)
//by using date instead of adding intervals on Timer, we can close app, sleep it or turn it to a backglap and when we start again
//stoper still will be working (remember that in QML Timers sleeps/stops when app is in a backglap/sleep/turned off)
import QtQuick 2.0
import Qt.labs.settings 1.0

Item {
    id: stopWatchCodeCalculations

    //to give access to inner properties and functions
    property alias sWTimeTimer: sWTimeTimer
    property alias settingsStopWatch: settingsStopWatch

    property double sWStartTime: 0 //time when we start recording
    property double sWCurrentTime: 0 //current time ( updated everytime when Timer ticks)
    property double sWSleepStart: 0 // after click "STOP" button, store start time() for gap of time
    property double sWSleepStop: 0 // after click "START" button, store stop time() for gap of time
    property double sWSleepTime: 0 //sumarized gap in our time ( after stop button)
    property double sWCombinedTime: 0 //calculated time to display in combinedTime Text
    property string sWCombinedTimeString: "00:00:00.0" //string to display on screen

    property double sWLapTime: 0 //time between checks ( lap time)
    property double sWLapStartTime: 0 //starting point of sWLapTime
    property double sWLapSleepStart: 0 // after click "STOP" button, store start time() for gap of time
    property double sWLapSleepStop: 0 // after click "START" button, store stop time() for gap of time
    property double sWLapSleepTime: 0 //sleep time in lap
    property string sWLapTimeString: "00:00:00.0" //string to display on screen

    property int sWLapCount: 1

    property bool runningStopWatch: false
    property bool runningSWstopWatchSleepTimer: false
    property bool sWIsActive: false
    property bool sWIsEmpty: true //value to determine if we have alredy some records or not ( to start lapTime after 1-st record)

    Settings {
        id: settingsStopWatch
        property alias sWStartTime: stopWatchCodeCalculations.sWStartTime
        property alias sWSleepStart: stopWatchCodeCalculations.sWSleepStart
        property alias sWSleepStop: stopWatchCodeCalculations.sWSleepStop
        property alias sWSleepTime: stopWatchCodeCalculations.sWSleepTime
        property alias sWLapStartTime: stopWatchCodeCalculations.sWLapStartTime
        property alias sWLapSleepStart: stopWatchCodeCalculations.sWLapSleepStart
        property alias sWLapSleepStop: stopWatchCodeCalculations.sWLapSleepStop
        property alias sWLapSleepTime: stopWatchCodeCalculations.sWLapSleepTime
        property alias sWLapCount: stopWatchCodeCalculations.sWLapCount
        property alias sWIsEmpty: stopWatchCodeCalculations.sWIsEmpty
        property alias runningStopWatch: stopWatchCodeCalculations.runningStopWatch
        property alias sWIsActive: stopWatchCodeCalculations.sWIsActive

        Component.onCompleted: {
            if(runningStopWatch == false && sWIsActive == true){
                updateTime()
                setSleepStop()
                setSleepStart()
                getCombinedTime()
                getlapTime()
                sWCombinedTimeString = getTimeString()
                sWLapTimeString = getTimeStringlap()
            }
        }
    }
    //on start button clicked ( new recording, not resuming- there is a different case for resume)
    function setStart(){
        sWStartTime = new Date().getTime()
        sWStartTime = Math.floor(sWStartTime/100)
        sWStartTime = sWStartTime*100
    }

    //on clicked button record
    function setLapStart(){
        sWLapStartTime = sWCurrentTime
    }

    //on every interval on stopWatchTimeTimer tick
    function updateTime(){
            sWCurrentTime = new Date().getTime()
            sWCurrentTime = Math.floor(sWCurrentTime/100)
            sWCurrentTime = sWCurrentTime*100
    }

    //triggered after clicked "STOP" button
    function setSleepStart(){
            sWSleepStart = new Date().getTime()
            sWSleepStart = Math.floor(sWSleepStart/100)
            sWSleepStart = sWSleepStart*100

            sWLapSleepStart = new Date().getTime()
            sWLapSleepStart = Math.floor(sWLapSleepStart/100)
            sWLapSleepStart = sWLapSleepStart*100
    }

    //triggered after clicked "START" button to resume application counting from sleep
    function setSleepStop(){
        if (sWIsActive == true){
            sWSleepStop = new Date().getTime()
            sWSleepStop = Math.floor(sWSleepStop/100)
            sWSleepStop = sWSleepStop*100

            sWLapSleepStop = new Date().getTime()
            sWLapSleepStop = Math.floor(sWLapSleepStop/100)
            sWLapSleepStop = sWLapSleepStop*100

            setSleepTime()
            clearSleep()
        }
    }

    //triggered everytime Timer ticks and state "stop" activated
    function setSleepTime(){
        sWSleepTime = sWSleepTime +(sWSleepStop - sWSleepStart)
        sWLapSleepTime = sWLapSleepTime + (sWLapSleepStop - sWLapSleepStart)
    }

    //function triggered everytime stopWatchTimeTimer ticks
    function getCombinedTime(){
        sWCombinedTime = sWCurrentTime - sWSleepTime - sWStartTime
    }

    //function for getting time of lap ( between checks)
    function getlapTime(){
        if (sWIsEmpty == false){
            sWLapTime = sWCurrentTime - sWLapSleepTime - sWLapStartTime
        }
    }

    //extra zeros in string ( if needed)
    function extraZeros(time){
        return (time < 10 ? "0" : "") + time
    }

    //transformation miliseconds to string representing time in hh:mm:ss:z format (00:00:00.0), 0.1 decimal precision ( combinedTime text)
    function getTimeString(){
        return (extraZeros(Math.floor(sWCombinedTime/3600000))+":") + //hours
                extraZeros(Math.floor((sWCombinedTime%3600000)/60000)) + ":" + //minutes
                extraZeros(Math.floor((sWCombinedTime%60000)/1000)) + "." + //seconds
                Math.floor((sWCombinedTime%1000)/100) //miliseconds
    }

    //transformation of miliseconds to string representing time ( lapTime Text)
    function getTimeStringlap(){
        return (extraZeros(Math.floor(sWLapTime/3600000))+":") + //hours
                extraZeros(Math.floor((sWLapTime%3600000)/60000)) + ":" + //minutes
                extraZeros(Math.floor((sWLapTime%60000)/1000)) + "." + //seconds
                Math.floor((sWLapTime%1000)/100) //miliseconds
    }

    //get status
    function getStatus(){
        if (runningStopWatch == true){return "RUNNING"}
        else if (sWIsActive == true) {return "STOPPED"}
        else {return "INACTIVE"}
    }

    //reseting LAP variables for calculations ( after click LAP)
    function clearLap(){
        sWLapTime = 0
        sWLapStartTime = 0
        sWLapSleepTime = 0
        sWLapTimeString = "00:00:00.0"
    }

    //to clear variables between uses
    function clearSleep(){
        sWLapSleepStart = 0
        sWLapSleepStop = 0
        sWSleepStart = 0
        sWSleepStop = 0
    }

    //clearing all results
    function clearAll(){

        sWIsActive = false
        runningStopWatch = false

        sWStartTime = 0
        sWCurrentTime = 0
        sWSleepStart = 0
        sWSleepStop = 0
        sWSleepTime = 0
        sWCombinedTime = 0
        sWCombinedTimeString = "00:00:00.0"

        sWLapTime = 0
        sWLapStartTime = 0
        sWLapSleepStart = 0
        sWLapSleepStop= 0
        sWLapSleepTime = 0
        sWLapTimeString = "00:00:00.0"

        sWLapCount = 1

        sWIsEmpty = true
    }

    function startClicked(){
        if (runningStopWatch == false && sWIsActive == false){
            setStart()
        }
        runningStopWatch = true
        setSleepStop()
        sWIsActive = true
    }

    function stopClicked(){
        runningStopWatch = false
        setSleepStart()
    }

    function lapClicked(){
        sWLapCount += 1;
        clearLap()
        setLapStart();
        sWIsEmpty = false;
    }

    function clearClicked(){
        clearAll()
    }

    //basic timer for making calculatons
    Timer {
        id: sWTimeTimer
        running: runningStopWatch
        repeat: true
        interval: 16//16 //16 instead of 100 to get more fps and more smoth update of time in texts

        onTriggered: {
            updateTime() //update current time
            getCombinedTime() //calculate time to display on screen
            getlapTime() //calculate lapTime to display on screen
            sWCombinedTimeString = getTimeString() //get string to display on screen
            sWLapTimeString = getTimeStringlap() //get string of lapTime to display on screen
        }
    }

    //separeted timer for updating sWSleepTime
    Timer {
        id: sWSleepTimer
        running: false
        repeat: true
        interval: 100

        onTriggered: {
        }
    }
}
