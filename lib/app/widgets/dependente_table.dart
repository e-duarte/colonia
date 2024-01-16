import 'package:colonia/app/widgets/date_field.dart';
import 'package:flutter/material.dart';

class _DependenteTableState extends State<DependenteTable> {
  String? newNomeDependente;
  String? newDateDependente;

  List<Map<String, dynamic>> dependentes = [];

  @override
  void initState() {
    super.initState();

    dependentes = widget.initDependentes;
  }

  @override
  Widget build(BuildContext context) {
    const heightSpacing = SizedBox(height: 20);

    return Column(
      children: [
        const Text(
          'DEPENDENTES',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        heightSpacing,
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4,
            minHeight: MediaQuery.of(context).size.height * 0.1,
          ),
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              children: [
                TableRow(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(13)),
                      ),
                      child: const Text(
                        'Nome Completo',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(13)),
                      ),
                      child: const Text(
                        'Data de Nascimento',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                ..._buildExistDependentesRow(),
                _buildNewDependentesRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<TableRow> _buildExistDependentesRow() {
    return List<int>.generate(dependentes.length, (index) => index).map(
      (index) {
        return TableRow(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                initialValue: dependentes[index]['name'],
                onChanged: (value) => dependentes[index]['name'] = value,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: DateField(
                        initValue: dependentes[index]['date'],
                        decoration: false,
                        labelText: '',
                        onChanged: (value) =>
                            dependentes[index]['date'] = value),
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeDependente(index),
                  ),
                ),
              ],
            )
          ],
        );
      },
    ).toList();
  }

  TableRow _buildNewDependentesRow() {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 8),
          child: TextFormField(
            key: UniqueKey(),
            initialValue: newNomeDependente,
            onChanged: (value) => newNomeDependente = value,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8),
                child: DateField(
                  initValue: newDateDependente ?? '',
                  decoration: false,
                  labelText: '',
                  onChanged: (value) {
                    setState(() => newDateDependente = value);
                  },
                ),
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: _updateDependentes,
              ),
            )
          ],
        )
      ],
    );
  }

  void _updateDependentes() {
    setState(() {
      dependentes.add(
        {
          'name': newNomeDependente!,
          'date': newDateDependente!,
        },
      );

      newNomeDependente = null;
      newDateDependente = null;

      widget.onChanged(dependentes);
    });
  }

  void _removeDependente(int index) {
    setState(() {
      dependentes.removeAt(index);
    });
  }
}

class DependenteTable extends StatefulWidget {
  const DependenteTable({
    super.key,
    required this.initDependentes,
    required this.onChanged,
  });

  final List<Map<String, dynamic>> initDependentes;
  final void Function(List<Map<String, dynamic>>) onChanged;

  @override
  State<DependenteTable> createState() => _DependenteTableState();
}
