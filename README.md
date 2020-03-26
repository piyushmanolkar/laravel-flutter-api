# laravel-flutter-api
A basic auth SINGLETON class to get access token from `laravel/passport` library, this comes with persistent token achieved with shared preference manager.

This class has two dependencies - 

```
shared_preferences: ^0.5.5
dio: ^3.0.0
```

### How to Use
1. Place Network.Dart in lib/ in your flutter project.
2. Include Nework.dart in your flutter project - `import 'package:your_package_name/Network.dart';`
3. Edit Network.dart and add passport client id and client secret and baseurl of your webapp in the appropriate variables.
4. Initialize the class in the main widget like - `Api api = Api();`
![Init](https://i.ibb.co/tsw3zDN/image.png)
5. Use the class anywhere in your code, simply like - `Api.login(username, password);`

### Methods
```dart

///Login
void login(username, password)

///Get Auth Token
String getToken()

///Get if user is Authenticated
bool auth()
```
