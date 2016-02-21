#include "dataobject.h"

DataObject::DataObject(){
}

QString DataObject::index(){
    return m_index;
}

QString DataObject::totalTime(){
    return m_totalTime;
}

QString DataObject::lapTime(){
    return m_lapTime;
}
