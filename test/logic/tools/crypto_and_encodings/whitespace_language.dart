import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/whitespace_language.dart';

void main() {
  group("whitespace_language.decodeWhitespace:", () {

    var fibonacci_whitespace = '''Ask the user how	many  	   
fibonacci	numbers
they want from the sequence 		 				
and	print
that many one number per line.			 			
	
     	     
	
     		 		 	
	
     		    	
	
     		 			 
	
     				  	
	
     						
	
     	     
	
     	 
	
		    
   	
 
 	
 	   	 	 
	
  
  	
 
    	
 
			 	      	
			 
	 
 	
 	   	 	 
	
     	 
			   	
	  	 
    	 
 
			 
			 
 
	
  	 
''';

    List<Map<String, dynamic>> _inputsToExpected = [
     /* {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ABCXYZ', 'expectedOutput' : '222999'},
      {'input' : 'AbcxyZ', 'expectedOutput' : '222999'},
      {'input' : 'ABC123XYZ', 'expectedOutput' : '222123999'},
      {'input' : 'ÄÖÜß', 'expectedOutput' : '2687'},
      {'input' : '*%&/', 'expectedOutput' : '*%&/'},
      {'input' : 'ABC*%&/', 'expectedOutput' : '222*%&/'},

      {'input' : ' ', 'numberForSpace': '1', 'expectedOutput' : '1'},
      {'input' : ' ', 'numberForSpace': '0', 'expectedOutput' : '0'},*/
      {'input' : fibonacci_whitespace, 'para': '5', 'error': false, 'expectedOutput' : 'How many?'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await decodeWhitespace(elem['input'], elem['para']);
        expect(_actual.output, elem['expectedOutput']);
        expect(_actual.error, elem['error']);
      });
    });
  });

}