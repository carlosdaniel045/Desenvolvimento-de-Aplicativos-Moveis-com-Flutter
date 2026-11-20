import 'package:flutter/material.dart';

void main() {
  runApp(const AgenciaViagensApp());
}

class AgenciaViagensApp extends StatelessWidget {
  const AgenciaViagensApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Mundo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String banner =
      "https://images.unsplash.com/photo-1501785888041-af3ef285b470";

  String destinoAtual = "Nenhum selecionado";
  String descricaoAtual = "";

  String sobreNos =
      "A Explore Mundo é uma agência de viagens especializada em experiências únicas ao redor do mundo. "
      "Nosso objetivo é conectar pessoas a destinos inesquecíveis com segurança, conforto e suporte completo.";

  // ⭐ AVALIAÇÕES FIXAS DOS DESTINOS
  final Map<String, double> avaliacoes = {
    "Paris": 4.5,
    "Maldivas": 4.9,
    "Tokyo": 4.7,
    "Rio de Janeiro": 4.6,
  };

  // CONTROLLER NOVO (COMENTÁRIOS)
  final TextEditingController comentarioController = TextEditingController();

  final Map<String, List<String>> comentarios = {
    "Paris": ["Lugar romântico!", "Incrível demais", "Quero voltar"],
    "Maldivas": ["Mar perfeito", "Experiência surreal"],
    "Tokyo": ["Cidade futurista", "Organização impecável"],
    "Rio de Janeiro": ["Vista incrível!", "Cidade maravilhosa"],
  };

  void mudarDestino(String nome, String desc, String img) {
    setState(() {
      destinoAtual = nome;
      descricaoAtual = desc;
      banner = img;
    });
  }

  void home() {
    setState(() {
      banner =
          "https://images.unsplash.com/photo-1501785888041-af3ef285b470";
      destinoAtual = "Nenhum selecionado";
      descricaoAtual = "";
    });
  }

  void ligar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ligando para +55 62 99821-4457 📞")),
    );
  }

  void acao(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  void adicionarComentario() {
    if (destinoAtual == "Nenhum selecionado") return;
    if (comentarioController.text.isEmpty) return;

    setState(() {
      comentarios.putIfAbsent(destinoAtual, () => []);
      comentarios[destinoAtual]!.add(comentarioController.text);
      comentarioController.clear();
    });
  }

  // ⭐ WIDGET DAS ESTRELAS
  Widget estrelas(double nota) {
    int inteiras = nota.floor();
    bool meia = (nota - inteiras) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < inteiras; i++)
          const Icon(Icons.star, color: Colors.amber, size: 16),

        if (meia)
          const Icon(Icons.star_half, color: Colors.amber, size: 16),

        for (int i = 0; i < (5 - inteiras - (meia ? 1 : 0)); i++)
          const Icon(Icons.star_border, color: Colors.amber, size: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Mundo 🌍"),
        actions: [
          IconButton(icon: const Icon(Icons.home), onPressed: home),
        ],
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Pesquisar destinos...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Image.network(
            banner,
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Destino: $destinoAtual",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  descricaoAtual.isEmpty
                      ? "Selecione um destino abaixo para ver detalhes."
                      : descricaoAtual,
                ),
              ],
            ),
          ),

          const Divider(),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: ligar,
              ),
              IconButton(
                icon: const Icon(Icons.near_me, color: Colors.blue),
                onPressed: () =>
                    acao("Rota sendo calculada para $destinoAtual"),
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.orange),
                onPressed: () => acao("Compartilhando destino..."),
              ),
            ],
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              sobreNos,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),

          const Divider(),

          destino(
            "Paris",
            "França 🇫🇷 - Cidade do amor, cultura e arquitetura histórica.",
            "https://images.unsplash.com/photo-1502602898657-3e91760cbb34",
          ),

          destino(
            "Maldivas",
            "Ilhas paradisíacas com águas cristalinas e resorts de luxo.",
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
          ),

          destino(
            "Tokyo",
            "Japão 🇯🇵 - Tecnologia, tradição e cultura vibrante.",
            "https://images.unsplash.com/photo-1549693578-d683be217e58",
          ),

          destino(
            "Rio de Janeiro",
            "Brasil 🇧🇷 - Cidade maravilhosa com praias e paisagens icônicas.",
            "https://images.unsplash.com/photo-1483729558449-99ef09a8c325",
          ),

          const Divider(),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              "Comentários - $destinoAtual",
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  controller: comentarioController,
                  decoration: const InputDecoration(
                    labelText: "Escreva um comentário",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: adicionarComentario,
                  child: const Text("Adicionar comentário"),
                ),
              ],
            ),
          ),

          ..._comentarios(),
        ],
      ),
    );
  }

  Widget destino(String nome, String desc, String img) {
    double nota = avaliacoes[nome] ?? 0;

    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: const Icon(Icons.place, color: Colors.blue),
        title: Text(nome),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(desc),
            const SizedBox(height: 4),
            estrelas(nota), // ⭐ AVALIAÇÃO AQUI
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => mudarDestino(nome, desc, img),
      ),
    );
  }

  List<Widget> _comentarios() {
    if (!comentarios.containsKey(destinoAtual)) {
      return const [
        Padding(
          padding: EdgeInsets.all(12),
          child: Text("Selecione um destino para ver comentários."),
        )
      ];
    }

    return comentarios[destinoAtual]!
        .map(
          (c) => ListTile(
            leading: const Icon(Icons.person),
            title: Text(c),
            onLongPress: () {
              setState(() {
                comentarios[destinoAtual]!.remove(c);
              });
            },
          ),
        )
        .toList();
  }
}