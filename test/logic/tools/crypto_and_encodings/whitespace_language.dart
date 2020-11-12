import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/whitespace_language.dart';

void main() {
  group("whitespace_language.whitespace:", () {
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
      {'input' : fibonacci_whitespace, 'numberForSpace': null, 'expectedOutput' : ' '},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, numberForSpace: ${elem['numberForSpace']}', () {
        var _actual = whitespace(elem['input']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

}