class ApiConstants {
  //CAY KHE APP

  static const String BASE_URL = "http://maychu.share4seo.com:8000/api";
  static const String BASE_IMAGE_URL = "http://maychu.share4seo.com:8000/";
  static const String SIGNIN_ACCOUNT = "/aktuser/login";
  static const String SIGNOUT_ACCOUNT = "/aktuser/logout";
  static const String CHANGE_PWD_USER = "/aktuser/changepassword";
  static const String GET_PROFILE = "/aktuser/getprofile";
  static const String GET_HOME_STATISTIC = "/aktaccount/getHomeStatistic";
  static const String GET_ACCOUNT = "/aktaccount/getAccount";
  static const String UPDATE_PROFILE = "/aktuser/updateprofile";
  static const String UPDATE_IMAGE = "/aktuser/updateimage";
  static const String UPLOAD_BASE64 = "/file/uploadbase64";
  static const String API_UPLOAD_IMAGE = "/file/upload";
  static const String REQUIRE_OTP = "/userapp/requireOTP";
  static const String VALIDATE_OTP = "/userapp/validateOtp";
  static const String REGISTER = "/aktuser/register";
  static const String RESET_PWD = "/aktuser/resetpassword";
  static const String REQUEST_PAY = "/aktaccount/requestPay";
  static const String REGISTER_SOCIAL_ACCOUNT = "/userapp/requireVerifySocialAcc";
  static const String TRANSACTION_HIS = "/aktaccount/getTransactionHis";
  static final String GET_NOTIFY = "/aktnotify/getMoreNotify";
  static final String GET_SOCIAL_NOTIFY = "aktaccount/getSocialReward";
  static final String GET_TOP_HUNTER = "/aktaccount/getTopHunter";
  static final String GET_TOP_HUNTER_REWARD_DESCRIPTION = "/ackaccount/getTopHunterRewardDescription";
  static final String GET_TASK = "/akttask/requestTask";
  static final String GET_READING_HIS = "/acktask/getPageReadingHis";
  static final String GET_TASK_STATUS = "/acktask/myVerifyTasks";
  static final String UPDATE_RESULT_TASK = "/acktask/updateResultTask";
  static final String RESUBMIT_REVIEW_TASK = "/acktask/reSubmitTask";
  static final String CHECK_OTP = "/userapp/canSendSms";
  static final String SUBMIT_REWARD = "/acktask/submitReward";
  static final String SUBMIT_REPORT = "/acktask/complaint";
  static final String SUBMIT_INVITE_CODE = "/userapp/submitIntroduceCode";
  static final String GET_REWARDS = "/ackaccount/getRewards";
  static final String GET_RECENT_REWARDS = "/aktaccount/getRecentReward";
  static final String GET_MY_MEMBER = "/aktuser/getMyMembers";
  static final String GET_SOCIAL_ACCOUNT = "/userapp/getMySocialAccount";
  static final String READ_NOTIFY = "/aktnotify/readNotify";
  static final String READ_ALL_NOTIFY = "/aktnotify/readAllNotify";
  static const String UPDATE_DEVICE_ID ="/aktuser/updateDevice";
  static const String UPDATE_FIREBASE_TOKEN_ID =
      "/aktuser/updateDeviceMember";




  static ApiConstants shared = ApiConstants();

  String getFullImage(String url) {
    return BASE_IMAGE_URL + url.toString();
  }
}
