\insert 'List.oz'

% Task 1

% 1.a
declare Lex
local Input S in
   fun {Lex Input}
      {String.tokens Input & }
   end
end
   
% 1.b
declare Tokenize
local Lexemes in
   fun {Tokenize Lexemes}
      if Lexemes == nil then
	 nil
      else
	 case Lexemes.1 of Token then  
	    case Token  of "+" then
	       operator(type:plus) | {Tokenize Lexemes.2}
	    [] "-" then
	       operator(type:minus) | {Tokenize Lexemes.2}
	    [] "*" then
	       operator(type:multiply) | {Tokenize Lexemes.2}
	    [] "/" then
	       operator(type:divide) | {Tokenize Lexemes.2}
	    [] "p" then % 1d
	       command(print) | {Tokenize Lexemes.2}
	    [] "d" then % 1e
	       command(duplicate) | {Tokenize Lexemes.2}
	    [] "i" then % 1f
	       command(invert) | {Tokenize Lexemes.2}
	    [] "c" then % 1g
	       command(clear) | {Tokenize Lexemes.2}
	    else
	       number({String.toFloat Token}) | {Tokenize Lexemes.2}
	    end
	 else
	    nil
	 end
      end
   end
end

declare DoOperation
local Operation NumberA NumberB in
   fun {DoOperation NumberA Operation NumberB}
      case Operation of plus then
	 number(NumberA + NumberB)
      [] minus then
	 number(NumberA - NumberB)
      [] multiply then
	 number(NumberA * NumberB)
      [] divide then
	 number(NumberA / NumberB)
      end
   end
end

declare CleanStack
local Stack
   fun {CleanStack Stack}
      if Stack == nil then
	 nil
      else	 
	 Stack.1.1 | {CleanStack Stack.2}
      end
   end
end

declare InterStep
local Tokens Stack in
   fun {InterStep Tokens Stack}
      case Tokens of nil then
	 Stack
      [] operator(type:Operator) | Tail then
	 {InterStep  Tokens.2 {DoOperation {Take Stack 2}.2.1.1 Operator {Take Stack 1}.1.1} | {Drop Stack 2}}
      [] command(Cmd) | Tail then
	 case Cmd of print then % 1d
	    {System.showInfo "cmd:print: "}
	    {System.show {CleanStack Stack}}
	    {InterStep Tokens.2 Stack}
	 [] duplicate then % 1e
	    {InterStep Tokens.2 Stack.1 | Stack}
	 [] invert then % 1f
	    {InterStep Tokens.2 {DoOperation Stack.1.1 multiply ~1.0} | Stack.2}
	 [] clear then % 1g
	    {InterStep Tokens.2 nil}
	 end
      else % If not a operator or a command, it must be a number
	 {InterStep Tokens.2 Tokens.1 | Stack}
      end
   end
end

% 1c
declare Interpret
local Tokens Stack in
   fun {Interpret Tokens}
      {CleanStack {InterStep Tokens nil}}
   end
end





{System.showInfo "Task 1"}

{System.showInfo "Task 1a: input: \"1 2 + 3 *\""}
{System.show {Lex "1 2 + 3 *"}}

{System.showInfo "Task 1b: input: {Lex \"1 2 + 3 *\"}"}
{System.show {Tokenize {Lex "1 2 + 3 *"}}}

{System.showInfo "Task 1c: input: {Tokenize {Lex \"1 2 3 +\"}}"}
{System.show {Interpret {Tokenize {Lex "1 2 3 +"}}}}
{System.showInfo "         input: {Tokenize {Lex \"1 2 + 3 *\"}}"}
{System.show {Interpret {Tokenize {Lex "1 2 + 3 *"}}}}

{System.showInfo "Task 1d: running: {Interpret {Tokenize {Lex \"1 2 p 3 +\"}}}"}
{System.show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}}

{System.showInfo "Task 1e: running: {Interpret {Tokenize {Lex \"1 2 3 + d\"}}}"}
{System.show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}

{System.showInfo "Task 1f: running: {Interpret {Tokenize {Lex \"1 2 3 + d i\"}}}"}
{System.show {Interpret {Tokenize {Lex "1 2 3 + d i"}}}}

{System.showInfo "Task 1g: running: {Interpret {Tokenize {Lex \"1 c 2 3 + d i\"}}}"}
{System.show {Interpret {Tokenize {Lex "1 c 2 3 + d i"}}}}


% Task 2

% 2a
declare ExpressionTreeInternal
local Tokens ExpressionStack in
   fun {ExpressionTreeInternal Tokens ExpressionStack}
      case Tokens of nil then
	 ExpressionStack.1
      [] number(N) | Tail then
	 {ExpressionTreeInternal Tokens.2 Tokens.1.1 | ExpressionStack}
      [] operator(type:Operator) | Tail then
	 {ExpressionTreeInternal Tokens.2 Operator({Take ExpressionStack 1}.1 {Take ExpressionStack 2}.2.1) | {Drop ExpressionStack 2}}
      end
   end
end

% 2b
declare ExpressionTree
local Tokens in
   fun {ExpressionTree Tokens}
      {ExpressionTreeInternal Tokens nil}
   end
end

{System.showInfo "Task 2"}

{System.showInfo "Task 2a: input: {Tokenize {Lex \"2 3 + 5 /\"}}"}
{System.show {ExpressionTreeInternal {Tokenize {Lex "2 3 + 5 /"}} nil}}

{System.showInfo "Task 2b: input: {ExpressionTree {Tokenize {Lex \"3 10 9 * - 7 +\"}}}"}
{System.show {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 +"}}}}