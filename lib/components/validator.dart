bool emailValidator(String _email) {
  if (RegExp(r"^([!-~]+@[a-zA-Z0-9-_.]+.([a-zA-Z0-9-]+))*$").hasMatch(_email)) {
    return true;
  } else {
    return false;
  }
}

bool passwordValidator(String _password) {
  if (RegExp(r"(?=.*[a-zA-Z])(?=.*[0-9])[ -~]{6,}").hasMatch(_password)) {
    return true;
  } else {
    return false;
  }
}
