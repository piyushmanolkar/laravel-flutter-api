import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///Class for api calls and auth token management.
class Api{

  /// Shared Preference Manager Instance Holder.
  static SharedPreferences sharedPref;

  /// Auth Token Holder.
  static String token;

  /// Used for checking if user is authenticated.
  static bool _auth = false;

  /// Laravel Passport Client Id Constant. Edit.
  static const String _clientId = 'id';

  /// Laravel Passport Client Secret Constant. Edit.
  static const String _clientSecret = 'client_secret';

  /// Laravel Passport Grant Type Constant. Edit if needed.
  static const String _grantType = 'password';

  /// Base Url For Api Calls.
  static const String _baseUrl = 'xxxxx';
  
  /// Dio Client Holder for Api Calls.
  static Dio api = Dio(BaseOptions(baseUrl: _baseUrl));

  /// Singleton Init Holder
  static final Api _api = Api._init();

  ///Factory method for Api Singleton
  factory Api() => _api;

  ///Initialization method for Api Singleton
  static _init() => _setPrefHandle();

  ///Private get token method to retrieve token on Init from SharedPref if available.
  static _getToken(){
    if(sharedPref.containsKey('authToken') && sharedPref.getString('authToken').isNotEmpty)
    {
      token = sharedPref.getString('authToken');
      _auth = true;
    }
  }
  /// Token Getter
  static String getToken() => token;

  /// Init method for Getting SharedPref
  static _setPrefHandle() async {
    sharedPref =  await SharedPreferences.getInstance();
    _getToken();
  }

  ///Private async method to login, Takes [username] and [password] as parameters. Optional parameters [context] and [namedRoute] to redirect after login. (Logic Method)
  static Future<void> _login(String username, String password, [BuildContext context, String namedRoute]) async {
    if(!_auth){
      Response response = await api.post('oauth/token', data:FormData.fromMap({ 'grant_type':_grantType, 'client_id':_clientId, 'client_secret':_clientSecret, 'username':username, 'password':password, 'scope':''}));
      Map<String, dynamic> jsonArr = Map.from(response.data);
      if(jsonArr.containsKey('access_token')){
        token = jsonArr['access_token'];
        sharedPref.setString('authToken', token);
        _auth = true;
        if(context != null && (namedRoute.isNotEmpty || namedRoute != null))
          Navigator.pushReplacementNamed(context, namedRoute);
      }
    }
  }
  
  ///Public method for login, Takes [username] and [password] as parameters to pass to actual logic method.  Optional parameters [context] and [namedRoute] to redirect after login. (Facade Method)
  static void login(String username, String password, [BuildContext context, String namedRoute]) {
    if(context != null && (namedRoute.isNotEmpty || namedRoute != null)) _login(username, password, context, namedRoute);
    else _login(username, password);
  }

  ///Check if User is authenticated.
  static bool auth() => _auth;
}
