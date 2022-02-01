import 'package:redux/redux.dart';
import 'package:resched/redux/models.dart';
import 'package:tuple/tuple.dart';
import 'package:dio/dio.dart';

class IncomingStreamAction {}
class OutgoingStreamAction {}


class SetStreamMsgAction {
  List<StreamMsg> streamMsgs;
  SetStreamMsgAction(this.isIncoming, this.streamMsgs);
}
class SetLikesStreamMsgAction {
  int msgId;
  List<Like> likes;
  SetLikesStreamMsgAction(this.msgId, this.likes);
}
class SetIncomingStreamMsgAction extends SetStreamMsgAction with IncomingStreamAction {
  SetIncomingStreamMsgAction(List<StreamMsg> streamMsgs): super(streamMsgs);
}
class FetchLikesSuccessIncomingStreamMsgAction extends SetLikesStreamMsgAction with IncomingStreamAction {
  FetchLikesSuccessIncomingStreamMsgAction( int msgId, List<Like> likes): super(msgId, likes);
}
class SetOutgoingStreamMsgAction extends SetStreamMsgAction with OutgoingStreamAction {
  SetOutgoingStreamMsgAction(bool isIncoming, List<StreamMsg> streamMsgs): super(isIncoming, streamMsgs);
}
class FetchLikesSuccessOutgoingStreamMsgAction extends SetLikesStreamMsgAction with OutgoingStreamAction {
  FetchLikesSuccessOutgoingStreamMsgAction(int msgId, List<Like> likes): super(msgId, likes);
}
class FetchSuccessStreamMsgAction {
  Response response;
  FetchSuccessStreamMsgAction(this.response);
}
class FetchLikesIncomingStreamMsgAction {
  int msgId;
  FetchLikesIncomingStreamMsgAction(this.msgId);
}
class FetchLikesOutgoingStreamMsgAction {
  int msgId;
  FetchLikesOutgoingStreamMsgAction(this.msgId);
}
class FetchLikeStreamMsgAction {
  int msgId;
  FetchLikeStreamMsgAction(this.msgId);
}



final streamMsgReducer = combineReducers<List<StreamMsg>>([
  TypedReducer<List<StreamMsg>, SetStreamMsgAction>(_set),
  TypedReducer<List<StreamMsg>, SetLikesStreamMsgAction>(_setLikes)
]);
List<StreamMsg> _set(List<StreamMsg> state, SetStreamMsgAction action) {
  return action.streamMsgs;
}
List<StreamMsg> _setLikes(List<StreamMsg> state, SetLikesStreamMsgAction action) {
  return state.map((x) => x.msgId == action.msgId ? x.copyWith(likes: action.likes) : x).toList();
}
