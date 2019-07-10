let _ =
      try
        let lexbuf = Lexing.from_channel stdin in
        while true do
          let _ = Parsing.set_trace true in
          let (name, states, goals) = LispParserLLTP.main LispLexerLLTP.token lexbuf in
          let parens s = "(" ^ s ^ ")" in 
          let states1 = List.map (String.concat " ") states in
          let states2 = List.map parens states1 in 
          let statesFinal = parens (String.concat " * " states2) in
          let goals1 = List.map (String.concat " ") goals in 
          let goals2 = List.map parens goals1 in 
          let goalsFinal = parens (String.concat " * " goals2) in 
          let res = "fof(" ^ name ^ ", conjecture, " ^ statesFinal ^ " -o " ^ goalsFinal ^ ")" in

            print_string res; print_newline(); flush stdout
        done
      with LispLexerLLTP.Eof ->
        exit 0