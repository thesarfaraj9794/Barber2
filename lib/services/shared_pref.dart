import 'package:shared_preferences/shared_preferences.dart';

class SharedpreferenceHelper{                    //this is class jiske ander hm shared pre.. ko handle krenge
  static String userIdKey="USERKEY";                    //   same
  static String userNameKey="USERNAMEKEY";              // ye key h jiske dara hm  data save or retrive karenge
  static String userEmailKey="USEREMAILKEY";
             //  same
  //static String userImageKey="USERIMAGEKEY";

  // ye funtio h jo userid save krta h bool ka mtlb data save hua ki nahi true of false retuen krta h

  Future<bool>saveUserId(String getUserId)async{
    SharedPreferences prefs=await SharedPreferences.getInstance(); //data ko read or write krega  object ye immidiate nahi hota h isliye awiat krta h

    return prefs.setString(userIdKey,getUserId);    //ye userid ko userid key ke sath save krta h

  }
   //this is same for name
   Future<bool>saveUserName(String getUserName)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();

    return prefs.setString(userNameKey,getUserName);//ye user name ko usernamekey ke sath save krta h

  }
   // this is also same for mail
   Future<bool>saveUserEmail(String getUserEmail)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();

    return prefs.setString(userEmailKey,getUserEmail);


  }

  //for admin panel ke liye h
  //jb firebases me data save kiye h  h waha se userid fetch krta h
  //jaha hmne firebases me user create h name peter or password 123456 ye waha se fetch krta h
   


  Future<String?>getUserId()async{
    SharedPreferences prefs=await SharedPreferences.getInstance(); //String? का मतलब है कि अगर userId save नहीं है तो यह null return कर सकता है
    return prefs.getString(userIdKey);

  }Future<String?>getUserName()async{     //username fetch krne ke liye for admin panel ke liye
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);

  }
  Future<String?>getUserEmail()async{    // or ye email fetch krne ke liye
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);

  }
  




}