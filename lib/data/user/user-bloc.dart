import 'package:ServiceHub/api/connection.dart';
import 'package:ServiceHub/api/user-api.dart';
import 'package:ServiceHub/data/user/user-event.dart';
import 'package:ServiceHub/data/user/user-state.dart';
import 'package:ServiceHub/db/user-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userAPI = UserAPI();
  final _userDB = UserDB();

  UserBloc() : super(UserUnauthenticated());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserAuthenticate) {
      yield* _mapUserAuthenticateToState(event);
    } else if (event is UserLogin) {
      yield* _mapUserLoginToState(event);
    } else if (event is UserRegister) {
      yield* _mapUserRegisterToState(event);
    } else if (event is UserResetPassword) {
      yield* _mapUserResetPasswordToState(event);
    } else if (event is UserVerifyEmail) {
      yield* _mapUserVerifyEmailToState(event);
    } else if (event is UserLogout) {
      yield* _mapUserLogoutToState(event);
    } else if (event is UserUpdate) {
      yield* _mapUserUpdateToState(event);
    }
  }

  Stream<UserState> _mapUserAuthenticateToState(UserAuthenticate event) async* {
    try {
      yield UserAuthenticating();
      final user = await _userDB.authenticate();

      if (user != null && user is Account) {
        Account.setCurrentUser(user); // [IMPORTANT] set current user

        if (user.verified)
          yield UserAuthenticated(user);
        else
          yield UserNotVerified(user);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield UserAuthenticationFailure(apiError);
    } catch (error) {
      yield UserAuthenticationFailure(APIError(message: error.toString()));
    }
  }

  Stream<UserState> _mapUserLoginToState(UserLogin event) async* {
    try {
      yield UserAuthenticating();
      final isConnected = await Connection().isConnected();
      if (!isConnected) {
        throw APIError(message: 'Check your internet connection.');
      }

      final data = await _userAPI.login(
        email: event.email,
        password: event.password,
        type: event.type,
        rememberMe: event.rememberMe,
      );
      if (data != null && data is Account) {
        final user = data;
        Account.setCurrentUser(user); // [IMPORTANT] set current user

        if (user.verified)
          yield UserAuthenticated(user);
        else
          yield UserNotVerified(user);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield UserAuthenticationFailure(apiError);
    } catch (error) {
      yield UserAuthenticationFailure(APIError(message: error.toString()));
    }
  }

  Stream<UserState> _mapUserRegisterToState(UserRegister event) async* {
    try {
      yield UserAuthenticating();
      final isConnected = await Connection().isConnected();
      if (!isConnected) {
        throw APIError(message: 'Check your internet connection.');
      }

      final data = await _userAPI.register(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
      );
      if (data != null) {
        yield UserRegistered(email: data['email'], password: data['password']);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield UserAuthenticationFailure(apiError);
    } catch (error) {
      yield UserAuthenticationFailure(APIError(message: error.toString()));
    }
  }

  Stream<UserState> _mapUserResetPasswordToState(
      UserResetPassword event) async* {
    try {
      yield UserAuthenticating();
      final isConnected = await Connection().isConnected();
      if (!isConnected) {
        throw APIError(message: 'Check your internet connection.');
      }

      final data = await _userAPI.resetPassword(email: event.email);

      if (data['success'] != null)
        yield UserResetPasswordSent(message: data['success']);
      else if (data['error'] != null)
        yield UserResetPasswordFailure(APIError(message: data['error']));
      else
        throw APIError();
    } on APIError catch (apiError) {
      yield UserResetPasswordFailure(apiError);
    } catch (error) {
      yield UserResetPasswordFailure(APIError(message: error.toString()));
    }
  }

  Stream<UserState> _mapUserVerifyEmailToState(UserVerifyEmail event) async* {
    try {
      yield UserAuthenticating();
      final isConnected = await Connection().isConnected();
      if (!isConnected) {
        throw APIError(message: 'Check your internet connection.');
      }

      final data = await _userAPI.verifyEmail();

      if (data['success'] != null)
        yield UserEmailVerifySent(message: data['success']);
      else if (data['error'] != null)
        yield UserEmailVerifyFailure(APIError(message: data['error']));
      else
        throw APIError();
    } on APIError catch (apiError) {
      yield UserEmailVerifyFailure(apiError);
    } catch (error) {
      yield UserEmailVerifyFailure(APIError(message: error.toString()));
    }
  }

  Stream<UserState> _mapUserLogoutToState(UserLogout event) async* {
    yield UserAuthenticating();
    await _userDB.clearUser(Account.currentUser);
    Account.setCurrentUser(null); // [IMPORTANT] set current user
    yield UserUnauthenticated();
  }

  Stream<UserState> _mapUserUpdateToState(UserUpdate event) async* {
    try {
      yield UserUpdating();
      final isConnected = await Connection().isConnected();
      if (!isConnected) {
        throw APIError(message: 'Check your internet connection.');
      }

      final data =
          await _userAPI.updateUser(event.user, newImage: event.newImage);

      if (data != null && data is Account) {
        final reviews = Account.currentUser.reviews;  // save user reviews
        Account.setCurrentUser(data); // [IMPORTANT] set current user
        Account.currentUser.reviews = reviews;  // attach user reviews
        yield UserUpdated(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield UserUpdateFailure(apiError);
    } catch (error) {
      yield UserUpdateFailure(APIError(message: error.toString()));
    }
  }
}
