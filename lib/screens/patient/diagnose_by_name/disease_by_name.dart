import 'package:aid_first/screens/patient/diagnose_by_name/disease_by_name_details.dart';
import 'package:aid_first/screens/patient/shimmer_loader.dart';
import 'package:aid_first/services/diseases_response_service.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseByName extends StatefulWidget {
  const DiseaseByName({Key? key}) : super(key: key);

  @override
  State<DiseaseByName> createState() => _DiseaseByNameState();
}

class _DiseaseByNameState extends State<DiseaseByName> {
  List diseaseData = [];
  List sortedDisList = [];
  List searchList = [];
  var diseaseNames = [];
  bool isLoading = true;
  late final TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    DiseaseResponseService().getDiseasesList().then((res) => setState(() {
          diseaseData = res;
          for (int i = 0; i < diseaseData.length; i++) {
            diseaseNames.add(diseaseData[i]['name']);
          }
          diseaseNames.sort();
          for (int i = 0; i < diseaseNames.length; i++) {
            for (int j = 0; j < diseaseData.length; j++) {
              if (diseaseNames[i] == diseaseData[j]['name']) {
                sortedDisList.add(diseaseData[j]);
              }
            }
          }
        }));
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (diseaseNames.isNotEmpty) {
      setState(() {
        isLoading = false;
      });
    }
    if (textEditingController.text.isNotEmpty) {
      String text = textEditingController.text;
      setState(() {
        for (int i = 0; i < sortedDisList.length; i++) {
          if (sortedDisList[i]['name']
              .toString()
              .toLowerCase()
              .contains(text)) {
            if (!searchList.contains(sortedDisList[i])) {
              searchList.add(sortedDisList[i]);
            }
          }
        }
      });
      print(searchList);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Disease By Name',
          style: GoogleFonts.prociono(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: AnimSearchBar(
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.lightBlueAccent,
        prefixIcon: const Icon(
          Icons.search,
          size: 30,
        ),
        autoFocus: true,
        rtl: true,
        animationDurationInMilli: 250,
        textController: textEditingController,
        closeSearchOnSuffixTap: true,
        onSuffixTap: () {
          setState(() {
            textEditingController.clear();
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 20,
        ),
        child: isLoading
            ? ListView.separated(
                shrinkWrap: true,
                itemBuilder: (_, index) => const ShimmerLoader(),
                separatorBuilder: (_, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: 10,
              )
            : SizedBox(
                width: double.maxFinite,
                child: ListView.separated(
                  itemBuilder: (_, i) => Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DiseaseByNameDetails(
                              details: textEditingController.text.isEmpty
                                  ? sortedDisList[i]
                                  : searchList[i],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 100,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              child: Icon(
                                Icons.medication,
                                size: 34,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Disease Name',
                                  style: GoogleFonts.poppins(fontSize: 20),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.57,
                                  child: Text(
                                    textEditingController.text.isEmpty ||
                                            searchList.isEmpty
                                        ? diseaseNames[i]
                                        : searchList[i]['name'],
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                  ),
                  separatorBuilder: (_, i) => const SizedBox(
                    height: 20,
                  ),
                  itemCount: textEditingController.text.isEmpty
                      ? diseaseNames.length
                      : searchList.length,
                ),
              ),
      ),
    );
  }
}
