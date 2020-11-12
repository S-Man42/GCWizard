
import 'package:tuple/tuple.dart';
// https://github.com/adapap/whitespace-interpreter/blob/master/whitespace_interpreter.py#L1
// from collections import OrderedDict



///Helper class to manage integers in Whitespace.
class WhitespaceInt{

    WhitespaceInt() {}

    ///Converts the Whitespace representation of a number to an integer.
    static int from_whitespace(String code){

        var num = 0;
        if (code.length == 1){
            num = 0;
            return num;
        }
        final List<String> keys = [' ', '\t'];
        var sign = 2 * (1 - keys.indexOf(code[0])) - 1;
        var binary = '';
        for (var x = 1; x < code.length; x++)
            binary += keys.indexOf(code[x]).toString();
        num = int.parse(binary, radix: 2) * sign;
        return num;
    }
}

List<dynamic> stack = List<dynamic>();
List<dynamic> heap = List<dynamic>();
var pos = 0;
var code = '';
var code_length = 0;
var inp = '';
List<String> input;
var output = '';
var loading = true;

var instruction = '';
var command = '';
var labels = Map<String, int>();
var return_positions = List<int>();

void stack_append(dynamic item){
    stack.add(item);
}

dynamic stack_pop(){
    var item = stack.last;
    stack.removeLast();
    return item;
}

///Gets the token for an IMP category.
void get_command(Map<String, String> imp){

    //var pos   = this.pos;
    //var code  = this.code;
    var token = code.substring(pos,pos + 1);
    if (!imp.containsKey(token)){
        token = code.substring(pos,pos + 2);
    }
    // Check if our token is a valid IMP
    if (imp.containsKey(token)){
        command = imp[token];
        pos += token.length;

    } else{
        throw new Exception('KeyError: No IMP found for token: {token}');
        //raise KeyError('No IMP found for token: {token}')
    }
}

///Retrieves the next number in the sequence.
Tuple2<int, int> num_parameter(){
    /*
        Format of a number:
        sign - binary - terminator
        sign: [space] + / [tab] -
        binary: [space] 0 / [tab] 1
        terminator: \n
        */
    //var code = this.code;
    var index = code.indexOf('\n', pos);
    // Only including a terminal causes an error
    if (index == pos){
        throw new Exception('SyntaxError: Number must include more than just the terminal.');
        //raise SyntaxError('Number must include more than just the terminal.');
    }
    var item = WhitespaceInt.from_whitespace(code.substring(pos, index));
    print('num_parameter >>>>>' +  index.toString() +" " + item.toString());
    return Tuple2<int, int>(index, item);
}

///Sets a label in the sequence if possible.
Tuple2<int, String> label_parameter(){
    /*
        Format of a label:
        name - terminator
        *name: any number of [space] and [tab]
        terminator: \n
        *Must be unique.
        */
    //var code  = this.code;
    var index = code.indexOf('\n', pos) + 1;
    // Empty string is a valid label
    var name  = code.substring(pos, index);
    return Tuple2<int, String>(index, name);
}

///Returns a readable string representation of whitespace.
String clean(String s){
    return s.replaceAll(' ', 's').replaceAll('\t', 't').replaceAll('\n', 'n');
}

///The main interpreter for the program handles our state and responds to input.///
class Interpreter{

    /*Instruction Modification Parameters (IMPs)
    [space]: Stack Manipulation
    [tab][space]: Arithmetic
    [tab][tab]: Heap Access
    [tab][line-feed]: Input/Output
    [line-feed]: Flow Control
    */
    final Map<String, String> IMP = {
        ' ': 'Stack',
        '\t ': 'Arithmetic',
        '\t\t': 'Heap',
        '\t\n': 'IO',
        '\n': 'FlowControl'
    };



    Interpreter(String _code, String _inp ){
        code = _code;
        code_length = _code.length;
        inp = _inp;
        input = _inp.split('').toList();
    }

    ///Alias for the size of the stack.
    int stack_size(){
        return stack.length;
    }

