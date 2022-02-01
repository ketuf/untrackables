import 'package:redux_epics/redux_epics.dart';
import 'package:resched/redux/combiner.dart';
import 'package:resched/redux/bottom_nav/reducer.dart';
import 'package:resched/redux/stream/reducer.dart';
Stream<dynamic> bottomNavIndex(Stream<dynamic> actions, EpicStore<AppState> store) {
	return actions
	.where((action) => action is BottomNavIndex)
	.expand((action)  => [
			FetchStreamAction()	
		]
	);
}
