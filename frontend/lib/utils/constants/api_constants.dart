class RConstants {
  static const String countriesAndCitiesJson = "assets/json/countries.json";

  // static const String auth0Domain = String.fromEnvironment('AUTH0_DOMAIN');
  // static const String auth0ClientId = String.fromEnvironment('AUTH0_CLIENT_ID');

  static const String auth0Domain = "dev-32micva8iqjojfue.us.auth0.com";
  static const String auth0ClientId = "N8Q88DwQE3PJM0BgGKJmiLoyjoc3A4OW";


  static const String auth0Issuer = "https://$auth0Domain";
  static const String auth0BundleId = "com.rayeh.app";
  // static const String auth0BundleId = "com.rayeh.app.auth0";
  static const String auth0EndpointUrl = "$mainEndpointUrl/auth/login";
  // static const String auth0EndpointUrl = "$mainEndpointUrl/login";
  static const String auth0RedirectUrl = "$auth0BundleId://login";
  static const List<String> auth0Scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
  ];


// local backend server, finlly it worked
  static const String mainEndpointUrl = "http://192.168.192.11:3000";
  // static const String mainEndpointUrl = "http://172.20.10.2:3000";
    // this is working for me in my home
  // static const String mainEndpointUrl = "http://192.168.0.202:3000";

  // static const String mainEndpointUrl = "http://localhost:3000";
  // live backend server
  // static const String mainEndpointUrl = "https://stingray-app-vscgv.ondigitalocean.app";


// these are all the scopes.
  // static const List<String> auth0Scopes = [
  //   "openid",
  //   "profile",
  //   "offline_access",
  //   "name",
  //   "given_name",
  //   "family_name",
  //   "nickname",
  //   "email",
  //   "email_verified",
  //   "picture",
  //   "created_at",
  //   "identities",
  //   "phone",
  //   "address",
  // ];
}
