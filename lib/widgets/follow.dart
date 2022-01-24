import 'package:flutter/material.dart';
import 'package:resched/widgets/highway.dart';
import 'package:resched/widgets/helpers/border.dart';
import 'package:resched/redux/follow/reducer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/redux/combiner.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

class Follow extends StatelessWidget {
	final _nicknameController = TextEditingController();
	final _followController = TextEditingController();
	Widget build(BuildContext context) {
		return Stack(children: <Widget> [
			HighWay(),
			Scaffold(
				appBar: AppBar(
					title: Text('(un)trackabl.es', style: TextStyle(color: Colors.yellow)),
					backgroundColor: Colors.black54,
					actions: <Widget>[
						StoreConnector<AppState, VoidCallback>(
							converter: (store) {
								return () => store.dispatch(NavigateToAction.replace('/qr'));
							},
							builder: (context, callback) {
								return IconButton(icon: Icon(Icons.qr_code), onPressed: callback, color: Colors.yellow);
							}
						)
					]
				),
				backgroundColor: Colors.black54,
				body: Padding(padding: EdgeInsets.only(left: 40, right: 40), child: Column(
					crossAxisAlignment: CrossAxisAlignment.center,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
					      TextField(
         						cursorColor: Colors.yellow,
         						style: const TextStyle(color: Colors.yellow),
         						obscureText: false,
         						decoration: InputDecoration(
         								labelText: 'ID',
							            labelStyle: const TextStyle(color: Colors.yellow),
         								border: const OutlineInputBorder(),
							         	enabledBorder: border(),
							            focusedBorder: border(),    
        						),
        						controller: _followController,
     					  ),
     					  SizedBox(height: 40),
     					  TextField(
         						cursorColor: Colors.yellow,
         						style: const TextStyle(color: Colors.yellow),
         						obscureText: false,
         						decoration: InputDecoration(
         								labelText: 'Nickname',
							            labelStyle: const TextStyle(color: Colors.yellow),
         								border: const OutlineInputBorder(),
							         	enabledBorder: border(),
							            focusedBorder: border(),    
        						),
        						controller: _nicknameController,
     					  ), 
     					  SizedBox(height: 40),
     					  StoreConnector<AppState, VoidCallback>(
     					  	converter: (store) {
     					  		return () => store.dispatch(FollowFetch(_followController.text, _nicknameController.text));
     					  	},
     					  	builder: (context, callback) {
     					  		return ElevatedButton(child: Text('follow'), onPressed: callback, style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)));
     					  	}
     					  ),	
					]
				)),
				floatingActionButton: StoreConnector<AppState, _ViewModel>(
					converter: (store) => _ViewModel.create(store),
					builder: (context, viewmodel) {
							return Padding(
							padding: EdgeInsets.all(16.0),
							child: Row(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,	
							children: <Widget>[
								FloatingActionButton(
									onPressed: () => viewmodel.onHome(),
									child: Icon(Icons.home),
									backgroundColor: Colors.yellow
								),
								FloatingActionButton(
									onPressed: () => viewmodel.onScan(),
									child: Icon(Icons.change_circle),
									backgroundColor: Colors.yellow,
								)
							]
							)
						);
					}
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked
			)
		]);
	}
}
class _ViewModel {
	final VoidCallback onHome;
	final VoidCallback onScan;
	_ViewModel({
		required this.onHome,
		required this.onScan
	});
	factory _ViewModel.create(Store<AppState> store) {
		_onHome() {
			store.dispatch(NavigateToAction.replace('/home'));
		}
		_onScan() {
			store.dispatch(NavigateToAction.replace('/scan'));
		}
		return _ViewModel(
			onHome: _onHome,
			onScan: _onScan
		);
	}
}
