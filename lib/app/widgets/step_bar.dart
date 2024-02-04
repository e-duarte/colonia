import 'package:colonia/app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class StepController extends StatelessWidget {
  const StepController({
    required this.tabs,
    required this.activeTab,
    required this.views,
    required this.viewHandles,
    required this.validator,
    super.key,
  });

  final List<String> tabs;
  final int activeTab;
  final List<Widget> views;
  final List<void Function()> viewHandles;
  final bool Function() validator;

  void nextView() {
    if (validator()) {
      viewHandles[activeTab]();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StepBar(
            activeTab: activeTab,
            tabs: tabs,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: views[activeTab],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  child: CloseButtonWidget(),
                ),
                if (activeTab == views.length - 1)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          viewHandles.last();
                        },
                        child: const Text('Concluir Cadastro',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                const SizedBox(
                  width: 20,
                ),
                Positioned(
                  right: 0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: activeTab == views.length - 1 ? null : nextView,
                    child: const Text('Próximo',
                        style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StepBar extends StatelessWidget {
  const StepBar({
    super.key,
    required this.tabs,
    required this.activeTab,
  });

  final List<String> tabs;
  final int activeTab;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: tabs.asMap().entries.map((e) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: e.key == activeTab ? Colors.green : Colors.black,
                  width: 1),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              ),
              Text(
                e.value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: e.key == activeTab
                        ? FontWeight.bold
                        : FontWeight.normal),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.08,
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
