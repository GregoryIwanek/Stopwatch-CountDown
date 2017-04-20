//What does it do?
//CALCULATION CODE
//variables for calculation time are represented by using date().getTime() function ( we get time in miliseconds since 1970something)
//by using date instead of adding intervals on Timer, we can close app, sleep it or turn it to a background and when we start again
//stoper still will be working (remember that in QML Timers sleeps/stops when app is in a background/sleep/turned off)
import QtQuick 2.0
import Qt.labs.settings 1.0

Item {
    id: countDownCodeCalculations

    property alias settingsCountDown: settingsCountDown

    property int hours: 0
    property int minutes: 0
    property int seconds: 0
    property double timeToCountDown: hours*60*60*1000 + minutes*60*1000 + seconds * 1000 // time set to countDown

    property double cDStartTime: 0 //time when we start recording
    property double cDCurrentTime: 0 //current time ( updated everytime when Timer ticks)
    property double cDSleepStart: 0 // after click "STOP" button, store start time() for gap of time
    property double cDSleepStop: 0 // after click "START" button, store stop time() for gap of time
    property double cDSleepTime: 0 //sumarized gap in our time ( between stop <-> start click)
    property double cDCombinedTime: 0 //calculated time to display in cDCombinedTime Text
    property string cDCombinedTimeString: "00:00:00.0"//"00:00:00.0" //string to display on screen

    property double cDLapTime: 0 //time between checks ( lap time)
    property double cDLapStartTime: 0 //starting point of cDLapTime
    property double cDLapSleepStart: 0 // after click "STOP" button, store start time() for gap of time
    property double cDLapSleepStop: 0 // after click "START" button, store stop time() for gap of time
    property double cDLapSleepTime: 0 //sleep time in lap
    property string cDLapTimeString: "00:00:00.0" //string to display on screen
    property string cDLapTimeStringCapture: "00:00:00.0" //separeted string to capture result ( coz of Math.floor/ceil imperfection between different results)

    property int cDLapCount: 1

    property bool cDIsEmpty: true //value to determine if we have alredy some records or not ( to start cDLapTime after 1-st record)

    property bool cDIsActive: false
    property bool runningCountDown: false

    //for storing variables dynamically ( start new session with state of app when ended)
    Settings {
        id: settingsCountDown
        property alias cDStartTime: countDownCodeCalculations.cDStartTime
        property alias cDSleepStart: countDownCodeCalculations.cDSleepStart
        property alias cDSleepStop: countDownCodeCalculations.cDSleepStop
        property alias cDSleepTime: countDownCodeCalculations.cDSleepTime
        property alias cDLapStartTime: countDownCodeCalculations.cDLapStartTime
        property alias cDLapSleepStart: countDownCodeCalculations.cDLapSleepStart
        property alias cDLapSleepStop: countDownCodeCalculations.cDLapSleepStop
        property alias cDLapSleepTime: countDownCodeCalculations.cDLapSleepTime
        property alias cDLapCount: countDownCodeCalculations.cDLapCount
        property alias cDIsEmpty: countDownCodeCalculations.cDIsEmpty
        property alias hours:countDownCodeCalculations.hours
        property alias minutes:countDownCodeCalculations.minutes
        property alias seconds:countDownCodeCalculations.seconds
        property alias cDIsActive: countDownCodeCalculations.cDIsActive
        property alias runningCountDown: countDownCodeCalculations.runningCountDown

        // in case we left app with STOP clicked-> to update time ( from 0:00:00...) when start new session
        Component.onCompleted: {
            if(runningCountDown == false && cDIsActive == true){
                updateTime()
                setSleepStop()
                setSleepStart()
                getCombinedTime()
                getlapTime()
                cDCombinedTimeString = getTimeString()
                cDLapTimeString = getTimeStringlap()
            }
        }
    }

    //on start button clicked ( new recording, not resuming- there is a different case for resume)
    function setStart(){
        cDStartTime = new Date().getTime()
        cDStartTime = Math.floor(cDStartTime/100)
        cDStartTime = cDStartTime*100
    }

    //on clicked button LAP
    function setLapStart(){
        cDLapStartTime = cDCurrentTime
    }

    //on every interval on timeTimer tick
    function updateTime(){
        cDCurrentTime = new Date().getTime()
        cDCurrentTime = Math.floor(cDCurrentTime/100)
        cDCurrentTime = cDCurrentTime*100
    }

    //triggered after clicked "STOP" button
    function setSleepStart(){
        cDSleepStart = new Date().getTime()
        cDSleepStart = Math.floor(cDSleepStart/100)
        cDSleepStart = cDSleepStart*100

        cDLapSleepStart = new Date().getTime()
        cDLapSleepStart = Math.floor(cDLapSleepStart/100)
        cDLapSleepStart = cDLapSleepStart*100
    }

    //triggered after clicked "START" button to resume application counting from sleep
    function setSleepStop(){
        if (cDIsActive == true){
            cDSleepStop = new Date().getTime()
            cDSleepStop = Math.floor(cDSleepStop/100)
            cDSleepStop = cDSleepStop*100

            cDLapSleepStop = new Date().getTime()
            cDLapSleepStop = Math.floor(cDLapSleepStop/100)
            cDLapSleepStop = cDLapSleepStop*100

            setSleepTime()
            clearSleep()
        }
    }

    //triggered everytime Timer ticks and state "stop" activated
    function setSleepTime(){
        cDSleepTime = cDSleepTime +(cDSleepStop - cDSleepStart)
        cDLapSleepTime = cDLapSleepTime + (cDLapSleepStop - cDLapSleepStart)
    }

    //function triggered everytime timeTimer ticks
    function getCombinedTime(){
        cDCombinedTime = timeToCountDown + cDStartTime - cDCurrentTime + cDSleepTime
    }

    //function for getting time of lap ( between checks)
    function getlapTime(){
        if (cDIsEmpty == false){
            cDLapTime = cDCurrentTime - cDLapSleepTime - cDLapStartTime
        }
    }

    //extra zeros in string ( if needed)
    function extraZeros(time){
        return (time < 10 ? "0" : "") + time
    }

    //transformation miliseconds to string representing time in hh:mm:ss:z format (00:00:00.0), 0.1 decimal precision ( cDCombinedTime text)
    function getTimeString(){
        return (extraZeros(Math.floor(cDCombinedTime/3600000))+":") + //hours
                extraZeros(Math.floor((cDCombinedTime%3600000)/60000)) + ":" + //minutes
                extraZeros(Math.floor((cDCombinedTime%60000)/1000)) + "." + //seconds
                Math.floor((cDCombinedTime%1000)/100) //miliseconds
    }

    //transformation of miliseconds to string representing time ( cDLapTime Text)
    function getTimeStringlap(){
        return (extraZeros(Math.floor(cDLapTime/3600000))+":") + //hours
                extraZeros(Math.floor((cDLapTime%3600000)/60000)) + ":" + //minutes
                extraZeros(Math.floor((cDLapTime%60000)/1000)) + "." + //seconds
                Math.floor((cDLapTime%1000)/100) //miliseconds
    }

    //get status
    function getStatus(){
        if (runningCountDown == true){return "RUNNING"}
        else if (cDIsActive == true) {return "STOPPED"}
        else if (cDIsActive == false && timeToCountDown != 0) {return "INACTIVE"}
        else {return "SET TIME"}
    }

    //reseting LAP variables for calculations ( after click LAP)
    function clearLap(){
        cDLapTime = 0
        cDLapStartTime = 0
        cDLapSleepStart = 0
        cDLapSleepStop = 0
        cDLapSleepTime = 0
        cDLapTimeString = "00:00:00.0"
    }

    //to clear variables between uses
    function clearSleep(){
        cDLapSleepStart = 0
        cDLapSleepStop = 0
        cDSleepStart = 0
        cDSleepStop = 0
    }

    //clearing all results
    function clearAll(){

        cDIsActive = false
        runningCountDown = false

        hours = 0
        minutes = 0
        seconds = 0

        cDStartTime = 0
        cDCurrentTime = 0
        cDSleepStart = 0
        cDSleepStop = 0
        cDSleepTime = 0
        cDCombinedTime = 0
        cDCombinedTimeString = "00:00:00.0"

        cDLapTime = 0
        cDLapStartTime = 0
        cDLapSleepStart = 0
        cDLapSleepStop = 0
        cDLapSleepTime = 0
        cDLapTimeString = "00:00:00.0"

        cDLapCount = 1

        cDIsEmpty = true
    }

    function startClicked(){
        if (runningCountDown == false && cDIsActive == false){
            setStart()
        }
        runningCountDown = true
        setSleepStop()
        cDIsActive = true
    }

    function stopClicked(){
        runningCountDown = false
        setSleepStart()
    }

    function lapClicked(){
        cDLapCount += 1;
        clearLap()
        setLapStart();
        cDIsEmpty = false;
    }

    function clearClicked(){
        clearAll()
    }

    //basic timer for making calculatons
    Timer {
        id: timeTimerCountDown
        running: runningCountDown
        repeat: true
        interval: 16//16 //16 instead of 100 to get more fps and more smoth update of time in texts

        onTriggered: {
            updateTime() //update current time
            getCombinedTime() //calculate time to display on screen
            getlapTime() //calculate cDLapTime to display on screen
            cDCombinedTimeString = getTimeString() //get string to display on screen
            cDLapTimeString = getTimeStringlap() //get string of cDLapTime to display on screen
        }
    }

}
