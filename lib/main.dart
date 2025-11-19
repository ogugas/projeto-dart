import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ImcCalculator(),
    );
  }
}

class ImcCalculator extends StatefulWidget {
  const ImcCalculator({super.key});

  @override
  State<ImcCalculator> createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  String resultado = "";

  void calcularIMC() {
    double peso = double.tryParse(pesoController.text) ?? 0;
    double altura = double.tryParse(alturaController.text) ?? 0;

    if (peso <= 0 || altura <= 0) {
      setState(() => resultado = "Digite valores válidos.");
      return;
    }

    double imc = peso / (altura * altura);

    String classificacao;
    if (imc < 18.5) {
      classificacao = "Abaixo do peso";
    } else if (imc < 24.9) {
      classificacao = "Peso normal";
    } else if (imc < 29.9) {
      classificacao = "Sobrepeso";
    } else if (imc < 34.9) {
      classificacao = "Obesidade Grau I";
    } else if (imc < 39.9) {
      classificacao = "Obesidade Grau II";
    } else {
      classificacao = "Obesidade Grau III";
    }

    setState(() {
      resultado = "IMC: ${imc.toStringAsFixed(2)}\n$classificacao";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A5AE0), Color(0xFF8A4FFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 350,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Calculadora de IMC",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A5AE0),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Campo Peso
                  TextField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Campo Altura
                  TextField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (m)",
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Botão Calcular
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: calcularIMC,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6A5AE0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                      ),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Resultado animado
                  AnimatedOpacity(
                    opacity: resultado.isEmpty ? 0 : 1,
                    duration: const Duration(milliseconds: 400),
                    child: Text(
                      resultado,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B2ED3),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}