import 'package:ari_kuryer/ui/provider/token_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TokenState {
  final bool hasToken;

  TokenState({this.hasToken});

  TokenState copyWith({bool hasToken}) {
    {
      return TokenState(hasToken: hasToken ?? this.hasToken);
    }
  }
}

final TokenState initialState = TokenState(hasToken: false);

//Reducer
TokenState _tokenReduce(TokenState tokenState, TokenAction action) {
  if (action is TokenAction) {
    return tokenState.copyWith(hasToken: action.hasToken);
  }
  return tokenState;
}

//Store

Store<TokenState, TokenAction> useTokenStore() {
  Store<TokenState, TokenAction> store =
      useReducer(_tokenReduce, initialState: initialState);
  return store;
}
