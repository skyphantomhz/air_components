import 'package:air_components/bloc/observer_bloc.dart';
import 'package:air_components/model/main_request/msg.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObserverBloc>(context);
    bloc.observerAirComponent(12);
    return Container(
        child: StreamBuilder<Msg>(
          stream: bloc.msg(),
          builder: (context, snapshot) {
            final data = snapshot?.data?.aqi?.toString()??"null";
            return Text(data);
          }
        ),
      
    );
  }
}