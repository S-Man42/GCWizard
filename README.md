# GCWizard

## How to contribute a new function?

### Create your development environment

Everyone will use a different setting. Mine is as follows:

1. **Download source code:** `https://github.com/S-Man42/GCWizard.git` (for https) or `git@github.com:S-Man42/GCWizard.git` (for SSH)
1. **Download and extract Flutter SDK** https://flutter.dev/docs/get-started/install
1. **Download and install Android Studio** (with Android Virtual Device) https://developer.android.com/studio
   1. At first start, follow the install instructions
   1. When asked, import existing project
   1. Install Flutter/Dart plugin: Main menu -> File -> Settings -> Plugins -> Search for `flutter` -> Install (should install Dart automatically) -> Restart
   1. After restart, set Flutter SDK path: Main menu -> File -> Settings -> Languages & Frameworks -> Flutter -> Flutter SDK path -> Your path where you extracted flutter before.
1. **Get the project ready for compiling:**
   1. A message should appeared at the top of the code view: `'Packages get' has not been run`. If so: Click *Get dependencies*; if not: Go to *Terminal* (bottom of the IDE) and type in `flutter pub get`
   1. Wait a minute for new indexing; afterwards there shouldn't be any error message, anymore
1. **Install emulator:**
   1. Open AVD Manager (Toolbar, Button with Smartphone/Android logo) -> Create Virtual Device -> Choose one (e.g. the *Pixel 3*) 
   2. Choose Android Version, highest API level recommended (currently Android Q, API level 29) -> Download -> Accept
   3. After finishing Download, finish device creation; You can start the device now from the AVD Manager (Play button) -> wait until device has booted
1. **Run project**
   1. Run `main.dart` (sometimes, the IDE needs a moment to recognize the emulator, wait a moment, try a second time); first start may take a while
   1. Every code change will be deployed to the app immediately after saving due to the **Hot Reload** feature of the IDE
 
### Create a feature
Step-by-step tutorial by building a simple function which takes an integer value and increases it by 1 on *encrypt* mode, and other way round:

#### Build the logic:
Of course, if you like to code test-driven, please do the next step first :)

1. The business logic is located in `/lib/logic`. For crypto tools you should choose the path `/lib/logic/tools/crypto`. Create a well-named new dart file. Assuming, your encrypting algorithm is called *Increased N*, you should call your file `increased_n.dart`, everything in lower case, using underscores. If you are planning a more difficult feature with some sub function, think about a sub directory (e.g. as the coordinate functions or the math/primes functions) 
1. Dart coding guidlines recommend not creating a class if you only want to write static functions, as we will. You need a static function for each, encryption and decryption. The entry functions, which will be called later by external methods or the widget, should be called `encryptX`/`decryptX` or, in case of encodings, `encodeX`/`decodeX`. Please ensure, that you catch some edge cases and return either null or an empty string or whatever fits in that case:

```dart
encryptIncreasedN(int number) {
  if (number == null)
    return null;
  
  return number + 1;
}

decryptIncreasedN(int number) {
  if (number == null)
    return null;

  return number - 1;
}
```

#### Create tests for business logic:
1. Tests are located in the `/test/` directory. Its structure follows the main structure. So, your test should be located into `/test/logic/tools/crypto/increased_n.dart`.
1. **Test structure**: There are test groups. Every group is for testing a specific method. Usually there are two groups, one for encryption and one for decryption. Every group gets a list of input values, combined with the specific expected output.  Every list entry is a key/pair map, which should mirror the parameter names and their values. Afterwards this list will be iterated. For every list entry the relevant function will be called. Please add some well-thought test cases, some crazy values and, of course, the typical cases `null` and, if relevant, empty strings or lists.
2. **Write and run tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/crypto/increased_n.dart';

