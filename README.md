[![API](https://img.shields.io/badge/API-16%2B-brightgreen.svg?style=plastic)](https://android-arsenal.com/api?level=16)
# JumpGame
*Android FlappyBird-like game*

## What is JumpGame
Learning project.
JumpGame is a simple android, FlappyBird-like game.

## What was used to build app
To code and build this app was used:

**Tools**
* Java 7
* Android Studio 2.3

**Pattern**
* MVVM with Data Binding

**Libraries**
* <a href="https://github.com/ReactiveX/RxJava" title="GraphView">RxJava</a>

**Tested on**
* Nexus 4
* API version 22

## How does it look like
Game has only one view ( state 20.04.2017).

Navigation between activities and fragments is done through Navigarion Drawer | Main view section, consists lists of saved recording sessions
:-------------------------:|:-------------------------:
<img src="https://rawgit.com/GregoryIwanek/AltiMeter/GregoryIwanek-readme/screenshot/nav_drawer.png" title="nav drawer" height="250" />  |  <img src="https://rawgit.com/GregoryIwanek/AltiMeter/master/screenshot/main_view.png" title="main view" height="250" />

Recording session section, works as operation center for recording altitude and locations | Details section, shows basic information and statistics of choosen session
:-------------------------:|:-------------------------:
<img src="https://rawgit.com/GregoryIwanek/AltiMeter/GregoryIwanek-readme/screenshot/recording_session.png" title="recording session" height="250" />  |  <img src="https://rawgit.com/GregoryIwanek/AltiMeter/GregoryIwanek-readme/screenshot/details.png" title="details section" height="250" />

Statistics section, shows global statistics of the all recording sessions | Map section, shows recorded locations as a path on a google map
:-------------------------:|:-------------------------:
<img src="https://rawgit.com/GregoryIwanek/AltiMeter/GregoryIwanek-readme/screenshot/statistics.png" title="statistics section" height="250" />  |  <img src="https://rawgit.com/GregoryIwanek/AltiMeter/GregoryIwanek-readme/screenshot/map.png" title="map section" height="250" />

About section, consists series of fragments with descriptions of other sections | Settings section, holds bunch of custom user settings
:-------------------------:|:-------------------------:
<img src="https://rawgit.com/GregoryIwanek/AltiMeter/master/screenshot/about.png" title="about section" height="250" />  |  <img src="https://rawgit.com/GregoryIwanek/AltiMeter/master/screenshot/settings.png" title="settings section" height="250" />

## To do
* add sound effects
* replace java interface callbacs with RxJava
* add new types of enemies ( random movement pattern)
* add attack ( under bomb button -> remove all enemies upon use)
* add new types of bonuses


Simple QT C++ program for learning german with small SQLite database file which contains some words

Program is divided by two sections and main menu.
GuessSentenceSection (SENTENCE button in main menu) is a game where user have to put WordContainers on Sentence Area in correct order, to get sentence in german language same as given translation in English.
User can use Hint, which will show picture with some grammar rules. Goal can be achieved by sending correct WordContainers to Sentence Area in correct order, or, typing down into LineEdit correct german sentence.

FlashCardSection (FLASH CARD button in main menu) is a game where user have to pair corresponding words in WordContainers on screen. For each pair of words there is translation and origin word.

DONE:
CLASSES
-class MainWindow ( is main window of program)
-class MyApplication (contains MainWindow and will give access to data in futore)
-class MyApplicationData (contains general data, in future will contian settings)
-class Words ( picks word from SQL by generated query)
-class SentenceData (operates on given queries and create instances of Word class, also holds data about words from SQL)
-class SentenceScheme (generates sentences to guess and list of words)
-classes AlgorythmNoun/Verb etc. ( generates queries for picking words from SQL)
-class apperiance (instance is extern- for use in UI apperiance)
-class FlashCardSection which contains logic and UI of section ( it is a bridge between logic and UI)
-class GuessSentenceSection which contains logic and UI of section ( same as above)
-class MyButton (customized button with signals/slots)
-class WordContainer (contains information from Sentence class and displays texts from Word instances)

TODO:
-algorythm for moving WordContainers in GSSection to second Sentence Area if there is no space left in a first one
-algorythm for removing gaps from both Sentence Areas at same time
-timer in FCSection
-settings to choose ( like category of words in FCSecion, number of words in FCSection etc.)
