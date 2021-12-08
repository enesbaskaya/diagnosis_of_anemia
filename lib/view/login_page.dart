import 'package:circular_menu/circular_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kansizlik/model/anemi.dart';
import 'package:kansizlik/component/text_field.dart';
import 'package:kansizlik/view/list_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rbcController = TextEditingController();
  TextEditingController hgbController = TextEditingController();
  TextEditingController hctController = TextEditingController();
  TextEditingController mcvController = TextEditingController();
  TextEditingController mchController = TextEditingController();
  TextEditingController mchcController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getBody(),
      ),
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? CircularMenu(
              items: [
                CircularMenuItem(
                    icon: Icons.list,
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const ListPage(),
                        ),
                      );
                    }),
                CircularMenuItem(
                    icon: Icons.logout,
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      setState(() {});
                    }),
              ],
              alignment: Alignment.bottomRight,
            )
          : null,
    );
  }

  getBody() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return getRealBody();
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InAppTextField(
                    controller: mailController,
                    keyboard: TextInputType.emailAddress,
                    label: "Mail",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InAppTextField(
                    controller: passwordController,
                    passwordText: true,
                    label: "Password",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextButton(
                    onPressed: () async {
                      var mail = mailController.text;
                      var password = passwordController.text;
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: mail,
                          password: password,
                        );
                        setState(() {});
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'email-already-in-use') {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: mail,
                              password: password,
                            );
                            setState(() {});
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              debugPrint('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              debugPrint(
                                  'Wrong password provided for that user.');
                            }
                          }
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Giris Yap",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getRealBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            InAppTextField(
              controller: rbcController,
              keyboard: TextInputType.number,
              label: "RBC",
            ),
            const SizedBox(
              height: 10,
            ),
            InAppTextField(
              controller: hgbController,
              keyboard: TextInputType.number,
              label: "HGB",
            ),
            const SizedBox(
              height: 10,
            ),
            InAppTextField(
              controller: hctController,
              keyboard: TextInputType.number,
              label: "HCT",
            ),
            const SizedBox(
              height: 10,
            ),
            InAppTextField(
              controller: mcvController,
              keyboard: TextInputType.number,
              label: "MCV",
            ),
            const SizedBox(
              height: 10,
            ),
            InAppTextField(
              controller: mchController,
              keyboard: TextInputType.number,
              label: "MCH",
            ),
            const SizedBox(
              height: 10,
            ),
            InAppTextField(
              controller: mchcController,
              keyboard: TextInputType.number,
              label: "MCHC",
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Anemi? anemi = getAnemi(AnemiTypes.type1);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: anemi != null && anemi.result!
                            ? const Text("Yes")
                            : const Text("No"),
                      ));
                      if (anemi != null) {
                        FirebaseFirestore.instance
                            .collection('anemi')
                            .add(anemi.toJson());
                      }
                    },
                    child: const Text(
                      "Anemi 1",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Anemi? anemi = getAnemi(AnemiTypes.type2);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: anemi != null && anemi.result!
                            ? const Text("Yes")
                            : const Text("No"),
                      ));
                      if (anemi != null) {
                        FirebaseFirestore.instance
                            .collection('anemi')
                            .add(anemi.toJson());
                      }
                    },
                    child: const Text(
                      "Anemi 2",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Anemi? anemi = getAnemi(AnemiTypes.type3);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: anemi != null && anemi.result!
                            ? const Text("Yes")
                            : const Text("No"),
                      ));
                      if (anemi != null) {
                        FirebaseFirestore.instance
                            .collection('anemi')
                            .add(anemi.toJson());
                      }
                    },
                    child: const Text(
                      "Anemi 3",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Anemi? getAnemi(AnemiTypes type) {
    double? rbc;
    double? hgb;
    double? hct;
    double? mcv;
    double? mch;
    double? mchc;
    try {
      rbc = double.parse(rbcController.text);
      hgb = double.parse(hgbController.text);
      hct = double.parse(hctController.text);
      mch = double.parse(mchController.text);
      mchc = double.parse(mchcController.text);
      mcv = double.parse(mcvController.text);

      switch (type) {
        case AnemiTypes.type1:
          return Anemi(
            rbc: rbc,
            hgb: hgb,
            hct: hct,
            mcv: mcv,
            mch: mch,
            mchc: mchc,
            date: Timestamp.fromDate(DateTime.now()),
            uid: FirebaseAuth.instance.currentUser!.uid,
            type: type.getName,
            result: anemi1Funct(
              hgb,
              hct,
              mch,
              rbc,
            ),
          );
        case AnemiTypes.type2:
          return Anemi(
            rbc: rbc,
            hgb: hgb,
            hct: hct,
            mcv: mcv,
            mch: mch,
            mchc: mchc,
            date: Timestamp.fromDate(DateTime.now()),
            uid: FirebaseAuth.instance.currentUser!.uid,
            type: type.getName,
            result: anemi2Funct(
              rbc,
              hgb,
              hct,
              mchc,
            ),
          );

        case AnemiTypes.type3:
          return Anemi(
            rbc: rbc,
            hgb: hgb,
            hct: hct,
            mcv: mcv,
            mch: mch,
            mchc: mchc,
            date: Timestamp.fromDate(DateTime.now()),
            uid: FirebaseAuth.instance.currentUser!.uid,
            type: type.getName,
            result: anemi3Funct(
              rbc,
              hgb,
              mch,
              hct,
              mchc,
            ),
          );
      }
    } catch (e) {
      return null;
    }
  }

  bool anemi1Funct(double hgb, double hct, double mch, double rbc) {
    bool isAnemi = false;
    try {
      if (hgb <= 10.95) {
        isAnemi = true;
      } else {
        if (hct <= 33.950) {
          isAnemi = false;
        } else {
          if (hgb > 11.35) {
            isAnemi = false;
          } else {
            if (mch <= 29.95) {
              isAnemi = false;
            } else {
              if (rbc <= 3.665) {
                isAnemi = false;
              } else {
                isAnemi = true;
              }
            }
          }
        }
      }
    } catch (e) {
      isAnemi = false;
    }

    return isAnemi;
  }

  bool anemi2Funct(double rbc, double hgb, double hct, double mchc) {
    bool isAnemi = false;
    try {
      rbc = double.parse(rbcController.text);
      hgb = double.parse(hgbController.text);
      hct = double.parse(hctController.text);
      mchc = double.parse(mchcController.text);
      if (hgb <= 10.95) {
        if (hgb <= 5.51) {
          isAnemi = false;
        } else {
          isAnemi = true;
        }
      } else {
        if (hct > 33.95) {
          isAnemi = false;
        } else {
          if (mchc <= 32.5) {
            isAnemi = true;
          } else {
            if (hgb > 11.45) {
              isAnemi = true;
            } else {
              if (rbc <= 3.6) {
                isAnemi = true;
              } else {
                isAnemi = false;
              }
            }
          }
        }
      }
    } catch (e) {
      isAnemi = false;
    }

    return isAnemi;
  }

  bool anemi3Funct(
      double rbc, double hgb, double mch, double hct, double mchc) {
    bool isAnemi = false;

    try {
      if (hgb <= 10.95) {
        isAnemi = true;
      } else {
        if (hct <= 33.95) {
          if (mchc <= 32.95) {
            isAnemi = true;
          } else {
            isAnemi = false;
          }
        } else {
          if (hgb <= 11.35) {
            if (mch > 29.95) {
              if (rbc <= 3.65) {
                isAnemi = false;
              } else {
                isAnemi = true;
              }
            } else {
              if (mchc > 31.35) {
                isAnemi = false;
              } else {
                if (mchc <= 31.1) {
                  isAnemi = false;
                } else {
                  isAnemi = true;
                }
              }
            }
          } else {
            if (rbc > 4.435) {
              isAnemi = false;
            } else {
              if (rbc <= 4.425) {
                isAnemi = false;
              } else {
                if (mchc > 32.65) {
                  isAnemi = false;
                } else {
                  if (hgb <= 12.45) {
                    isAnemi = false;
                  } else {
                    isAnemi = true;
                  }
                }
              }
            }
          }
        }
      }
    } catch (e) {
      isAnemi = false;
    }
    return isAnemi;
  }
}
