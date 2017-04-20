/*What does it do?
Contains methods and model informations which can be accessed by QML sections ( stopWatch and countDown)
via Q_PROPERTY, Q_INVOKABLE and QQMLLISTPROPERTY;
operates methods save/clear, list with current results and saving/loading from and to .txt file
*/
#ifndef DATAMETHODS
#define DATAMETHODS
#include <QObject>
#include <QList>
#include <QFile>
#include <QTextStream>
#include <QQmlListProperty>
class DataMethods:public QObject{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<QObject> myModel READ getList NOTIFY listChanged)
public:
    DataMethods(QString sourceFile);

    Q_INVOKABLE void saveData(QString result); //called from QML
    Q_INVOKABLE void clearData(); //called form QML
    void loadData();

    //getters
    QQmlListProperty<QObject> getList();
    QList<QObject*> getDataList();
    //setters
    void setSource(QString sourceFile);
    void setDataObject(QStringList stringList); //sets attributes of DataObjects instance and adds to list

    //attributes
    QFile file;
    QString source, string;
    QTextStream *textStream;
    QStringList stringList;
    QList<QObject *> *listData;
    QList<QObject*> dataList;
signals:
    void listChanged();

};
#endif // DATAMETHODS

