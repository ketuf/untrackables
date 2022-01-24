import 'dart:async';
import 'package:redux_epics/redux_epics.dart';
import 'package:resched/redux/combiner.dart';
import 'package:dio/dio.dart';
import 'package:resched/redux/profile/reducer.dart';
import 'package:resched/redux/models.dart';
import 'dart:convert';
Stream<dynamic> fetchProfileAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is FetchProfileAction)
	.asyncMap<dynamic>((action) => Future.wait([
		Dio().get('${store.state.url.url}/profile/${action.encryptedId}', options: Options(headers: {
			'Authorization': 'Bearer ${store.state.login.accessToken}'
		})),
		Dio().get('${store.state.url.url}/profile_following/${action.encryptedId}', options: Options(headers: {
			'Authorization': 'Bearer ${store.state.login.accessToken}'
		}))
	]).then((res) => FetchSuccessProfileAction(
		incoming: List<Msg>.from(json.decode(res[0].data['incoming']).map((x) => Msg.fromJson(x))),
		outgoing: List<Msg>.from(json.decode(res[0].data['outgoing']).map((x) => Msg.fromJson(x))),
		following: List<ProfileFollow>.from(json.decode(res[1].data).map((x) => ProfileFollow.fromJson(x)))
	)).catchError((error) => FetchErrorProfileAction()));
}
