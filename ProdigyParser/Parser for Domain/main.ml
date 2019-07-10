let _ =
      try
        let lexbuf = Lexing.from_channel stdin in
        while true do
          let _ = Parsing.set_trace true in

          let parsedList = DomainParser.main DomainLexer.token lexbuf in
          let _ = print_string "YEET" in
          let parens s = "(" ^ s ^ ")" in 
          let listHelper (name, preconds, effects) = 
            let preconds1 = List.map (String.concat " ") preconds in
            let preconds2 = List.map parens preconds1 in 
            let precondsFinal = parens (String.concat " * " preconds2) in
            let effects1 = List.map (String.concat " ") effects in 
            let effects2 = List.map parens effects1 in 
            let effectsFinal = parens (String.concat " * " effects2) in 
            let res = "Name: " ^ name ^ " PRECONDS: " ^ precondsFinal ^ " EFFECTS: " ^ effectsFinal in

              print_string res; print_newline(); flush stdout
          in
            List.iter print_string parsedList
        done
      with DomainLexer.Eof ->
        exit 0