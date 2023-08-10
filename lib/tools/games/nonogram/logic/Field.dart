    import 'dart:core';

class Field {
//     // Struct management
//     int value = 0; //private'
//     int get Index => this.value + 2;
//
//     Field(int value) {
//         this.value = value;
//     }
// }
        // The fields
        final Decoration = Field(-2);    // An empty square with a decoration colour
        Field get Empty => Field(-1);         // A square you are sure it's empty
        Field get Unknown => Field(0);        // A square you don't know anything about
        Field get Black => Field(1);          // A black square
        Field get Red => Field(2);            // A red square

        Set<Field> get All => { Decoration, Empty, Unknown, Black, Red };

        // Logic methods
        bool get  IsOn => this.value > 0;
        bool get IsNotOn => !this.IsOn;
        bool get IsOff => this.value < 0;
        bool get IsNotOff => !this.IsOff;

        // Struct management
         int value = 0; //private'
        int get Index => this.value + 2;

        Field (int value) {
            this.value = value;
        }

        // public override string ToString() {
        //     return this.value.ToString();
        // }

        // bool Equals(Object obj) {
        //     return base.Equals(obj);
        // }
        //
        // public bool Equals(Field other) {
        //     if ((object)other == null)
        //         return false;
        //     return this.value == other.value;
        // }
        //
        // public override int GetHashCode() {
        //     return this.value.GetHashCode();
        // }

        bool operator ==(Field other) => other.value == value;

        @override
        bool operator ==(Field b) => value == b.value;

        @override
        bool operator !=(Field a, Field b) => a.value != b.value;

        @override
        Field Parse(String s) => Field(int.parse(s));
    }
}