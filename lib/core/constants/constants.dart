// Auth Data

//Bearer Token
Map<String, String> bearerTokenAuth(String token) {
  return {authorizationTxt: 'Bearer $token'};
}

/// RegExp
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]");
const String _phonePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
final RegExp phoneValidationRegExp = RegExp(_phonePattern);

const bearerTxt = 'Bearer ';
const isNewUserTxt = 'isNewUser';
const renderedTxt = 'rendered';
const appLogo = 'assets/images/logo.png';
const userId = 'userId';
const authProviderTxt = 'authProvider';
const googleTxt = 'Google';
const facebookTxt = 'Facebook';
const wooCommerceTxt = 'WooCommerce';
const authorizationTxt = 'Authorization';

const contentTypeTxt = 'Content-Type';
const contentType = 'application/json';
const keyTxt = 'consumer_key';
const secretTxt = 'consumer_secret';

const fieldsTxt = '_fields';
const orderByTxt = 'orderby';
const orderTxt = 'order';
const perPageTxt = 'per_page';
const pageTxt = 'page';

//Login & Registration & Customer
const customerEP = '/wc/v3/customers/';
const registerEP = '/wc/v3/customers/';
const usersEP = '/wp/v2/users/';
const loginEP = '/wp/v2/users/me/';
const resetPasswordEP = '/bdpwr/v1/reset-password';
const validateAndSetPasswordEP = '/bdpwr/v1/set-password';
const registerRequiredFields = 'id,username,avatar_url';
const loginRequiredFields = 'id,name,avatar_urls';

//Admin Basic Auth
const adminBasicAuth = 'Basic c2xhZG1pbjpTRUAjJDYzNTRnZXIhQA==';
