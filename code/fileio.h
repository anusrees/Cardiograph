#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QUrl>
#include <QString>

class FileIO : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QString key READ key WRITE setKey NOTIFY keyChanged)

public:
    FileIO( QObject *parent = 0 );

    QString source();
    void setSource( QString source );

    QString text();
    void setText( QString text );

    QString key();
    void setKey( QString key );

    static bool checkPasscodeFile( QString source );

    Q_INVOKABLE void read();
    Q_INVOKABLE void write();

signals:
    void sourceChanged();
    void textChanged( QString text );
    void keyChanged( QString key );

private:
    QString m_source;
    QString m_text;
    QString m_key;
};

#endif // FILEIO_H
