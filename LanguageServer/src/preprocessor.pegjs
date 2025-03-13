Start = e:Expression* {return e.join("");}

Expression
  = CompareChain
  / Infix
  / l:literal+ r:postfix* { return `${l.join(" ").replace(/^ /gm, "").replace(/ +[\n]/gm, "\n")}${r.join("")}`;}
  / l:prefix+ r:Expression { return `${l.join("")}${r}`;}
  / $comment
  / _+ {return ` `;}
  / EOL


//Infixのほうが親
CompareChain
  = chain:(l:Infix* _* c:compare _* {return [l,c]})+ _* i:Infix* {
      console.log(chain);
      console.log(`i:${i}`);
      return `${chain.flat(Infinity).join("")}${i}`
    }

//CompareChainを子に入れる
Infix = l:literal* _* c:infix _* r:Expression* {return `${l.join("")}${c}${r.flat(Infinity).join("")}`;}

Block
  = l:"(" _* c:(BlockExpression*) _* r:")"  _* e:EOL {return `${l}${c.join("")}${r}${e}`;}
  / l:"{" _* c:(BlockExpression*) _* r:"}"  _* e:EOL {return `${l}${c.join("")}${r}${e}`;}
  / l:"[" _* c:(BlockExpression*) _* r:"]"  _* e:EOL {return `${l}${c.join("")}${r}${e}`;}
  / l:"(" _* c:(BlockExpression*) _* r:")"  _* e:Block {return `${l}${c.join("")}${r} ${e}`;}
  / l:"{" _* c:(BlockExpression*) _* r:"}"  _* e:Block {return `${l}${c.join("")}${r} ${e}`;}
  / l:"[" _* c:(BlockExpression*) _* r:"]"  _* e:Block {return `${l}${c.join("")}${r} ${e}`;}
  / l:"(" _* c:(BlockExpression*) _* r:")"  _* e:Expression* {return `${l}${c.join("")}${r}${e.flat(Infinity).join("")}`;}
  / l:"{" _* c:(BlockExpression*) _* r:"}"  _* e:Expression* {return `${l}${c.join("")}${r}${e.flat(Infinity).join("")}`;}
  / l:"[" _* c:(BlockExpression*) _* r:"]"  _* e:Expression* {return `${l}${c.join("")}${r}${e.flat(Infinity).join("")}`;}
  / IndentBlock

BlockExpression
  = CompareChain
  / l:literal* _* c:blockInfix _* r:BlockExpression* {return `${l.join("")}${c}${r.join("")}`;}
  / l:literal+ r:postfix* { return `${l.join(" ").replace(/^ /gm, "").replace(/ +[\n]/gm, "\n")}${r.join("")}`;}
  / l:prefix+ r:BlockExpression { return `${l.join("")}${r}`;}
  / _+ {return ` `;}

IndentBlock = l:BlockStart r:Expression+  { return `${l}${r.join("")}`;}
BlockStart = s:$(EOL tab+)

literal = atom / Block
atom = $(string / letter / bin / oct / hex / number / tag / unit)

number = $("-"? [0-9]+ "."? [0-9]* )
hex = $("0x"([0-9] / [A-F] / [a-f])+)
oct = $("0o"[0-7]+)
bin = $("0b"("0" / "1")+)
tag = $((([A-Z] / [a-z]) / (("_" / [A-Z] / [a-z]) ("_" / [A-Z] / [a-z] / [0-9]))) ("_" / [A-Z] / [a-z] / [0-9])*)
letter = ("\\" .)
comment = $("`" [^\n\r`]*)
string = $("`" [^\n\r`]* "`")
unit = $"_"
key = $(string / letter / tag)

prefix = $(export / import / not / spread)
blockInfix = s:$(infix / spread) {return ` ${s} `;}
infix = s:(be / lambda / pair / or / xor / and / add / sub / mul / div / mod / get / pow) {return ` ${s} `;}
compare = s:$(lt / le / eq / ne / me / mt ) {return ` ${s} `;}
postfix = $(spread / factrial)

logicOr = $(or / xor)
additive = $(add / sub)
multiple = $(mul / div / mod)

export = $"#"
be = $":"
lambda = $"?"
pair = $","
or = $"|"
xor = $";"
and = $"&"
not = $"!"
lt = $"<"
le = $"<="
eq = $("=" / "==")
ne = $("!=" / "><")
me = $">="
mt = $">"
add = $"+"
sub = $"-"
mul = $"*"
div = $"/"
mod = $"%"
pow = $"^"
factrial = $"!"
spread = $"~"
get = $"'"
import = $"@"
tab = $"\t"
EOL = $("\n" / "\r" "\n"?)
_ = $" "
