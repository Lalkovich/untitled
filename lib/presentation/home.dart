import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/presentation/home/home_state.dart';

import '../domain/model/day.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _latController = TextEditingController();
  final _lngController = TextEditingController();

  late HomeState _homeState;

  @override
  void initState() {
    super.initState();
    _homeState = GetIt.instance<HomeState>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getRowInput(),
            SizedBox(height: 20),
            FloatingActionButton(
              child: Text('Получить'),
              onPressed: _getDay,
            ),
            SizedBox(height: 20),
            _getDayInfo(),
          ],
        ),
      ),
    );
  }

  Widget _getRowInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _latController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(hintText: 'Широта'),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: _lngController,
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: true),
            decoration: InputDecoration(hintText: 'Долгота'),
          ),
        ),
      ],
    );
  }

  Widget _getDayInfo() {
    return SingleChildScrollView(
      child: Observer(
        builder: (_) {
          if (_homeState.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (_homeState.day == null) {
            return Container();
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Восход: ${_homeState.day?.sunrise?.toLocal()}'),
                Text('Заход: ${_homeState.day?.sunset?.toLocal()}'),
                Text('Полдень: ${_homeState.day?.solarNoon?.toLocal()}'),
                Text(
                    'Продолжительность: ${Duration(seconds: _homeState.day!.dayLength)}'),
              ],
            );
          }
        },
      ),
    );
  }

  void _getDay() {
    // здесь получаем данные
    final lat = double.tryParse(_latController.text);
    final lng = double.tryParse(_lngController.text);
    _homeState.getDay(latitude: lat!, longitude: lng!);
  }
}
