import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/utils/snackbar.dart';
import 'package:whatsapp_ui/common/widgets/custombutton.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';



class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/loginscreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  String countryCode = '';

  void pickCountry(){
    showCountryPicker(
        context: context,
        exclude: <String>['KN', 'MF'],
        favorite: <String>['IN'],
        showPhoneCode: true,
        onSelect: (Country country) {
          setState((){
            countryCode = country.phoneCode;
          });
      print('Select country: ${country.phoneCode}');
    },
    // Optional. Sets the theme for the country list picker.
    countryListTheme: CountryListThemeData(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
    ),
    // Optional. Styles the search field.
    inputDecoration: InputDecoration(
    labelText: 'Search',
    hintText: 'Start typing to search',
    prefixIcon: const Icon(Icons.search),
    border: OutlineInputBorder(
    borderSide: BorderSide(
    color: const Color(0xFF8C98A8).withOpacity(0.2),
    ),
    ),
    ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }

  void sendPhoneNumber(){
    String phoneNumber = _phoneController.text.trim();
    if(countryCode!=null&&phoneNumber.isNotEmpty){
      ///ref is used to interact with provider with provider
          ref.read(authControllerProvider).signInWithPhoneNumber(context,'+${countryCode}$phoneNumber');
      ///widget ref is used to interact widget with provider
    }
    else{
      showSnackBar(context: context, content: "Invalid Inputs");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
        appBar: AppBar(
            title:Text("Enter your phone number"),
          elevation: 0,
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("LetsChat will need to verify your number"),
              const SizedBox(
                height: 10,
              ),
              TextButton(onPressed: (){
                pickCountry();
              }, child: Text("Pick Country")),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  if(countryCode!=null)Text("+${countryCode}"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextField(
                      controller: _phoneController,
                      decoration:const InputDecoration(
                        hintText: "Phone number",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.6,
              ),
              SizedBox(
                width: 90,
                child: CustomButton(
                  text: "NEXT",
                  onPresses: sendPhoneNumber,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
