import 'package:redux_epics/redux_epics.dart';
import 'dart:async';
import 'package:resched/redux/combiner.dart';
import 'package:resched/redux/stream_msg/reducer.dart';
import 'package:resched/redux/models.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:resched/redux/error/reducer.dart';
import 'package:resched/redux/stream/reducer.dart';

Stream<dynamic> setIncomingStreamAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
  .where((action) => action is SetIncomingStreamMsgAction)
  .expand((action) =>
 	action.streamMsgs.map((x) => FetchLikesIncomingStreamMsgAction(x.msgId)).isNotEmpty ?
    action.streamMsgs.map((x) => FetchLikesIncomingStreamMsgAction(x.msgId)) :
    [StopFetchingStreamAction(true)]);
}
Stream<dynamic> setOutgoingStreamAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
  .where((action) => action is SetOutgoingStreamMsgAction)
  .expand((action) =>
  action.streamMsgs.map((x) => FetchLikesOutgoingStreamMsgAction(x.msgId)).isNotEmpty ?
  action.streamMsgs.map((x) => FetchLikesOutgoingStreamMsgAction(x.msgId)) :
	[StopFetchingStreamAction(false)]);
}
Stream<dynamic> fetchLikesIncomingStreamMsgAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
  .where((action) => action is FetchLikesIncomingStreamMsgAction)
  .asyncMap((action) => Dio().get('${store.state.url.url}/likes/${action.msgId}', options: Options(headers: {
    'Authorization': 'Bearer ${store.state.login.accessToken}'
  })).then((res) => FetchLikesSuccessIncomingStreamMsgAction(action.msgId, List<Like>.from(json.decode(res.data).map((x) => Like.fromJson(x)))))
  .catchError((error) => SetErrorAction(error.response.data['error'])));
}
Stream<dynamic> fetchLikesOutgoingStreamAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
  .where((action) => action is FetchLikesOutgoingStreamMsgAction)
	.asyncMap<dynamic>((action) => Dio().get('${store.state.url.url}/likes/${action.msgId}', options: Options(headers: {
		'Authorization': 'Bearer ${store.state.login.accessToken}'
	})).then((res) => FetchLikesSuccessOutgoingStreamMsgAction(action.msgId, List<Like>.from(json.decode(res.data).map((x) => Like.fromJson(x)))))
  .catchError((error) => SetErrorAction(error.response.data['error'])));
}

Stream<dynamic> fetchLikesSuccessIncomingStreamMsgAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
  .where((action) => action is FetchLikesSuccessIncomingStreamMsgAction)
  .map((action) => StopFetchingStreamAction(true));
}
Stream<dynamic> fetchLikesSuccessOutgoingStreamMsgAction(Stream<dynamic> actions, EpicStore<AppState> store) {
  return actions
  .where((action) => action is FetchLikesSuccessOutgoingStreamMsgAction)
  .map((action) => StopFetchingStreamAction(false));
}
