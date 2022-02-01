import 'package:resched/redux/conversations/reducer.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:resched/redux/models.dart';
import 'package:resched/redux/combiner.dart';
import 'package:redux_epics/redux_epics.dart';
Stream<dynamic> fetchConversationsAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is FetchConversationsAction)
	.asyncMap<dynamic>((action) => Dio().get('${store.state.url.url}/conversations', options: Options(headers: {
		'Authorization': 'Bearer ${store.state.login.accessToken}'
	})).then((res) => FetchSuccessConversationsAction(
	List<List<OurMsg>>.from(json.decode(res.data).map((x) =>List<OurMsg>.from(x.map((y) => OurMsg.fromJson(y))))))).catchError((error) => FetchErrorConversationsAction(error.response.data['error'])));
}
