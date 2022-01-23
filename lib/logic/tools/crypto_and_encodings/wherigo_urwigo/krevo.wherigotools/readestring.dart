int _find(String palette, String char) {
  for (int i = 0; i < palette.length; i++)
    if (palette[i] == char)
      return i;
  return -1;
}

String WWW_deobf(String str){
  String result = '';
  String rot_palette = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-~";
  int plen = rot_palette.length;
  var magic = { ["\001"] : "B", ["\002"] : "R", ["\003"] : "" };
  int d = 0;
  String x;

  str = str.replaceAll('&lt;', '\004').replaceAll('&gt;', '\005').replaceAll('&amp;', '\006');

  for (int i = 0; i < str.length; i++) {
    String c = str[i];
    int p = _find(rot_palette, c);
    if (p != -1) {
      int jump = (d % 8) + 9;
      p = p - jump;
      if (p < 1)
        p = p + plen;
      c = rot_palette[p];
    }
    else {
      x = magic[c];
      if (x != null)
        c = x;
    }
    d = d + 1;
    //  if (WWB_strings_unicode) then
    //     x = string.byte(c)
    //     if (x and (x >= 128)) then
    //        d = d + 1
    //        if (x >= 2048) then
    //           d = d + 1
    //        end
    //     end
    //  end
    result = result + c;
  }
  result = result.replaceAll('\004', '&lt;').replaceAll('\005', '&gt;').replaceAll('\006', '&amp;');
  return result;
}


/**
 *
 function WWB_deobf (str)

   for i = 1, string.len(str) do
     local c = string.sub(str, i, i)
     local p = string.find(rot_palette, c, 1, true)
     if (p) then
         local jump = (d % 8) + 9
         p = p - jump
         if (p < 1) then
             p = p + plen
         end
         c = string.sub(rot_palette, p, p)
     else
         x = magic[c]
         if (x) then
             c = x
         else
         end
     end
     d = d + 1
     if (WWB_strings_unicode) then
         x = string.byte(c)
         if (x and (x >= 128)) then
             d = d + 1
             if (x >= 2048) then
                 d = d + 1
             end
         end
     end
     result = result .. c
   end
   result = string.gsub(result, "\004", "\038lt;")
   result = string.gsub(result, "\005", "\038gt;")
   result = string.gsub(result, "\006", "\038amp;")
   return result
 end

 */

