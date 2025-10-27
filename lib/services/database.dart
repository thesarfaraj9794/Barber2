
import 'package:cloud_firestore/cloud_firestore.dart';
 
   //ye firebases ke liye hai

class DatabaseMethod{     //class bnaye h jiska name databasemethod h is class ke andr hm sabhiFirestore operations रखेंगे।  
  Future addUserDetails(Map<String,dynamic> userInfoMap,String id)async{ // //yh function user details ko database में save करने के लिए है।
    //String id → document का unique id (user id)।
    return await FirebaseFirestore.instance
    .collection("users") //database me users name ki collection select krta h
    .doc(id)        //us collection में document id select krta h
    .set(userInfoMap); //document में data save krta h //mtlb: user का data users collection में id ke sath save ho jayega
  }

  //ye jb user booking krega tb  wh jakr firebases me store ho jayega or bookihg me show hoga
  Future addUserBooking(Map<String,dynamic> userInfoMap)async{ 

                                                          
    return await FirebaseFirestore.instance
    .collection("Booking")  //Booking name ki collection select krta h
    
    .add(userInfoMap);  //Firestore auto-generated document id ke sathdata save krta h
  }
//yh function Booking collection के data ko live stream me return krta h

  Future<Stream<QuerySnapshot>>getBookings()async{
    return await FirebaseFirestore.instance.collection("Booking").snapshots();//Firestore data real-time update deta h

  }
  //jb admin done krega to automatically booking me detete ho jayega with firebases

   Future DeleteBooking(String id)async{
    return await FirebaseFirestore.instance
    .collection("Booking") 
    
    .doc(id).delete();////उस booking document select krta h doc.idor delete se firebases se hta deta h
  }

}

