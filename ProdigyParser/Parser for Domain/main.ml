let _ =
      try
        let lexbuf = Lexing.from_channel stdin in
        let _ = Parsing.set_trace true in
        let _ = (print_endline "***** Begin parsing..."; flush stdout) in
        let parsedList = DomainParser.main DomainLexer.token lexbuf in
        let _ = (print_endline "***** End parsing."; flush stdout) in
        let parens s = "(" ^ s ^ ")" in 
        let merger (id, args) = id ^ " " ^ (String.concat " " args) in 
        let listHelper (name, precondsList, effectsList) = 
          let precondsList1 = List.map merger precondsList in
          let precondsListFiller = String.concat " " (List.map parens precondsList1) in
          let effectsList1 = List.map merger effectsList in
          let effectsListFiller = String.concat " " (List.map parens effectsList1) in
          let res = "Name: " ^ name ^ " PRECONDS: " ^ precondsListFiller ^ " EFFECTS: " ^ effectsListFiller in

            print_string res; print_newline(); flush stdout
        in
          List.iter listHelper parsedList;
      with DomainLexer.Eof -> print_endline "Exits with EOF exception"; exit 0
