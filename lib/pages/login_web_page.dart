import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osc_client/constants/constants.dart';
import 'package:flutter_osc_client/utils/data_utils.dart';
import 'package:flutter_osc_client/utils/net_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebViewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //监听url变化
    _flutterWebViewPlugin.onUrlChanged.listen((url) {
      //https://www.oschina.net/action/oauth2/authorize?response_type=code&client_id=6i4Yu6IUqXnR64em0rsJ&redirect_uri=https://www.dongnaoedu.com/
      print('LoginWebPage onUrlChanged: $url');
      //mounted 判断当前的widget还在不在
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      //https://www.dongnaoedu.com/?code=hRiuIJ&state=
      if (url != null && url.contains('?code=')) {
        //登录成功了
        //提取授权码code
        String code = url.split('?')[1].split('&')[0].split('=')[1];
        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data){
          print('$data');
          if(data!=null){
            Map<String, dynamic> map = json.decode(data);
            if (map != null && map.isNotEmpty) {
              //保存token等信息
              DataUtils.saveLoginInfo(map);
              //弹出当前路由，并返回refresh通知我的界面刷新数据
              Navigator.pop(context, 'login_success_refresh');
            }
          }
        });


      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _flutterWebViewPlugin.close();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(
          color: Color(AppColors.APP_BAR),
        ),
      ),
    ];

    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }

    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfos.CLIENT_ID +
          '&redirect_uri=' +
          AppInfos.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
      ),
      //允许执行js
      withJavascript: true,
      //允许本地存储
      withLocalStorage: true,
      //允许网页缩放
      withZoom: true,
    );
  }
}
