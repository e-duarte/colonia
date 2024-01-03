import 'package:flutter/material.dart';

class _DependenteTableState extends State<DependenteTable> {
  String? novoNomeDependente;
  String? novoFoneDependente;

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
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.all(8),
                      child: const Text(
                        'Fone',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                ...List<int>.generate(dependentes.length, (index) => index)
                    .map((index) {
                  return TableRow(children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        initialValue: dependentes[index]['nome'],
                        onChanged: (value) =>
                            dependentes[index]['nome'] = value,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: TextFormField(
                        initialValue: dependentes[index]['telefone'],
                        onChanged: (value) =>
                            dependentes[index]['telefone'] = value,
                      ),
                    )
                  ]);
                }).toList(),
                TableRow(children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextFormField(
                      key: UniqueKey(),
                      onChanged: (value) => novoNomeDependente = value,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextFormField(
                      key: UniqueKey(),
                      onChanged: (value) => novoFoneDependente = value,
                    ),
                  )
                ])
              ],
            ),
          ),
        ),
        heightSpacing,
        Row(
          children: [
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: _updateDependentes,
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ],
    );
  }

  void _updateDependentes() {
    setState(() {
      dependentes.add(
        {
          'nome': novoNomeDependente!,
          'telefone': novoFoneDependente!,
        },
      );

      widget.onChanged(dependentes);
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
