
class Constants {

  //Total de páginas do formulário de cadastro
  static int totalPagesFormNewUser = 19; 

  static String basicAuthUser = "SchoolMatchAppData";
  static String basicAuthPass = "BatatinhaQuandoNasce123!";

  static String appDataUsersUrl = "https://10.0.2.2:7290";
  static String userData = "$appDataUsersUrl/users/data";
  static String siteVerifyEmail = "$userData/schoolmach-web/src/verifyEmail.php?";
  static String verifyEmail = "$userData/VerifyEmail";

  static String appDataApiUrl = "https://10.0.2.2:7142";
  static String appData = "$appDataApiUrl/appdata";

  static String courses = "$appData/courses";
  static String getAllCourses = "$courses/AppCourses";
  static String getCourseDuration = "$courses/AppCourseDuration";

  static String blocks = "$appData/blocks";
  static String getMainBlocks = "$blocks/MainBlocks";
  static String getSecondaryBlocks = "$blocks/SecondaryBlocks";
  
  static String sexuality = "$appData/sexuality";
  static String getAllSexualities = "$sexuality/GetAllSexualities";

  static String interests = "$appData/interests";
  static String getAllInterests = "$interests/GetAllInterests";



  static String spotifyUrl = "https://api.spotify.com/v1/";
  static String spotifyClientId = "a3a5bece3819449d9cd7dd86266f82f3";
  static String spotifyClientSecret = "d36f0243a8404e4db03ba12f8b014fb8";
  static String spotifyAuthUrl = "https://accounts.spotify.com/api/token";
  static String spotifyGrantType = "client_credentials";

}