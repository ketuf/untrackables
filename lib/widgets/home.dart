import 'package:flutter/material.dart';
import 'package:resched/widgets/highway.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/redux/combiner.dart';
import 'package:redux/redux.dart';
import 'package:resched/redux/bottom_nav/reducer.dart';
import 'package:resched/redux/you/reducer.dart';
List<List<Widget>> body(viewModel) => [
	[
		Text('nothing'),
		Text('nothing')
	],
	[
		Text('nothing'),
		DefaultTabController(
			length: 2,
			child: Scaffold(
				appBar: AppBar(
					backgroundColor: Colors.transparent,
					bottom: TabBar(
						tabs: <Widget>[
							Tab(icon: Icon(Icons.arrow_upward)),
							Tab(icon: Icon(Icons.arrow_downward))														
						],
						indicatorColor: Colors.yellow
					)
				),
				backgroundColor: Colors.transparent
			)
		)		
	],
	[
		ListView.builder(
			itemCount: viewModel.following.length,
			itemBuilder: (context, index) {
				return ListTile(
					title: Text('${viewModel.following[index].nickname}/${viewModel.following[index].personalNickname}'),
					subtitle: Text('followers: ${viewModel.following[index].followers}, following:  ${viewModel.following[index].following}'),
					onTap: () => viewModel.profileFollower(viewModel.following[index])
				);
			}
		),
		ListView.builder(
			itemCount: viewModel.followers.length,
			itemBuilder: (context, index) {
				return ListTile(
					title: Text('${viewModel.followers[index].nickname}'),
					subtitle: Text('followers: ${viewModel.followers[index].followers}, following:  ${viewModel.followers[index].following}'),
					onTap: () => viewModel.profileFollower(viewModel.followers[index])
				);
			}
		)
	]
];


class Home extends StatelessWidget {
	Widget build(BuildContext context) {
		return Stack(children: [
			HighWay(),
			StoreConnector<AppState, _HomeViewModel>(
				converter: (store) => _HomeViewModel.create(store),
				builder: (context, viewModel) {
				return DefaultTabController(
				length: 2,
				child: Scaffold(
					appBar: AppBar(
						iconTheme: IconThemeData(
							color: Colors.yellow
						),
						title: Text('(un)trackabl.es', style: TextStyle(color: Colors.yellow)),
						backgroundColor: Colors.black,
						actions: <Widget>[
							StoreConnector<AppState, VoidCallback>(
								converter: (store) {
									return () => store.dispatch(NavigateToAction.push('/follow'));
								},
								builder: (context, callback) {
									return IconButton(icon: Icon(Icons.add), onPressed: callback, color: Colors.yellow);
								}	
							),
							StoreConnector<AppState, VoidCallback>(
								converter: (store) {
									return () => store.dispatch(NavigateToAction.replace('/qr'));
								},
								builder: (context, callback) {
									return IconButton(icon: const Icon(Icons.qr_code), onPressed: callback, color: Colors.yellow);
								}	
							)
						],
						bottom: (viewModel.index == 0) ?
							TabBar(
								tabs: [
									Tab(icon: Icon(Icons.directions_car)),
									Tab(icon: Icon(Icons.directions_car))
								],
								indicatorColor: Colors.yellow
							) : (viewModel.index == 1 ? TabBar(
								tabs: [
									Tab(icon: Icon(Icons.outbond)),
									Tab(icon: Icon(Icons.other_houses))									
								],
								indicatorColor: Colors.yellow
							) : 
								TabBar(
								indicatorColor: Colors.yellow,
								tabs: [
									Tab(icon: Icon(Icons.arrow_upward), text: '${viewModel.following.length}'),
									Tab(icon: Icon(Icons.arrow_downward), text: '${viewModel.followers.length}')
								]
							))
					),
					body: TabBarView(
						children: body(viewModel)[viewModel.index]
					),
					backgroundColor: Colors.black54,
					bottomNavigationBar: BottomNavigationBar(
								backgroundColor: Colors.black,
								selectedItemColor: Colors.yellow,
								currentIndex: viewModel.index,
								onTap:(i) => viewModel.navigate(i),
								items: const <BottomNavigationBarItem>[
									BottomNavigationBarItem(
										icon: Icon(Icons.dynamic_feed),
										label: 'stream'
									),
									BottomNavigationBarItem(
										icon: Icon(Icons.chat),
										label: 'chat',
									),
									BottomNavigationBarItem(
										icon: Icon(Icons.flash_on),
										label: 'followers'
									),
							
								]
							)					
				)
			);
			})
		]);
	}
}
class _HomeViewModel {
	final List<Follower> followers;
	final List<Follower> following;
	final int index;
	final Function(int) navigate;
	final Function(Follower) profileFollower;
	_HomeViewModel({
		required this.followers,
		required this.following,
		required this.index,
		required this.navigate,
		required this.profileFollower
	});
	factory _HomeViewModel.create(Store<AppState> store) {
		List<Follower> followers = store.state.you.followers;
		List<Follower> following = store.state.you.following;
		int index = store.state.bottomNav.selected;
		_navigate(int i) {
			store.dispatch(BottomNavIndex(i));
		}
		_profileFollower(Follower f) {
			store.dispatch(NavigateToAction.push("/chatter", arguments: f));
		}
		return _HomeViewModel(
			followers: followers,
			following: following,
			index: index,
			navigate: _navigate,
			profileFollower: _profileFollower,
		);
	}
}
class _ViewModel {
	final Function(int) navigate;
	final int index;
	_ViewModel({
		required this.navigate,
		required this.index
	});
	factory _ViewModel.create(Store<AppState> store) {
		int index = store.state.bottomNav.selected;
		_navigate(int i) {
			print('dispatched');
		}
		return _ViewModel(
			navigate: _navigate,
			index: index
		);
	}
	
}
