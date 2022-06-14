import 'package:aid_first/models/user.dart';
import 'package:mobx/mobx.dart';
part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String? userId;

  @observable
  User? user;

  @action
  void setUserId(String id) {
    userId = id;
  }

  @action
  void setUser(User value) {
    user = value;
  }

  @computed
  bool get isSignedIn => user != null;
}

UserStore userStore = UserStore();
