import 'package:colonia/app/utils/setting_manager.dart';
import 'package:colonia/app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class _SettingState extends State<Setting> {
  final _formKey = GlobalKey<FormState>();
  String? _user;
  String? _host;
  String? _port;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Text('CONFIGURAÇÕES'),
        content: Builder(
          builder: (context) {
            var height = MediaQuery.of(context).size.height * 0.3;
            var width = MediaQuery.of(context).size.width * 0.4;

            return SizedBox(
              height: height,
              width: width,
              child: FutureBuilder<Map<String, dynamic>>(
                future: SettingManager.loadSetting(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _user = snapshot.data!['user'];
                    _host = snapshot.data!['host'];
                    _port = snapshot.data!['port'];

                    return _buildContent(context);
                  } else if (snapshot.hasError) {
                    return const Text('Error em carregar configurações');
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.green,
                    );
                  }
                },
              ),
            );
          },
        ),
        actions: [
          const CloseButtonWidget(),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await SettingManager.updateParams('user', _user!);
                await SettingManager.updateParams('host', _host!);
                await SettingManager.updateParams('port', _port!);

                if (!mounted) return;
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(context) {
    return Column(
      children: [
        TextFormField(
          key: UniqueKey(),
          initialValue: _user,
          onChanged: (value) => _user = value,
          validator: validation,
          decoration: const InputDecoration(label: Text('User')),
        ),
        TextFormField(
          key: UniqueKey(),
          initialValue: _host,
          onChanged: (value) => _host = value,
          validator: validation,
          decoration: const InputDecoration(label: Text('host')),
        ),
        TextFormField(
          key: UniqueKey(),
          initialValue: _port,
          onChanged: (value) => _port = value,
          validator: validation,
          decoration: const InputDecoration(label: Text('porta')),
        ),
      ],
    );
  }

  String? validation(String? value) {
    if (value == null || value.isEmpty) {
      return '*Campo obrigatório';
    }

    return null;
  }
}

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  _SettingState createState() => _SettingState();
}
