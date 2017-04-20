/*What does it do?
Most basic block of informations which is used in DataMethods lists to contain single record ( totalTime, lapTime, index;
represents one line of text with results from .txt file
*/
#ifndef DATAOBJECT
#define DATAOBJECT
#include <QObject>
class DataObject: public QObject{
    Q_OBJECT
    Q_PROPERTY(QString index READ index CONSTANT)
    Q_PROPERTY(QString totalTime READ totalTime CONSTANT)
    Q_PROPERTY(QString lapTime READ lapTime CONSTANT)
public:
    DataObject();

    //methods
    QString index();
    QString totalTime();
    QString lapTime();

    //attributes
    QString m_index, m_totalTime, m_lapTime;
};

#endif // DATAOBJECT

