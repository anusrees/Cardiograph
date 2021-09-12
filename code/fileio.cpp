#include "fileio.h"

#include "crypto.h"
#include "random.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

#define DIR "entry\\"

using namespace std;

FileIO::FileIO(QObject *parent) : QObject(parent)
{

}

QString FileIO::source()
{
    return m_source;
}

void FileIO::setSource( QString source )
{
    m_source = QString(DIR).append(source);
    emit sourceChanged();
}

QString FileIO::text()
{
    return m_text;
}

void FileIO::setText( QString text )
{
    m_text = text;
    emit textChanged(m_text);
}

QString FileIO::key()
{
    return m_key;
}

void FileIO::setKey( QString key )
{
    int index;
    int size = key.toStdString().at(0)%key.length();
    int offset = key.toStdString().at(size)%key.length();
    m_key = key;
    index = offset;
    for(int i=0; i<size; i++)
    {
        m_key.push_back(QChar(random[index%128]));
        index++;
    }
    emit keyChanged(m_key);
}

void FileIO::read()
{
    if(m_source.isEmpty()) {
        return;
    }
    QFile file(m_source);
    if(!file.exists()) {
        qWarning() << "Does not exits: " << m_source;
        m_text = "";
        return;
    }
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        m_text = encrypt_decrypt( stream.readAll().toStdString(),
                                  m_key.toStdString(), false );
        emit textChanged(m_text);
    }
    file.close();
}

void FileIO::write()
{
    if(m_source.isEmpty()) {
        return;
    }

    QFile file(m_source);
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        stream << encrypt_decrypt( m_text.toStdString(),
                             m_key.toStdString(), true );
    }

    file.close();
}

bool FileIO::checkPasscodeFile( QString source )
{
    return QFile(source).exists();
}
