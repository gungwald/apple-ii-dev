' readtoken
' @return tkn$
if pushbackchar$ <> "" then c$=pushbackchar$:pushbackchar$="":goto testchar
if pushbackchar$ = "" then get c$

testchar:
if c$="(" or c$=")" or c$="," or c$="{" or c$="}" or c$=";" or c$="[" or c$="]" then tkn$=c$:return

