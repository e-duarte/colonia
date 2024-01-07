import 'package:colonia/app/services/setting_service.dart';
import 'package:colonia/app/utils/utils.dart';
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
                future: SettingService.loadData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _user = snapshot.data!['user'];
                    _host = snapshot.data!['host'];
                    _port = snapshot.data!['port'];

                    return _buildContent(context);
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Text('Error em carregar configurações'),
                        Text('${snapshot.error}'),
                      ],
                    );
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
            onPressed: _saveSettings,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
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
          validator: FieldValidator.checkEmptyField,
          decoration: const InputDecoration(label: Text('User')),
          onEditingComplete: _saveSettings,
        ),
        TextFormField(
          key: UniqueKey(),
          initialValue: _host,
          onChanged: (value) => _host = value,
          validator: FieldValidator.checkEmptyField,
          decoration: const InputDecoration(label: Text('host')),
          onEditingComplete: _saveSettings,
        ),
        TextFormField(
          key: UniqueKey(),
          initialValue: _port,
          onChanged: (value) => _port = value,
          validator: FieldValidator.checkEmptyField,
          decoration: const InputDecoration(label: Text('porta')),
          onEditingComplete: _saveSettings,
        ),
      ],
    );
  }

  void _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      await SettingService.saveData({
        'user': _user,
        'host': _host,
        'port': _port,
      });

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }
}

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
