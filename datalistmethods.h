#ifndef DATALISTMETHODS
#define DATALISTMETHODS
#include <QObject>
class DataListMethods: public QObject{
public:
    DataListMethods();
    void fillList(QList<QObject*> list);
    QString namee;
}
#endif // DATALISTMETHODS
