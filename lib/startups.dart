import 'constants.dart';

class Startup {
  Startup({
    this.startupName,
    this.yearOfEstablishment,
    this.monthOfEstablishment,
    this.description,
    this.photo,
    this.bookmarkPhoto,
    this.id,
  });

  final String startupName;
  final int yearOfEstablishment;
  final String monthOfEstablishment;
  final String description;
  final String photo;
  final String bookmarkPhoto;
  final String id;
}

List<Startup> startup = [
  Startup(
    startupName: 'Zomato',
    yearOfEstablishment: 2008,
    monthOfEstablishment: 'July',
    description: kZomatoText,
    photo: 'images/zomato3.png',
    bookmarkPhoto: 'images/zomato1.png',
    id: '0',
  ),
  Startup(
    startupName: 'Cure.fit',
    yearOfEstablishment: 2016,
    monthOfEstablishment: 'July',
    description: kCureFitText,
    photo: 'images/curefit7.png',
    bookmarkPhoto: 'images/curefit1.png',
    id: '1',
  ),
  Startup(
    startupName: 'Nykaa',
    yearOfEstablishment: 2012,
    monthOfEstablishment: 'April',
    description: kNykaaText,
    photo: 'images/nykaa10.png',
    bookmarkPhoto: 'images/nykaa1.jpeg',
    id: '2',
  ),
  Startup(
    startupName: 'Bombay Shaving Company',
    yearOfEstablishment: 2015,
    monthOfEstablishment: 'October',
    description: kBombayShavingCompanyText,
    photo: '',
  ),
];
