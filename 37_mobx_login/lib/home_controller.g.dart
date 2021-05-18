// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on HomeControllerBase, Store {
  Computed<String> _$emailAndPasswordComputed;

  @override
  String get emailAndPassword => (_$emailAndPasswordComputed ??=
          Computed<String>(() => super.emailAndPassword,
              name: 'HomeControllerBase.emailAndPassword'))
      .value;
  Computed<bool> _$formIsValidComputed;

  @override
  bool get formIsValid =>
      (_$formIsValidComputed ??= Computed<bool>(() => super.formIsValid,
              name: 'HomeControllerBase.formIsValid'))
          .value;

  final _$emailAtom = Atom(name: 'HomeControllerBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: 'HomeControllerBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$userIsLoggedAtom = Atom(name: 'HomeControllerBase.userIsLogged');

  @override
  bool get userIsLogged {
    _$userIsLoggedAtom.reportRead();
    return super.userIsLogged;
  }

  @override
  set userIsLogged(bool value) {
    _$userIsLoggedAtom.reportWrite(value, super.userIsLogged, () {
      super.userIsLogged = value;
    });
  }

  final _$loadingAtom = Atom(name: 'HomeControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$doLoginAsyncAction = AsyncAction('HomeControllerBase.doLogin');

  @override
  Future<void> doLogin() {
    return _$doLoginAsyncAction.run(() => super.doLogin());
  }

  final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase');

  @override
  void setEmail(dynamic value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(dynamic value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
userIsLogged: ${userIsLogged},
loading: ${loading},
emailAndPassword: ${emailAndPassword},
formIsValid: ${formIsValid}
    ''';
  }
}
