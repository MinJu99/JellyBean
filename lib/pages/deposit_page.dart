import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:test/components/drawer.dart';
import 'package:test/components/loading_circle.dart';
import 'package:test/components/logo.dart';
import 'package:test/components/plus_button.dart';
import 'package:test/components/top_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/services/group/get_logo_name.dart';
import 'package:test/services/util/swipe_card.dart';
import '../components/transaction.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:test/pages/group_list_page.dart';
import 'package:test/pages/inquiry_page.dart';
import 'package:test/pages/notice_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/pages/profile_page.dart';

class DepositPage extends StatefulWidget {
  final String docId;
  const DepositPage({
    required this.docId,
    super.key});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isIncome = false;
  //controller
  final _controller = PageController();

  //image
  XFile? _image;
  final ImagePicker picker = ImagePicker();
  String scannedText = "";
  String result = "";

  String expense = "";
  String uses = "";

  final moneyController = TextEditingController(); //금액
  final useController = TextEditingController(); //사용처
  //final breakdownController = TextEditingController(); //내역

  //새로운 데이터 입력
  // 데이터 로딩까지 기다리기
  bool timerHasStarted = false;

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToGListPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupListPage(),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToNoticePage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoticePage(),
      ),
    );
  }

  void goToInquiryPage() {
    //Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InquiryPage(),
      ),
    );
  }

  // 새로운 입출금 내역
  void _newTransaction() {
    showDialog(
      context: context,
      builder: (context) {
        MainAxisAlignment.spaceBetween; //
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.white,
              actions: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '금액    ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: moneyController,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                    //const SizedBox(width: 10,),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      '사용처',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: useController,
                        textCapitalization: TextCapitalization.words,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                _buildPhotoArea(),
                const SizedBox(
                  height: 15,
                ),
                _buildButton(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: Colors.white,
                      child: const Text(
                        '취소',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            _image = null;
                          },
                        );
                        Navigator.of(context).pop();
                      },
                    ),   
                    MaterialButton(
                      color: Colors.white,
                      child: const Text(
                        '추가',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        _getInfo(useController.text,
                            moneyController.text.toString());
                        Navigator.of(context).pop(); //닫히게 함
                      },
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future _getInfo(String item, String amount) async {
    setState(() {
      uses = item;
      expense = amount;
    });
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 210, 
            height: 280,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 210, 
            height: 280, 
            color: Colors.grey,
          );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
          },
          child: Text("카메라"),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          child: Text("갤러리"),
        ),
      ],
    );
  }

  //이미지 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
      //getRecognizedText(_image!);
    }
  }

  /*void getRecognizedText(XFile image) async {
    final InputImage inputImage = InputImage.fromFilePath(image.path);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    await textRecognizer.close();

    scannedText = "";

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    String target = "AMOUNT";
    int target_num = scannedText.indexOf(target);
    result = scannedText.substring(target_num,
        (scannedText.substring(target_num).indexOf(":") + target_num));
    result = result.replaceAll(RegExp('[^0-9]'), '');

    setState(() {});
  }*/

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        endDrawer: MyDrawer(
          //Drawer->endDrawer
          onProfileTap: goToProfilePage,
          onSignOut: signOut,
          onHomeTap: goToGListPage,
          onNoticeTap: goToNoticePage,
          onInquiryTap: goToInquiryPage,
        ),
        backgroundColor: Colors.white, //grey[300],

        body: Stack(
          //Padding(
          alignment: Alignment.topRight,
          //padding: const EdgeInsets.all(7.0), //15.0

          children: [
            Positioned(
              top: 40, //5
              left: 10,
              child: GetLogoName(documentId: widget.docId),
            ),
            Positioned(
              top: 70, //30
              right: 20,
              child: IconButton(
                //padding: const EdgeInsets.all(30),
                icon: Icon(Icons.menu),
                color: Colors.black,
                onPressed: () {
                  _globalKey.currentState!
                      .openEndDrawer(); //openDrawer->openEndDrawer
                },
              ),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 110,
                  ),
                  SizedBox(
                    height: 160,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      children: const [
                        TopNeuCard(
                            balance: '20,000',
                            expense: '10,000',
                            income: '30,000'),
                        myPointCard(
                            balance: '17,000',
                            expense: '2,000',
                            income: '8,000'),
                      ],
                    ),
                  ),

                  //const SizedBox(height: 5),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      dotColor: Color.fromARGB(255, 211, 195, 227),
                      activeDotColor: Color.fromARGB(255, 186, 158, 215),
                    ),
                    //effect: ExpandingDotsEffect(activeDotColor: Color.fromARGB(255,211,195,227),),
                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            MyTransaction(
                                expenseOrIncome: 'expense',
                                transactionName: uses,
                                money: expense),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PlusButton(
                    function: _newTransaction,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
