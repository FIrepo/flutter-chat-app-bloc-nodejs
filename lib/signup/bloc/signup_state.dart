part of 'signup_bloc.dart';

@immutable
class SignupState {
  //* define all the bool value which has control over the state
  //* in frontend
  final bool isUsernameValid;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  //* isFormValid is provide so to have controll over the signup button
  bool get isFormValid => isUsernameValid && isEmailValid && isPasswordValid;

  SignupState(
      {@required this.isUsernameValid,
      @required this.isEmailValid,
      @required this.isPasswordValid,
      @required this.isSubmitting,
      @required this.isSuccess,
      @required this.isFailure});

  //! We will define different constructor and whenever there
  //! is change in event  different constructor will give
  //! different SingupState

  //* initally our username, email, password are empty but if we
  //* make our isUsernameValid false then frontend will show
  //* red border which is not good user interface and same for email
  //* and password
  factory SignupState.intial() {
    return SignupState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignupState.loading() {
    return SignupState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SignupState.success() {
    return SignupState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory SignupState.failure() {
    return SignupState(
      isUsernameValid: true,
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  //! Now we will define some function so that whenever the data
  //! comes from frontend it get update in backend

  SignupState update({
    //* it will call from bloc while checking in validator class
    bool isUsernameValid,
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  SignupState copyWith({
    bool isUsernameValid,
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignupState(
      //* if there is one bool variable is call there is change
      //* there is change in one variable

      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''SignupState {
      isUsernameValid: $isUsernameValid,
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
