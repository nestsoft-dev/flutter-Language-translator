import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:translator/translator.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _userInput = TextEditingController();
  bool isloading = false;
  var selectedValue;
  var translated;
  final List<String> items = [
    'Spanish',
    'Italy',
    'Korean',
    'Japan',
  ];

  void translateText(String text) async {
    final translator = GoogleTranslator();
    var translate =
        await translator.translate(text, from: 'auto', to: 'it').then((value) {
      setState(() {
        translated = value;
        print(value.toString());
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff131212),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            //head text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select Language to Translate",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )
              ],
            ),

            SizedBox(
              height: 25,
            ),

            //spinner for languages
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //to
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Translate To',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 243, 243, 243),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Color.fromARGB(255, 78, 78, 78),
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        iconSize: 14,
                        iconEnabledColor: Color.fromARGB(255, 119, 119, 118),
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        padding: null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Color.fromARGB(255, 121, 121, 121),
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility:
                              MaterialStateProperty.all<bool>(true),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //container for user input
            SizedBox(
              height: 20,
            ),
            Container(
              height: 175,
              width: 378,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(0xfff232222),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        offset: Offset(3, 6),
                        color: Color(0xfff3D3D3D))
                  ]),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _userInput,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Please Enter text to Translate',
                  hintStyle: TextStyle(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            //translate button
            GestureDetector(
              onTap: () {
                if (_userInput.text == "" || _userInput.text.length < 1) {
                  print('provide input');
                } else {
                  translateText(_userInput.text);
                  setState(() {
                    isloading = true;
                  });
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Color(0xfff1A1717),
                    borderRadius: BorderRadius.circular(12)),
                child: isloading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: Text(
                        'Translate Text',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            //translated text container
            Container(
              height: 175,
              width: 378,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(0xfff232222),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 6,
                        offset: Offset(3, 6),
                        color: Color(0xfff3D3D3D))
                  ]),
              child: translated == null
                  ? null
                  : Text(
                      '$translated',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
            ),

            SizedBox(
              height: 35,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //copy container
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(translated);
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfff232222),
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(3, 6),
                                color: Color(0xfff3D3D3D))
                          ]),
                      child: Center(
                        child: Icon(
                          Icons.copy,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),

                  //share translated text
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfff232222),
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(3, 6),
                                color: Color(0xfff3D3D3D))
                          ]),
                      child: Center(
                        child: Icon(
                          Icons.share,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),

                  //text to speech
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfff232222),
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(3, 6),
                                color: Color(0xfff3D3D3D))
                          ]),
                      child: Center(
                        child: Icon(
                          Icons.speaker,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),

                  //speech to text

                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Color(0xfff232222),
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                offset: Offset(3, 6),
                                color: Color(0xfff3D3D3D))
                          ]),
                      child: Center(
                        child: Icon(
                          Icons.mic,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
