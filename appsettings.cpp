/*in future- for storing custom user settings ( like screen orientation, size of text, color of text etc. it won't store
any variables from calculations ( too poor performance to update it in real time)
*/
#include "appsettings.h"
#include <QDebug>
AppSettings::AppSettings(){
    settings_ = new QSettings("appSettings.ini",QSettings::IniFormat);
}

void AppSettings::saveValue( QString key, QVariant value){
    settings_->setValue(key, value);
}

QVariant AppSettings::getSavedValue( QString key, QVariant defaultValue){

    return settings_->value(key, defaultValue);
}


