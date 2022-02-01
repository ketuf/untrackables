import 'dart:async';
import 'package:redux_epics/redux_epics.dart';
import 'package:resched/redux/combiner.dart';
import 'package:dio/dio.dart';
import 'package:resched/redux/profile/reducer.dart';
import 'package:resched/redux/models.dart';
import 'dart:convert';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

Stream<dynamic> refreshAndNavigateProfileAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is RefreshAndNavigateProfileAction)
	.map((action) => RefreshAndNavigateOneProfileAction(action.encryptedId, action.nickname));
}
Stream<dynamic> refreshAndNavigateOneProfileAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is RefreshAndNavigateOneProfileAction)
	.map((action) => NavigateToAction.replace('/chatter', arguments: Follower(encryptedId: action.encryptedId, nickname: action.nickname)));
}
Stream<dynamic> refreshAndNavigateOnePofileAction2(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is RefreshAndNavigateOneProfileAction)
	.map((action) => FetchProfileAction(action.encryptedId));
}

Stream<dynamic> fetchProfileAction(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is FetchProfileAction)
	.asyncMap<dynamic>((action) => Future.wait([
		Dio().get('${store.state.url.url}/profile/${action.encryptedId}', options: Options(headers: {
			'Authorization': 'Bearer ${store.state.login.accessToken}'
		})),
		Dio().get('${store.state.url.url}/profile_following/${action.encryptedId}', options: Options(headers: {
			'Authorization': 'Bearer ${store.state.login.accessToken}'
		})),
		Dio().get('${store.state.url.url}/profile_followers/${action.encryptedId}', options: Options(headers: {
			'Authorization': 'Bearer ${store.state.login.accessToken}'
		}))
	]).then((res) => FetchSuccessProfileAction(
		incoming: List<ShowMsg>.from(json.decode(res[0].data['incoming']).map((x) => ShowMsg.fromJson(x))),
		outgoing: List<ShowMsg>.from(json.decode(res[0].data['outgoing']).map((x) => ShowMsg.fromJson(x))),
		following: List<ProfileFollow>.from(json.decode(res[1].data).map((x) => ProfileFollow.fromJson(x))),
		followers: List<ProfileFollow>.from(json.decode(res[2].data).map((x) => ProfileFollow.fromJson(x)))
	)).catchError((error) => FetchErrorProfileAction()));
}