    ///Main loop of the program goes through each instruction.
    void run(){
        if (code_length == 0){
            throw new Exception('SyntaxError: Unclean termination of program');
            //raise SyntaxError('Unclean termination of program');
        }
        if (loading){
            print('Code: ' + clean(code));
            print('Input: ' + input.join() );
        }
        while (pos < code_length){
            //var pos   = this.pos;
            //var code  = this.code;
            var token = code.substring(pos, pos + 1);
            if (!IMP.containsKey(token)){
                token = code.substring(pos, pos + 2);
            }
            // Check if our token is a valid IMP
            if (IMP.containsKey(token)){
                instruction = IMP[token];
            } else {
                print(clean(code));
                throw new Exception('Unknown instruction ' + instruction);
                //raise SyntaxError('Unknown instruction ' + instruction);
            }
            if (!loading){
                print('('+ pos.toString() + ') Instruction: '+ instruction + ' - Stack: ' + stack.toString() + ' - Heap: ' + heap.toString());
            }
            pos += token.length;

            switch (instruction) {
                case 'Stack':
                    Stack().parse();
                    break;
                case 'Arithmetic':
                //Arithmetic().parse();
                    break;
                case 'Heap':
                    Heap().parse();
                    break;
                case 'IO':
                    IO().parse();
                    break;
                case 'FlowControl':
                    FlowControl().parse();
                    break;
            };

        }
        if (loading){
            print('Finished marking labels. Starting program sequence...');
            pos = 0;
            loading = false;
            run();
        } else if ((return_positions.length > 0) && (pos != 9999999)) {
            throw new Exception('SyntaxError: Subroutine does not properly exit or return');
            //raise SyntaxError('Subroutine does not properly exit or return');
        } else if (pos == code_length){
            throw new Exception('RuntimeError: Unclean termination');
            //raise RuntimeError('Unclean termination');
            //raise Exception('Unclean termination');
        }
    }
}
///Handles stack manipulation instructions.
class Stack{
    /*Instructions
        [space] (number): Push n onto the stack.
        [tab][space] (number): Duplicate the nth value from the top of the stack.
        [tab][line-feed] (number): Discard the top n values below the top of the stack from the stack.
            (For n<0 or n>=stack.length, remove everything but the top value.)
        [line-feed][space]: Duplicate the top value on the stack.
        [line-feed][tab]: Swap the top two value on the stack.
        [line-feed][line-feed]: Discard the top value on the stack.
        */
    Map<String, String> STACK_IMP = {
        ' ': 'push_num',
        '\t ': 'duplicate_nth',
        '\t\n': 'discard_n',
        '\n ': 'duplicate_top',
        '\n\t': 'swap',
        '\n\n': 'discard_top'
    };

    ///Parses the next stack IMP.
    void parse(){
        //var Stack = this.Stack;
        get_command(STACK_IMP);
        if (command == 'push_num'){
            var parameter = num_parameter();
            var index = parameter.item1;
            var item  = parameter.item2;
            if (!loading){
                print('Command: ' + command + '(' + item.toString() + ')');
                push_num( item);
            }
            pos = index + 1;
        } else if (command == 'duplicate_nth'){
            var parameter = num_parameter();
            var index = parameter.item1;
            var item  = parameter.item2;
            if (!loading){
                print('Command: ' + command + '(' + item.toString() + ')');
                duplicate_nth( item);
            }
            pos = index + 1;
        } else if (command == 'discard_n'){
            var parameter = num_parameter();
            var index = parameter.item1;
            var item  = parameter.item2;
            if (!loading){
                print('Command: ' + command + '(' + item.toString() + ')');
                discard_n( item);
            }
            pos = index + 1;
        } else if (command == 'duplicate_top'){
            if (!loading){
                print('Command: ' + command);
                duplicate_nth( 0);
            }
        } else if (command == 'swap'){
            if (!loading){
                print('Command: ' + command);
                swap();
            }
        } else if (command == 'discard_top'){
            if (!loading){
                print('Command: ' + command);
                discard_top();
            }
        }
    }
    void push_num(item){
        stack_append(item);
    }
    void duplicate_nth(int n){
        if (n > stack.length - 1){
            throw new Exception('ValueError: Cannot duplicate - Value exceeds stack size limit');
            //raise ValueError('Cannot duplicate - Value exceeds stack size limit');
        } else if (n < 0){
            throw new Exception('IndexError: Cannot duplicate negative stack index');
            //raise IndexError('Cannot duplicate negative stack index');
        }
        var item = stack[-n - 1];
        stack_append(item);
    }
    void discard_n(int n){
        if (n >= stack.length || n < 0){
            n = stack.length - 1;
        }
        var top = stack_pop();
        for (var i = 0; i< n; i++){
            stack_pop();
        }
        stack_append(top);
    }
    void discard_top(){
        stack_pop();
    }
    void swap(){
        var a = stack_pop();
        var b = stack_pop();
        stack_append(a);
        stack_append(b);
    }
}

