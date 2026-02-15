import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:math_expressions/math_expressions.dart';
import 'function_editor.dart';
import 'graph_painter.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final List<String> _rawFunctions = [];
  final List<Expression> _parsedExpressions = [];
  final List<Color> _lineColors = [
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
  ];
  final Parser _parser = Parser();

  double _vXMin = -10, _vXMax = 10, _vYMin = -10, _vYMax = 10;
  bool _showEditor = false;

  void _addFunction(String input) {
    if (input.isEmpty) return;
    try {
      String clean = input
          .replaceAll(' ', '')
          .replaceAll('π', '3.141592')
          .replaceAll('e', '2.718281')
          .replaceAll('sen', 'sin')
          // Multiplicación implícita: 2x -> 2*x, (x)(y) -> (x)*(y)
          .replaceAllMapped(
            RegExp(r'(\d)([x\(a-zA-Z])'),
            (m) => '${m[1]}*${m[2]}',
          )
          .replaceAllMapped(RegExp(r'([x\)])(\d)'), (m) => '${m[1]}*${m[2]}')
          .replaceAllMapped(
            RegExp(r'(\))([x\(a-zA-Z])'),
            (m) => '${m[1]}*${m[2]}',
          )
          .replaceAllMapped(RegExp(r'([x])(\()'), (m) => '${m[1]}*${m[2]}');

      Expression exp = _parser.parse(clean);
      setState(() {
        _rawFunctions.add(input);
        _parsedExpressions.add(exp);
        _showEditor = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error en la expresión matemática"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                'Graficadora',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              right: 96,
              child: IconButton(
                icon: Icon(
                  Iconsax.rotate_left,
                  color: isDark ? Colors.white : Colors.blue,
                ),
                onPressed: _resetView,
              ),
            ),
            Positioned(
              right: 16,
              child: IconButton(
                icon: Icon(
                  Iconsax.graph,
                  color: isDark ? Colors.white : Colors.blue,
                ),
                onPressed: _showList,
              ),
            ),
          ],
        ),
        toolbarHeight: kToolbarHeight,
      ),

      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (d) {
              setState(() {
                double scaleFactor =
                    (_vXMax - _vXMin) / MediaQuery.of(context).size.width;
                _vXMin -= d.delta.dx * scaleFactor;
                _vXMax -= d.delta.dx * scaleFactor;
                _vYMin += d.delta.dy * scaleFactor;
                _vYMax += d.delta.dy * scaleFactor;
              });
            },
            child: Container(
              color: Colors.transparent,
              child: CustomPaint(
                painter: FunctionGraphPainter(
                  expressions: _parsedExpressions,
                  xMin: _vXMin,
                  xMax: _vXMax,
                  yMin: _vYMin,
                  yMax: _vYMax,
                  lineColors: _lineColors,
                  scale: 1.0,
                  isDark: isDark,
                ),
                size: Size.infinite,
              ),
            ),
          ),

          if (!_showEditor)
            Positioned(
              left: 16,
              bottom: 16,
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: 'z1',
                    mini: true,
                    onPressed: () => _zoom(0.8),
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 8),
                  FloatingActionButton(
                    heroTag: 'z2',
                    mini: true,
                    onPressed: () => _zoom(1.2),
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),

          if (_showEditor)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: FunctionEditor(
                onAddFunction: _addFunction,
                onCancel: () => setState(() => _showEditor = false),
                isDark: isDark,
              ),
            ),
        ],
      ),
      floatingActionButton: _showEditor
          ? null
          : FloatingActionButton.extended(
              onPressed: () => setState(() => _showEditor = true),
              label: const Text("Agregar"),
              icon: const Icon(Iconsax.add),
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
    );
  }

  void _zoom(double f) {
    setState(() {
      double rx = (_vXMax - _vXMin) * f;
      double ry = (_vYMax - _vYMin) * f;
      double cx = (_vXMin + _vXMax) / 2;
      double cy = (_vYMin + _vYMax) / 2;
      _vXMin = cx - rx / 2;
      _vXMax = cx + rx / 2;
      _vYMin = cy - ry / 2;
      _vYMax = cy + ry / 2;
    });
  }

  void _resetView() => setState(() {
    _vXMin = -10;
    _vXMax = 10;
    _vYMin = -10;
    _vYMax = 10;
  });

  void _showList() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ListView.builder(
        itemCount: _rawFunctions.length,
        itemBuilder: (c, i) => ListTile(
          leading: Icon(
            Icons.show_chart,
            color: _lineColors[i % _lineColors.length],
          ),
          title: Text(_rawFunctions[i]),
          trailing: IconButton(
            icon: const Icon(Iconsax.trash, color: Colors.red),
            onPressed: () {
              setState(() {
                _rawFunctions.removeAt(i);
                _parsedExpressions.removeAt(i);
              });
              Navigator.pop(ctx);
            },
          ),
        ),
      ),
    );
  }
}
