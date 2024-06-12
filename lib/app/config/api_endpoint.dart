import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String baseUrl =
      dotenv.get('BASE_URL') ?? ""; // Retrieve BASE_URL from .env file


  //----------REGISTRATION URL
  static final String registerPhase1 =
      "$baseUrl/api/open/common/account/registration-phase-1";
  static final String registerPhase2 =
      "$baseUrl/api/open/common/account/registration-phase-2";

//----------FORGET PASSORD URL
  static final String forgetpassword1 =
      "$baseUrl/api/open/common/account/forget-password/step1";
  static final String forgetpassword2 =
      "$baseUrl/api/open/common/account/forget-password/step2";

//----------STUDENT LOGIN URL
  static final String userLogin = "$baseUrl/api/open/student-and-teacher/login";

//------------TEACHER LOGIN URL

  static final String teacherLogin =
      "$baseUrl/api/open/common/account/common-login";

  //**notes */
  static final String getAllNotes =
      "$baseUrl/api/open/common/book/class-books/get-all";
  static final String getAllCourse =
      '$baseUrl/api/open/common/book/subject/get-all';

  // buy the course//
  static final String buyCourse =
      "$baseUrl/api/student/book/add-to-sales-ledger";
  static final String getPurchaseCourse =
      "$baseUrl/api/student/book/get-purchased-subjects";
  static final String inquiryApi = "$baseUrl/api/open/common/sales/add-inquiry";

//**MCQ'S */

  static final String getAllMcq = "$baseUrl/api/open/common/book/mcq/get-all";

//----------- TO FETCH THE ECOMEMRCE ITEM
  static final String getPhysicalProduct =
      "$baseUrl/api/open/common/book/ecommerce/get-all";

// --------------TO FETCH MANNUAL FOR TEACHER
  static final String getAllMannual =
      "$baseUrl/api/open/common/book/subject/manual/get/";
}
