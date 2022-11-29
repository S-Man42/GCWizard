Java Servlet that runs [LUA decompiler](https://github.com/HansWessels/unluac).

Receive a HTTP Multipart request containing a file with LUA bytecode.

Return the decompiled code as plain text.

### Test
`curl -F file=@<path_to_luac_file> <server_url>`