void main() {
  group('IncreasedN.encrypt:', () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'number' : null, 'expectedOutput' : null},

      {'number' : -42, 'expectedOutput' : -41},
      {'number' : -1, 'expectedOutput' : 0},
      {'number' : 0, 'expectedOutput' : 1},
      {'number' : 1, 'expectedOutput' : 2},
      {'number' : 42, 'expectedOutput' : 43},
    ];

    _inputsToExpected.forEach((elem) {
      test('number: ${elem['number']}', () {
        var _actual = encryptIncreasedN(elem['number']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });

  group('IncreasedN.decrypt:', () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'number' : null, 'expectedOutput' : null},

      {'number' : -42, 'expectedOutput' : -43},
      {'number' : -1, 'expectedOutput' : -2},
      {'number' : 0, 'expectedOutput' : -1},
      {'number' : 1, 'expectedOutput' : 0},
      {'number' : 42, 'expectedOutput' : 41},
    ];

    _inputsToExpected.forEach((elem) {
      test('number: ${elem['number']}', () {
        var _actual = decryptIncreasedN(elem['number']);
        expect(_actual, elem['expectedOutput']);
      });
    });
  });
}
```

#### Create frontend (widget)
<ol>
	<li>
		Widgets are located in <tt>/lib/widgets/</tt>, The sub directory, again, follows the structure of the logic directory. So, your widget should be located into <tt>/lib/widgets/tools/crypto/increased_n.dart</tt>
	</li>  
	<li>
		The widget structure supports you by encapsuling the boiler plate code for the simple widget creation, the navigation to the widget, the scrolling, the title and so on. You simply have to write a layout for inputs and outputs. All widgets are of type <tt>StatefulWidget</tt>, their state management (if you like, their whole frontend logic) is in their <tt>State</tt> class. The most important one is the <tt>build()</tt> method in the state class, which will be called by the framework to build your frontend.<br/>
		<br/>
		Usually (as long as no-one has a better idea), you will return a <tt>Column()</tt> widget, which layouts your text fields and output fields and everything else in vertically order.<br/>
		<br/>  
		It's very important that you always import the widgets from the <tt>material.dart</tt> and not the <tt>cupertino.dart</tt>, which mostly contains the same widgets, but which is only for iOS.<br/>
		<br/>
		This could be your stub, which would show an empty page (with title):
  
```dart
import 'package:flutter/material.dart';

class IncreasedN extends StatefulWidget {
  @override
  IncreasedNState createState() => IncreasedNState();
}

class IncreasedNState extends State<IncreasedN> {

  @override
  Widget build(BuildContext context) {
  return Column(
    children: <Widget>[

    ],
  );
  }
}
```
    
</li>
	<li>
		<b>Create the structure</b>: You need a (integer) text field and a switch for encrypt/decrypt. Furthermore you need an output field:
		<ol>
      <li>
				<b>Integer TextField</b>: There are already many specialized widgets. You can find them in the <tt>widgets/common/</tt> directory. So, of course, there is already a special <tt>TextField</tt> for integer inputs, which:
				<ul>
					<li>already has an input controller</li>
					<li>allows only digits inputs</li>
					<li>eturns both, the real entered text and the parsed integer input</li>
				</ul>  
				It is called <b><tt>GCWIntegerTextField</tt></b>, which we take for simplicity. But, for real cases, there is another widget, which fits better: The <tt>GCWIntegerSpinner</tt>, which adds +/- buttons next to the <tt>TextField</tt>.
			</li>  
      <li>
				<b>The mode switch</b>: There are two types of switches: The first is a simple on/off switch, which returns <tt>true</tt> and <tt>false</tt>, and a two-options switch, which returns the switch position (<tt>left</tt> or <tt>right</tt>). Without any further configuration, it already shows: <i>Mode: Encrypt/Decrypt</i>. This is called <b><tt>GCWTwoOptionsSwitch</tt></b>
			</li>
			<li>
				<b>The output</b>: Of course, there is already a widget for it:
				<ul>
					<li>It paints a devider with localized <i>Output</i> text</li>
					<li>It provides a formatted Text widget for the content.</li>
				</ul>
				You only have to put the text to it. It's name is <b><tt>GCWOutputText</tt></b> 
			</li>    
</ol>


```dart
import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/common/base/gcw_output_text.dart';
import 'package:gc_wizard/widgets/common/gcw_integer_textfield.dart';
import 'package:gc_wizard/widgets/common/gcw_twooptions_switch.dart';
import 'package:gc_wizard/logic/tools/crypto/increased_n.dart';

class IncreasedN extends StatefulWidget {
  @override
  IncreasedNState createState() => IncreasedNState();
}

class IncreasedNState extends State<IncreasedN> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerTextField(),  // here are your widgets
        GCWTwoOptionsSwitch(),
        GCWOutputText(
          text: //TODO
        )
      ],
    );
  }
}
```
    
</li>
	<li>
		Store the values and calculate the output
		<ol>
			<li>
				Every widget returns a value: The integer input returns an integer and the switch returns its position. On the other hand, the output text presumes the output text. So, you have to create some local variables to store the input values and to hand over the result to the output.
			</li>
			<li>
				<b>Create <tt>onChanged()</tt> callback</b>: Most widgets can take a function callback for their <tt>onChanged</tt> events. This is the point to receive the values:
				
```dart
class IncreasedNState extends State<IncreasedN> {

