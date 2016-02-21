/*in future- for storing custom user settings ( like screen orientation, size of text, color of text etc. it won't store
any variables from calculations ( too poor performance to update it in real time)
*/
#ifndef APPSETTINGS
#define APPSETTINGS
#include <QObject>
#include <QSettings>
#include <QVariant>
class AppSettings: public QObject{
    Q_OBJECT
public:
    AppSettings();

    Q_INVOKABLE void saveValue (QString key, QVariant value);
    Q_INVOKABLE QVariant getSavedValue (QString key, QVariant defaultValue);

    QSettings *settings_;
    void valueChanged();
};

#endif // APPSETTINGS

