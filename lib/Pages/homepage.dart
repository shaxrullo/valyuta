import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valyuta/homepageProvider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<void> openCBU() async {
    final Uri url = Uri.parse('https://cbu.uz');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Sayt ochilmadi');
    }
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<Homepageprovider>().loadCurriens();
      context.read<Homepageprovider>().amountController;
      context.read<Homepageprovider>().amountFieldController;
      context.read<Homepageprovider>().convertedController;
      context.read<Homepageprovider>().convertedFieldController;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<Homepageprovider>();
    if (provider.currenies.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final date = provider.currenies[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Valyuta ayirboshlash",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Barcha ma'lumotlar Markaziy Bank saytidan olingan",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  action: SnackBarAction(label: "Kirish", onPressed: openCBU),
                ),
              );
            },
            child: Text(
              "!",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.deepOrangeAccent.shade400, Colors.yellow],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: .spaceAround,
                  children: [
                    Text(
                      "Valyuta ayirboshlash",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        minimumSize: Size(100, 50),
                      ),
                      onPressed: () {
                        print(provider.currenies.length);
                        print(provider.nomlar.length);
                        showDialog(
                          context: context,
                          builder: (context) => const MyAlertDialog(),
                        );
                      },
                      label: Text(
                        "Kirish",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      icon: Icon(Icons.monetization_on_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Center(
                child: Text("Valyuta kurslari", style: TextStyle(fontSize: 24)),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 19.0, left: 20),
              child: Text("${date.date}", style: TextStyle(fontSize: 16)),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final valyuta = provider.currenies[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black54,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 25),
                          const Icon(Icons.attach_money_rounded, size: 30),
                          Text(
                            valyuta.ccy,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "MB kursi",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.white30,
                                ),
                              ),
                              Text(
                                valyuta.rate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sotib olish",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.white30,
                                ),
                              ),
                              Text(
                                "${double.parse(valyuta.rate)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Sotish",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.white30,
                                ),
                              ),
                              Text(
                                valyuta.rate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }, childCount: provider.currenies.length),
          ),
        ],
      ),
    );
  }
}

class MyAlertDialog extends StatefulWidget {
  const MyAlertDialog({super.key});

  @override
  State<MyAlertDialog> createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<Homepageprovider>().loadCurriens();
      context.read<Homepageprovider>().amountController;
      context.read<Homepageprovider>().amountFieldController;
      context.read<Homepageprovider>().convertedController;
      context.read<Homepageprovider>().convertedFieldController;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Homepageprovider>(context, listen: false);
    return SizedBox(
      height: 80,
      child: AlertDialog(
        title: Text("Convertor"),
        content: Column(
          mainAxisSize: .min,
          children: [
            Row(
              children: [
                Text(
                  "Miqdori",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 4),

            Row(
              mainAxisSize: .min,
              children: [
                Expanded(
                  flex: 7,
                  child: Consumer<Homepageprovider>(
                    builder: (context, provider, child) => TextField(
                      controller: provider.amountController,
                      onChanged: (value) => provider.calculate(),
                      decoration: InputDecoration(
                        hintText: "Miqdorini kiriting",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Consumer<Homepageprovider>(
                    builder: (context, provider, child) => DropdownMenu(
                      hintText: 'Tanla',
                      controller: provider.amountFieldController,
                      focusNode: FocusNode(canRequestFocus: false),
                      dropdownMenuEntries: provider.currenies
                          .map((e) => e.ccy)
                          .map((e) => DropdownMenuEntry(value: e, label: e))
                          .toList(),
                      onSelected: (value) {
                        provider.amountFieldController.text = value??'';
                        provider.calculate();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.currency_exchange_outlined,
                color: Colors.black,
                size: 24,
              ),
            ),
            Row(
              children: [
                Text(
                  "O'zgartirildi",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              mainAxisSize: .min,
              children: [
                Expanded(
                  flex: 7,
                  child: Consumer<Homepageprovider>(
                    builder: (context, provider, child) => TextField(
                      controller: provider.convertedController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Consumer<Homepageprovider>(
                    builder: (context, provider, child) => DropdownMenu(
                      hintText: 'Tanla',
                      controller: provider.convertedFieldController,
                      focusNode: FocusNode(canRequestFocus: false),
                      dropdownMenuEntries: provider.nomlar
                          .map((e) => DropdownMenuEntry(value: e, label: e))
                          .toList(),
                      onSelected: (value) {
                        provider.convertedFieldController.text = value??'';
                        provider.calculate();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }
}
