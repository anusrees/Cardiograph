#include "profile.h"
#include <QFile>
#include <QTextStream>
#include <QPlainTextEdit>
#include <hashlibpp.h>

Profile::Profile(QObject *parent) : QObject(parent)
{

}

QString Profile::name()
{
    return m_name;
}

void Profile::setName( QString name )
{
    m_name = name;
    emit nameChanged();
}

QString Profile::password()
{
    return m_password;
}

void Profile::setPassword( QString password )
{
    m_password = password;
    emit passwordChanged();
}

void Profile::generateProfile()
{
    QFile file("profile.txt");
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        hashwrapper *h = new sha512wrapper();
        h->test();
        std::string sha = h->getHashFromString(m_password.toStdString());

        stream<<m_name<<"\r\n"<<QString::fromStdString(sha);
    }
    file.close();
}

int Profile::matchPassCode( QString password )
{
    hashwrapper *h = new sha512wrapper();
    h->test();
    std::string sha = h->getHashFromString(password.toStdString());

    if(sha!=m_password.toStdString())
        return 0;

    m_password = password;

    return 1;
}

void Profile::readProfile()
{
    QFile file("profile.txt");
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream in(&file);
        QString line = in.readLine();
        m_name = line;
        line = in.readLine();
        m_password = line;
    }
    file.close();
}
