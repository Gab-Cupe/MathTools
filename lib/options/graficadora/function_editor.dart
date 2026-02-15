import 'package:flutter/material.dart';

class FunctionEditor extends StatefulWidget {
  final Function(String) onAddFunction;
  final VoidCallback onCancel;
  final bool isDark;

  const FunctionEditor({
    super.key,
    required this.onAddFunction,
    required this.onCancel,
    required this.isDark,
  });

  @override
  _FunctionEditorState createState() => _FunctionEditorState();
}

class _FunctionEditorState extends State<FunctionEditor> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _insert(String t) {
    final sel = _controller.selection;
    final text = _controller.text;
    final start = sel.start != -1 ? sel.start : text.length;
    _controller.value = TextEditingValue(
      text: text.replaceRange(start, sel.end != -1 ? sel.end : text.length, t),
      selection: TextSelection.collapsed(offset: start + t.length),
    );
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: true,
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
            decoration: InputDecoration(
              hintText: 'f(x) = ...',
              filled: true,
              fillColor: isDark ? Colors.white10 : Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildKeys(isDark),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: widget.onCancel,
                  child: const Text("Cerrar"),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => widget.onAddFunction(_controller.text),
                  child: const Text("Graficar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeys(bool isDark) {
    final rows = [
      ['sin(', 'cos(', 'tan(', 'ln(', 'sqrt('],
      ['7', '8', '9', '(', ')'],
      ['4', '5', '6', '+', '-'],
      ['1', '2', '3', '*', '/'],
      ['0', 'x', '.', '^', '⌫'],
    ];
    return Column(
      children: rows
          .map(
            (row) => Row(
              children: row
                  .map(
                    (key) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: MaterialButton(
                          onPressed: () => key == '⌫' ? _back() : _insert(key),
                          color: isDark ? Colors.grey[800] : Colors.grey[200],
                          textColor: isDark ? Colors.white : Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            key,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }

  void _back() {
    if (_controller.text.isNotEmpty) {
      _controller.text = _controller.text.substring(
        0,
        _controller.text.length - 1,
      );
    }
  }
}
