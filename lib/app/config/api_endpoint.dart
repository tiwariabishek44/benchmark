//do you need internet --10.0.4.54
//hridaya --192.168.1.186

class ApiEndpoints {
  static const baseUrl = "http://192.168.1.186:8080";
  static const registerPhase1 =
      "$baseUrl/api/open/common/account/registration-phase-1";
  static const registerPhase2 =
      "$baseUrl/api/open/common/account/registration-phase-2";

//----------FORGET PASSORD --------
  static const forgetpassword1 =
      "$baseUrl/api/open/common/account/forget-password/step1";
  static const forgetpassword2 =
      "$baseUrl/api/open/common/account/forget-password/step2";
//----------STUDENT LOGIN
  static const firstLogin =
      "$baseUrl/api/open/student/student-first-login-attempt";
  static const secondLogin = "$baseUrl/api/open/student/login";
//------------TEACHER LOGIN

  static const teacherLogin = "$baseUrl/api/open/common/account/common-login";

  static const resetPassword = "$baseUrl/api/v1/auth";
  static const getUserDetails = "$baseUrl/api/v1/user";
  static const userDetailUpdate = "$baseUrl/api/v1/user";
  static const changePassword = "$baseUrl/api/v1/auth";
  //**notes */
  static const getAllNotes =
      "$baseUrl/api/open/common/book/class-books/get-all";
  static const getAllCourse = '$baseUrl/api/open/common/book/subject/get-all';

  // buy the course//
  static const buyCourse = "$baseUrl/api/student/book/add-to-sales-ledger";
  static const getPurchaseCourse =
      "$baseUrl/api/student/book/get-purchased-subjects";
  static const inquiryApi = "$baseUrl/api/open/common/sales/add-inquiry";

//**MCQ'S */

  static const getAllMcq = "$baseUrl/api/open/common/book/mcq/get-all";
  static const getPhysicalProduct =
      "$baseUrl/api/open/common/book/ecommerce/get-all";
}
