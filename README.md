# laravel-flutter-api
A basic auth SINGLETON class to get access token from `laravel/passport` library, this comes with persistent token achieved with shared preference manager.

This class has two dependencies - 

```
shared_preferences: ^0.5.5
dio: ^3.0.0
```
### Note
I have made this for my personal use. Any suggetions are welcome, any demamds will not be considered unless they are useful for me.

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
/// Optional params - context and namedRoute - to redirect after authentication
/// NOTE: namedRoute must be a String and a route defined in optional parameter of MaterialApp && Login must be done after specifying
/// the material routes.
void login(username, password, [BuildContext context, String namedRoute])

///Get Auth Token
String getToken()

///Get if user is Authenticated
bool auth()
```
