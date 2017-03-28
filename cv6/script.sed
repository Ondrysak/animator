s#<h3 class="kurzy_tisk">\(.*\)</h3>#\1#
s#Platnost pro ##
s/Pořadí: /#/p;
s#^<tr><th>země</th><th>\(.*\)</th><th>\(.*\)</th><th>\(.*\)</th><th>\(.*\)</th></tr>$#země|\1|\2|\3|\4#p;
/^<tr><td>Austrálie<\/td><td>dolar<\/td.*>/ s#</tr>#\n#g;
/^<tr><td>Austrálie<\/td>/ s#<tr>##g;
/^<td>Austrálie<\/td>/ s#<\/td>#|#g;
/^<td>Austrálie/ s#<td[^>]*>##g;
s#\n\n$#\n#
/^Austrálie/ s#|\n#\n#gp;


 
