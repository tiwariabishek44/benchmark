class ApiEndpoints {
  static const baseUrl = "http://192.168.1.69:3000";
  static const userRegister = "$baseUrl/api/v1/signup";
  static const userLogin = "$baseUrl/api/v1/signin";
  static const resetPassword = "$baseUrl/api/v1/auth";
  static const getUserDetails = "$baseUrl/api/v1/user";
  static const userDetailUpdate = "$baseUrl/api/v1/user";
  static const changePassword = "$baseUrl/api/v1/auth";
  //**notes */
  static const getAllNotes = "$baseUrl/api/v1/get-course/";
  static const getAllMcq = "$baseUrl/api/v1/get-all-mcqs";

  // buy the course//
  static const buyCourse = "$baseUrl/api/v1/get-course/";
  static const getPurchaseCourse = "$baseUrl/api/v1/get-course/";
  static const inquiryApi = "$baseUrl/api/v1/get-course/";
}
