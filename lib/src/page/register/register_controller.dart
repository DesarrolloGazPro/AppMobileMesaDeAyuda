import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mesadeayuda/src/models/user.dart';
import 'package:mesadeayuda/src/providers/users_provider.dart';
import 'package:mesadeayuda/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController {

 late BuildContext context;
 TextEditingController emailController = new TextEditingController();
 TextEditingController nameController = new TextEditingController();
 TextEditingController lastNameController = new TextEditingController();
 TextEditingController phoneController = new TextEditingController();
 TextEditingController passwordController = new TextEditingController();
 TextEditingController confirmPasswordController = new TextEditingController();
 UsersProviders usersProviders = new UsersProviders();
  XFile? pickedFile;
  File? imageFile;
 late Function refresh;
 late ProgressDialog _progressDialog;
 bool isEnable = true;

 Future<void> init(BuildContext context, Function refresh) async {
   this.context=context;
   this.refresh=refresh;
   await usersProviders.init(context);
   _progressDialog=ProgressDialog(context: context);
 }

 void register() async {
  String email= emailController.text.trim();
  String name= nameController.text.trim();
  String lastName= lastNameController.text.trim();
  String phone= phoneController.text.trim();
  String password= passwordController.text.trim();
  String confirmPassword= confirmPasswordController.text.trim();

  if(email.isEmpty || name.isEmpty ||
      lastName.isEmpty || phone.isEmpty
      || password.isEmpty || confirmPassword.isEmpty){
   MySnackBar.show(context, 'Debes ingresar todos los campos');
   return;
  }

  if(confirmPassword != password){
   MySnackBar.show(context, 'Lac contrasenas no coinciden');
   return;
  }

  if(password.length < 6){
   MySnackBar.show(context, 'Lac contrasena debe de tener almenos 6 caracteres');
   return;
  }

  _progressDialog.show(max: 100, msg: 'Espera un momento...');
  isEnable=false;
  User user = new User(
      id: 0,
      email: email,
      name: name,
      lastname: lastName,
      phone: phone,
      password: password
  );



   final res =  await usersProviders.create(user, imageFile!);
   if (res){
    _progressDialog.close();
    MySnackBar.show(context, 'Usuarioa agregado correctamente');
    isEnable=true;
   }else{
    _progressDialog.close();
    isEnable=true;
   }
 }

 Future selectImage(ImageSource imageSource) async{
  pickedFile = await ImagePicker().pickImage(source: imageSource);

  if(pickedFile != null){
     imageFile=File(pickedFile!.path);
  }

  Navigator.pop(context);

  refresh();
 }

 void showAlertDialog(){
  Widget galleryButton= ElevatedButton(
      onPressed: (){ 
       selectImage(ImageSource.gallery);
      },
      child: Text('GALERIA')
  );

  Widget camaraButton= ElevatedButton(
      onPressed: (){
       selectImage(ImageSource.camera);

      },
      child: Text('CAMARA')
  );
  
  AlertDialog alertDialog = AlertDialog( 
   title: Text('Selecciona tu imagen'),
   actions: [
    galleryButton,
    camaraButton
   ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context){
       return alertDialog;
      });
    }
 void back(){
  Navigator.pop(context);
 }
}