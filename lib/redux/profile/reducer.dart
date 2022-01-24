import 'package:redux/redux.dart';
import 'package:resched/redux/models.dart';
import 'dart:core';
class ProfileState {
	bool isFetch;
	List <Msg> incoming;
	List<Msg> outgoing;
	List<ProfileFollow> following;
	ProfileState({ required this.isFetch, required this.incoming, required this.outgoing, required this.following });
	ProfileState.initial(): isFetch = false, incoming = [], outgoing = [], following = [];
	ProfileState copyWith({
		bool? isFetch,
		List<Msg>? incoming,
		List<Msg>? outgoing,
		List<ProfileFollow>? following
	}) {
		return ProfileState(
			isFetch: isFetch ?? this.isFetch,
			incoming: incoming ?? this.incoming,
			outgoing: outgoing ?? this.outgoing,
			following: following ?? this.following
		);
	}
}
class ProfileAction {}
class FetchProfileAction extends ProfileAction {
	String encryptedId;
	FetchProfileAction(this.encryptedId);
}
class FetchSuccessProfileAction extends ProfileAction {
	List<Msg> incoming;
	List<Msg> outgoing;
	List<ProfileFollow> following;
	FetchSuccessProfileAction({ required this.incoming, required this.outgoing, required this.following });
}
class FetchErrorProfileAction extends ProfileAction {}

final profileReducer = combineReducers<ProfileState>([
	TypedReducer<ProfileState, FetchProfileAction>(_fetch),
	TypedReducer<ProfileState, FetchSuccessProfileAction>(_fetchSuccess)
]);
ProfileState _fetch(ProfileState state, FetchProfileAction action) {
	return state.copyWith(isFetch: true);
}
ProfileState _fetchSuccess(ProfileState state, FetchSuccessProfileAction action) {
	return state.copyWith(isFetch: false, incoming: action.incoming, outgoing: action.outgoing, following: action.following);
}
