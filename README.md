# GCWizard

## How to contribute a new function?

### Create your development environment (Android)

[And iOS setup is missing at the moment]

Everyone will use a different setting. Mine is as follows:

1. **Download source code:** `https://github.com/S-Man42/GCWizard.git` (for https) or `git@github.com:S-Man42/GCWizard.git` (for SSH)
1. **Download and extract Flutter SDK** https://flutter.dev/docs/get-started/install
1. **Download and install Android Studio** (with Android Virtual Device) https://developer.android.com/studio
   1. At first start, follow the install instructions
      1. This should include the installation of the Android SDK (minimum API Level 28); if not, do it manually: Main menu -> Tools -> SDK Manager -> System settings -> Android SDK
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
Tests for the logic are essential: First, they ensure that the logic works as expected and they ensure, that a possible change will not destroy the current functionality. Second, they serve as a documentation. If somebody wants to know, how a certain functions works, he or she can take a look at the test cases, check out the parameters and can see the expected result. This is also one of the first things, a reviewer for Pull Requests checks out before he or she will take a look at the real code.
1. Tests are located in the `/test/` directory. Its structure follows the main structure. So, your test should be located into `/test/logic/tools/crypto_and_encodings/increased_n.dart`.
1. **Test structure**: There are test groups. Every group is for testing a specific method. Usually there are two groups, one for encryption and one for decryption. Every group gets a list of input values, combined with the specific expected output.  Every list entry is a key/pair map, which should mirror the parameter names and their values. Afterwards this list will be iterated. For every list entry the relevant function will be called. Please add some well-thought test cases, some crazy values and, of course, the typical cases `null` and, if relevant, empty strings or lists.
2. **Write and run tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/increased_n.dart';

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
		Widgets are located in <tt>/lib/widgets/</tt>, The sub directory, again, follows the structure of the logic directory. So, your widget should be located into <tt>/lib/widgets/tools/crypto_and_encodings/increased_n.dart</tt>
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
import 'package:gc_wizard/logic/tools/crypto_and_encodings/increased_n.dart';

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
		<b>Register the widget</b>: All widgets are registered centrally. The file is <tt>/widgets/registry.dart</tt>. This imports your widget, wraps your layout with a real page widget, adds a keyword for the language files (which will be mapped to title, description and example, see below), the category, where the tool fits (usually <tt>CRYPTOGRAPHY</tt> for codes or <tt>SCIENCE_AND_TECHNOLOGY</tt> for some scientific formula stuff) and even the keywords for the search engine (without umlauts or diacritics):
	
```dart
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/increasedn.dart';

...

GCWToolWidget(
  tool: IncreasedN(), 
  i18nPrefix: 'increasedn', 
  category: ToolCategory.CRYPTOGRAPHY,
  searchStrings: 'increasedn'
),
```

Notice, that the toolname is a call of the <tt>i18n()</tt> method. This is for internationalization. It maps the given keyword (<tt>increasedn_title</tt> in this case) to the real output in all available languages. 
  </li>
	<li>
		<b>Put the widget into a list</b>: This means: Every widget has a list as parent. Most widget are located in the main list, which is shown on the main screen. But some tools, like the coordinate functions are part of an own list. All lists order their tools by their (localized) titles. So, this tool can be put into the main list, which can be found in <tt>/widgets/main_view.dart</tt>, around lines 112ff.. Add line (and import):
  
```dart
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/increased.dart';

...

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

## Branching philosophy
<ul>
	<li>Every single upcoming version has its own version branch. E.g. The next version would be 1.42.0, then there's a branch with name <tt>1.42.0</tt>. All features, fixes, etc. should be merged onto this version branch (PR destination branch is the version branch). You can think of it as the current temporary master branch.</li>
	<li>Feature branch: Every single feature needs its own branch. If you want to contribute a new feature "Increased N", please create a branch with a corresponding name (maybe <tt>increased_n</tt>) from the current <b>version branch</b>. If you worked on two different features simultaneously, you would need two different feature branches. This allows me to merge the features separately, maybe one includes some errors but the other one is ready to merge. The final PR's destination branch is the version branch, of course. (If there's just a small bug fix or a typo, it is ok, to do this the pragmatic way without creating a specific branch, but this should be an exception for really small things!)</li>
	<li><tt>master</tt> branch: This branch should always contain the stable code of the current productive version. So, if the current productive version would be 1.41.3, this branch's last commit contains exactly the code for this version. So, when the new, following version 1.42.0 is released, the version branch <tt>1.42.0</tt> will be merged onto the <tt>master</tt>. So, checking out the master should reflect the code of the released app. Any further contributions need to be done on a new version branch (e.g. <tt>1.43.0</tt> for a new feature version or <tt>1.42.1</tt> for a patch version with bug fixes, but without any new features)</li>
</ul>

## Misc, Coding Styles, etc.
<ul>
	<li>Please try to reuse already existing code to avoid code duplication. For example, your new crypto function uses a "Polybios" cipher internally, it is a good idea to reuse the Polybios code (creating the grid and use the encryption/decryption. E.g. have a look at the ADFGVX or Bifid Ciphers). Many functions are included in the code. There's a great chance that something similar to your new function has already been done.
		<ul><li>Other basic crypto functions are "Transposition" (<tt>logic/tools/crypto_end_encodings/transposition.dart</tt>; moves characters or strings from rows to columns and vice versa) and "Substitution" (<tt>logic/tools/crypto_and_encodings/substitution.dart</tt>; very common operation in many ciphers; replaces characters or strings with new characters or strings)</li>
			<li>When it comes to coordinate calculations, the base functions <tt>logic/tools/coords/projection/projection()</tt> for waypoint projection and <tt>logic/tools/coords/distance_and_bearing/distanceBearing()</tt> for calculation of distances and bearings between two coordinates should be useful.
			<li>Maybe you discover new possibilities for centralizing some functions or values, please do not hesitate to encapsulate them to a more common place. Cleanup and refactoring is an important and necessary step in coding. For example, you could use one of the Utils files for such centralization if they fit.
		</ul>
	</li>
	<li>Please avoid using Frontend/UI classes or types in logic or test code. This avoids many nested internal Flutter UI dependencies where there are not necessary. These types usually have the prefix <tt>GCW</tt> and they are located in the <tt>widgets</tt> path. Best way to avoid this, is to write the logic/test code before creating the UI. If you need, for example, the output of a Switch widget (usually of type <tt>GCWSwitchPosition</tt>), do not hesitate to map it to a more common enum type, that can be used easily within the logic or test code.
	</li>
	<li>Please always use spaces around comparators and operators: <tt>var i = a + b</tt></li>
	<li>The Dart coding style uses two spaces as default indent. Please use this, althought it may looks nasty... ;)</li>
	<li>The localisation keywords currently follow their own rules: E.g. let's take <tt>coords_formatconverter_mgrs_easting</tt>: This keywords contains four parts, separated by an underscore. Those can be seen as an hierachy: Topmost the coords section, after that the tool "Format Converter" (here without any separator and without camel case!), afterwards the sub tool "MGRS", which has an "Easting". So, please try to keep such an order when creating a tool. I believe, in more complex cases a separator for parts could make sense. Then please use a dot: <tt>coords_format.converter_mgrs_easting</tt></li>
	<li>Please name all methods and variables in English. All comments have to be in English, as well.</li>
</ul>
