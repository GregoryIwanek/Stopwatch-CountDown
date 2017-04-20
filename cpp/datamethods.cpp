#include "datamethods.h"
#include "dataobject.h"
#include <QList>
#include <QObject>
#include <QDebug>
#include <iostream>
#include <sstream>
#include <QTextStream>
#include <QFile>

DataMethods::DataMethods(QString sourceFile){
    setSource(sourceFile);
}

void DataMethods::loadData(){
    //load data from .txt file
    file.open(QIODevice::ReadOnly);
    textStream = new QTextStream(&file);
    while (true){
        string = textStream->readLine();
        if (string.isNull()) break;
        else {
            stringList = string.split(";");
            setDataObject(stringList);
            stringList.clear();
        }
    }
    file.close();
}

void DataMethods::setDataObject(QStringList stringList){
    //set data objects to QList containing list of QObjects representing our results
    DataObject *newDataObject = new DataObject();
    newDataObject->m_totalTime = stringList[0];
    newDataObject->m_lapTime = stringList[1];
    newDataObject->m_index = stringList[2];
    dataList.append(newDataObject);
}

QQmlListProperty<QObject> DataMethods::getList(){
    return QQmlListProperty<QObject>(this, dataList);
}

QList<QObject *> DataMethods::getDataList(){
    return dataList;
}

void DataMethods::setSource(QString sourceFile){
    //set sourcefile
    file.setFileName(sourceFile);
}

void DataMethods::saveData(QString result){
    //append line with result to .txt ( format : totalTime;lapTime;index)
    file.open(QIODevice::Append | QIODevice::Text);
    QTextStream textStreamSave(&file);
    textStreamSave << result;
    textStreamSave << endl;
    file.close();

    stringList = result.split(";");
    setDataObject(stringList);
    emit listChanged();
    stringList.clear();
}

void DataMethods::clearData(){
    file.open(QIODevice::WriteOnly | QIODevice::Truncate);
    file.close();
    dataList.clear();
    emit listChanged();
}

