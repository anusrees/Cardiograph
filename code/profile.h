#ifndef PROFILE_H
#define PROFILE_H

#include <QObject>

class Profile : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QString name READ name WRITE setName NOTIFY nameChanged )
    Q_PROPERTY( QString password READ password WRITE setPassword NOTIFY passwordChanged )

public:
    Profile( QObject *parent = 0 );

    QString name();
    void setName( QString name );

    QString password();
    void setPassword( QString password );

    Q_INVOKABLE void readProfile();
    Q_INVOKABLE void generateProfile();
    Q_INVOKABLE int matchPassCode( QString passcode );

signals:
    void nameChanged();
    void passwordChanged();

private:
    QString m_name;
    QString m_password;
};

#endif // PROFILE_H