///Handles input/output operations.
class IO{
    /*Instructions
        [space][space]: Pop a value off the stack and output it as a character.
        [space][tab]: Pop a value off the stack and output it as a number.
        [tab][space]: Read a character from input, a, Pop a value off the stack, b, then store the ASCII value of a at heap address b.
        [tab][tab]: Read a number from input, a, Pop a value off the stack, b, then store a at heap address b.
        */
    Map<String, String> IO_IMP = {
        '  ': 'output_char',
        ' \t': 'output_num',
        '\t ': 'input_char',
        '\t\t': 'input_num'
    };

    IO(){}

    ///Parses the next I/O IMP.
    void parse(){
        //var IO = this.IO
        get_command(IO_IMP);
        if (loading){
            return;
        }
        print('\tCommand: ' + command);
        if (command == 'output_char'){
            output_char();
        } else if (command == 'output_num'){
            output_num();
        } else if (command == 'input_char'){
            input_char();
        } else if (command == 'input_num'){
            input_num();
        }
    }
    void output_char(){
        var char = new String.fromCharCode(stack_pop());
        output += char;
        print('>>> {char}');
    }
    void output_num(){
        var num = int.parse(stack_pop());
        output += num.toString();
        print('>>> {num}');
    }
    void input_char(){
        var a = input_pop(0);
        var b = stack_pop();
        heap[b] = a.codeUnits;
    }
    void input_num(){
        var b = stack_pop();
        var index = input.indexOf('\n');
        var num = input.sublist(0, index).join();
        input = input.sublist(index + 1);
        heap[b] = int.parse(num);
    }


    String input_pop(int index){
        var item = input[index];
        input.removeAt(index);
        return item;
    }
}

///Handles flow control operations.
class FlowControl{
    /*Instructions
  [space][space] (label): Mark a location in the program with label n.
    [space][tab] (label): Call a subroutine with the location specified by label n.
    [space][line-feed] (label): Jump unconditionally to the position specified by label n.
    [tab][space] (label): Pop a value off the stack and jump to the label specified by n if the value is zero.
    [tab][tab] (label): Pop a value off the stack and jump to the label specified by n if the value is less than zero.
    [tab][line-feed]: Exit a subroutine and return control to the location from which the subroutine was called.
    [line-feed][line-feed]: Exit the program.
    */
    Map<String, String> FLOW_IMP = {
        '  ': 'mark_label',
        ' \t': 'call_subroutine',
        ' \n': 'jump',
        '\t ': 'jump_zero',
        '\t\t': 'jump_lt_zero',
        '\t\n': 'exit_subroutine',
        '\n\n': 'exit'
    };