  //define local variables and initialize them
  var _currentIntegerValue = {'text': '', 'value': 0}; // this is how the return value of the GCWIntegerTextField looks like. There is a global variable for the initial value: defaultIntegerText
  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerTextField(
          onChanged: (ret) {              // onChanged callback for TextField
            setState(() {
              _currentIntegerValue = ret; // set value
            });
          }
        ),
        GCWTwoOptionsSwitch(
          onChanged: (value) {            // onChanged callback for Switch
            setState(() {
              _currentMode = value;       // set value
            });
          },
        ),
        GCWOutputText(
          text: //TODO
        )
      ],
    );
  }
}
```
        
</li>
			<li>
				<b>Calculate and set output</b>: There are several ways to do it. You surely noticed the <tt>setState()</tt> calls in the <tt>onChanged()</tt> callbacks. They trigger a widget rebuild. So, in that case, everytime a value has changed, the widget will be rebuild. And the output will be recalculated. So, you can add the calculation directly to the text attribute of the <tt>GCWOutputText</tt>. Because, usually your layout would be much more complex, so, it is better to extract this calculation to a method, which should return a string in all cases:

```dart
class IncreasedNState extends State<IncreasedN> {

  var _currentIntegerValue = defaultIntegerText; // here the global variable is used
  var _currentMode = GCWSwitchPosition.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GCWIntegerTextField(
          ...
        ),
        GCWTwoOptionsSwitch(
          ...
        ),
        GCWOutputText(
          text: _buildOutput()            // call the ouput method
        )
      ],
    );
  }

  _buildOutput() {
    if (_currentIntegerValue == null)      // catch some edge cases
      return '';

    var calculated = _currentMode == GCWSwitchPosition.left
      ? encryptIncreasedN(_currentIntegerValue['value'])  // Position.left == encrypt; notice the ['value'] part, which takes the parsed integer value from the text field result
      : decryptIncreasedN(_currentIntegerValue['value']); // Position.right == decrypt

    return calculated == null ? '' : calculated.toString();
  }
}
```
        
</li>
		</ol>
	</li>
	<li>
		<b>Register the widget</b>: All widgets are registered centrally. The file is <tt>/widgets/registry.dart</tt>. This wraps your layout with a real page widget, adds a keyword for the language files (which will be mapped to title, description and example, see below), the category, where the tool fits (usually <tt>CRYPTOGRAPHY</tt> for codes or <tt>SCIENCE_AND_TECHNOLOGY<tt/> for some scientific formula stuff) and even the keywords for the search engine:
  
```dart
GCWToolWidget(
  tool: IncreasedN(), 
  i18nPrefix: 'increasedn'), 
  category: ToolCategory.CRYPTOGRAPHY,
  searchStrings: 'increasedn')
),
```

Notice, that the toolname is a call of the <tt>i18n()</tt> method. This is for internationalization. It maps the given keyword (<tt>increasedn_title</tt> in this case) to the real output in all available languages. 
  </li>
	<li>
		<b>Put the widget into a list</b>: This means: Every widget has a list as parent. Most widget are located in the main list, which is shown on the main screen. But some tools, like the coordinate functions are part of an own list. All lists order their tools by their (localized) titles. So, this tool can be put into the main list, which can be found in <tt>/widgets/main_screen.dart</tt>, around lines 90ff.. Add line:
  
```dart
className(IncreasedN()),
```
    
</li>
	<li>
		<b>Internationalize</b>: In the directory <tt>/assets/i18n/</tt> you can find all language files. These are key/value JSON files, each for every supported language. You already used a localization key in the registry, which is mapped here to the title, the description and an example (title is neccessary, others are optional but recommended). This needs to be transferred to a real text. So, please add all used keys (maybe you used some directly in your widget as well) and put the text in the specific language:

```
en.json:
 "increasedn_title" : "Increased N",
 "increasedn_description" : "Increases an integer value by 1",
 "increasedn_example" : "41 → 42",

de.json:
 "increasedn_title" : "Inkrementiertes N",
 "increasedn_description" : "Erhöht eine Ganzzahl um 1",
 "increasedn_example" : "41 → 42",
```
    
</li>
</ol>

#### Run App. Enjoy!
