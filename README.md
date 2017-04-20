# Stopwatch-CountDown
*Mobile QtQuick/Qt Stopwatch app*

TESTED ON LUMIA, WINDOWS PHONE 8.1; PC- run on Windows 10
## What is Stopwatch-CountDown
Stopwatch-CountDown is a simple Windows Phone application. Can be used to measure time and count down precisely.

## What was used to build app
To code and build this app were used:

**Tools**
* C++
* <a href="http://doc.qt.io/qt-5/qtqml-index.html" title="QML">QML</a>
* <a href="https://github.com/qtproject" title="qtproject">Qt framework</a>

**Libraries**
* <a href="https://github.com/qt/qtquickcontrols" title="QtQuick">QtQuick</a>

**Tested on**
* Lumia - Windows Phone 8.1
* PC - Windows 10

## How does it look like
Application is divided into C++ ( part of Logic) and QML ( UI and Javascript logic) sections.

**Scheme**

<img src="https://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/scheme.png" title="scheme" height="450" />

**C++ Section, goals:**
* create class for storing splitted string with results (DataObject)✓
* create class for handling methods between QML/C++ and loading stored results from .txt file ( DataMethods), and saving them there✓
* expand data model ( read from .txt file) from c++ to QML by using rootContext ✓
* connect save/load functions from DataMethods with QML by using Q_INVOCABLE, Q_PROPERTY macros ✓
* connect model to ListView delegates in correct sections ✓
* create class for storing global settings ✓ ( FOR FUTURE USE)

**QML section, goals:**
* custom button ✓
* custom text ✓
* custom scrollbar ✓
* loading sections by Loader component to a ListView ✓
* stopwatch section layout ( ListView for printing results, buttons, text)✓
* countdown stack section ( create map to navigate to subsections)✓
* countdown set time subsection layout ( based on vertical PathView) ✓
* countdown main section ( ListView for printing results, buttons, text)✓
* code section for stopwatch section ✓
* code section for countdown section ✓

|StopWatch section main screen. | CountDown section main screen.
|:-------------------------:|:-------------------------:|
<img src="https://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/wp_ss_20160221_0001.jpg" title="stopwatch_section" height="300" />  |  <img src="https://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/wp_ss_20160221_0002.jpg" title="count_down_section" height="300" />

|Custom tumbler. Used to set time to count down. | Visibility is changing if movement stops.| 
| :-------------------------:|:-------------------------: |
<img src="https://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/wp_ss_20160221_0003.jpg" title="custom tumbler" height="300" />  |  <img src="https://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/wp_ss_20160221_0004.jpg" title="custom tumbler visibility" height="300" />

|StopWatch list with records. Records are saved dynamically into .txt | CountDown list with records. Records are saved dynamically into .txt |
|:-------------------------:|:-------------------------:|
<img src="https://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/wp_ss_20160221_0007.jpg" title="stopwatch full" height="300" />  |  <img src="https://rawgit.com/GregoryIwanek/AltiMeter/GregoryIwanek-readme/screenshot/map.pnghttps://rawgit.com/GregoryIwanek/Stopwatch-CountDown/master/GRAPHICS%20FROM%20SMARTPHONE/wp_ss_20160221_0005.jpg" title="count down full" height="300" />

## Issues solved
* performance upon scrolling ListView ✓ ( do not use "rotation" in ListView and ListView's delegates)
* fix freezed Timer while app is sleeping/background ✓ ( Date().getTime() instead of Timer intervals)
* fix starting from ending point between sessions ✓ ( Settings component in Code sections for storing current state)
* connect model from C++ to QML ✓ ( expanding properties with rootContext and Q_PROPERTY(QQmlListProperty<QObject>)
* connect methods from C++ to QML ✓ ( expanding with Q_INVOCABLE and Q_QMLPROPERTY)
* location of .txt file of executable version ✓ ( just put in main executable folder)
* set fixed orientation ( portrait/vertical)✓ ( edit manually AppManifest file with extra lines)
* clear comments ✓

## To Do
* fix conflict between variables for two instances of CodeSection between sessions - ( workaround- sadly, two different files with
same code, but with different first letters of variables-> there is a conflict between variables from StopWatch and CountDown saved
in Settings-> they can overwrite themselfs upon new session, even while id of Sections ( CountDown and StopWatch)
and Settings ( setting for StopWatch and CountDown) are different)


