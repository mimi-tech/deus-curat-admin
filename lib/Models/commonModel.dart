
class CommonsModel {
  dynamic testimonyCount;
  dynamic requestCount;
  dynamic totalDonation;
  dynamic accountName;
  dynamic accountNumber;
  dynamic bankName;
  dynamic yearlyDonation;
  dynamic weeklyDonation;
  dynamic monthlyDonation;
  dynamic dailyDonation;
  dynamic day;
  dynamic week;
  dynamic month;
  dynamic year;


  CommonsModel({

    this.testimonyCount,
    this.totalDonation,
    this.accountName,
    this.accountNumber,
    this.bankName,
    this.requestCount,
    this.yearlyDonation,
    this.weeklyDonation,
    this.monthlyDonation,
    this.dailyDonation,
    this.day,
    this.week,
    this.month,
    this.year,

  });
  // now create converter

  factory CommonsModel.fromJson(Map<String,dynamic> responseData){
    return CommonsModel(
      testimonyCount : responseData['testimonyCount'] ?? 0,
      totalDonation: responseData['totalDonation'] ?? 0,
      accountName: responseData['accountDetails']['accountName'] ?? "Deus Curat Charity Organization",
      accountNumber: responseData['accountDetails']['accountNumber'] ?? "09434848944",
      bankName: responseData['accountDetails']['bankName'] ?? "United bank for Africa (UBA)",
      requestCount: responseData['requestCount'] ?? 0,
      yearlyDonation: responseData['yearlyDonation'] ?? 0,
      weeklyDonation: responseData['weeklyDonation'] ?? 0,
      monthlyDonation: responseData['monthlyDonation'] ?? 0,
      dailyDonation: responseData['dailyDonation'] ?? 0,
      day: responseData['day'] ?? 0,
      week: responseData['week'] ?? 0,
      month: responseData['month'] ?? 0,
      year: responseData['year'] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {

      "testimonyCount": testimonyCount,
      "totalDonation":totalDonation,
      "accountName":accountName,
      "accountNumber":accountNumber,
      "requestCount":requestCount,
      "yearlyDonation":yearlyDonation,
      "weeklyDonation":weeklyDonation,
      "monthlyDonation":monthlyDonation,
      "dailyDonation":dailyDonation,
      "day":day,
      "week":week,
      "month":month,
      "year":year,
    };
  }}