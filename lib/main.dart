import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ConversorDivisas(),
  ));
}

class ConversorDivisas extends StatefulWidget {
  const ConversorDivisas({super.key});

  @override
  ConversorDivisasEstado createState() => ConversorDivisasEstado();
}

class ConversorDivisasEstado extends State<ConversorDivisas> {
  TextEditingController pesoControlador = TextEditingController();
  TextEditingController euroControlador = TextEditingController();
  TextEditingController dolarControlador = TextEditingController();

  double pesosaEuros = 0.00023;
  double pesosaDolares = 0.00024;
  double eurosaDolares = 1.06;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Monedas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildTextField(
              controller: pesoControlador,
              labelText: '                                (COP)',
            ),
            const SizedBox(height: 10),
            buildTextField(
              controller: euroControlador,
              labelText: '                                (EUR)',
            ),
            const SizedBox(height: 10),
            buildTextField(
              controller: dolarControlador,
              labelText: '                                (USD)',
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  convertirMoneda();
                },
                child: const Text('Convertir'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  limpiarCampos();
                },
                child: const Text('Limpiar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Container(
      width: 200,
      height: 50,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }

  void convertirMoneda() {
    double cop = double.tryParse(pesoControlador.text) ?? 0.0;
    double eur = double.tryParse(euroControlador.text) ?? 0.0;
    double usd = double.tryParse(dolarControlador.text) ?? 0.0;

    if (pesoControlador.text.isNotEmpty) {
      double eurDesdeCop = cop * pesosaEuros;
      double usdDesdeCop = cop * pesosaDolares;
      euroControlador.text = eurDesdeCop.toStringAsFixed(2);
      dolarControlador.text = usdDesdeCop.toStringAsFixed(2);
    } else if (euroControlador.text.isNotEmpty) {
      double copDesdeEur = eur / pesosaEuros;
      double usdDesdeEur = eur * eurosaDolares;
      pesoControlador.text = copDesdeEur.toStringAsFixed(2);
      dolarControlador.text = usdDesdeEur.toStringAsFixed(2);
    } else if (dolarControlador.text.isNotEmpty) {
      double copDesdeUsd = usd / pesosaDolares;
      double eurDesdeUsd = usd / eurosaDolares;
      pesoControlador.text = copDesdeUsd.toStringAsFixed(2);
      euroControlador.text = eurDesdeUsd.toStringAsFixed(2);
    }
  }

  void limpiarCampos() {
    pesoControlador.clear();
    euroControlador.clear();
    dolarControlador.clear();
  }
}
