import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/whitespace_language.dart';

void main() {
  group("whitespace_language.encodeWhitespace:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'expectedOutput' : ''},
      {'input' : '', 'expectedOutput' : ''},

      {'input' : 'ltu', 'expectedOutput' : ' \t\n'},
      {'input' : 'stl', 'expectedOutput' : ' \t\n'},
      {'input' : 'ltu ABC\nDEF', 'expectedOutput' : ' \t\n'},
      {'input' : 'stl ABC\nDEF', 'expectedOutput' : ' \t\n'},
      {'input' : ' \t\nABCDEF', 'expectedOutput' : ' \t\n'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await encodeWhitespace(elem['input']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });

  group("whitespace_language.decodeWhitespace:", () {

    var fibonacci_whitespace = '''Ask the user how	many  	   
fibonacci	numbers
they want from the sequence 		 				
and	print
that many one number per line.			 			
	
     	     
	
     		 		 	
	
     		    	
	
     		 			 
	
     				  	
	
     						
	
     	     
	
     	 
	
		    
   	
 
 	
 	   	 	 
	
  
  	
 
    	
 
			 	      	
			 
	 
 	
 	   	 	 
	
     	 
			   	
	  	 
    	 
 
			 
			 
 
	
  	 
''';

    var helloWorldCode = '''sssttsttssltlsssssttsttssltlsssssttsttssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttstssltl'
    'sssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttststltlssssstt'
    'sttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttststltlssssstttstssltlssssstttstsslt'
    'lsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssst'
    'tsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssl'
    'tlssssstttstssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssss'
    'tttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttstltlssssststsltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttststltlsss'
    'ssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttststltlssssstttstssltlssssstttst'
    'ssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlss'
    'sssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttts'
    'tssltlssssstttstssltlsssssttsttssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltls'
    'sssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttststltlsssssttsttssltlssssstts'
    'ttssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltl'
    'sssssttsttssltlsssssttstltlssssststsltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssl'
    'tlssssstttstssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssss'
    'ttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstss'
    'ltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssss'
    'sttsttssltlssssstttstssltlsssssttsttssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttstts'
    'sltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttstssltlsss'
    'sstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttstltlssssststsltlssssstttstssltlsssssttsttssltlsssssttsttssltls'
    'sssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttststltlssssstts'
    'ttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltl'
    'sssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlsssssttsttssltlssssstttstssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstt'
    'tstssltlsssssttsttssltlssssstttstssltlssssstttststltlssssstttstssltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstsslt'
    'lsssssttsttssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttstssltlssssst'
    'tsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttstssltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssl'
    'tlssssstttststltlssssstttstssltlsssssttstltlssssststsltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttststltlssssstttststltlsssssttstts'
    'sltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttststltlsssssttsttssltlssssstttststltlsssssttsttssltlssssstttstssltlssssstttstssltlssssstttstssltlsssssttsttssltlsss'
    'sstttststltlsssssttsttssltlssssstttststltlssssstttstssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttststltlssssstttstssltlssssstttststltlsssssttsttssltlsssssttstt'
    'ssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlssssstttststltlssssstttstssltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttststltlsssssttsttssltlssssstttststltlss'
    'sssttsttssltlsssssttsttssltlssssstttstssltlssssstttststltlssssstttststltlsssssttsttssltlsssssttsttssltlsssssttsttssltlssssstttstssltlsssssttsttssltlssssstttststltlssssstttststltlsssssttts'
    'tstltlssssstttststltlssllll''';

    var helloWorldOutput = '''lllullltlltllluttlllltulllttlltltuttlllltlulllttlttlluttllllttulllttlttlluttllll\r\ntllulllttlttttuttlllltltullltlttlluttllllttlullltllllluttlllltttullltttltttuttll\r\nlltlllulllttlttttuttlllltlltullltttlltluttlllltltlulllttlttlluttlllltlttulllttll\r\ntlluttllllttllullltlllltuttllllttltulllttltuttlllltttlullltltluttllllttttullllut\r\ntllllluulllltulultttlulutlltlutullllltutlllululltuullltluuuu''';

    var helloWorldTextGerman ='''lllullltlltllluttlllltulllttlltltuttlllltlulllttlttlluttllllttulllttlttlluttllll
 tllulllttlttttuttlllltltullltlttlluttllllttlullltllllluttlllltttullltttltttuttll
 lltlllulllttlttttuttlllltlltullltttlltluttlllltltlulllttlttlluttlllltlttulllttll
 tlluttllllttllullltlllltuttllllttltulllttltuttlllltttlullltltluttllllttttullllut
 tllllluulllltulultttlulutlltlutullllltutlllululltuullltluuuu''';

    var helloWorldTextEnglish = '''SSSLSSSTSSTSSSLTTSSSSTLSSSTTSSTSTLTTSSSSTSLSSSTTSTTSSLTTSSSSTTLSSSTTSTTSSLTTSSSS
TSSLSSSTTSTTTTLTTSSSSTSTLSSSTSTTSSLTTSSSSTTSLSSSTSSSSSLTTSSSSTTTLSSSTTTSTTTLTTSS
SSTSSSLSSSTTSTTTTLTTSSSSTSSTLSSSTTTSSTSLTTSSSSTSTSLSSSTTSTTSSLTTSSSSTSTTLSSSTTSS
TSSLTTSSSSTTSSLSSSTSSSSTLTTSSSSTTSTLSSSTTSTLTTSSSSTTTSLSSSTSTSLTTSSSSTTTTLSSSSLT
TSSSSSLLSSSSTLSLSTTTSLSLTSSTSLTLSSSSSTLTSSSLSLSSTLLSSSTSLLLL''';

    var helloWorld2 = '''ssslssstsstssslttsssstlsssttsststlttsssstslsssttsttsslttssssttlsssttsttsslttsssstsslsssttsttttlttsssststlssststtsslttssssttslssstssssslttsssstttlssstttstttlttsssstsssl'
    'sssttsttttlttsssstsstlssstttsstslttsssststslsssttsttsslttsssststtlsssttsstsslttssssttsslssstssssslttssssttstlsssttsttttlttsssstttslsssttssttslttssssttttlssstssssslttsssstsssslssstttssttlt'
    'tsssstssstlssstttsssslttsssstsstslsssttsssstlttsssstssttlsssttsssttlttsssststsslsssttsststlttsssstststlssstttssttlttsssststtslssstsssstlttsssststttlsssslttsssssllststttstttstttsstssttstss'
    'tstttstsssttsststllststtstttssttsstststttstttsttsttsssttstsststtstttssttsststlllllsssttsssststtsstsssttsstssltsssltllssstttstttstttsstssttstsststttstsssttsststlslstttslsltsstttstttstttsst'
    'ssttstsststttstsssttsststststttttsttsstststtstttssttsstssltlssssstltssslslstttstttstttsstssttstsststttstsssttsststllssstttstttstttsstssttstsststttstsssttsststststttttsttsstststtstttssttss'
    'tsslsllsllltllssstttsstssttsstststtsssststtsstsslslsslstltstttslsssststsltsstltsstttsstssttsstststtsssststtsstssststttttsttsstststtstttssttsstsslsllssstltssslslstttsstssttsstststtsssststt'
    'sstssllssstttsstssttsstststtsssststtsstssststttttsttsstststtstttssttsstsslsllssstltssssssslttsltllsssttstttssttsstststttstttsttsttsssttstsststtstttssttsststlssststslsssttstltlsstlsslt''';

    var cat_program = 'ulllullltututlllltuttttullllltuutltuululuulltuuuu';

    var truthMachine = 'lllulultutttttutlluulltullltutultulutuulllulllutultuuu';

    // Test don't work with whitspace text, only with character as first sign (trim problem ??)
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : null, 'para': null, 'timeOut': 30000, 'error': false, 'expectedOutput' : ''},
      {'input' : '', 'para': null, 'timeOut': 30000, 'error': false, 'expectedOutput' : ''},
      {'input' : '', 'para': '', 'timeOut': 30000, 'error': false, 'expectedOutput' : ''},
      {'input' : null, 'para': '', 'timeOut': 30000, 'error': false, 'expectedOutput' : ''},


      {'input' : fibonacci_whitespace, 'para': '5', 'timeOut': 30000, 'error': true, 'expectedOutput' : 'How many? 1\n1\n'},
      {'input' : helloWorldCode, 'para': '', 'timeOut': 30000, 'error': false, 'expectedOutput' : helloWorldOutput},
      {'input' : helloWorldTextGerman, 'para': '', 'timeOut': 30000, 'error': false, 'expectedOutput' : 'Hello, world!\r\n'},
      {'input' : helloWorldTextEnglish, 'para': '', 'timeOut': 30000, 'error': false, 'expectedOutput' : 'Hello, world!\r\n'},
      {'input' : helloWorld2, 'para': '', 'timeOut': 30000, 'error': true, 'expectedOutput' : 'Hello, world of spaces!\r\n'},
      {'input' : cat_program, 'para': 'Test', 'timeOut': 30000, 'error': true, 'expectedOutput' : 'Test'},
     {'input' : truthMachine, 'para': '0', 'timeOut': 30000, 'error': false, 'expectedOutput' : '0'},
      //timeout test
      //{'input' : truthMachine, 'para': '1', 'timeOut': 100, 'error': true, 'expectedOutput' : '111111111111111111111111111111111111111111111111111111111'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}', () async {
        var _actual = await decodeWhitespace(elem['input'], elem['para'], timeOut : elem['timeOut']);
        expect(_actual.output, elem['expectedOutput']);
        expect(_actual.error, elem['error']);
      });
    });
  });

}