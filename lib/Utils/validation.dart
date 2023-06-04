class Validator {

  static String? validateRePassword(String? value) {
    if(value!.isEmpty) {
      return "Re-type password can't be empty";
    }
    if(value.length < 6) {
      return "password is too short";
    }

    return null;
  }



  static String? validateEmail(String? value) {

    RegExp regex = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(value!.isEmpty) {
      return "Email address can't be empty";
    }
    if(value.length < 2) {
      return "Email address is too short";
    }
    if(!regex.hasMatch(value)){
      return "Please provide a valid email address";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if(value!.isEmpty) {
      return "password can't be empty";
    }
    if(value.length < 6) {
      return "Password is too short";
    }

    return null;
  }

  static String? validateField(String? value) {
    if(value!.isEmpty) {
      return "Field can't be empty";
    }
    if(value.length < 6) {
      return "Field is too short";
    }

    return null;
  }

  static String? validateAmount(String? value) {
    if(value!.isEmpty) {
      return "Amount can't be empty";
    }

    return null;
  }

  static String? validateFieldSearch(String? value) {
    if(value!.isEmpty) {
      return "Search query can't be empty";
    }
    if(value.length < 2) {
      return "Search query is too short";
    }

    return null;
  }


}

class Strings {
  static const String fieldReq = 'This field is required';

}
