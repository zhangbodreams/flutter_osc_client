abstract class AppColors {
  //App主题颜色
  static const APP_THEME = 0xff63ca6c;

  //AppBar颜色
  static const APP_BAR = 0xffffffff;
}

abstract class AppUrls {
  //HOST
  static const String HOST = 'https://www.oschina.net';

  //授权登录
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';

  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';

  //获取用户信息
  static const String OPENAPI_USER = HOST + '/action/openapi/user';

  static const String MY_INFORMATION = HOST + '/action/openapi/my_information';

  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';
  static const String NEWS_LIST = HOST + '/action/openapi/news_list';

  static const String NEWS_DETAIL = HOST + '/action/openapi/news_detail';
  static const String TWEET_LIST = HOST + '/action/openapi/tweet_list';
  static const String TWEET_PUB = HOST + '/action/openapi/tweet_pub';

}

abstract class AppInfos {
  //应用id
  static const String CLIENT_ID = '1uCh6Ba5rybEkDH2Jfqx';

  //应用密钥
  static const String CLIENT_SECRET = 'VBmo1ewIy9CcVPME3vdR2YEspMLSVfsG';

  //回调地址
  static const String REDIRECT_URI = 'https://www.dongnaoedu.com/';
}
