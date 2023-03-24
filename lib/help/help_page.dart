import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';

import 'package:exereader/generated/l10n.dart';

class HelpPage extends StatefulWidget {
  @override
  HelpPageState createState() => new HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  List<Slide> slides = [];
  Color colorTexto = const Color(0xFF475e45);
  Color colorFondo = Colors.white;

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() async {
    //Registramos que ha ya visto la ayuda y nos vamos a home
    // LocalStorage localStorage = LocalStorage();
    //await localStorage.setOtrosdatosStorage(false); //No es el primer login
    Navigator.of(context).pop();
    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ExeReader()),); //saltar a home
  }

  @override
  Widget build(BuildContext context) {

    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    colorTexto = (isDark) ? Colors.white : const Color(0xFF475e45);
    colorFondo = (isDark) ? const Color(0xFF2E2E2E) : Colors.white;

    generateSlides(isDark);

    return IntroSlider(
        slides: this.slides,
        onSkipPress: this.onDonePress,
        onDonePress: this.onDonePress,
        colorActiveDot: Colors.green,
        colorDot: colorTexto,
        renderNextBtn: Icon(Icons.navigate_next, color: colorTexto),
        renderPrevBtn: Icon(Icons.navigate_before, color: colorTexto),
        renderDoneBtn: Icon(Icons.done, color: colorTexto),
        renderSkipBtn: Icon(Icons.close, color: colorTexto),
        doneButtonStyle: ButtonStyle(
          shadowColor: MaterialStateProperty.all(colorTexto),
        ),
        backgroundColorAllSlides: colorFondo);
  }

  // generateSlides
  //
  // Prepare the slides for the presentation, allowing the use of localization
  void generateSlides(bool isDark) {

    String img1 = isDark ? 'assets/splash.png' : 'assets/splash.png';
    String img2 = isDark ? 'assets/help/helpscreen02_dark.png' : 'assets/help/helpscreen02.png';
    String img3 = isDark ? 'assets/help/helpscreen03_dark.png' : 'assets/help/helpscreen03.png';
    String img4 = isDark ? 'assets/help/helpscreen04_dark.png' : 'assets/help/helpscreen04.png';
    String img5 = isDark ? 'assets/help/helpscreen05_dark.png' : 'assets/help/helpscreen05.png';
    String img6 = isDark ? 'assets/help/helpscreen06_dark.png' : 'assets/help/helpscreen06.png';
    String img7 = isDark ? 'assets/help/helpscreen07_dark.png' : 'assets/help/helpscreen07.png';

    slides.add(
      Slide(
          title: S.of(context).appTitle,
          styleTitle: TextStyle(
              color: colorTexto,
              fontSize: 30.0,
              fontWeight: FontWeight.bold
          ),
          maxLineTitle: 2,
          marginTitle: EdgeInsets.only(bottom: 50, top: 90),
          description: S.of(context).helpPart01,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img1,
          backgroundOpacity: 0.3,
          backgroundColor: colorFondo),
    );

    slides.add(
      Slide(
          title: S.of(context).titleHelpPart02,
          styleTitle: TextStyle(
            color: colorTexto,
            fontSize: 30.0,
          ),
          maxLineTitle: 2,
          marginTitle: const EdgeInsets.only(bottom: 30, top: 90),
          description: S.of(context).helpPart02,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img2,
          backgroundColor: colorFondo),
    );

    slides.add(
      Slide(
          title: S.of(context).titleHelpPart03,
          styleTitle: TextStyle(
            color: colorTexto,
            fontSize: 30.0,
          ),
          maxLineTitle: 2,
          marginTitle: const EdgeInsets.only(bottom: 0, top: 90),
          description: S.of(context).helpPart03,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img3,
          backgroundColor: colorFondo),
    );

    slides.add(
      Slide(
          title: S.of(context).titleHelpPart04,
          styleTitle: TextStyle(
            color: colorTexto,
            fontSize: 30.0,
          ),
          maxLineTitle: 2,
          marginTitle: const EdgeInsets.only(bottom: 30, top: 60),
          description: S.of(context).helpPart04,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img4,
          heightImage: 300,
          backgroundColor: colorFondo),
    );

    slides.add(
      Slide(
          title: S.of(context).titleHelpPart05,
          styleTitle: TextStyle(
            color: colorTexto,
            fontSize: 30.0,
          ),
          maxLineTitle: 2,
          marginTitle: const EdgeInsets.only(bottom: 30, top: 90),
          description: S.of(context).helpPart05,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img5,
          backgroundColor: colorFondo),
    );

    slides.add(
      Slide(
          title: S.of(context).titleHelpPart06,
          styleTitle: TextStyle(
            color: colorTexto,
            fontSize: 30.0,
          ),
          maxLineTitle: 2,
          marginTitle: const EdgeInsets.only(bottom: 30, top: 90),
          description: S.of(context).helpPart06,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img6,
          backgroundColor: colorFondo),
    );

    slides.add(
      Slide(
          title: S.of(context).titleHelpPart07,
          styleTitle: TextStyle(
            color: colorTexto,
            fontSize: 30.0,
          ),
          maxLineTitle: 2,
          marginTitle: const EdgeInsets.only(bottom: 30, top: 70),
          description: S.of(context).helpPart07,
          textAlignDescription: TextAlign.left,
          marginDescription: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          styleDescription: TextStyle(color: colorTexto, fontSize: 16.0, fontWeight: FontWeight.normal),
          pathImage: img7,
          backgroundColor: colorFondo),
    );
  }
}
