import 'package:frontend/components/text_fields.dart';
import 'package:frontend/controller/auth_controller.dart';
import 'package:frontend/provider/user_provider.dart';
import 'package:frontend/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final AuthService authService = AuthService();
  late TextEditingController stateController;
  late TextEditingController cityController;
  late TextEditingController localityController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = ref.read(userProvider);
    stateController = TextEditingController(text: user!.state.isEmpty ? '' : user.state );
    cityController = TextEditingController(text: user.city.isEmpty ? '' : user.city );
    localityController = TextEditingController(text: user.locality.isEmpty ? '' : user.locality );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Address",style: GoogleFonts.marcellusSc(fontSize: 28,fontWeight: FontWeight.bold,letterSpacing: 1.7),),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(child: Text("Where will your order \nbe shipped",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.7,
                  color: Colors.grey.shade700
                ),)
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFields(
                  controller: stateController,
                  hinttext: "Enter State Here",
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter The State";
                    }
                    else{
                      return null;
                    }
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFields(
                  controller: cityController ,
                  hinttext: "Enter City Here",
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter The City";
                    }
                    else{
                      return null;
                    }
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFields(
                  controller: localityController,
                  hinttext: "Enter Locality Here",
                  validator: (value){
                    if(value!.isEmpty){
                      return "Please Enter The Locality";
                    }
                    else{
                      return null;
                    }

                  }
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
        child: InkWell(
          onTap: ()async{
            dialogProgressIndicator(context, "Updating...");
            if(_formKey.currentState!.validate()){
              await authService.updateUserLocation(
                  context: context,
                  ref: ref,
                  id: ref.read(userProvider)!.id,
                  state: stateController.text,
                  city: cityController.text,
                  locality: localityController.text
              );
              Navigator.pop(context);
              Navigator.of(context).pop();
            }
            else{
              print("Not Valid");
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blueAccent
            ),
            height: 65,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("Save",style: GoogleFonts.mochiyPopOne(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)),
          ),
        ),
      ),
    );
  }
}

