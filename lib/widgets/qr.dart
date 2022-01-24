import 'package:flutter/material.dart';
import 'package:resched/widgets/highway.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:resched/redux/combiner.dart';
import 'package:resched/redux/qr/reducer.dart';
class Qr extends StatelessWidget {
	Widget build(BuildContext context) {
		return Stack(children: <Widget>[
			HighWay(),
			Scaffold(
				appBar: AppBar(title: Text('(un)trackabl.es', style: TextStyle(color: Colors.yellow)), backgroundColor: Colors.black54, actions: <Widget>[
					StoreConnector<AppState, VoidCallback>(
						converter: (store) {
							return () => store.dispatch(NavigateToAction.replace('/follow'));
						},
						builder: (context, callback) {
							return IconButton(icon: Icon(Icons.add), color: Colors.yellow, onPressed: callback);
						}
					)
				]),
				backgroundColor: Colors.black54,
				body: StoreConnector<AppState, QrState>(
								converter: (store) => store.state.qr,
								builder: (context, state) {
									return Column(
										crossAxisAlignment: CrossAxisAlignment.center,
										mainAxisAlignment: MainAxisAlignment.center,
										children: <Widget> [
											Image.network('http://165.22.202.242/qr/${state.id}'),
											SizedBox(height: 40),
											Text('${state.id}', style: TextStyle(color: Colors.yellow, fontSize: 10, fontWeight: FontWeight.bold))				
										]
									);
								}
							),
				floatingActionButton: StoreConnector<AppState, VoidCallback>(
					converter: (store) {
						return () => store.dispatch(NavigateToAction.replace('/home'));
					},
					builder: (context, callback) {
						return Padding(
							padding: EdgeInsets.all(16.0),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: <Widget>[
									FloatingActionButton(
										onPressed: callback,
										child: Icon(Icons.home),
										backgroundColor: Colors.yellow
									),
									FloatingActionButton(
										onPressed: callback,
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
