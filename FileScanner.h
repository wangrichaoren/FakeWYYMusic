#ifndef FILESCANNER_H
#define FILESCANNER_H

#include <QDir>
#include <QFileInfo>
#include <QList>
#include <QDebug>

class FileScanner : public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE QStringList findMp3Files(const QString &directory)
    {

        QStringList mp3Files;
        QDir dir(directory);
        if (dir.exists()) {
            QStringList filters;
            filters << "*.mp3";
            QFileInfoList fileList = dir.entryInfoList(filters, QDir::Files);

            foreach (const QFileInfo &fileInfo, fileList) {
                mp3Files.append(fileInfo.absoluteFilePath());
            }
        }

        return mp3Files;
    }

    Q_INVOKABLE QString parseMp3Name(const QString &filePath)
    {
        QFileInfo fileInfo(filePath);
        if (!fileInfo.isFile()){
            return filePath;
        }
        QString fileNameWithoutExtension = fileInfo.baseName();
//        qDebug() << "File Name: " << fileNameWithoutExtension;
        return fileNameWithoutExtension;
    }
};


#endif // FILESCANNER_H
