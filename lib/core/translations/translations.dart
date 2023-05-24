//Package Dependancy
import 'package:get/get.dart';

//Internal Dependancy
import './languages/en_us.dart';
import './languages/mr_in.dart';

class Messages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {

    EnUS.key: EnUS.values,
    
    MrIn.key: MrIn.values,

  };

}