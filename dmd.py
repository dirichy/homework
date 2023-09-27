import pyperclip
def give_dmd(mode,char,output):
    result="\t"
    result+="\""
    result+=mode
    result+=char
    result+="\":{\n\t\t\"prefix\":\""
    result+=mode
    result+=char
    result+="\",\n\t\t\"body\":[\n\t\t\t\""
    result+=output
    result+="\"\n\t\t]\n\t}"
    return result

mode="bbm"
result=""
for i in range(ord('A'),ord('Z')+1,1):
    result+=give_dmd(mode,chr(i),"\\\\math"+"bbm"+"{"+chr(i)+"}")+",\n"
pyperclip.copy(result)
