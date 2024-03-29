#============================================================================
# UTILITIES
#============================================================================
#
# History:
#
# 11sep97 Set *UI* to nil upon exit by exit_proc. [cox]
#
# 20dec97 Quitting the UI now closes the shell-stream. [cox]
#
#
#============================================================================

# The return-val function is defined in prod-specific.lisp. The lispVar 
# procedure returns the value of the lisp variable named by vname if it 
# exists; otherwise, it returns the string "NIL"
# 
proc lispVar {vname} {
    lisp_send "(return-val $vname)"
    return [lisp_receive]
}

#NOTE that quit-shell used to be called quit-tcl-shell.
proc exit_proc {} {  
    lisp_command \
	    "(progn (setf *ui* nil)(clear-prod-handlers)(quit-shell *alt-stream* (quote *alt-stream*))(quit-shell))"
    puts "exiting Prodigy4.0 UI Version 2.0 now"
    exit
}


proc odd {num} {
    if {[expr %($num / 2)] == 0} {
	return 1
    } else {
	return 0
    }
}


