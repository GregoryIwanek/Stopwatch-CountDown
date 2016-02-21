//#include "datalist.h"
//#include "dataobject.h"
//#include <QDebug>
//DataList::DataList(QString name, QString sourceFile)
//{
//    setSource(sourceFile);
//    setReciever(name);
//    loadData();
//}

//void DataList::loadData()
//{
//    file.open(QIODevice::ReadOnly);
//    textStream = new QTextStream(&file);
//    while (true){
//        string = textStream->readLine();

//        if (string.isNull()) break;
//        else {
//            stringList = string.split(";");
//            setDataObject(stringList);
//            stringList.clear();
//        }
//    }
//}

//void DataList::setSource(QString sourceFile){
//    file.setFileName(sourceFile);
//}

//void DataList::setDataObject(QStringList stringList){
//    indexList.append(stringList[0]);
//    totalTimeList.append(stringList[1]);
//    lapTimeList.append(stringList[2]);
//    DataObject *newDataObject = new DataObject(reciever);
//    newDataObject->m_index = stringList[0];
//    newDataObject->m_totalTime = stringList[1];
//    newDataObject->m_lapTime = stringList[2];
//    dataList.append(newDataObject);
//}

//void DataList::setReciever(QString name){
//    reciever = name;
//}

//QStringList DataList::getIndexList()
//{
//    return indexList;
//}

//QList<QObject *> DataList::getDataList()
//{
//    return dataList;
//}



////void DataList::fillWithData()
////{

////}

////void DataList::saveData()
////{

////}

////void DataList::clearData()
////{

////}
//////int main()
//////{
//////    std::vector<student> students;

//////    std::string line;
//////    while(std::getline(std::cin, line))
//////    {
//////        std::istringstream ss(line);
//////        std::istream_iterator<std::string> begin(ss), end;
//////        std::vector<std::string> words(begin, end);

//////        assert(words.size() >= 5);

//////        int n = words.size() - 1;
//////        student s { words[0], words[n-3], words[n-2], words[n-1], words[n] };
//////        for (int i = 1 ; i < n - 3 ; i++) s.name += " " + words[i];

//////        students.push_back(s);
//////    }

//////    //printing
//////    for(auto && s : students)
//////        std::cout << "name       = " << s.name  << "\n"
//////                  << "phone      = " << s.phone << "\n"
//////                  << "gender     = " << s.gender << "\n"
//////                  << "student_id = " << s.student_id << "\n"
//////                  << "email      = " << s.email << "\n\n";
//////}