    ///Parses the next flow control IMP.
    void parse(){
        //var Flow = FlowControl;
        get_command(FLOW_IMP);
        if (command == 'exit'){
            if (!loading){
                print('\tCommand: ' + command);
                exit();
            }
        } else if (command == 'mark_label'){
            var parameter = label_parameter();
            var index = parameter.item1;
            var label = parameter.item2;
            if (loading){
                print('Command: ' + command + '(' + label.toString() + ')');
                mark_label( label);
            } else{
                print('Ignoring label marker');
            }
            pos = index;
        } else if (command == 'jump'){
            var parameter = label_parameter();
            var index = parameter.item1;
            var label = parameter.item2;
            if (!loading){
                print('Command: ' + command + '(' + label.toString() + ')');
                jump( label);
            } else {
                pos = index;
            }
        } else if (command == 'jump_zero'){
            var parameter = label_parameter();
            var index = parameter.item1;
            var label = parameter.item2;
            if (!loading){
                print('Command: ' + command + '(' + label.toString() + ')');
                var num = stack_pop();
                if (num == 0){
                    jump( label);
                } else {
                    pos = index;
                }
            } else {
                pos = index;
            }
        } else if (command == 'jump_lt_zero'){
            var parameter = label_parameter();
            var index = parameter.item1;
            var label = parameter.item2;
            if (!loading){
                print('Command: ' + command + '(' + label.toString() + ')');
                var num = stack_pop();
                if (num < 0){
                    jump( label);
                } else{
                    pos = index;
                }
            } else {
                pos = index;
            }
        } else if (command == 'exit_subroutine'){
            if (!loading){
                print('Command: ' + command);
                exit_subroutine();
            }

        } else if (command == 'call_subroutine'){
            var parameter = label_parameter();
            var index = parameter.item1;
            var label = parameter.item2;
            pos = index;
            if (!loading){
                print('Command: ' + command + '(' + label.toString() + ')');
                call_subroutine( label);
            }
        }
    }
    void exit(){
        print('Program terminated.');
        pos = 9999999;
    }
    void mark_label(String label){
        if (labels.containsKey(label)){
            throw new Exception('ValueError: Label already exists');
            //raise ValueError('Label already exists');
        }
        labels[label] = pos + label.length;
        print(labels.toString());
    }
    void jump(String label){
        pos = labels[label];
    }
    void exit_subroutine(){
        if (return_positions.length > 0){
            pos = return_positions_pop();
        } else {
            throw new Exception('SyntaxError: Return outside of subroutine');
            //raise SyntaxError('Return outside of subroutine')
        }
    }
    void call_subroutine(String label){
        return_positions_append(pos);
        pos = labels[label];
    }

    void return_positions_append(int item){
        return_positions.add(item);
    }

    int return_positions_pop(){
        var item = return_positions.last;
        return_positions.removeLast();
        return item;
    }

}

///Handles operations on the heap.
class Heap{
    /*
    Instructions
    [space]: Pop a and b, then store a at heap address b.
      [tab]: Pop a and then push the value at heap address a onto the stack.
      */
    Map<String, String> HEAP_IMP = {
        ' ': 'store',
        '\t': 'push'
    };

    ///Parses the next heap IMP.
    void parse(){
        //var Heap = this.Heap;
        get_command(HEAP_IMP);
        if (loading)
            return;
        if (command == 'store') {
            print('Command: ' + command);
            store();
        } else if (command == 'push') {
            print('Command: ' + command);
            push();
        }

    }
    void store(){
        var a = stack_pop();
        var b = stack_pop();
        heap[b] = a;
    }
    void push(){
        var a = stack_pop();
        stack_append(heap[a]);
    }
}

///Removes extranneous characters from the code input.
String uncomment(String s){
    return s.replaceAll(RegExp(r'[^ \t\n]'), '');
}

String whitespace(String code, {String inp = ''}){
    try {
        code = uncomment(code);
        var interpreter = Interpreter(code, inp);
        interpreter.run();
        print('Output: ' + output);
        return output;
    } catch( e) {
        print(output);
        print('Code: ' + clean(code));
        return e.errMsg();

    }
}

String to_whitespace(String s){
    s = s.replaceAll(RegExp(r'[^STNstn]'), '');
    return s.replaceAll('s',' ').replaceAll('t','\t').replaceAll('n','\n');
}
