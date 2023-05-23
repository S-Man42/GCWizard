
# start

Start -> Terminal
cd gcw_server
cd GCWServer
dart run

# parameter

input
modeencode
parameter1
parameter2
fromformat
toformat

# syntax

toolname?input=xxx&parameter1=xxx&parameter2=xxx

# example

MultiDecoder?input=Test%20String
Morse?input=Test%20String&modeencode=true
Morse?input=...%20---%20...
Morse?input=test&modeencode=true
alphabetvalues?input=Test
alphabetvalues?input=Test&modeencode=true
alphabetvalues?input=Test12&modeencode=true
alphabetvalues?input=1%202%203%204&modeencode=true
coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&
coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&toformat=coords_utm
coords_formatconverter?input=N48%C2%B023.123%20E9%C2%B012.456&toformat=coords_all
rotate?input=test&parameter1=4
reverse?input=test
