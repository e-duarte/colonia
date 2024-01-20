import 'package:colonia/app/widgets/buttons.dart';
import 'package:flutter/material.dart';

class StepController extends StatefulWidget {
  const StepController({
    required this.tabs,
    required this.views,
    required this.validator,
    required this.saveForm,
    super.key,
  });

  final List<String> tabs;
  final List<Widget> views;
  final bool Function() validator;
  final void Function() saveForm;

  @override
  State<StepController> createState() => _StepControllerState();
}

class _StepControllerState extends State<StepController> {
  int activeTab = 0;

  void nextView() {
    setState(() {
      if (widget.validator()) {
        activeTab++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          StepBar(
            activeTab: activeTab,
            tabs: widget.tabs,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: widget.views[activeTab],
            ),
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
                if (activeTab == widget.views.length - 1)
                  Positioned.fill(
                    // left: 300,
                    // right: 300,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: widget.saveForm,
                        child: const Text('salvar',
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
                    onPressed:
                        activeTab == widget.views.length - 1 ? null : nextView,
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
