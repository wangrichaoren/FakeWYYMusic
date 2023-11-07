//#include <QDir>
//#include <QFileInfo>
//#include <QList>

//class FileScanner : public QObject
//{
//    Q_OBJECT

//public:
//    Q_INVOKABLE QStringList findMp3Files(const QString &directory)
//    {
//        QStringList mp3Files;
//        QDir dir(directory);

//        if (dir.exists()) {
//            QStringList filters;
//            filters << "*.mp3";
//            QFileInfoList fileList = dir.entryInfoList(filters, QDir::Files);

//            foreach (const QFileInfo &fileInfo, fileList) {
//                mp3Files.append(fileInfo.absoluteFilePath());
//            }
//        }

//        return mp3Files;
//    }
//};
