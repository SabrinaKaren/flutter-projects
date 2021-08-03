import 'package:flutter/material.dart';
import 'package:imc_unit_test/bloc_provider.dart';
import 'package:imc_unit_test/person_bloc.dart';
import 'package:imc_unit_test/person_state.dart';

class HomePage extends StatelessWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Persons list'),
        actions: [
          StreamBuilder(
            stream: bloc.stream,
            builder: (context, snapshot) {
              final isEnabled = bloc.state is PersonListState && (bloc.state as PersonListState).data.isNotEmpty;
              return IconButton(
                icon: Icon(Icons.refresh_outlined, color: Colors.white),
                onPressed: isEnabled ? () => bloc.add(PersonEvent.clear) : null,
              );
            },
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (bloc.state is PersonErrorState) return _ErrorWidget();
            else if (bloc.state is PersonLoadingState) return CircularProgressIndicator();
            else return _ListWidget();
          },
        ),
      ),
    );

  }

}

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.get(context);
    final textError = (bloc.state as PersonErrorState).error?.toString() ?? 'Erro desconhecido';
    return Text(textError);
  }
}

class _ListWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.get(context);
    final personList = (bloc.state as PersonListState).data;

    if (personList.isEmpty) {
      return TextButton(
        onPressed: () {
          bloc.add(PersonEvent.fetch);
        },
        child: Text('Fetch persons')
      );
    }

    return ListView.builder(
      itemCount: personList.length,
      itemBuilder: (context, index) {
        final item = personList[index];
        return ListTile(
          title: Text(item.name),
          subtitle: Text (item.isOlder ? 'Maior' : 'Menor' ' de idade'),
        );
      },
    );

  }

}