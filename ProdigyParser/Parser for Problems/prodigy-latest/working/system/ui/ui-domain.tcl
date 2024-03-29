#! /usr/khaigh/tcl/bin/wish -f

# Note that ui-start.tcl is assumed to have been loaded!
# All the globals are in there (so they can be changed in the user's
# customisation file)

# History
#
#

#llopxx======================================================================
#  OPERATOR PARAMS
#============================================================================

proc OperatorParam {name} {

   global oper_struc index oper_msg
   global par_name var_name

   if {[llength [lindex $oper_struc 1]] >= 2} {
       set list [lreplace [lindex $oper_struc 1] 1 1 <$name>]
   } else {
           set list [lindex $oper_struc 1] 
           set list [linsert $list [llength $list] <$name>]
   }
   set oper_struc [lreplace $oper_struc 1 1 $list]
   set oper_msg "The \"$name\" param was added to operator."
   if {$index == 0} {
       set option [dialog .d {User decision} {Would you like to create another parameters ? The\
                   default is "Create"} questhead 0 Create Quit] 
       if {$option == 0} {
           CreateParamFrame
       } else {
                 set list_aux [lreplace [lindex $oper_struc 2] 0 0]
                 set list_aux1 ""
                 foreach args $list_aux {
                         set list_aux1 [linsert $list_aux1 [llength $list_aux1] [lindex $args 0]]
                 }
                 set pos [lsearch -exact $list_aux1 <$par_name>]
                 if {$pos == -1} {
                     set oper_msg "The \"$par_name\" parameter isn't defined yet.\
                          define it as precondition variable."                  
                     set var_name $par_name
                 } else {
                         if {$index > 0} {
                             set index_aux $index
                             while {$index_aux > 0} {
                                    SearchList name$index_aux $list_aux1
                                    incr index_aux -1
                              }
                         }
                 }
                 focus .w.do.pre.v.entryvar
       }
   } else {
           focus .w.do.par.up1.par1.dynamic
   }
}

#llcfpxx======================================================================
#  CREATE PARAM FRAMES
#============================================================================

proc CreateParamFrame {} {

   global basefont  
   global line index TabList
 
   incr index
   if {[winfo exists .w.do.par.up$line.par$index] != 1} {
       if {$index == [expr 4 * $line]} {
           set framepos "w"
           incr line                           
           frame .w.do.par.up$line
           pack  .w.do.par.up$line -anchor w
           label .w.do.par.up$line.space -text "                 "
           pack  .w.do.par.up$line.space -side left
       } else {
               set framepos "center"
       }                   
       frame .w.do.par.up$line.par$index
       pack  .w.do.par.up$line.par$index   -side left -anchor $framepos
       label .w.do.par.up$line.par$index.< -text "<"
       pack  .w.do.par.up$line.par$index.<  -side left -anchor $framepos
       entry .w.do.par.up$line.par$index.dynamic -width 15 -textvariable\
             name$index -font $basefont -relief sunken                  
       pack  .w.do.par.up$line.par$index.dynamic  -side left  -anchor $framepos
       label .w.do.par.up$line.par$index.> -text ">"
       pack  .w.do.par.up$line.par$index.>  -side left -anchor $framepos
       tkwait visibility .w.do.par.up$line.par$index
    }

    set TabList [linsert $TabList [expr $index +1] .w.do.par.up$line.par$index.dynamic]

    focus .w.do.par.up$line.par$index.dynamic
    bind  .w.do.par.up$line.par$index.dynamic <Return> "ReadParOperator name$index"
    bind  .w.do.par.up$line.par$index.dynamic <Tab> {Tab $TabList}
    bind  .w.do.par.up$line.par$index.dynamic <Shift-Tab> {ShiftTab $TabList}
}

#llrpoxx======================================================================
# READ OPERATOR PARAMS
#============================================================================


proc ReadParOperator {name} {
     upvar #0 $name realname

     global   list_par index line
     global  oper_msg oper_struc var_name par_name

     if {$realname == ""} {
         set oper_msg "Enter a valid param name."
         return
     }
     regexp {([0-9]+)} $name num

     set oper_msg "The \"$realname\" param was added to operator."

     set list [lindex $oper_struc 1] 
     set leng_param [llength $list]

     if {[expr $leng_param - $num] >= 2} {
         set list [lreplace $list [expr $num +1] [expr $num +1] <$realname>]
     } else {
              set list [linsert $list [llength $list] <$realname>]
     }
     set oper_struc [lreplace $oper_struc 1 1 $list]   
     if {$num == $index} {
         set option [dialog .d {User decision} {Would you like to create another parameter ? The\
                     default is "Create"} questhead 0 Create Quit] 
         if {$option == 0} {
             CreateParamFrame
         } else {
                 set list_aux [lreplace [lindex $oper_struc 2] 0 0]
                 set list_aux1 ""
                 foreach args $list_aux {
                         set list_aux1 [linsert $list_aux1 [llength $list_aux1] [lindex $args 0]]
                 }
                 set list_par [lreplace [lindex $oper_struc 1] 0 0]
                 foreach args $list_par {
                      set pos [lsearch -exact $list_aux1 $args]
                      if {$pos == -1} {
                          set var [string trimleft $args <]
                          set var [string trimright $var >]
                          set var_name $var
                          set oper_msg "The \"$var\" parameter isn't defined yet.\
                          Define it as precondition variable."
                          break
                      } else {
                              if {[winfo exists .w.do.pre.p1.entrypred] == 1} {
                                  focus .w.do.pre.p1.entrypred
                              }
                      }
                 } 
                 focus .w.do.pre.v.entryvar
         }
     } else {
              if {$num < 3} {
                  focus .w.do.par.up1.par[expr $num +1].dynamic
              } else {
                      if {$num < 7} {
                         focus .w.do.par.up2.par[expr $num +1].dynamic
                      } else {
                              if {$num < 11} {
                                  focus .w.do.par.up3.par[expr $num +1].dynamic
                              } else {
                                      set oper_msg "I can't believe that you need so many params.\
                                          Sorry! The cursor will be stop in this params\
                                          . Use <Tab> to shift to other params"
                              }
                      }
              }

     }
}

#llfosxx=====================================================================
# FILL OUT OPERATOR STRUCTURE
#============================================================================

proc FillOperStruc {operator {position ""} {name_oper ""}} {

     global dom_struc oper_struc
     global oper_name par_name TabList

     if {$position != ""} {
         set oper_struc [lindex $dom_struc $position]
     }
     if {$name_oper != ""} {
         set oper_name $name_oper
         set oper_struc [lreplace $oper_struc 0 0 "operator: $oper_name"]
     } else {
              set oper_name $operator
     }

     set list_param [lindex $oper_struc 1]
     set num_param [expr [llength $list_param] -1]
     set par_name_a [lindex $list_param 1]
     set par_name [string trimleft $par_name_a "<"]
     set par_name [string trimright $par_name ">"]
     for {set i 1} {$i < $num_param} {incr i} {
         CreateParamFrame
         global name$i
         set name [lindex $list_param [expr $i +1]]
         set name [string trimleft $name "<"]
         set name [string trimright $name ">"] 
         set name$i $name

     }
     .w.do.par.up1.par  configure -state normal
     .w.do.pre.v.but    configure -state normal
     .w.do.eff.v.but    configure -state normal
#    .w.do.eff.d.del    configure -state normal
#    .w.do.eff.a.add    configure -state normal
     .w.do.pre.t.simple configure -state normal
     .w.do.pre.t.free   configure -state normal
}

#lltlxx======================================================================
# TAB PROCEDURE
#============================================================================

proc Tab list {

     set i [lsearch -exact $list [focus]]
     incr i
     if {$i >= [llength $list]} {
         set i 0
     }
     focus [lindex $list $i]
}

#llstlxx=====================================================================
# SHIFT TAB PROCEDURE
#============================================================================

proc ShiftTab list {

     set i [lsearch -exact $list [focus]]
     incr i -1
     if {$i < 0} {
         set i [expr [llength $list] -1]
     }
     focus [lindex $list $i]
}

#llusxx======================================================================
# UPDATE LIST BOX OF OPERATORS
#============================================================================

proc update_scroll {name element op} {

   global oper_struc save_oper

   set pos [.w.do.r.scrbar get]
   set pos [lindex $pos 2]
   .w.do.r.lb delete 0 end
   foreach args $oper_struc {
       if {[llength $args] > 1} {
           foreach argsint $args {
                .w.do.r.lb insert end $argsint
           }
       } else {
               .w.do.r.lb insert end $args
       }
   }
   .w.do.r.lb yview $pos
   set save_oper 0
}

#lldodxx======================================================================
# DELETE OPERATOR FROM DOMAIN
#============================================================================

proc DeleteOperatorDomain oper_del {

   global dom_struc select_oper_msg
   global index line TabList oper_name par_name
   global curr_oper
 
   for {set i 3} {$i < [llength $dom_struc]} {incr i} {
        set operator [lindex [lindex [lindex $dom_struc $i] 0] 1] 
        if {$operator == $oper_del} {
            set option [dialog .d {Delete Operator} "The \"$oper_del\" was\
            selected. Are you sure to remove it from domain ?" questhead 0\
            {Yes} {Cancel}]
            if {$option == 0} {
                set dom_struc [lreplace $dom_struc $i $i]
                .dot.up.oper delete 0 end
                for {set i 3} {$i < [llength $dom_struc]} {incr i} {
                     set operator [lindex [lindex [lindex $dom_struc $i] 0] 1] 
                     .dot.up.oper insert end $operator
                }
                set select_oper_msg "The \"$oper_del\" was deleted."

#If the condition bellow is true. The current display is OPERATORS DEFINITION  window of the
#operator that you want to delete then I have to delete all slots and reinitialize the
# variable : index, line, TabList and oper_struc

                if {$oper_name == $oper_del} {
                    if {$index != 0} {
                        while {$index >= 1} {
                               if {[winfo exists .w.do.par.up1.par$index] == 1} {
                                    destroy .w.do.par.up1.par$index
                               }
                               set pos [lsearch -regexp $TabList dynamic]                            
                               if {$pos > 0} {
                               set TabList [lreplace $TabList $pos $pos]
                               }
                               incr index -1
                        }
                        if {$line > 1} {
                            while {$line >= 2} {
                                   destroy .w.do.par.up$line
                                   incr line -1                              
                            }
                        }
                        set index 0
                        set line  1
                    }
                    set oper_struc {{operator:} {params:} {preconds_var:}\
                        {preconds_pred:} {effects_var:} {effects_del:} {effects_add:}}
                    set oper_name ""
                    set par_name  ""
                    .w.do.r.lb delete 0 end
                } else {
                        #It's necessary to update the curr_oper variable, if it's already defined. 
                        if {$oper_name != ""} {
                            set len_dom [expr [llength $dom_struc] - 1]
                            set i 3
                            while {$i <= $len_dom } {
                                   set name [lindex [lindex [lindex $dom_struc $i] 0 ] 1 ]
                                   if {$name == $oper_name} {
                                       set curr_oper $i
                                       break
                                   }
                                   incr i
                            }
                        }
                }
                break
            } else {
                    set select_oper_msg "The delete command was canceled."
                    break
            }
        }
    }
}

#llsoxx======================================================================
# SELECT OPERATOR
#============================================================================

proc SelectOperator {pwind {name_oper ""}} {

   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global dom_struc domain_name

   global line index new_operator
   global select_oper_msg globalname_oper
   
   set globalname_oper $name_oper
   set select_oper_msg "Message Area to User"
  
# This procedure update the "ptype_of" slot of the following:
# dom_struc { {Problem_space: }  {ptype_of: } {pinstance_of: } { {operator: }\
#             {params_op: } {params_pre: } {preconds: }} {effects: {params_eff: }\
#             {ADD: } {DEL: }} }

   if {[winfo exists .dot] == 1} {
       destroy .dot
   }
 
   toplevel .dot
   checkGeometry $pwind
   wm geometry .dot "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .dot "OPERATORS LIST: \"$domain_name\""

   frame .dot.up -bd 1 -relief raised
   pack  .dot.up -side top -fill both

   frame .dot.bot -bd 1 -relief raised
   pack  .dot.bot -side top -fill both 
   
   frame .dot.up.left -relief raised
   pack  .dot.up.left -side left
   label .dot.up.left.bitmap -bitmap info
   pack  .dot.up.left.bitmap -side top -padx 3m -pady 3m
   message .dot.up.left.msg -width 2i -text "\"To DELETE operator, select operator in List and\
            click \"Delete\". To SELECT operator, choose operator and click button-1 twice.\""\
            -font $basefont
   pack    .dot.up.left.msg -side top 
      
   label .dot.up.label -text "Operators List" -relief raised -font $boldfont
   pack  .dot.up.label -side top -fill x

   scrollbar .dot.up.scrbary -relief sunken -command ".dot.up.oper yview"
   scrollbar .dot.up.scrbarx -relief sunken -command ".dot.up.oper xview" -orient horiz

   pack      .dot.up.scrbary  -side right  -fill y
   pack      .dot.up.scrbarx  -side bottom -fill x

   listbox   .dot.up.oper -relief raised -borderwidth 2 -yscrollcommand ".dot.up.scrbary set"\
                          -xscrollcommand ".dot.up.scrbarx set" -font $basefont
   pack      .dot.up.oper -fill both

   button .dot.bot.delete -text "Delete" -relief raised -bd 2 -font $basefont -command { \
          if {[selection own] != ".dot.up.oper"} {
              set select_oper_msg "Incorrect Selection! Select operator from list."
          } else {
                  DeleteOperatorDomain [selection get]
          }}
   
   button .dot.bot.close -text "Close" -relief raised -bd 2 -font $basefont -command { \
          set select_oper_msg "Message Area to User"
          destroy .dot
          }
  
   pack .dot.bot.delete  -side left -expand 1 -fill x
   pack .dot.bot.close  -side left -expand 1 -fill x

   label .dot.msg -textvariable select_oper_msg -width 50 -font $obliquefont -relief raised
   pack  .dot.msg -side top -fill x
   
#==Update listbox
   set test [lindex [lindex [lindex $dom_struc 3] 0] 0]
   if {$test == "operator:"} { 
       for {set i 3} {$i < [llength $dom_struc]} {incr i} {
           set operator [lindex [lindex [lindex $dom_struc $i] 0] 1] 
           .dot.up.oper insert end $operator
       }
   }

   bind .dot.up.oper <Double-Button-1> {
                
# Initialization of variable to show params of the new operator
                ResetStrucOper
                set i 3
                for {} {$i < [llength $dom_struc]} {incr i} {
                        set operator [lindex [lindex [lindex $dom_struc $i] 0] 1]
                        if {$operator == [selection get]} {
                            break
                        }
                }
#******************************
#Ocurred a strange TCL/TK error here, because the Fill procedure doesn't exist but
#the TCL/TK is calling the FillOperStruc procedure and doing what I want
#******************************
#                Fill [selection get] $i
#******************************

                if {$new_operator == -1} {
                    #This mean that the user has been used the mouse to fill out the structure
                    #then it is an old operator
                    set new_operator 0
                }

                set curr_oper $i
                FillOperStruc [selection get] $i $globalname_oper
                destroy .dot
   }
   tkwait visibility .dot
   grab set .dot
}

#llrsxx=====================================================================
# RESET STRUCTURE OF OPERATORS
#============================================================================

proc ResetStrucOper {} {

   global oper_struc index line
   global TabList
   global par_name var_name

   set par_name ""
   set var_name ""

   if {$index > 0} {
       while {$index >= 1} {
              if {[winfo exists .w.do.par.up1.par$index] == 1} {
                  destroy .w.do.par.up1.par$index
              }
              set pos [lsearch -regexp $TabList dynamic]                            
              if {$pos > 0} {
                  set TabList [lreplace $TabList $pos $pos]
              }
              global name$index
              set name$index ""
              incr index -1
       }
       if {$line > 1} {
           while {$line >= 2} {
                  destroy .w.do.par.up$line
                  incr line -1                              
           }
       }
       set index 0
       set line  1
   }
   if {[winfo exist .w.do.pre.t.log] == 1} {
       destroy .w.do.pre.t.log
   }
   ResetArgumentsFrame  total
   ResetEffectsArgumentsFrame
}


#llrnoxx=====================================================================
# README NAME OF OPERATORS
#============================================================================

proc ReadNameOperator {name_oper} {

   global dom_struc oper_struc oper_msg
   global curr_oper oper_name new_operator par_name var_name
   global index line TabList

   #minus 2 because the last element is predicate structure 
   set len_dom [expr [llength $dom_struc] -2]
   set i 3
   while {$i <= $len_dom } {
          set name [lindex [lindex [lindex $dom_struc $i] 0 ] 1 ]
          if {$name == $name_oper} {
              set option [dialog .d {Question} "The \"$name_oper\" operator already exists\
                         in the domain. Would you like to make changes ?" questhead 0 YES NO]

              if {$option == 0} {
                  set new_operator 0
                  set curr_oper $i
                  ResetStrucOper
                  FillOperStruc $name_oper $curr_oper
                  set oper_struc [lindex $dom_struc $curr_oper]
                  focus .w.do.par.up1.parnames
                  set oper_msg "Do your changes in \"$name_oper\" operator."
                  return
              } else {
                      set oper_msg "Changes in \"$name_oper\" was canceled."
                      ResetStrucOper
                      set oper_name ""
                      return
              }
          }
          incr i
    }
    set new_operator 1
    if {[llength $dom_struc] > 4} {
        set option [dialog .d {User Decision} "This is a new operator. Would you like to build it\
                               based on previous one ?" questhead 0 No Yes]
    } else {
            set option 0
    }
    switch $option  {
    
              0 {
                  ResetStrucOper
                  .w.do.r.lb delete 0 end
                  set oper_struc {{operator:} {params:} {preconds_var:}\
                  {preconds_pred:} {effects_var:} {effects_del:} {effects_add:}}
                  set oper_struc [lreplace $oper_struc 0 0 "operator: $name_oper"]
                  set oper_msg "This is a new operator."
                }
   
              1 {
                  SelectOperator .w $name_oper
                  set oper_msg "This structure was based in selected operator."       
                }
    }

    set curr_oper $i
    .w.do.par.up1.par  configure -state normal
    .w.do.pre.v.but    configure -state normal
    .w.do.eff.v.but    configure -state normal
#   .w.do.eff.d.del    configure -state normal
#   .w.do.eff.a.add    configure -state normal
    .w.do.pre.t.simple configure -state normal
    .w.do.pre.t.free   configure -state normal

    focus .w.do.par.up1.parnames
}

#llftix======================================================================
# FIND ITEM TYPE
#============================================================================

proc FindItemType pos_item {

    global pos_predvar pos_param pos_pred
    global pos_effvar pos_effdel pos_effadd

    #get the number of listbox elements 
    set final [lindex [.w.do.r.scrbar get] 0]
    set list ""
    for {set i 0} {$i <= $final} {incr i} {
           set list [linsert $list [llength $list] [.w.do.r.lb get $i]]
    }

    set pos_param    [lsearch -exact $list params:]
    set pos_predvar  [lsearch -exact $list preconds_var:]
    set pos_pred     [lsearch -exact $list preconds_pred:]
    set pos_effvar   [lsearch -exact $list effects_var:]
    set pos_effdel   [lsearch -exact $list effects_del:]
    set pos_effadd   [lsearch -exact $list effects_add:]

    if {$pos_item > $pos_effadd} {
        return 5 
    }
    if {$pos_item > $pos_effdel} {
         return 4
    } 
    if {$pos_item > $pos_effvar} {
        return 3
    }
    if {$pos_item > $pos_pred} {
        return 2
    }
    if {$pos_item > $pos_predvar} {
        return 1
    }
    if {$pos_item > $pos_param} {
        return 0
    }
}

#lllbox======================================================================
# LIST BOX OPERATORS
#============================================================================

proc ListBoxOperator {item} {

     global oper_struc 
     global oper_msg change_position
     global var_name desc_name pred_name
     global eff_var_name eff_desc_name
     global more_than_one
     global simple_type

     if {($item == "operator:") || ($item == "params:") || ($item == "preconds_var:") ||\
         ($item == "preconds_pred:")  || ($item == "effects_var:") || ($item == "effects_del:") ||\
         ($item == "effects_add:") || ($item == "And") || ($item == "Or") } {
         set oper_msg "Wrong selection. It isn't allowed to handle this object."
         return
     }
     set pos_item [.w.do.r.lb curselection]
     if {$pos_item == 1} {
         set oper_msg "You can modify operator name directly in the appropriate field."
         focus .w.do.par.top.opname
         return
     }

     set type [FindItemType $pos_item]

     switch $type {
            0  {HandleParam .w}
            1  { 
                set change_position $pos_item
                set var_a [lindex [lindex $item 0] 0]
                set var_a [string trimright $var_a >]
                set var_a [string trimleft  $var_a <]
                set var_name $var_a
                set desc_name [lindex [lindex $item 0] 1]
                if {[llength $desc_name] > 1} {
                    set simple_type 0
                } else {
                         set simple_type 1
                }
                set oper_msg "You can do changes in the \"$var_a\" variable."
                focus .w.do.pre.v.entryvar
               }

            2  {
                MouseSelection $pos_item $item 3
               }

            3  { 
                set change_position $pos_item
                set var_a [lindex [lindex $item 0] 0]
                set var_a [string trimright $var_a >]
                set var_a [string trimleft  $var_a <]
                set eff_var_name $var_a
                set eff_desc_name [lindex [lindex $item 0] 1]
                if {[llength $eff_desc_name] > 1} {
                    set simple_type 0
                } else {
                         set simple_type 1
                }
                set oper_msg "You can do changes in the \"$var_a\" variable."
                focus .w.do.eff.v.entryvar
               }

            4  { 
                 MouseSelection $pos_item $item 5
               }

            5  {
                 MouseSelection $pos_item $item 6
               }        
    }
}

#llmsxx======================================================================
# MOUSE SELECTION
#============================================================================

proc MouseSelection {pos_item item type} {

   global pred_name add_pred_name del_pred_name
   global oper_struc
   global more_than_one_aux more_than_one
   global pos_pred pos_effvar
   global pos_effdel pos_effadd
   switch $type {
      
        3 {
            set pred_name [lindex [lindex $item 0] 0]
            ResetArgumentsFrame
            if {[winfo exists .w.do.pre.p1] != 1} {
                set type [lindex [lindex $oper_struc 3] 1]
                if {($type == "And") || ($type == "Or")} {
                         CreateConjDisjFrame $type
                } else {
                        dialog .d {Software Error} "Couldn't find the type of logic operator\
                                   in preconditions expressions" error 0 Ok
                        return
                }
            }
            ChangePrecondsPred $pos_item ""
            set list [lindex $oper_struc 3]
            #take out the "preconds_pred" title
            set list [lreplace $list 0 0]
            set more_than_one 0
            #Test which ocurrence of the predicate will be changed
            for {set i [expr $pos_pred +1]} {$i < $pos_effvar} {incr i} {
                 if {$pred_name == [lindex [.w.do.r.lb get $i] 0]} {
                     incr more_than_one
                     if {$i == $pos_item} {
                         break
                     }
                 }
            }
           }
  
         5 {
            set del_pred_name [lindex [lindex $item 0] 0]
            ResetEffectsArgumentsFrame 5
            if {[winfo exists .w.do.eff.d1] != 1} {
                HandleDeleteEffects
                CreateEffectsArgFrame $del_pred_name 5
            }
            ChangeEffectsPred $pos_item "" $del_pred_name 5
            set list [lindex $oper_struc 5]
            #take out the "effects_del" title
            set list [lreplace $list 0 0]
            set more_than_one_aux 0
            #Test which ocurrence of the predicate will be changed
            for {set i [expr $pos_effdel +1]} {$i < $pos_effadd} {incr i} {
                 if {$del_pred_name == [lindex [.w.do.r.lb get $i] 0]} {
                     incr more_than_one_aux
                     if {$i == $pos_item} {
                         break
                     }
                 }
            }
           }
  
         6 {
            set add_pred_name [lindex [lindex $item 0] 0]
            ResetEffectsArgumentsFrame 6
            if {[winfo exists .w.do.eff.a1] != 1} {
                HandleAddEffects
                CreateEffectsArgFrame $add_pred_name 6
            }
            ChangeEffectsPred $pos_item "" $add_pred_name 6
            set list [lindex $oper_struc 6]
            #take out the "effects_add" title
            set list [lreplace $list 0 0]
            set more_than_one_aux 0
            #Test which ocurrence of the predicate will be changed
            set final [lindex [.w.do.r.scrbar get] 0]
            for {set i [expr $pos_effadd +1]} {$i < $final} {incr i} {
                 if {$add_pred_name == [lindex [.w.do.r.lb get $i] 0]} {
                     incr more_than_one_aux
                     if {$i == $pos_item} {
                         break
                     }
                 }
            }
           }
   }
}



#llhnvx======================================================================
# HANDLE NEW PREDICATE VARIABLE
#============================================================================

proc HandleNewPredicateVariable {} {

     global oper_struc simple_type
     global var_name par_name oper_msg

     if {$var_name == ""} {
         if {$par_name != ""} {
             set list_aux [lreplace [lindex $oper_struc 2] 0 0]
             set list_aux1 ""
             foreach args $list_aux {
                     set list_aux1 [linsert $list_aux1 [llength $list_aux1] [lindex $args 0]]
             }
             set list_par [lreplace [lindex $oper_struc 1] 0 0]
             foreach args $list_par {
                  set pos [lsearch -exact $list_aux1 $args]
                  #Test if the param was defined, if not define it.
                  if {$pos == -1} {
                      set var [string trimleft $args <]
                      set var [string trimright $var >]
                      set var_name $var
                      set oper_msg "The \"$var\" param isn't defined yet.\
                      Define it as precondition variable."
                      focus .w.do.pre.v.entrydes
                      return
                  } 
             } 
             if {[winfo exists .w.do.pre.p1.entrypred] == 1} {
                 focus .w.do.pre.p1.entrypred
             }
         } else {
                 if {[winfo exists .w.do.pre.p1.entrypred] == 1} {
                     focus .w.do.pre.p1.entrypred
                 }
         }
     } else {
        set option [dialog .d {User Decision} "Define the type of the variable.\
                 The default is \"Simple Type\"." questhead 0 "Simple Type" "Constraint\
                 Type"]
        if {$option == 0} {
            set oper_msg "The \"Simple Type\" was choosed. I will check out the descriptor."
            set simple_type 1
        } else {
             set oper_msg "The \"Constraint Type\" was choosed. I won't check out the\
                       descriptor. The syntax and semantic are your responsability."
             set simple_type 0
        }
        focus .w.do.pre.v.entrydes
     }
}
#llhcvx======================================================================
# HANDLE CHANGES IN THE PREDICATE VARIABLE
#============================================================================

proc HandleChangesPredicateVariable {} {

   global change_position
   global var_name par_name oper_msg
   global oper_struc simple_type

   set option [dialog .d {User Decision} "Define the type of the variable.\
               The default is \"Simple Type\"." questhead 0 "Simple Type" "Constraint\
               Type"]
   if {$option == 0} {
       set oper_msg "The \"Simple Type\" was choosed. I will check out the descriptor."
       set simple_type 1
   } else {
           set oper_msg "The \"Constraint Type\" was choosed. I won't check out the\
                      descriptor. The syntax and semantic are your responsability."
           set simple_type 0
   }
   if {$change_position == -1} {
       set oper_msg "Warning. Ocurred one error in sequence of operations, I couldn't\
                     do changes in the predicate variable."
       set var_name ""
       set desc_name ""
       focus .w.do.pre.v.entryvar
       return
   }
   focus .w.do.pre.v.entrydes
}
 
#llhnpd======================================================================
# HANDLE NEW PREDICATE VARIABLE DESCRIPTOR
#============================================================================
  
proc HandleNewPredicateVariableDescriptor {} {

   global oper_struc simple_type
   global var_name desc_name oper_msg par_name

   if {$desc_name == ""} {
          set oper_msg "Enter a valid descriptor to variable \"$var_name\"."
      } else {
              if {$var_name != ""} {
                  if {$simple_type == 1} {
                      set var_spec "<$var_name> $desc_name"
                  } else {
                      set var_spec "<$var_name> \{$desc_name\}"
                  }
                  set list1 [lindex $oper_struc 2]
                  set list1 [linsert $list1 [llength $list1] $var_spec]
                  set oper_struc [lreplace $oper_struc 2 2 $list1]
                 
                  if {$par_name != ""} {
                      set list_aux [lreplace [lindex $oper_struc 2] 0 0]
                      set list_aux1 ""
                      foreach args $list_aux {
                           set list_aux1 [linsert $list_aux1 [llength $list_aux1] [lindex $args 0]]
                      }
                      set list_par [lreplace [lindex $oper_struc 1] 0 0]
                      set flag 0
                      foreach args $list_par {
                           set pos [lsearch -exact $list_aux1 $args]
                           if {$pos == -1} {
                               set var [string trimleft $args <]
                               set var [string trimright $var >]
                               set var_name $var
                               set desc_name ""
                               set oper_msg "The \"$var\" param isn't defined yet.\
                               Define it as precondition variable."
                               focus .w.do.pre.v.entryvar
                               return
                           } 
                           set flag 1
                      }
                      if {$flag == 1} {
                          set var_name ""
                          set desc_name ""
                          focus .w.do.pre.v.entryvar
                      }
                  
                  } else {
                      set var_name ""
                      set desc_name ""
                      focus .w.do.pre.v.entryvar
                  }
             } else {
                     set oper_msg "First, you have to define variable name."
             }
      }
}

#llhcdv======================================================================
# HANDLE CHANGES IN PREDICATE VARIABLE DESCRIPTOR
#============================================================================

proc HandleChangesPredicateVariableDescriptor {} {
   
   global oper_struc simple_type
   global desc_name var_name
   global change_position pos_predvar

   if {$desc_name == ""} {
        set oper_msg "Enter a valid descriptor to variable \"$var_name\"."
   } else {
           if {$var_name != ""} {
                if {$simple_type == 1} {
                    set var_spec "<$var_name> $desc_name"
                } else {
                        set var_spec "<$var_name> \{$desc_name\}"
                }
                set list1 [lindex $oper_struc 2]
                set pos [expr $change_position - $pos_predvar]
                set list1 [lreplace $list1 $pos $pos $var_spec]
                set oper_struc [lreplace $oper_struc 2 2 $list1]
                set oper_msg "Changes in \"$var_name\" variable was executed."
                set desc_name ""
                set var_name ""
                set change_position -1
                focus .w.do.pre.v.entryvar
          } else {
                  set oper_msg "First, you have to define variable name."
          }
    }
}

#lldoxx======================================================================
# DELETE OPERATORS OBJECTS
#============================================================================

proc DeleteOperatorObject {item pos_item} {

   global oper_msg
   global pos_predvar pos_param pos_pre
   global pos_effvar pos_effdel pos_effadd

   foreach args $item {
        if {($args == "operator:") || ($args == "params:") || ($args == "preconds_var:") ||\
        ($args == "preconds_pred:")  || ($args == "effects_var:") || ($args == "effects_del:") ||\
        ($args == "effects_add:") || ($args == "And") || ($args == "Or") } {
            set oper_msg "That selection isn't allowed. There is a reserved object selected."
            return
        }
   }
   set pos [lindex $pos_item 0]
   set type [FindItemType $pos]    
   switch $type {
       0  {DeleteOperItem $item "" 1}
       1  {DeleteOperItem $item "" 2}
       2  {DeleteOperItem $item "" 3}
       3  {DeleteOperItem $item "" 4}
       4  {DeleteOperItem $item "" 5}
       5  {DeleteOperItem $item "" 6}
   } 
}   

#llmvoo======================================================================
# MOVE OPERATORS OBJECTS
#============================================================================

proc MoveCopyOperatorObject {item pos_item operation} {

   global oper_msg
   global pos_predvar pos_param pos_pred
   global pos_effvar pos_effdel pos_effadd

   if {[llength $item] > 1} {
       set oper_msg "You selected more than one item. Only the first will be\
                     handled."
       set item [lindex $item 0]
       set pos_item [lindex $pos_item]
       .w.do.r.lb select from $pos_item
   }

  if {($item == "operator:") || ($item == "params:") || ($item == "preconds_var:") ||\
       ($item == "preconds_pred:")  || ($item == "effects_var:") || ($item == "effects_del:") ||\
       ($item == "effects_add:") || ($item == "And") || ($item == "Or") } {
          set oper_msg "That selection isn't allowed. There is a reserved object selected."
            return
   }
   set oper_msg ""
   set type [FindItemType $pos_item]    
   set t_op {copy move}
   set t_object {"a parameter" "a precondition variable" " a precondition" "an effect variable"\
                 "an add effect" "an delete effect"} 
   
   set option [dialog .d {User Decision} "The selected item is [lindex $t_object $type].\
              Select a new position and click on \"Ok\" to complete the [lindex $t_op $operation]\
              operation." info 0 Ok Cancel]
   if {$option == 1} {
       return
   } 
puts "posicao antiga $pos_item"
   set new_pos [.w.do.r.lb curselection]
   set sel_obj [.w.do.r.lb get $new_pos]

   switch $type {
       0  { #is parameter            
            if {($new_pos >= $pos_param) && ($new_pos < $pos_predvar)} {
                set pos_sel [expr $new_pos -$pos_param] 
                set pos [expr $pos_item -$pos_param] 
                ExecMoveCopy 1 $item $pos $pos_sel $operation 
            } else {
                    dialog .d {Error} "Wrong selection! It is out of parameter range." info 0 Ok
                    return
            }
          }

       1  { #is precondition variable
            if {(($new_pos >= $pos_predvar) && ($new_pos < $pos_pred))} {
                set pos_sel [expr $new_pos -$pos_predvar] 
                set pos [expr $pos_item -$pos_predvar] 
                ExecMoveCopy 2 $item $pos $pos_sel $operation          
            } else {
                    dialog .d {Error} "Wrong selection! It is out of variable range." info 0 Ok
                    return
            }
          }        

       2  {  #is precondition
            if {(($new_pos >= [expr $pos_pred +1]) && ($new_pos < $pos_effvar))} {
                set aux [expr $pos_pred +1]
                set pos_sel [expr $new_pos -$pos_pred] 
                set pos [expr $pos_item -$pos_pred] 
                ExecMoveCopy 3 $item $pos $pos_sel $operation                         
            } else {
                    dialog .d {Error} "Wrong selection! It is out of precondition range." info 0 Ok
                    return
            }
          }

      3  {  #is effects variable
            if {(($new_pos >= $pos_effvar)  && ($new_pos < $pos_effdel))} {
                set pos_sel [expr $new_pos -$pos_effvar] 
                set pos [expr $pos_item -$pos_effvar] 
                ExecMoveCopy 4 $item $pos $pos_sel $operation                          
            } else {
                    dialog .d {Error} "Wrong selection! It is out of variable range." info 0 Ok
                    return
            }
          }

       4  {  #is delete effect
            
            if {(($new_pos >= $pos_effdel) && ($new_pos < $pos_effadd))} {
                 set pos_sel [expr $new_pos -$pos_effdel] 
                 set pos [expr $pos_item -$pos_effdel] 
                 ExecMoveCopy 5 $item $pos $pos_sel $operation                        
            } else {
                    dialog .d {Error} "Wrong selection! It is out of precondition range." info 0 Ok
                    return
            
            }
          }
      

       5  {  #is add effect
            if {($new_pos >= $pos_effadd)} {
                 set pos_sel [expr $new_pos -$pos_effadd] 
                 set pos [expr $pos_item -$pos_effadd] 
                 ExecMoveCopy 6 $item $pos $pos_sel $operation                          
            } else {
                    dialog .d {Error} "Wrong selection! It is out of precondition range." info 0 Ok
                    return
            }
          }
   }
}  

   
#llemcx======================================================================
# Execute Move and Copy operator item
#============================================================================

proc ExecMoveCopy {type item pos pos_sel operation} {

   global oper_struc

   set list [lindex $oper_struc $type]
   if {$pos == $pos_sel} {
       return
   }
   if {$operation == 0} {  ;# Copy operation
       set list [linsert $list [expr $pos_sel +1] [lindex $item 0]]
   } else {
           set list [linsert $list [expr $pos_sel +1] [lindex $item 0]]
           if {$pos > $pos_sel} {
               incr pos
           }              
           set list [lreplace $list $pos $pos]
   }
   set oper_struc [lreplace $oper_struc $type $type $list] 
}      

   
#llsplx======================================================================
# Show Predicate List
#============================================================================
                
proc ShowPredicateList {pwind type} {

   global pred_struc
   global basefont boldfont
   global xgeometry ygeometry
   global gtype pred_index aux_index

   set gtype $type
   #type can be : pred or add or del

   global pred_name del_pred_name add_pred_name

   if {[winfo exists .spl] == 1} {
       set xybdomain [wm geometry .spl]
       destroy .spl
   }

   toplevel .spl
   checkGeometry $pwind
   wm geometry .spl "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .spl "PREDICATE LIST"
   
   frame .spl.w -bd 1 -relief sunken
   pack  .spl.w

   frame .spl.w.top -bd 1 -relief sunken
   pack  .spl.w.top -side top

   frame .spl.w.top.msg -relief raised
   pack  .spl.w.top.msg -side left

   label .spl.w.top.msg.bitmap -bitmap info
   pack  .spl.w.top.msg.bitmap -side top -padx 3m -pady 3m
   message .spl.w.top.msg.text -width 3i -text "Click left button twice to transfer the selected\
           predicate to appropriate entry point in the Operators Definition Window." -font $basefont
    
   pack .spl.w.top.msg.text

   label .spl.w.top.label -text "Predicate List" -relief raised -font $boldfont
   pack  .spl.w.top.label -side top -fill x
 
   listbox   .spl.w.top.lb -relief raised -borderwidth 2 -yscrollcommand ".spl.w.top.scrbary set"\
             -xscrollcommand ".spl.w.top.scrbarx set" -font $basefont -geometry 40x15 

   scrollbar .spl.w.top.scrbary -relief sunken -command ".spl.w.top.lb yview"
   scrollbar .spl.w.top.scrbarx -relief sunken -command ".spl.w.top.lb xview" -orient horiz

   pack      .spl.w.top.scrbary -side right -fill y
   pack      .spl.w.top.scrbarx -side bottom -fill x
   pack      .spl.w.top.lb -expand 1

   button .spl.w.close -text "Close" -relief raised -bd 2 -font $basefont\
          -command {
                    destroy .spl
                   }
   pack   .spl.w.close -side left -fill x -expand 1

   foreach args $pred_struc {
        .spl.w.top.lb insert end $args
        }

   bind .spl.w.top.lb <Double-Button-1> {
               set pos [.spl.w.top.lb curselection]
               set pred [lindex $pred_struc $pos]
               switch $gtype {
                   pred {
                           set pred_name [lindex $pred 0]
                           if {$pred_index > 0} {
                               ResetArgumentsFrame
                           }
                         }
                   del  { 
                           set del_pred_name [lindex $pred 0]
                           if {$aux_index > 0} {
                               ResetEffectsArgumentsFrame 5
                           }
                          }
                   add   { 
                           set add_pred_name [lindex $pred 0]
                           if {$aux_index > 0} {
                               ResetEffectsArgumentsFrame 6
                           }
                         }
               }
               destroy .spl
   } 
   tkwait visibility .spl
   grab set .spl
}

#llhpxx======================================================================
# HANDLE PREDICATES
#============================================================================

proc HandlePredicate {} {

   global pred_struc oper_struc
   global pred_name pred_index
   global changes_preconds more_than_one
   global save_oper

   if {$pred_name == ""} {
       focus .w.do.pre.p1.entrypred
       return
   }
   set exist 0
   set position -1
   set num -1
   foreach args $pred_struc {
       incr position
       if {$pred_name == [lindex $args 0]} {
           set num [expr [llength $args] -1]
           set exist 1
           break
       }
   } 
   if {$exist == 0} {
       set option [dialog .d {Context Error} "The \"$pred_name\" predicate doesn't exist in\
                   the domain. Would you like to define it ?" info 0 Yes No]
       if {$option == 0} {
           DefinePredicates .w $pred_name 
           return
       } else {
               return
       }
   }
 
   focus .w.do.pre.p1.entrypred
   set changes_preconds 0
   set list [lindex $oper_struc 3]
   #take out the "preconds_pred" title
   set list [lreplace $list 0 0]
   set more_than_one 0
   foreach args $list {
         if {$pred_name == [lindex $args 0]} {
             set options "You can choice the following options:\n\n\
                               CHANGE   - Allow you to make changes in the predicate;\n\n\
                               CONTINUE - Search for a next ocurrence of the predicate;\n\n\
                               INSERT   - Allow you to insert other predicate;\n\n\
                               CANCEL   - Close the window and cancel the command.\n"
             incr more_than_one 
             if {$more_than_one > 1} {
                 if {$more_than_one == 2} {
                     set mess "This is the $more_than_one-nd ocurrence of the \"$pred_name\". $options"
                 } else {
                         set mess "This is the $more_than_one-th ocurrence of the \"$pred_name\". $options"
                 }
             } else {
                     set mess "The \"$pred_name\" predicate already exists. $options"
             }         
             set option [dialog .d {User Decision} "$mess" questhead 0 Change Continue Insert Cancel]
             switch $option {
                 0 {
                     set changes_preconds 1
                     break
                   }
                 1 {
                     set changes_preconds 2
                   }
                 2 {
                     set changes_preconds 0
                     set more_than_one 0
                     foreach args $list {
                           if {$pred_name == [lindex $args 0]} {
                               incr more_than_one
                           }
                     }
                     incr more_than_one
                     break
                   }
                 3 {
                     set changes_preconds 2
                     set oper_msg "The command was canceled."
                      break
                   }
             } 
         }
   }
   if {$more_than_one == 0} {
       set more_than_one 1
   }
   set save_oper 0
   switch $changes_preconds {
        0 {NewPrecondsPred $num}
        1 {ChangePrecondsPred "" $more_than_one}
        2 { 
            if {$pred_index >= 1} {
                ResetArgumentsFrame
            }
            set pred_name ""
          }        
   }
}
#llcppx======================================================================
# CHANGE PRECONDITIONS OF PREDICATES
#============================================================================

proc ChangePrecondsPred { {position ""} {pred ""} } {

   global oper_msg pred_name
   global oper_struc pcd_list

   set oper_msg "This predicate already exists in the operator. You can make changes."
 
   set pcd_list $pred_name
   set list [lindex $oper_struc 3]
   #take out the "preconds_pred" title
   set list [lreplace $list 0 0]
   #this is called with return
   if {$pred != ""} {
       set next 0
       foreach args $list {
             if {$pred_name == [lindex $args 0]} {
                 incr next
                 if {$next == $pred} {
                     set num [expr [llength $args] -1]
                     ResetArgumentsFrame
                     for {set i 1} {$i <= $num} {incr i} {
                          CreateArgumentsFrame 
                          global parg$i
                          set var [lindex $args $i]
                          set var1 [string trim $var <>]
                          set parg$i $var1
                          set pcd_list [linsert $pcd_list [llength $pcd_list] $var]
                     }
                     return
                  }
              }
       }
   }
   #This is called with mouse
   if {$position != ""} {
       set pred [.w.do.r.lb get $position]
       set num [expr [llength $pred] -1]
       ResetArgumentsFrame
       for {set i 1} {$i <= $num} {incr i} {
            CreateArgumentsFrame 
            global parg$i
            set var [lindex $pred $i]
            set var1 [string trim $var <>]
            set parg$i $var1
            set pcd_list [linsert $pcd_list [llength $pcd_list] $var]
       }
   }
}

#llnppx======================================================================
# NEW PRECONDITIONS OF PREDICATES
#============================================================================

proc NewPrecondsPred {num} {

   global oper_msg pred_name
   global pcd_list oper_struc

   set oper_msg "This is a new predicate to operator"
  
   ResetArgumentsFrame

   set pcd_list $pred_name
   if {$num == 0} {
       set list [lindex $oper_struc 3]
       set list [linsert $list [llength $list] $pcd_list]
       set oper_struc [lreplace $oper_struc 3 3 $list]
       set pcd_list ""
       set pred_name ""
   } else {
           while {$num >= 1} {
              #to predicate arguments
              set pcd_list [linsert $pcd_list [llength $pcd_list] ""]
              CreateArgumentsFrame
              incr num -1
           }
           set list [lindex $oper_struc 3]
           set list [linsert $list [llength $list] $pcd_list]
           set oper_struc [lreplace $oper_struc 3 3 $list]
           focus .w.do.pre.p1.1.dynarg
   }
}

#llcafx======================================================================
# READ PREDICATE ARGUMENTS
#============================================================================

proc ReadPredArguments name {

     upvar #0 $name realarg
     global pred_name pred_index
     global pcd_list oper_struc dom_struc
     global changes_preconds TabList
     global more_than_one
     global save_oper

     set save_oper 0  
     if {$realarg == ""} {
         set oper_msg "Enter a valid argument name."
         return
     }
     set exists 0
     set list [lindex $oper_struc 2]
     for {set i 1} {$i < [llength $list]} {incr i} {
          if {"<$realarg>" == [lindex [lindex $list $i] 0]} {
              set exists 1
              break
          }
     }
     set instance 0
     if {$exists == 0} {
         set instance_list [lreplace [lindex $dom_struc 2] 0 0]
         foreach args $instance_list {
                 if {$realarg == [lindex $args 0]} {
                     set instance 1
                     break
                 }
         }
         if {$instance == 0} {
             set option [dialog .d {Warning} "The \"$realarg\" argument wasn't defined as\
                         variable or as instance of object. If it will be defined later\
                         and you want to enter now, press Yes" info 0 OK Yes]
             if {$option == 0} {
                 return
             } else {
                      set instance 1
             }
         }
     }
     regexp {([0-9]+)} $name num
   
     if {$instance == 0} {
         set pcd_list [lreplace $pcd_list $num $num <$realarg>]
     } else {
             set pcd_list [lreplace $pcd_list $num $num $realarg]
     }
     
     set list [lindex $oper_struc 3]
     set next 0
     for {set i 1} {$i < [llength $list]} {incr i} {
          if {$pred_name == [lindex [lindex $list $i] 0]} {
              incr next
              if {$more_than_one == $next} {
                  set list [lreplace $list $i $i $pcd_list]
                  break
              }
          }
     }
     set oper_struc [lreplace $oper_struc 3 3 $list]

     if {$num == $pred_index} {
         ResetArgumentsFrame
         set pred_name ""
         focus .w.do.pre.p1.entrypred
     } else {
              set i [lsearch -exact $TabList [focus]]
              incr i
              focus [lindex $TabList $i]
     }
}

#llcafx======================================================================
# RESET ARGUMENTS FRAME
#============================================================================

proc ResetArgumentsFrame { {total ""} } {

   global pred_index pred_line
   global TabList

   if {[winfo exists .w.do.pre.p1.tit.desc] == 1} {
       destroy .w.do.pre.p1.tit.desc
   }
   while {$pred_line >= 2} {
          destroy .w.do.pre.p$pred_line
          incr pred_line -1
   }
   if {$pred_index >= 1} {
       for {set i $pred_index} {$i > 0} {incr i -1} {
            if {[winfo exists .w.do.pre.p1.$i] == 1} {
                destroy .w.do.pre.p1.$i
            }
       }
       while {$pred_index >= 1} {
              set pos [lsearch -regexp $TabList dynarg]                            
              if {$pos > 0} {
                  set TabList [lreplace $TabList $pos $pos]
              }
              global parg$pred_index
              set parg$pred_index ""
              incr pred_index -1
       }
       set pred_line 1
       set pred_index 0
   }
   if {[winfo exists .w.do.pre.p1.entrypred] == 1} {
       focus .w.do.pre.p1.entrypred
   }
   if {$total != ""} {
       if {[winfo exists .w.do.pre.p1] == 1} {
           destroy .w.do.pre.p1
       }
   }
}

#llcafx======================================================================
# CREATE ARGUMENTS FRAME
#============================================================================

proc CreateArgumentsFrame {} {

   global basefont boldfont
   global pred_index pred_line
   global TabList

   incr pred_index

   if {[winfo exists .w.do.pre.p1.tit.desc] != 1} {
       label .w.do.pre.p1.tit.desc -text "        Predicate Variable List" -font $boldfont 
       pack  .w.do.pre.p1.tit.desc -side right
   }
   if {[winfo exists .w.do.pre.p$pred_line.$pred_index] != 1} {
       if {$pred_index == [expr [expr 3 * $pred_line] +1]} {
           set framepos "w"
           incr pred_line                           
           frame .w.do.pre.p$pred_line
           pack  .w.do.pre.p$pred_line -anchor w
           label .w.do.pre.p$pred_line.space -text " "
           pack  .w.do.pre.p$pred_line.space -side left -padx 3.05c
       } else {
               set framepos "center"
       }                 

       frame .w.do.pre.p$pred_line.$pred_index
       pack  .w.do.pre.p$pred_line.$pred_index   -side left -anchor $framepos
   
       label .w.do.pre.p$pred_line.$pred_index.< -text "<"
       pack  .w.do.pre.p$pred_line.$pred_index.< -side left
   
       entry .w.do.pre.p$pred_line.$pred_index.dynarg -width 15 -textvariable\
            parg$pred_index -font $basefont -relief sunken                  
       pack  .w.do.pre.p$pred_line.$pred_index.dynarg  -side left  -anchor $framepos

       label .w.do.pre.p$pred_line.$pred_index.> -text ">"
       pack  .w.do.pre.p$pred_line.$pred_index.> -side left

       tkwait visibility .w.do.pre.p$pred_line.$pred_index
    }

    set TabList [linsert $TabList [llength $TabList] .w.do.pre.p$pred_line.$pred_index.dynarg]

    focus .w.do.pre.p$pred_line.$pred_index.dynarg
    bind  .w.do.pre.p$pred_line.$pred_index.dynarg <Return> "ReadPredArguments parg$pred_index"
    bind  .w.do.pre.p$pred_line.$pred_index.dynarg <Tab> {Tab $TabList}
    bind  .w.do.pre.p$pred_line.$pred_index.dynarg <Shift-Tab> {ShiftTab $TabList}
}

#lldspe======================================================================
# CREATE CONJUNCTIVE FRAME
#============================================================================

proc CreateConjDisjFrame type {
  
   global boldfont basefont
   global TabList pred_line
   global oper_struc

   for {set i 2} {$i <= 5} {incr i} {
        if {[winfo exists .w.do.pre.b$i] == 1} {
            destroy .w.do.pre.b$i
        }
   }
   frame .w.do.pre.p1
   pack  .w.do.pre.p1 -side top -anchor w  

   frame .w.do.pre.p1.tit
   pack  .w.do.pre.p1.tit -anchor w

   label .w.do.pre.p1.tit.space -text "                    "
   pack  .w.do.pre.p1.tit.space -side left
   label .w.do.pre.p1.tit.var -text "Predicate-name    " -font $boldfont
   pack  .w.do.pre.p1.tit.var -side left
      
   button .w.do.pre.p1.pred -text "Predicate" -relief raised -bd 2 -font $basefont\
          -command {
                     ShowPredicateList .w pred
                   }
   pack   .w.do.pre.p1.pred -side left -ipadx 5
   label  .w.do.pre.p1.space -text "  "
   pack   .w.do.pre.p1.space -side left
   entry  .w.do.pre.p1.entrypred -width 15 -textvariable pred_name -font $basefont\
          -relief sunken
   pack  .w.do.pre.p1.entrypred -side left

   if {[winfo exists .w.do.pre.b] != 1} {
       frame .w.do.pre.b
       pack  .w.do.pre.b -side bottom
       label .w.do.pre.b.space -text ""
       pack  .w.do.pre.b.space
   }

   set TabList [linsert $TabList [llength $TabList] ".w.do.pre.p1.entrypred"]
   bind .w.do.pre.p1.entrypred <Tab> {Tab $TabList}
   bind .w.do.pre.p1.entrypred <Shift-Tab> {Tab $TabList}

   if {$type == "And"} {
       button .w.do.pre.t.log -text AND -relief raised -bd 2 -font $basefont -command\
          {
           .w.do.pre.t.simple configure -state normal
           .w.do.pre.t.free   configure -state normal
           destroy .w.do.pre.t.log
           destroy .w.do.pre.p1
           while {$pred_line >= 2} {
                  destroy .w.do.pre.p$pred_line
                  incr pred_line -1
           }
       }
       pack .w.do.pre.t.log -ipadx 8
   } else {
           button .w.do.pre.t.log -text OR -relief raised -bd 2 -font $basefont -command\
                {
                  .w.do.pre.t.simple configure -state normal
                  .w.do.pre.t.free   configure -state normal
                  destroy .w.do.pre.t.log
                  destroy .w.do.pre.p1
                  while {$pred_line >= 2} {
                         destroy .w.do.pre.p$pred_line
                         incr pred_line -1
                  }
                }
           pack .w.do.pre.t.log -ipadx 10
   }

   .w.do.pre.t.simple configure -state disabled
   .w.do.pre.t.free   configure -state disabled

   focus .w.do.pre.p1.entrypred 
   bind .w.do.pre.p1.entrypred <Return> {
            HandlePredicate          
   }
}


#lldspe======================================================================
# DEFINE SIMPLE PRECONDITION EXPRESSION
#============================================================================

proc DefineSimplePreExpression {} {

   global opr_msg oper_struc

   set option [dialog .d {User Decision} "Would you like to create conjunctive\
               or disjunctives preconditions?\n The default is conjunctive."\
               questhead 0 And Or]
   if {$option == 0} {
       set opr_msg "The conjunctive preconditions was choosed."
       set pre [lindex $oper_struc 3]
       set logic [lindex $pre 1]
       if {$logic != "And"} {
           if {$logic == "Or"} {
               set pre [lreplace $pre 1 1]       
           }
           set pre [linsert $pre 1 And]
           set oper_struc [lreplace $oper_struc 3 3 $pre]
       }
       CreateConjDisjFrame And
   } else {
           set pre [lindex $oper_struc 3]
           set logic [lindex $pre 1]
           if {$logic != "Or"} {
               if {$logic == "And"} {
                   set pre [lreplace $pre 1 1]
               }
               set pre [linsert $pre 1 Or]
               set oper_struc [lreplace $oper_struc 3 3 $pre]
           }
           CreateConjDisjFrame Or
           set opr_msg "The disjunctive preconditions was choosed."
   }
}

#lldoxx======================================================================
# DEFINE OPERATORS
#============================================================================

proc DefineOperators {pwind} {

   global world_path domain_name olddomain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global dom_struc
   global file_name space_name 

#These global variable are defined in this procedure

   global oper_msg oper_struc save_oper
   global oper_name index again list_par
   global nframe line TabList
   global new_operator 
   global change_position
   global pred_index pred_line aux_index aux_line

# The operator slot of the structure below will be updated during this procedure\
#. The reserved slots of whole structure are:
# are:
# dom_struc { {Problem_space: } {ptype_of: } {pinstance_of: } { {operator: }\
#             {params: } {preconds_var: } {preconds_pred: } {effects_var:} {effects_del: }\
#             {effects_add:} } 
#           }

   set TabList {.w.do.par.top.opname .w.do.par.up1.parnames .w.do.pre.v.entryvar}

#Modifiquei para criar dinamico
#                .w.do.pre.p.entrypred .w.do.eff.v.entryvar  .w.do.eff.d.entrypred 
#                .w.do.eff.a.entrypred


   if {[winfo exists .w] == 1} {
       set xybdomain [wm geometry .w]
       destroy .w
   }

   toplevel .w
   checkGeometry $pwind
   wm geometry .w "+[expr $xgeometry-200]+[expr $ygeometry+25]"
   wm title .w "OPERATORS DEFINITION : \"$domain_name\""

   frame .w.do
   pack  .w.do -side top -expand 1 -fill both

   frame .w.menu -bd 1 -relief raised
   pack  .w.menu -side bottom -fill x 
 
   frame .w.do.r -bd 1 -relief raised 
   pack  .w.do.r -side right -expand 1 -fill both


   listbox   .w.do.r.lb -relief raised -borderwidth 2 -yscrollcommand ".w.do.r.scrbar set"\
             -xscrollcommand ".w.do.r.scrbarx set" -font $basefont
# -geometry 35x15

   scrollbar .w.do.r.scrbar -relief sunken -command ".w.do.r.lb yview"
   scrollbar .w.do.r.scrbarx -relief sunken -command ".w.do.r.lb xview" -orient horiz

   pack      .w.do.r.scrbar -side right -fill y
   pack      .w.do.r.scrbarx -side bottom -fill x
   pack      .w.do.r.lb -expand 1 -fill both

   frame .w.do.par -bd 1 -relief raised
   pack  .w.do.par -side top -anchor w -fill both

   frame .w.do.par.top 
   pack  .w.do.par.top -side top -fill both -anchor w

   button .w.do.par.top.op -text "Operator"  -relief raised -bd 2 -font $basefont\
                -command {SelectOperator .w}
   label .w.do.par.top.sp -text "  "
   entry  .w.do.par.top.opname -textvariable oper_name -width 40 -relief sunken\
                 -font $basefont
   pack  .w.do.par.top.op -side left -ipadx 7
   pack  .w.do.par.top.sp -side left
   pack  .w.do.par.top.opname -side left 

   frame .w.do.par.up1 -bd 1
   pack  .w.do.par.up1 -side top -fill both -anchor w
  
   button .w.do.par.up1.par -text "Params" -relief raised -bd 2 -font $basefont\
                -command { HandleParam .w}
   pack  .w.do.par.up1.par -side left -ipadx 11

   label .w.do.par.up1.< -text "<"
   pack  .w.do.par.up1.< -side left

   entry .w.do.par.up1.parnames -width 15 -textvariable par_name -font $basefont -relief sunken
   pack  .w.do.par.up1.parnames -side left -anchor w
 
   label .w.do.par.up1.> -text ">"
   pack  .w.do.par.up1.> -side left -fill x

   frame .w.do.pre -bd 1 -relief sunken
   pack  .w.do.pre -anchor w -fill both
  
   label .w.do.pre.title -text "Preconds:" -font $boldfont 
   pack  .w.do.pre.title -anchor w

#Variable Frame  
   frame .w.do.pre.tit
   pack  .w.do.pre.tit -anchor w

   label .w.do.pre.tit.space -text "                    "
   pack  .w.do.pre.tit.space -side left
   label .w.do.pre.tit.var -text "Variable name          " -font $boldfont
   pack  .w.do.pre.tit.var -side left
   label .w.do.pre.tit.desc -text "        Descriptor" -font $boldfont 
   pack  .w.do.pre.tit.desc -side right
 
   frame .w.do.pre.v
   pack  .w.do.pre.v -side top -anchor w
 
   button .w.do.pre.v.but -text "Variable" -relief raised -bd 2 -font $basefont\
           -command {puts "not implemented yet"}
   pack  .w.do.pre.v.but -side left -ipadx 8
   label .w.do.pre.v.< -text "<"
   pack  .w.do.pre.v.< -side left

   entry .w.do.pre.v.entryvar -width 15 -textvariable var_name -font $basefont\
           -relief sunken
   pack  .w.do.pre.v.entryvar -side left -fill x
  
   label .w.do.pre.v.> -text ">"
   pack  .w.do.pre.v.> -side left
 
   entry .w.do.pre.v.entrydes -width 61 -textvariable desc_name -font $basefont\
         -relief sunken
   pack  .w.do.pre.v.entrydes -side left -fill x

#Predicate Frame
#  frame .w.do.pre.b1
#  pack  .w.do.pre.b1 -side top
#  label .w.do.pre.b1.space -text ""
#  pack  .w.do.pre.b1.space

   frame .w.do.pre.t
   pack  .w.do.pre.t -side top -anchor w -pady 20

   label .w.do.pre.t.expr -text "Precondition Expression:" -font $boldfont
   pack  .w.do.pre.t.expr -side left
   button .w.do.pre.t.simple -text And/Or -relief raised -bd 2 -font $basefont\
          -command {
                     DefineSimplePreExpression
                   }
   pack  .w.do.pre.t.simple -side left -ipadx 5 -padx 10
   button .w.do.pre.t.free -text Free -relief raised -bd 2 -font $basefont\
          -command {
                     set oper_msg "Not implemented yet."
                   }
   pack  .w.do.pre.t.free -side left -ipadx 14 -padx 10
 
   .w.do.pre.t.simple configure -state disabled
   .w.do.pre.t.free   configure -state disabled

   for {set i 2} {$i <= 5} {incr i} {
        frame .w.do.pre.b$i
        pack  .w.do.pre.b$i -side top
        label .w.do.pre.b$i.space -text ""
        pack  .w.do.pre.b$i.space
   }
  
# Effects Frames

   frame .w.do.eff -bd 1 -relief sunken
   pack  .w.do.eff -side top -fill both

   label .w.do.eff.title -text "Effects:" -font $boldfont 
   pack  .w.do.eff.title -anchor nw

#Variable Frame  
  
   frame .w.do.eff.tit
   pack  .w.do.eff.tit -anchor w 

   label .w.do.eff.tit.space -text "                    "
   pack  .w.do.eff.tit.space -side left
   label .w.do.eff.tit.var -text "Variable name         " -font $boldfont
   pack  .w.do.eff.tit.var -side left
   label .w.do.eff.tit.desc -text "        Descriptor" -font $boldfont 
   pack  .w.do.eff.tit.desc -side right
 
   frame .w.do.eff.v 
   pack  .w.do.eff.v -side top -anchor w
 
   button .w.do.eff.v.but -text "Variable" -relief raised -bd 2 -font $basefont\
           -command {puts "not implemented yet"}
   pack  .w.do.eff.v.but -side left -ipadx 10
   label .w.do.eff.v.< -text "<"
   pack  .w.do.eff.v.< -side left
   entry .w.do.eff.v.entryvar -width 15 -textvariable eff_var_name -font $basefont\
           -relief sunken
   pack  .w.do.eff.v.entryvar -side left -fill x
  
   label .w.do.eff.v.> -text ">"
   pack  .w.do.eff.v.> -side left
   entry .w.do.eff.v.entrydes -width 60 -textvariable eff_desc_name -font $basefont\
         -relief sunken
   pack  .w.do.eff.v.entrydes -side left -fill x

   frame .w.do.eff.but 
   pack  .w.do.eff.but -side top -pady 20 -anchor w

   label .w.do.eff.but.tit -text "Effects List:" -font $boldfont
   pack  .w.do.eff.but.tit -side left

   button .w.do.eff.but.add -text Add -relief raised -bd 2 -font $basefont -command\
            {
              if {[winfo exists .w.do.eff.a1] != 1} {
                  HandleAddEffects
              }
            }
   pack   .w.do.eff.but.add -side left -ipadx 30 -padx 10
  
   button .w.do.eff.but.del -text Delete -relief raised -bd 2 -font $basefont -command\
            {
              if {[winfo exists .w.do.eff.d1] != 1} {
                  HandleDeleteEffects
              }
            }
   pack   .w.do.eff.but.del -side left -ipadx 24 -padx 10
   
   button .w.do.eff.but.cond -text Conditional -relief raised -bd 2 -font $basefont -command\
            {
              HandleConditionalEffects 
            }
   pack   .w.do.eff.but.cond -side left -ipadx 20 -padx 10
  
   for {set i 1} {$i <= 4} {incr i} {
        frame .w.do.eff.b$i
        pack  .w.do.eff.b$i -side top
        label .w.do.eff.b$i.space -text ""
        pack  .w.do.eff.b$i.space
   }

   set oper_msg "First, type the operator name or click the Operator button to select operator."

   frame .w.menu.bot -bd 1 -relief raised
   pack  .w.menu.bot -side top -expand 1 -fill x

   frame .w.menu.bot.but -bd 1 -relief raised
   pack  .w.menu.bot.but -side top -expand 1 -fill x
   label .w.menu.bot.msg  -textvariable oper_msg  -bd 1 -relief sunken -font $obliquefont
   pack  .w.menu.bot.msg -side top -fill x -expand 1
   
   #This is the initial value of this variable. In normal conditional this value must be igual
   #0 or 1, otherwise there is an logic error in the program. 
   set new_operator -1

   button .w.menu.bot.but.save -text "Save" -relief raised -bd 2 -font $basefont\
        -command {
                    if {$oper_name != ""} {
                       
                        switch $new_operator {
                             0 { 
                                 set dom_struc [lreplace $dom_struc $curr_oper $curr_oper $oper_struc]
                                 set oper_msg "The domain was saved."
                               }
                         
                             1 { 
                                 set pos [expr [llength $dom_struc] -1]
                                 set dom_struc [linsert $dom_struc $pos $oper_struc]
                                 set new_operator 0
                                 set oper_msg "The domain was saved."
                               }

                       default {
                                 dialog .d {Program Error} "Ocurred one logic error in program. Please\
                                            reported this error to a responsible person.\n\n\
                                            Error message : \"unbounded new_operator\"" error 0 Ok
                                            
                               }
                        }
                    } else {
                            set oper_msg "Sorry! I couldn't save, it's missing operator name."
                    }
                    set save_oper 1
                    SaveDomStruc
                 }
   pack   .w.menu.bot.but.save -side left -fill x -expand 1

   button .w.menu.bot.but.copy -text Copy -relief raised -bd 2 -font $basefont\
          -command {
                     if {[selection own] != ".w.do.r.lb"} {
                         set oper_msg "Incorrect Selection. To move any object of operator, first\
                                      select object in the list."
                     } else {
                             MoveCopyOperatorObject [selection get] [.w.do.r.lb curselection] 0
                     }
                   }
   pack   .w.menu.bot.but.copy -side left -fill x -expand 1
  
   button .w.menu.bot.but.move -text Move -relief raised -bd 2 -font $basefont\
          -command {
                     if {[selection own] != ".w.do.r.lb"} {
                         set oper_msg "Incorrect Selection. To move any object of operator, first\
                                      select object in the list."
                     } else {
                             MoveCopyOperatorObject [selection get] [.w.do.r.lb curselection] 1
                     }
                   }
   pack   .w.menu.bot.but.move -side left -fill x -expand 1
   
   button .w.menu.bot.but.delete -text "Delete" -relief raised -bd 2 -font $basefont\
          -command {
                     if {[selection own] != ".w.do.r.lb"} {
                         set oper_msg "Incorrect Selection. To delete any object of operator, first\
                                      select object in the list."
                     } else {
                             DeleteOperatorObject [selection get] [.w.do.r.lb curselection]
                     }
                   }

   pack   .w.menu.bot.but.delete -side left -fill x -expand 1

   button .w.menu.bot.but.close -text "Close" -relief raised -bd 2 -font $basefont\
          -command {
                     if {$save_oper == 0} {
                         set option [dialog .d {Save Domain} {The domain has been modified since\
                                     your last savings. Do you like to save last changes ?}\
                                     questhead 0 {Yes} {No}]
                         if {$option == 0} {
                              if {$oper_name != ""} {
                                  if {$new_operator == 0} {
                                      set dom_struc [lreplace $dom_struc $curr_oper $curr_oper\
                                                     $oper_struc]
                                  } else { 
                                           set pos [expr [llength $dom_struc] -1]
                                           set dom_struc [linsert $dom_struc $pos $oper_struc]
                                           set new_operator 0
                                  }
                                  set oper_msg "The domain was saved."
                              } else {
                                      set oper_msg "Sorry! I couldn't save, it's missing operator\
                                                    name."
                              }
                              SaveDomStruc
                         }
                      }
                      set oper_struc {{operator:} {params:} {preconds_var:}\
                          {preconds_pred:} {effects_var:} {effects_del:} {effects_add:}}
                     set oper_name ""
                     set par_name ""
                     set desc_name ""
                     set pred_name ""
                     set predvar_name ""
                     set eff_var_name ""
                     set eff_desc_name ""
                     set del_pred_name ""
                     set del_predvar_name ""
                     set add_pred_name    ""
                     set add_predvar_name ""
                     for {set i 1} {$i <= $index} {incr i} {
                          global name$i
                          set name$i ""
                     }
                     destroy .w}
   pack   .w.menu.bot.but.close -side left -fill x -expand 1
  
   focus .w.do.par.top.opname

# Start of the actions

   set oper_struc { {operator:} {params:} {preconds_var:} {preconds_pred:}\
                                 {effects_var:} {effects_del:} {effects_add:} }

   trace variable oper_struc w update_scroll
   set save_oper 1

   if {[lindex [lindex [lindex $dom_struc 3] 0] 1] != ""} {
       .w.do.par.up1.par configure -state normal
   }

   bind .w.do.par.top.opname <Return> {
        if {$oper_name == ""} {
           set oper_msg "Enter a valid Operator name."

        } else {
                ReadNameOperator $oper_name
        }
        set save_oper 0
   }
   #These variable are used to create parameters frame dynamically
   set index 0
   set line 1

   #These variable are used to create predicate arguments frame dynamically
   set pred_index 0
   set pred_line 1

   #These variable are used to create argumens to effects predicates
   set aux_index 0
   set aux_line 1

   bind .w.do.par.up1.parnames <Return> {
        if {$par_name != ""} {
            OperatorParam $par_name
        } else {
                focus .w.do.pre.v.entryvar
        }
        set save_oper 0
   }
         
   bind .w.do.pre.v.entryvar <Return> {
        if {$desc_name == ""} {
            HandleNewPredicateVariable
        } else {
                HandleChangesPredicateVariable
        }
        set save_oper 0
   }

   set change_position -1
   bind .w.do.pre.v.entrydes <Return> { 
         if {$change_position == -1} { 
             HandleNewPredicateVariableDescriptor
         } else {
                 HandleChangesPredicateVariableDescriptor
        }
   }

###The code that follow is related with Effects - Variable and descriptor
       
   bind .w.do.eff.v.entryvar <Return> {
        if {$eff_desc_name == ""} {
            HandleNewEffectsVariable
        } else {
                HandleChangesEffectsVariable
        }
        set save_oper 0
   }

   bind .w.do.eff.v.entrydes <Return> {
        if {$change_position == -1} {
            HandleNewEffectsVariableDescriptor
        } else {
                HandleChangesEffectsVariableDescriptor
        }
        set save_oper 0
   }

##### BIND TAB

   foreach w $TabList {
       bind $w <Tab> {Tab $TabList} 
   } 

##### BIND SHIFT-TAB

   foreach w $TabList {
       bind $w <Shift-Tab> {ShiftTab $TabList} 
   }

##### BIND LISTBOX OF OPERATOR

   bind .w.do.r.lb <Double-Button-1> {
        ListBoxOperator [selection get]
        }
   .w.do.par.up1.par  configure -state disabled
   .w.do.pre.v.but    configure -state disabled
   .w.do.eff.v.but    configure -state disabled
#  .w.do.eff.d.del    configure -state disabled
#  .w.do.eff.a.add    configure -state disabled
   grab set .w

}



#*********************************************************************************
#The procedures bellow are related with the Definition of Predicates
#
#*********************************************************************************

#llcpsx======================================================================
# CHANGE IN PARAM STRUCTURE
#============================================================================

proc ChangeParamStruc {position} {

   global pred_struc pred_list pred_id
   global boldfont is_changes 
   global position_change_pred_struc

   #This command is necessary when this procedure is called by double-button-1 
   set position_change_pred_struc $position
   set is_changes 1
   set pred_list [lindex $pred_struc $position]
   set pnum [llength $pred_list]
   set pred_id [lindex $pred_list 0]
   for {set i 1} {$i < $pnum} {incr i} {
        if {$i == 1} {
            #The .dp.w.mid frame was create in DefinePredicates procedures
            if {[winfo exist .dp.w.mid.title.desc] != 1} {
                label .dp.w.mid.title.desc -text "          Argument Type List" -font $boldfont 
                pack  .dp.w.mid.title.desc -side left 
            }
        }
        CreatePredParam
        global pname$i
        set pname$i [lindex $pred_list $i]
   }
}

#lldpxx======================================================================
# DELETE PREDICATES
#============================================================================

proc DeletePredicate object {

   global pred_struc save_pred

   set numobj [llength $object]
   set object_aux $object
   set delete_all 0
   foreach args $object {
        if { $delete_all == 0 } {
             set option [dialog .d {Confirm Predicate Deletion} "The selectioned predicate -\
             \"$object_aux\" will be deleted. Are you sure to remove them from the list?" questhead 0\
               {Yes for all} {Yes} {Cancel}]
        }
        if {$option == 0} { 
            set delete_all 1
            set pos [lsearch -exact $pred_struc $args]
            if {$pos == -1} {
                dialog .d {Context error} "The \"$args\" predicate doesn't exist in list." error 0 Ok
                return 
            } else {
                    set pred_struc [lreplace $pred_struc $pos $pos]
                    .dp.w.top.lb delete $pos
            }
            set save_pred 0
        }
        if {$option == 1} {
            set pos [lsearch -exact $pred_struc $args]
            if {$pos == -1} {
                dialog .d {Context error} "The \"$args\" predicate doesn't exist in list." error 0 Ok
                return 
            } else {
                    set pred_struc [lreplace $pred_struc $pos $pos]
                    .dp.w.top.lb delete $pos
            }
            set save_pred 0
        }
        if {$option == 2} {
            return
        }
   }
}

#lldpxx======================================================================
# DELETE PREDICATES
#============================================================================

proc DeletePredicateTypeParam {type pos} {
   upvar #0 $type realtype 
   global pred_struc
   global pred_id pred_msg

   set option [dialog .d {Confirm Predicate Param Deletion} "The predicate param -\
             \"$realtype \" will be deleted. Are you sure to remove them from the list?" questhead 0\
               Yes No]
   if {$option == 1} {
       set pred_msg "The command delete was canceled."
       return
   }
   set position -1
   foreach args $pred_struc  {
        incr position
        if {$pred_id == [lindex $args 0]} {
            break
        }
   }
   set pred_list [lindex $pred_struc $position]
   set pred_list [lreplace $pred_list $pos $pos]
   set pred_struc [lreplace $pred_struc $position $position $pred_list]
   ResetParamStruc
   .dp.w.top.lb delete $position
   .dp.w.top.lb insert $position $pred_list
   ChangeParamStruc $position
}

#lldpxx======================================================================
# DEFINE PREDICATES
#============================================================================

proc DefinePredicates {pwind {newpred ""}} {

   global world_path domain_name olddomain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global dom_struc pred_struc
   global TabListParam
   global save_pred  

#These global variable are defined in this procedure
   global pred_struc pred_list pred_id
   global position_change_pred_struc is_changes
   global pindex pline oldfocus

   set oldfocus [focus] 
   set save_pred 1
   set pred_list  ""
   set TabListParam {.dp.w.mid.par1.entry}

   if {[winfo exists .dp] == 1} {
       set xybdomain [wm geometry .dp]
       destroy .dp
   }

   toplevel .dp
   checkGeometry $pwind
   wm geometry .dp "+[expr $xgeometry-50]+[expr $ygeometry+25]"
   wm title .dp "PREDICATES DEFINITION : \"$domain_name\""
   
   frame .dp.w -bd 1 -relief sunken
   pack  .dp.w

   frame .dp.w.top -bd 1 -relief sunken
   pack  .dp.w.top -side top

   frame .dp.w.top.msg -relief raised
   pack  .dp.w.top.msg -side left

   label .dp.w.top.msg.bitmap -bitmap info
   pack  .dp.w.top.msg.bitmap -side top -padx 3m -pady 3m
   message .dp.w.top.msg.text -width 4.7i -text "\
      TO CREATE a new predicate:\n\
         -- enter the Predicate Name,\n\
         -- press return,\n\
         -- answer to the number of arguments,\n\
         -- enter the type of each argument.\n\n\

      TO EDIT a predicate, select the predicate from the Predicate List\
      by clicking twice the left button.\n\n\

      You can:\n\
         -- change the predicate name, change the argument types, and\n\
            add new or delete current arguments.\n\n\

      TO CHANGE the predicate name or the argument names:\n\
    	 -- position the cursor on the corresponding field, type the new name,\n\
            and press return.\n\n\

      TO ADD a new argument:\n\
         -- position the cursor on the last argument, press enter,\n\
            and answer the menu.\n\n\

      The DELETE button applies to any field that is highlighted, i.e.\n\
      a field that was selected by clicking the left button on it.\n\
      Therefore,\n\
         -- to delete a predicate, select it from the Predicate List;\n\
         -- to delete an argument, select it from the Argument Type List.\n" -font $basefont
   pack .dp.w.top.msg.text
      

   frame .dp.w.mid -bd 1 -relief raised
   pack  .dp.w.mid -anchor w -fill x -expand 1 -pady 5
 
   label .dp.w.top.label -text "Predicate List" -relief raised -font $boldfont
   pack  .dp.w.top.label -side top -fill x
 
   listbox   .dp.w.top.lb -relief raised -borderwidth 2 -yscrollcommand ".dp.w.top.scrbary set"\
             -xscrollcommand ".dp.w.top.scrbarx set" -font $basefont 
#-geometry 40x25

   scrollbar .dp.w.top.scrbary -relief sunken -command ".dp.w.top.lb yview"
   scrollbar .dp.w.top.scrbarx -relief sunken -command ".dp.w.top.lb xview" -orient horiz

   pack      .dp.w.top.scrbary -side right -fill y
   pack      .dp.w.top.scrbarx -side bottom -fill x
   pack      .dp.w.top.lb -expand 1

   frame .dp.w.mid.title
   pack  .dp.w.mid.title -anchor w 

   frame .dp.w.mid.par1
   pack  .dp.w.mid.par1 -side top -anchor w

   label .dp.w.mid.title.label -text "Predicate Name   " -font $boldfont
   pack  .dp.w.mid.title.label -side left
 
   entry  .dp.w.mid.par1.entry -width 20 -textvariable pred_id -font $basefont\
          -relief sunken
   pack  .dp.w.mid.par1.entry -side left
 
   frame .dp.w.bot -bd 1 -relief raised
   pack  .dp.w.bot -side top -fill x -expand 1 
  
   label  .dp.w.msg -textvariable pred_msg -bd 1 -relief sunken -font $obliquefont
   pack   .dp.w.msg -side top -fill x

   foreach args $pred_struc {
        .dp.w.top.lb insert end $args
   }

   if {$newpred != ""} {
       set pred_id $newpred
   }
   button .dp.w.bot.delete -text "Delete" -relief raised -bd 2 -font $basefont\
          -command {
                    if {[selection own] == ".dp.w.top.lb"} {
                        DeletePredicate [selection get]
                    } else {
                            if {[winfo exists [focus]] == 1} {
                                set entry_p [focus]
                                if {$entry_p == ".dp.w.mid.par1.entry"} {
                                set pred_msg "Incorrect Selection. Select one param type in\
                                              Argument Type List."
                                } else {
                                        set pos [string trimright $entry_p .dynamic]
                                        set len [string length $pos]
                                        set pos [string range $pos [expr $len - 2] end]
                                        if {[string match .? $pos] == 1} {
                                            set pos [string trimleft $pos .]
                                        }
                                        global pname$pos
                                        DeletePredicateTypeParam pname$pos $pos
                                }
                            } 
                    }

                   }
   pack   .dp.w.bot.delete -side left  -fill x -expand 1

   button .dp.w.bot.save -text "Save" -relief raised -bd 2 -font $basefont\
          -command {
                     if {[llength $dom_struc] == 3} {
                         set dom_struc [linsert $dom_struc [llength $dom_struc] $pred_struc]
                     } else {
                             set pos [expr [llength $dom_struc] -1]
                             set dom_struc [lreplace $dom_struc $pos $pos "predicates: $pred_struc"]
                     }
                     SaveDomStruc
                     set save_pred 1
                   }

   pack   .dp.w.bot.save -side left -fill x -expand 1
     
   button .dp.w.bot.close -text "Close" -relief raised -bd 2 -font $basefont\
          -command {
                     if {$save_pred == 0} {
                         set option [dialog .d {Save Domain} {The predicates structure has been\
                                     modified since your last savings. Do you like to save last\
                                     changes ?} questhead 0 {Yes} {No}]
                         if {$option == 0} {
                             if {[llength $dom_struc] == 3} {
                                 set dom_struc [linsert $dom_struc [llength $dom_struc] $pred_struc]
                             } else {
                                     set pos [expr [llength $dom_struc] -1]
                                     set dom_struc [lreplace $dom_struc $pos $pos "predicates:\
                                                 $pred_struc"]
                             }
                       
                             SaveDomStruc
                             set save_pred 1
                          }
                     }
                     ResetParamStruc
                     focus $oldfocus
                     destroy .dp
                   }
   pack   .dp.w.bot.close -side left -fill x -expand 1

   set is_changes 0
   set pindex 0
   set pline 1
   focus .dp.w.mid.par1.entry
   bind .dp.w.mid.par1.entry <Return> {
        #Test to see if is new or if is changes
        set save_pred 0
        if {$is_changes == 0} {
            set position_change_pred_struc -1        
            foreach args $pred_struc {
                  incr position_change_pred_struc
                  if {$pred_id == [lindex $args 0]} {
                    set option [dialog .d {User Decision} "This predicate already exists in the\
                         domain. Would you like to make changes ?" questhead 0 Yes No]
                    if {$option == 0} {
                        set pred_msg "You can do changes."
                        #the "is_changes" variable is set to 1 in ChangeParamStruc procedure
                        ChangeParamStruc $position_change_pred_struc
                        focus .dp.w.mid.par1.entry
                        return 
                    } else {
                            set pred_msg "Changes in the predicate was canceled."
                            set pred_id ""
                            focus .dp.w.mid.par1.entry
                            return
                    }
                  }
            }
            set pred_list ""
            set pred_list [linsert $pred_list 0 $pred_id]
            AskParamNumber .dp

        } else {
                #I'm going to test the new predicate name during changes mode
                set new_pos -1
                foreach args $pred_struc {
                      incr new_pos
                      if {$pred_id == [lindex $args 0]} {
                          if {$new_pos != $position_change_pred_struc} {
                              #This means that the user is choosing one repeated predicate name
                              set new_pos -1
                              break
                          }
                      }
                }
                if {$new_pos == -1} {
                    set pred_msg "Sorry! The \"$pred_id\" already exists as predicate name, you can't\
                                  choose it."
                } else {
                        set pred_list [lreplace $pred_list 0 0 $pred_id]
                        set pos $position_change_pred_struc
                        set pred_struc [lreplace $pred_struc $pos $pos $pred_list]
                        .dp.w.top.lb delete $pos
                        .dp.w.top.lb insert $pos $pred_list
                        if {[winfo exists .dp.w.mid.par1.1.dynamic] == 1} {
                            focus .dp.w.mid.par1.1.dynamic
                        } else {
                                AskParamNumber .dp
                        }
                }
        }       
   }
   
   bind .dp.w.mid.par1.entry <Tab> {Tab $TabListParam}
   bind .dp.w.mid.par1.entry <Shift-Tab> {Tab $TabListParam}

   bind .dp.w.top.lb <Double-Button-1> {
                     set pred_msg "You can do changes."
                     #the "is_changes" variable is set to 1 in ChangeParamStruc procedure
                     ResetParamStruc
                     ChangeParamStruc [.dp.w.top.lb curselection]
                     focus .dp.w.mid.par1.entry
              } 
         
   tkwait visibility .dp
   grab set .dp
}

#*********************************************************************************
#The procedures bellow are related with the Definition of Params of Operators
#
#*********************************************************************************

#lldpix======================================================================
# DELETE OPERATOR ITEM
#============================================================================

proc DeleteOperItem {object {listbox ""} type} {

   global oper_struc
   global oper_name curr_oper
   global save_oper

   set numobj [llength $object]
   set object_aux $object
   set delete_all 0
   foreach args $object {
        if { $delete_all == 0 } {
             set option [dialog .d {Confirm Object Deletion} "The selectioned objects - \"$object_aux\"\
             will be deleted. Are you sure to remove them from the list?" questhead 0\
               {Yes for all} {Yes} {Cancel}]
        }
        if {$option == 0} { 
            set delete_all 1
            set list1 [lindex $oper_struc $type]
#You have to add 1 because I took off the title of the list
 
            set el_pos [lsearch $list1 $args]
            if {$el_pos == -1} {
                dialog .d {Context error} "The \"$args\" object doesn't exist in list." error 0 Ok
                return
            } else {
                    set list1 [lreplace $list1 $el_pos $el_pos]
                    set oper_struc [lreplace $oper_struc $type $type $list1]
            }
            set save_oper 0

        }
        if {$option == 1} {
            set list1 [lindex $oper_struc $type]
            set object_aux [lreplace $object_aux 0 0]
            set el_pos [lsearch $list1 $args]
            if {$el_pos == -1} {
                dialog .d {Context error} "The \"$args\" object doesn't exist in list." error 0 Ok
                return
            } else {
                    set list2 [lreplace $list1 $el_pos $el_pos]
                    set oper_struc [lreplace $oper_struc $type $type $list2]
            }
            set save_oper 0
        }
        if {$option == 2} {
            return
        }
   }
#==Update object listbox
   if {$listbox != ""} {
       $listbox delete 0 end
       foreach args [lsort [lreplace [lindex $oper_struc $type] 0 0]] {
           set var [string trimright $args >]
           set var [string trimleft  $var  <]
           $listbox insert end $var
       }
   }
   if {$type == 1} {
       ResetStrucOper
       FillOperStruc $oper_name
   }
}

#lldopx======================================================================
# DELETE OF OPERATORS PARAMS
#============================================================================

proc DeleteParam {list lbox type} {

   set list_aux ""
   foreach args $list {
       set list_aux [linsert $list_aux [llength $list_aux] <$args>]
   }
   DeleteOperItem $list_aux $lbox $type
}

#llhpxx======================================================================
# HANDLE OF OPERATORS PARAMS
#============================================================================

proc HandleParam {pwind} {

   global world_path domain_name
   global boldfont basefont obliquefont
   global xgeometry ygeometry
   global oper_struc oper_name
   global index

   global param_num
   
   toplevel .hp
   checkGeometry $pwind
   wm geometry .hp "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .hp "PARAMS DEFINITION : \"$oper_name\" Operator"

   frame .hp.up -bd 1 -relief raised
   pack  .hp.up -side top -fill both
   frame .hp.mid -bd 1 -relief raised
   pack  .hp.mid -side top -fill both
   frame .hp.mid.right -bd 1 -relief raised
   pack  .hp.mid.right -side right -fill both
   frame .hp.bot -bd 1 -relief raised
   pack  .hp.bot -side top -fill both 
   
   label .hp.up.label -text "Param Number: " -font $boldfont
   entry .hp.up.entry -width 2 -textvariable param_num -font $basefont\
	 -relief sunken
   pack .hp.up.label .hp.up.entry -side left

   label .hp.mid.right.label -text "Params List" -relief raised -font $boldfont
   pack  .hp.mid.right.label -side top  -fill x -expand 1

   scrollbar .hp.mid.right.scrbar -relief sunken -command ".hp.mid.right.object yview"
   pack      .hp.mid.right.scrbar  -side right -fill y

   listbox   .hp.mid.right.object -relief raised -borderwidth 2 \
                             -yscrollcommand ".hp.mid.right.scrbar set" -font $basefont
   pack      .hp.mid.right.object  -side right -fill y

   frame .hp.mid.left -relief raised
   pack  .hp.mid.left -side left
   label .hp.mid.left.bitmap -bitmap info
   pack  .hp.mid.left.bitmap -side top -padx 3m -pady 3m
   message .hp.mid.left.msg -width 3i -text "\"Param Number is optional, enter the number if you want\
                   the automatic creation of entry point. To Delete param select in the list and click\
                   \"Delete\"." -font $basefont
   pack    .hp.mid.left.msg -side top 

   button .hp.bot.delete -text "Delete" -relief raised -bd 2 -font $basefont -command { \
          if {[selection own] != ".hp.mid.right.object"} {
              set param_msg "Incorrect Selection! Select object types from list."
          } else {
                  DeleteParam [selection get] .hp.mid.right.object 1
          }}
   
   button .hp.bot.close -text "Close" -relief raised -bd 2 -font $basefont -command { \
          set param_num ""
          destroy .hp
          }
  
   pack .hp.bot.delete  -side left -expand 1 -fill x
   pack .hp.bot.close  -side left -expand 1 -fill x

   label .hp.msg -textvariable param_msg -width 50 -font $obliquefont -relief raised
   pack  .hp.msg -side top -fill x
   pack .hp.up.label .hp.up.entry -side left
   
#==Update listbox
   foreach args [lsort [lreplace [lindex $oper_struc 1] 0 0]] {
      set par [string trimright $args >]
      set par [string trimleft  $par <]
      .hp.mid.right.object insert end $par
   }
   
   set param_num [expr $index +1]
   bind .hp.up.entry <Return> {
        if {$param_num < [expr $index +1]} {
            set param_msg "Wrong number - $param_num, it has to be greater than the actual number."
            set param_num ""
        } else {
                set din [expr $param_num - [expr $index +1]]
                set param_msg "It was created \"$din\" param entry point."
                while {$din >= 1} {
                       CreateParamFrame
                       incr din -1
                }
        }
   }

   tkwait visibility .hp
   grab set .hp
}


#lldpxx======================================================================
# ASK FOR NUMBER OF PREDICATE PARAMS
#============================================================================

proc AskParamNumber {pwind} {
   
   global domain_name
   global pindex pline
   global xgeometry ygeometry
   global basefont boldfont obliquefont
   global is_changes position_change_pred_struc
   global pred_id pred_list

   toplevel .npw
   checkGeometry $pwind
   wm geometry .npw "+[expr $xgeometry+25]+[expr $ygeometry+25]"
   wm title .npw "PREDICATE PARAMS DEFINITION : \"$domain_name\""

   frame .npw.up -bd 1 -relief raised
   pack  .npw.up -side top -fill both
   frame .npw.mid -bd 1 -relief raised
   pack  .npw.mid -side top -fill both
   frame .npw.bot -bd 1 -relief raised
   pack  .npw.bot -side top -fill both 
   
   label .npw.up.label -text "Param Number: " -font $boldfont
   entry .npw.up.entry -width 2 -textvariable param_pred_num -font $basefont\
	 -relief sunken
   pack .npw.up.label .npw.up.entry -side left

   label .npw.mid.bitmap -bitmap info
   pack  .npw.mid.bitmap -side top -padx 3m -pady 3m
   message .npw.mid.msg -width 3i -text "\"Enter the number of params that you want to create. If\
           you want to cancel the command click Close.\"" -font $basefont
   pack    .npw.mid.msg -side top 
   
   button .npw.bot.close -text "Close" -relief raised -bd 2 -font $basefont -command { \
          set param_msg "The command was canceled by user"
          set param_pred_num ""
          set param_pred_msg ""
          destroy .npw
          }
  
   pack .npw.bot.close  -side left -expand 1 -fill x

   label .npw.msg -textvariable param_pred_msg -width 50 -font $obliquefont -relief raised
   pack  .npw.msg -side top -fill x
   pack .npw.up.label .npw.up.entry -side left
   
   set pindex 0
   set pline  1
   focus .npw.up.entry
   bind .npw.up.entry <Return> {
        if {$param_pred_num == ""} {
            set param_pred_msg "Invalid Input. Enter an integer number."
        } else {
                if {[regexp -nocase {[a-z]} $param_pred_num] == 1} {
                    set param_pred_msg "\"$param_pred_num\" - Invalid Input. Enter an integer\
                                        number."
                    set param_pred_num ""
                } else {
                        if {$param_pred_num == 0} {
                            #This means no param in the predicate
                            if {$is_changes == 0} {
                                set pred_struc [linsert $pred_struc [llength $pred_struc] $pred_list]
                               .dp.w.top.lb insert end $pred_list
                            } else {
                                    set pos $position_change_pred_struc
                                    set pred_struc [lreplace $pred_struc $pos $pos $pred_list]
                                    .dp.w.top.lb delete $pos
                                    .dp.w.top.lb insert $pos $pred_list
                            }
                            set pred_list ""
                            set pred_id ""
                            set is_changes 0
                            focus .dp.w.mid.par1.entry                 
                        } else {
                                #The .dp.w.mid frame was create in DefinePredicates procedures
                                if {[winfo exists .dp.w.mid.title.desc] != 1} {
                                    label .dp.w.mid.title.desc -text "          Argument Type List"\
                                              -font $boldfont 
                                    pack  .dp.w.mid.title.desc -side left 
                                }
                                while {$param_pred_num >= 1} {
                                       set pred_list [linsert $pred_list [llength $pred_list] ""]
                                       CreatePredParam
                                       incr param_pred_num -1
                                }
                                .dp.w.top.lb insert end $pred_list
                                focus .dp.w.mid.par1.1.dynamic
                        }
                        destroy .npw
                }
        }
   }
   tkwait visibility .npw
   grab set .npw
}

#llpppx======================================================================
# CREATE FRAMES TO PREDICATE PARAMS
#============================================================================

proc CreatePredParam {} {
   
   global basefont  
   global pline pindex 
   global TabListParam 
   incr pindex

    if {[winfo exists .dp.w.mid.par$pline.$pindex] != 1} {
       if {$pindex == [expr [expr 4 * $pline] +1]} {
           set framepos "w"
           incr pline                           
           frame .dp.w.mid.par$pline
           pack  .dp.w.mid.par$pline -anchor w
           label .dp.w.mid.par$pline.space -text "                                   "
           pack  .dp.w.mid.par$pline.space -side left
       } else {
               set framepos "center"
       }                   
       frame .dp.w.mid.par$pline.$pindex
       pack  .dp.w.mid.par$pline.$pindex   -side left -anchor $framepos
       entry .dp.w.mid.par$pline.$pindex.dynamic -width 15 -textvariable\
            pname$pindex -font $basefont -relief sunken                  
       pack  .dp.w.mid.par$pline.$pindex.dynamic  -side left  -anchor $framepos -padx 10
       tkwait visibility .dp.w.mid.par$pline.$pindex
    }

    set TabListParam [linsert $TabListParam [expr $pindex +1] .dp.w.mid.par$pline.$pindex.dynamic]

    focus .dp.w.mid.par$pline.$pindex.dynamic
    bind  .dp.w.mid.par$pline.$pindex.dynamic <Return> "ReadPredParam pname$pindex"
    bind  .dp.w.mid.par$pline.$pindex.dynamic <Tab> {Tab $TabListParam}
    bind  .dp.w.mid.par$pline.$pindex.dynamic <Shift-Tab> {ShiftTab $TabListParam}
}

#llrspx======================================================================
# RESET PARAM STRUCTURE
#============================================================================

proc ResetParamStruc {} {

   global pindex pline is_changes
   global pred_id TabListParam

   set pred_id ""
   if {[winfo exists .dp.w.mid.title.desc] == 1} {
       destroy .dp.w.mid.title.desc
   }
   if {$pindex > 0} {
       while {$pindex >= 1} {
              if {[winfo exists .dp.w.mid.par1.$pindex] == 1} {
                  destroy .dp.w.mid.par1.$pindex
              }
              set pos [lsearch -regexp $TabListParam dynamic]                            
              if {$pos > 0} {
                  set TabListParam [lreplace $TabListParam $pos $pos]
              }
              global pname$pindex
              set pname$pindex ""
              incr pindex -1
       }
       if {$pline > 1} {
           while {$pline >= 2} {
                  destroy .dp.w.mid.par$pline
                  incr pline -1                              
           }
       }
       if {[winfo exists .dp.w.mid.title.desc] == 1} {
           destroy .dp.w.mid.title.desc
       }
       set is_changes 0
       set pindex 0
       set pline  1
   }
}

#lldpxx======================================================================
# READ PREDICATE PARAMS
#============================================================================

proc ReadPredParam {name} {
    
   upvar #0 $name realname
   global pindex pred_msg pred_id
   global pred_list pred_struc
   global position_change_pred_struc is_changes
   global TabListParam
   global save_pred

   set save_pred 0
   if {$realname == ""} {
       set pred_msg "Enter a valid param type name."
         return
   }
   regexp {([0-9]+)} $name num
   set pred_msg "The \"$realname\" param type was added to predicate."
   set lpred [llength $pred_list]
   if {$is_changes == 0} {
       set pred_list [lreplace $pred_list $num $num $realname]
       .dp.w.top.lb delete end
       .dp.w.top.lb insert end $pred_list
   } else {
           set pos $position_change_pred_struc
           if {$lpred <= $pindex } {
               set pred_list [linsert $pred_list [llength $pred_list] $realname]
           } else {
                   set pred_list [lreplace $pred_list $num $num $realname]           
           }
           .dp.w.top.lb delete $pos
           .dp.w.top.lb insert $pos $pred_list
   }
   if {$num == $pindex} {
       set already_exist 0
       set pos -1
       foreach args $pred_struc {
           incr pos
           if {$pred_id == [lindex $args  0]} {
               set already_exist 1
               break
           }
      }           
      if {$already_exist == 1} {
          set pred_struc [lreplace $pred_struc $pos $pos $pred_list]
          .dp.w.top.lb delete $pos
          .dp.w.top.lb insert $pos $pred_list
          set option [dialog .dial {User Decision} "Would you like to add another argument?"\
                     questhead 0 No Yes]
          if {$option == 1} {
              CreatePredParam
              return
          }
      } else {
              set pred_struc [linsert $pred_struc [llength $pred_struc] $pred_list]
      }
      ResetParamStruc
      set pred_list ""
      focus .dp.w.mid.par1.entry
      return
   } else {
           set i [lsearch -exact $TabListParam [focus]]
           incr i
           focus [lindex $TabListParam $i]
   }
}



#*********************************************************************************
#The procedures bellow are related with the Delete Effects
#
#*********************************************************************************

#ll    ======================================================================
# 
#============================================================================

proc HandleDeleteEffects {} {

   global basefont boldfont
   global TabList

   if {[winfo exists .w.do.eff.b1] == 1} {
       for {set i 1} {$i <= 4} {incr i} {
            destroy .w.do.eff.b$i
       }
   }
 
   if {[winfo exists .w.do.eff.b] == 1} {
       destroy .w.do.eff.b
   }
   
   if {[winfo exists .w.do.eff.a1] == 1} {
       destroy .w.do.eff.a1
   }

#Delete Frame
   frame .w.do.eff.d1
   pack  .w.do.eff.d1 -side top -anchor w 

   frame .w.do.eff.d1.tit
   pack  .w.do.eff.d1.tit -anchor w

   label .w.do.eff.d1.tit.space -text "                    "
   pack  .w.do.eff.d1.tit.space -side left
   label .w.do.eff.d1.tit.var -text "Predicate-name    " -font $boldfont
   pack  .w.do.eff.d1.tit.var -side left
 
   button .w.do.eff.d1.del -text "Delete" -relief raised -bd 2 -font $basefont\
          -command {
                      ShowPredicateList .w del
                    }
   pack   .w.do.eff.d1.del -side left -ipadx 15
   label  .w.do.eff.d1.space -text "  "
   pack   .w.do.eff.d1.space -side left
   entry .w.do.eff.d1.entrypred -width 15 -textvariable del_pred_name -font $basefont\
         -relief sunken
   pack  .w.do.eff.d1.entrypred -side left


   frame .w.do.eff.b
   pack  .w.do.eff.b -side bottom
   label .w.do.eff.b.space -text ""
   pack  .w.do.eff.b.space

   set pos [lsearch -exact $TabList ".w.do.eff.a1.entrypred"] 
   if {$pos != -1} {
       set TabList [lreplace $TabList $pos $pos]
   }
   set TabList [linsert $TabList [llength $TabList] ".w.do.eff.d1.entrypred"]
   bind .w.do.eff.d1.entrypred <Tab> {Tab $TabList}
   bind .w.do.eff.d1.entrypred <Shift-Tab> {Tab $TabList}
   focus .w.do.eff.d1.entrypred 
   bind .w.do.eff.d1.entrypred <Return> {
          HandleEffects $del_pred_name 5       
   }
}
#*********************************************************************************
#The procedures bellow are related with the Add Effects
#
#*********************************************************************************

#ll   x======================================================================
# 
#============================================================================

proc HandleAddEffects { } {
  
   global basefont boldfont
   global TabList
        
   if {[winfo exists .w.do.eff.b1] == 1} {
       for {set i 1} {$i <= 4} {incr i} {
        destroy .w.do.eff.b$i
       }
   }          
   if {[winfo exists .w.do.eff.b] == 1} {
       destroy .w.do.eff.b
   }
    
   if {[winfo exists .w.do.eff.d1] == 1} {
       destroy .w.do.eff.d1
   }
             

#ADD Frame
   frame .w.do.eff.a1
   pack  .w.do.eff.a1 -side top -anchor w  

   frame .w.do.eff.a1.tit
   pack  .w.do.eff.a1.tit -anchor w

   label .w.do.eff.a1.tit.space -text "                    "
   pack  .w.do.eff.a1.tit.space -side left
   label .w.do.eff.a1.tit.var -text "Predicate-name    " -font $boldfont
   pack  .w.do.eff.a1.tit.var -side left

   button .w.do.eff.a1.add -text "Add" -relief raised -bd 2 -font $basefont\
          -command {
                     ShowPredicateList .w add
                   }
   pack   .w.do.eff.a1.add -side left -ipadx 22 
   label  .w.do.eff.a1.space -text "  "
   pack   .w.do.eff.a1.space -side left
   entry .w.do.eff.a1.entrypred -width 15 -textvariable add_pred_name -font $basefont\
         -relief sunken
   pack  .w.do.eff.a1.entrypred -side left

    frame .w.do.eff.b
    pack  .w.do.eff.b -side bottom
    label .w.do.eff.b.space -text ""
    pack  .w.do.eff.b.space

    set pos [lsearch -exact $TabList ".w.do.eff.d1.entrypred"] 
    if {$pos != -1} {
        set TabList [lreplace $TabList $pos $pos]
    }
    set TabList [linsert $TabList [llength $TabList] ".w.do.eff.a1.entrypred"]
    bind .w.do.eff.a1.entrypred <Tab> {Tab $TabList}
    bind .w.do.eff.a1.entrypred <Shift-Tab> {Tab $TabList}

    focus .w.do.eff.a1.entrypred 
    bind .w.do.eff.a1.entrypred <Return> {
            HandleEffects $add_pred_name 6         
    }
}


#*********************************************************************************
#The procedures bellow are related with the Conditional Effects
#
#*********************************************************************************

#ll   x======================================================================
# 
#============================================================================

proc HandleConditionalEffects {} {
  
   global oper_msg

   set oper_msg "not implemented yet"

}

#********************************************
#The code bellow is related with Effects - Variable

#llhnev======================================================================
# HANDLE NEW EFFECTS VARIABLE
#============================================================================

proc HandleNewEffectsVariable {} {

     global simple_type
     global eff_var_name par_name oper_msg

     if {$eff_var_name == ""} {
         if {[winfo exists .w.do.eff.a1.entrypred] == 1} {
             focus .w.do.eff.a1.entrypred
             return
         }
         if {[winfo exists .w.do.eff.d1.entrypred] == 1} {
             focus .w.do.eff.d1.entrypred
             return
         }
         focus .w.do.par.top.opname
     } else {
        set option [dialog .d {User Decision} "Define the type of the variable.\
                 The default is \"Simple Type\"." questhead 0 "Simple Type" "Constraint\
                 Type"]
        if {$option == 0} {
            set oper_msg "The \"Simple Type\" was choosed. I will check out the descriptor."
            set simple_type 1
        } else {
             set oper_msg "The \"Constraint Type\" was choosed. I won't check out the\
                       descriptor. The syntax and semantic are your responsability."
             set simple_type 0
        }
        focus .w.do.eff.v.entrydes
     }
}

#llhcev======================================================================
# HANDLE CHANGES IN THE EFFECTS VARIABLE
#============================================================================

proc HandleChangesEffectsVariable {} {

   global change_position
   global eff_var_name oper_msg
   global simple_type

   set option [dialog .d {User Decision} "Define the type of the variable.\
               The default is \"Simple Type\"." questhead 0 "Simple Type" "Constraint\
               Type"]
   if {$option == 0} {
       set oper_msg "The \"Simple Type\" was choosed. I will check out the descriptor."
       set simple_type 1
   } else {
           set oper_msg "The \"Constraint Type\" was choosed. I won't check out the\
                      descriptor. The syntax and semantic are your responsability."
           set simple_type 0
   }
   if {$change_position == -1} {
       set oper_msg "Warning. Ocurred one error in sequence of operations, I couldn't\
                     do changes in the predicate variable."
       set eff_var_name ""
       set eff_desc_name ""
       focus .w.do.eff.v.entryvar
       return
   }
   focus .w.do.eff.v.entrydes
}
 
#llhnefd=====================================================================
# HANDLE NEW EFFECTS VARIABLE DESCRIPTOR
#============================================================================
  
proc HandleNewEffectsVariableDescriptor {} {

   global oper_struc simple_type
   global eff_var_name eff_desc_name oper_msg

   if {$eff_desc_name == ""} {
          set oper_msg "Enter a valid descriptor to variable \"$eff_var_name\"."
   } else {
            if {$eff_var_name != ""} {
                if {$simple_type == 1} {
                    set var_spec "<$eff_var_name> $eff_desc_name"
                } else {
                        set var_spec "<$eff_var_name> \{$eff_desc_name\}"
                }
                set list1 [lindex $oper_struc 4]
                set list1 [linsert $list1 [llength $list1] $var_spec]
                set oper_struc [lreplace $oper_struc 4 4 $list1]
                set eff_var_name ""
                set eff_desc_name ""
                focus .w.do.eff.v.entryvar
            } else {
                    set oper_msg "First, you have to define variable name."
            }
   }
}

#llhcefd=====================================================================
# HANDLE CHANGES IN EFFECTS VARIABLE DESCRIPTOR
#============================================================================

proc HandleChangesEffectsVariableDescriptor {} {
   
   global oper_struc simple_type
   global eff_desc_name eff_var_name
   global change_position pos_effvar

   if {$eff_desc_name == ""} {
        set oper_msg "Enter a valid descriptor to variable \"$eff_var_name\"."
   } else {
            if {$eff_var_name != ""} {
                if {$simple_type == 1} {
                    set var_spec "<$eff_var_name> $eff_desc_name"
                } else {
                    set var_spec "<$eff_var_name> \{$eff_desc_name\}"
                }
                set list1 [lindex $oper_struc 4]
                set pos [expr $change_position - $pos_effvar]
                set list1 [lreplace $list1 $pos $pos $var_spec]
                set oper_struc [lreplace $oper_struc 4 4 $list1]
                set oper_msg "Changes in \"$eff_var_name\" variable was executed."
                set eff_desc_name ""
                set eff_var_name ""
                set change_position -1
                focus .w.do.eff.v.entryvar
            } else {
                    set oper_msg "First, you have to define variable name."
            }
   }
}

#*************************************************
# The following Procedures are related with the Delete and Add effects

#llheff======================================================================
# HANDLE EFFECTS
#============================================================================

proc HandleEffects {aux_name type} {

   global pred_struc oper_struc
   global aux_index
   global changes_preconds more_than_one_aux
   global save_oper

   #If type == 5 is delete effects
   #   type == 6 is add effects

   if {$aux_name == ""} {
       switch $type {
             5  { focus .w.do.eff.d1.entrypred }
             6  { focus .w.do.eff.a1.entrypred }
       }
       return
   }
   set exist 0
   set position -1
   set num -1
   foreach args $pred_struc {
       incr position
       if {$aux_name == [lindex $args 0]} {
           set num [expr [llength $args] -1]
           set exist 1
           break
       }
   } 
   if {$exist == 0} {
       set option [dialog .d {Context Error} "The \"$aux_name\" predicate doesn't exist in\
                   the domain. Would you like to define it ?" info 0 Yes No]
       if {$option == 0} {
           DefinePredicates .w $aux_name
           return
       } else {
               return
       }
   }
   switch $type {
             5  { focus .w.do.eff.d1.entrypred }
             6  { focus .w.do.eff.a1.entrypred }
   }
   
   set changes_effects 0
   set list [lindex $oper_struc $type]
   #take out the "effects_del" or "effects_add" title
   set list [lreplace $list 0 0]
   set more_than_one_aux 0
   foreach args $list {
         if {$aux_name == [lindex $args 0]} {
             set options "You can choice the following options:\n\n\
                               CHANGE   - Allow you to make changes in the predicate;\n\n\
                               CONTINUE - Search for a next ocurrence of the predicate;\n\n\
                               INSERT   - Allow you to insert other predicate;\n\n\
                               CANCEL   - Close the window and cancel the command.\n"
             incr more_than_one_aux 
             if {$more_than_one_aux > 1} {
                 if {$more_than_one_aux == 2} {
                     set mess "This is the $more_than_one_aux-nd ocurrence of the \"$aux_name\". $options"
                 } else {
                         set mess "This is the $more_than_one_aux-th ocurrence of the \"$aux_name\". $options"
                 }
             } else {
                     set mess "The \"$aux_name\" predicate already exists. $options"
             }         
             set option [dialog .d {User Decision} "$mess" questhead 0 Change Continue Insert Cancel]
             switch $option {
                 0 {
                     set changes_effects 1
                     break
                   }
                 1 {
                     set changes_effects 2
                   }
                 2 {
                     set changes_effects 0
                     set more_than_one_aux 0
                     foreach args $list {
                           if {$aux_name == [lindex $args 0]} {
                               incr more_than_one_aux
                           }
                     }
                     incr more_than_one_aux
                     break
                   }
                 3 {
                     set changes_effects 2
                     set oper_msg "The command was canceled."
                     break
                   }
             } 
         }
   }
   if {$more_than_one_aux == 0} {
       set more_than_one_aux 1
       #This mean that's the first ocurrence of predicate
   }
   set save_oper 0
   switch $changes_effects {
        0 {NewEffectsPred $num $aux_name $type}
        1 {ChangeEffectsPred "" $more_than_one_aux $aux_name $type}
        2 { 
            if {$aux_index >= 1} {
                ResetEffectsArgumentsFrame $type
            }
          }        
   }
}
#llcppx======================================================================
# CHANGE PRECONDITIONS OF PREDICATES
#============================================================================

proc ChangeEffectsPred { {position ""} {more ""} aux_name type } {

   global oper_msg
   global oper_struc effects_list

   set oper_msg "This predicate already exists in the operator. You can make changes."
 
   set effects_list $aux_name
   set list [lindex $oper_struc $type]
   #take out the title
   set list [lreplace $list 0 0]
   #this is called with return
   if {$more != ""} {
       set next 0
       foreach args $list {
             if {$aux_name == [lindex $args 0]} {
                 incr next
                 if {$next == $more} {
                     set num [expr [llength $args] -1]
                     ResetEffectsArgumentsFrame $type
                     for {set i 1} {$i <= $num} {incr i} {
                          CreateEffectsArgFrame $aux_name $type 
                          global aux_arg$i
                          set var [lindex $args $i]
                          set var1 [string trim $var <>]
                          set aux_arg$i $var1
                          set effects_list [linsert $effects_list [llength $effects_list] $var]
                     }
                     return
                  }
              }
       }
   }
   #This is called with mouse
   if {$position != ""} {
       set more [.w.do.r.lb get $position]
       set num [expr [llength $more] -1]
       ResetEffectsArgumentsFrame $type
       for {set i 1} {$i <= $num} {incr i} {
            CreateEffectsArgFrame $aux_name $type 
            global aux_arg$i
            set var [lindex $more $i]
            set var1 [string trim $var <>]
            set aux_arg$i $var1
            set effects_list [linsert $effects_list [llength $effects_list] $var]
       }
   }
}

#llnepx======================================================================
# NEW EFFECTS PREDICATES
#============================================================================

proc NewEffectsPred {num aux_name type} {

   global oper_msg
   global effects_list oper_struc
   global add_pred_name del_pred_name

   set oper_msg "This is a new predicate to operator"
  
   ResetEffectsArgumentsFrame $type

   set effects_list $aux_name
   if {$num == 0} {
       set list [lindex $oper_struc $type]
       set list [linsert $list [llength $list] $effects_list]
       set oper_struc [lreplace $oper_struc $type $type $list]
       set effects_list ""
       switch $type {
            5 { set del_pred_name "" }
            6 { set add_pred_name "" }
       }
   } else {
           while {$num >= 1} {
              #to predicate arguments
              set effects_list [linsert $effects_list [llength $effects_list] ""]
              CreateEffectsArgFrame $aux_name $type
              incr num -1
           }
           set list [lindex $oper_struc $type]
           set list [linsert $list [llength $list] $effects_list]
           set oper_struc [lreplace $oper_struc $type $type $list]
           switch $type {
                5 { focus .w.do.eff.d1.1.dynaux }
                6 { focus .w.do.eff.a1.1.dynaux }         
           }
   }
}

#llreax======================================================================
# READ EFFECTS ARGUMENTS
#============================================================================

proc ReadEffectsArguments {name aux_name type} {

     upvar #0 $name realarg
     global aux_index
     global effects_list oper_struc dom_struc 
     global changes_effects TabList
     global more_than_one_aux
     global add_pred_name del_pred_name  
     global save_oper

     set save_oper 0
     if {$realarg == ""} {
         set oper_msg "Enter a valid argument name."
         return
     }
     set exists 0
     #Search if the variable was defined in the Variable list of Preconds
     set list [lindex $oper_struc 2]
     for {set i 1} {$i < [llength $list]} {incr i} {
          if {"<$realarg>" == [lindex [lindex $list $i] 0]} {
              set exists 1
              break
          }
     }
     #Search in the Variable List of Effects
     set list [lindex $oper_struc 4]
     for {set i 1} {$i < [llength $list]} {incr i} {
          if {"<$realarg>" == [lindex [lindex $list $i] 0]} {
              set exists 1
              break
          }
     }
     set instance 0
     if {$exists == 0} {
         set instance_list [lreplace [lindex $dom_struc 2] 0 0]
         foreach args $instance_list {
                 if {$realarg == [lindex $args 0]} {
                     set instance 1
                     break
                 }
         }
         if {$instance == 0} {
             set option [dialog .d {Warning} "The \"$realarg\" argument wasn't defined as\
                         variable or as instance of object. If it will be defined later\
                         and you want to enter now, press Yes" info 0 OK Yes]
             if {$option == 0} {
                 return
             } else {
                      set instance 1
             }
         }
     }

     regexp {([0-9]+)} $name num
     if {$instance == 0} {
         set effects_list [lreplace $effects_list $num $num <$realarg>]
     } else {
             set effects_list [lreplace $effects_list $num $num $realarg]     
     }
     set list [lindex $oper_struc $type]
     set next 0

     for {set i 1} {$i < [llength $list]} {incr i} {
          if {$aux_name == [lindex [lindex $list $i] 0]} {
              incr next
              if {$more_than_one_aux == $next} {
                  set list [lreplace $list $i $i $effects_list]
                  break
              }
          }
     }

     set oper_struc [lreplace $oper_struc $type $type $list]

     if {$num == $aux_index} {
         ResetEffectsArgumentsFrame $type
         switch $type {
              5 {
                 set del_pred_name ""
                 focus .w.do.eff.d1.entrypred
                }
              6 {
                 set add_pred_name ""
                 focus .w.do.eff.a1.entrypred       
                }
         }
     } else {
              set i [lsearch -exact $TabList [focus]]
              incr i
              focus [lindex $TabList $i]
     }
}

#llcafx======================================================================
# RESET ARGUMENTS FRAME
#============================================================================

proc ResetEffectsArgumentsFrame { {type ""} } {

   global aux_index aux_line
   global TabList

   if {[winfo exists .w.do.eff.a1.tit.desc] == 1} {
       destroy .w.do.eff.a1.tit.desc
   }
   if {[winfo exists .w.do.eff.d1.tit.desc] == 1} {
       destroy .w.do.eff.d1.tit.desc
   }

   while {$aux_line >= 2} {
          if {[winfo exists .w.do.eff.d$aux_line] == 1} { 
              destroy .w.do.eff.d$aux_line 
          }
          if {[winfo exists .w.do.eff.a$aux_line] == 1} { 
              destroy .w.do.eff.a$aux_line 
          }
          incr aux_line -1
   }
   if {$aux_index >= 1} {
       for {set i $aux_index} {$i > 0} {incr i -1} {
            if {[winfo exists .w.do.eff.d1.$i] == 1} {
                 destroy .w.do.eff.d1.$i
            }
            if {[winfo exists .w.do.eff.a1.$i] == 1} {
                destroy .w.do.eff.a1.$i
            }
       }

       while {$aux_index >= 1} {
              set pos [lsearch -regexp $TabList dynaux]                            
              if {$pos > 0} {
                  set TabList [lreplace $TabList $pos $pos]
              }
              global aux_arg$aux_index
              set aux_arg$aux_index ""
              incr aux_index -1
       }
       set aux_line 1
       set aux_index 0
   }
   switch $type {
        5 {
            if {[winfo exists .w.do.eff.d1.entrypred] == 1} {
               focus .w.do.eff.d1.entrypred
            }
           } 
        6 {  
            if {[winfo exists .w.do.eff.a1.entrypred] == 1} {
                focus .w.do.eff.a1.entrypred
            }
          } 
         
        default {
                 if {[winfo exists .w.do.eff.d1] == 1} {
                     destroy .w.do.eff.d1
                 }
                 if {[winfo exists .w.do.eff.a1] == 1} {
                     destroy .w.do.eff.a1
                 }
                }
   }
}

#llcafx======================================================================
# CREATE ARGUMENTS FRAME
#============================================================================

proc CreateEffectsArgFrame {aux_name type} {  

   global basefont boldfont
   global aux_index aux_line
   global TabList

   incr aux_index

   switch $type {
        5 { 
            set p d 
            if {[winfo exists .w.do.eff.d1.tit.desc] != 1} {
                label .w.do.eff.d1.tit.desc -text "         Predicate Variable List" -font\
                                                    $boldfont 
                pack  .w.do.eff.d1.tit.desc -side right
            }
          }
        6 { 
            set p a 
            if {[winfo exists .w.do.eff.a1.tit.desc] != 1} {
                label .w.do.eff.a1.tit.desc -text "         Predicate Variable List" -font\
                                                      $boldfont 
                pack  .w.do.eff.a1.tit.desc -side right
            }
          }
   } 


   if {[winfo exists .w.do.eff.$p$aux_line.$aux_index] != 1} {
       if {$aux_index == [expr [expr 3 * $aux_line] +1]} {
           set framepos "w"
           incr aux_line                           
           frame .w.do.eff.$p$aux_line
           pack  .w.do.eff.$p$aux_line -anchor w
           label .w.do.eff.$p$aux_line.space -text " "
           pack  .w.do.eff.$p$aux_line.space -side left -padx 3.1c
       } else {
               set framepos "center"
       }                 

       frame .w.do.eff.$p$aux_line.$aux_index
       pack  .w.do.eff.$p$aux_line.$aux_index   -side left -anchor $framepos
   
       label .w.do.eff.$p$aux_line.$aux_index.< -text "<"
       pack  .w.do.eff.$p$aux_line.$aux_index.< -side left
   
       entry .w.do.eff.$p$aux_line.$aux_index.dynaux -width 15 -textvariable\
            aux_arg$aux_index -font $basefont -relief sunken                  
       pack  .w.do.eff.$p$aux_line.$aux_index.dynaux  -side left  -anchor $framepos

       label .w.do.eff.$p$aux_line.$aux_index.> -text ">"
       pack  .w.do.eff.$p$aux_line.$aux_index.> -side left

       tkwait visibility .w.do.eff.$p$aux_line.$aux_index
    }

    set TabList [linsert $TabList [llength $TabList] .w.do.eff.$p$aux_line.$aux_index.dynaux]

    focus .w.do.eff.$p$aux_line.$aux_index.dynaux
    bind  .w.do.eff.$p$aux_line.$aux_index.dynaux <Return>\
         "ReadEffectsArguments aux_arg$aux_index $aux_name $type"
    bind  .w.do.eff.$p$aux_line.$aux_index.dynaux <Tab> {Tab $TabList}
    bind  .w.do.eff.$p$aux_line.$aux_index.dynaux <Shift-Tab> {ShiftTab $TabList}
}

#****************************************
#
# GENERATE DOMAIN.LISP FILE
#
#****************************************

proc GenerateDomainLisp {} {

   global dom_struc itype_struc world_path domain_name

   set file_name $world_path$domain_name/domain.lisp

   if {[file isfile $file_name] == 1} {
       exec rm $file_name
   }

   #Save domain structure before generating domain.lisp file.
   SaveDomStruc

   set fileid [open $file_name a+]

   puts $fileid "(create-problem-space '[lindex [lindex $dom_struc 0] 1] :current t)"

   #Generate infinite type list
   foreach args $itype_struc {
      puts $fileid "(infinite-type $args)"
   }

   #Generate object type list
   set list [lindex $dom_struc 1]
   set num [llength $list]
   for { set i [expr $num -1] } {$i > 0} {incr i -1} {
         puts $fileid "(ptype-of [lindex $list $i])"
   }

   #Generate instance list
   set list [lindex $dom_struc 2]
   set num [llength $list]
   for { set i [expr $num -1] } {$i > 0} {incr i -1} {
         set insta [lindex $list $i]
         puts $fileid "(pinstance-of [lindex $insta 0] [lindex $insta 2])"
   }
 
   #Generate operator list
   set list_oper [lreplace $dom_struc 0 2]

   set num [expr [llength $list_oper] -1]
   if {$num >= 1} {
       set list_oper [lreplace $list_oper $num $num]
   } 
   foreach args $list_oper {
           puts $fileid ""
           puts $fileid ""
           puts $fileid "(operator [lindex [lindex $args 0] 1]"

           set list_param [lreplace [lindex $args 1] 0 0]
           puts $fileid "  (params $list_param)"
           puts $fileid "  (preconds"
           
           if {[llength [lindex $args 2]] >=2} {
               set i 0
               set list_var [lreplace [lindex $args 2] 0 0]
               if {[llength $list_var] == 1} {
                   set arg1 [lindex $list_var 0]
                   set arg2 [lindex $list_var 1]
                   puts $fileid "   (($arg1 $arg2))"
               } else {
                       foreach argi $list_var {
                          set arg1 [lindex $argi 0]
                          set arg2 [lindex $argi 1]
                          incr i
                          if {$i == 1} {
                              puts $fileid "   (($arg1 $arg2)"
                          } else {
                                   if {$i == [llength $list_var]} {
                                       puts $fileid "    ($arg1 $arg2))"
                                   } else {
                                            puts $fileid "    ($arg1 $arg2)"
                                   } 
                         }
                       }
               }
           } else {
                    puts $fileid "   ()"
           }

           if {[llength [lindex $args 3]] >= 2} {
               set list_pre [lreplace [lindex $args 3] 0 0]
               set logic [lindex $list_pre 0]
               set list_pre [lreplace $list_pre 0 0]
               puts $fileid "   ($logic"
               set i 0
               foreach argi $list_pre {
                       incr i
                       if {$i != [llength $list_pre]} {
                           puts $fileid "    ($argi)"
                       } else {
                               puts $fileid "    ($argi)))"
                       }             
               }
            }
            
            if {[llength [lindex $args 4]] >=  2} {
                set list_var [lreplace [lindex $args 4] 0 0]
                puts $fileid "  (effects ("
                set i 0                    
                foreach argi $list_var {
                        set arg1 [lindex $argi 0]
                        set arg2 [lindex $argi 1]
                        incr i
                        if {$i != [llength $list_var]} {
                            puts $fileid "   ($arg1 $arg2)"
                        } else {
                                 puts $fileid "   ($arg1 $arg2))"
                        }
                }
             } else {
                      puts $fileid "  (effects"
                      puts $fileid "   ()"
             }

             if {[llength [lindex $args 5]] >=2} {
                 set list_del [lreplace [lindex $args 5] 0 0]
                 set num [llength $list_del]
                 if {$num != 0} {
                     set i 0
                     foreach argi $list_del {
                             incr i
                             if {$i != $num} {
                                 if {$i == 1} {
                                     puts $fileid "   ((del ($argi))"
                                 } else { 
                                         puts $fileid "    (del ($argi))"
                                 }
                             } else {
                                     if {[llength [lindex $args 6]] == 1} {
                                         if {$i == 1} {
                                             puts $fileid "   ((del ($argi)))))"
                                         } else {
                                                  puts $fileid "    (del ($argi)))))"
                                         }
                                     } else {
                                             if {$i == 1} {
                                                 puts $fileid "   ((del ($argi))"
                                             } else {
                                                      puts $fileid "    (del ($argi))"
                                             }
                                     }
                             }
                     }
                 }
             }

             if {[llength [lindex $args 6]] >= 2} {
                 set list_add [lreplace [lindex $args 6] 0 0]
                 set num [llength $list_add]
                 if {$num != 0} {
                     set i 0
                     foreach argi $list_add {
                             incr i
                             if {$i != $num} {
                                 if {[llength [lindex $args 5]] == 1} {
                                     if {$i == 1} {
                                         puts $fileid "   ((add ($argi))"
                                     } else {
                                             puts $fileid "    (add ($argi))"
                                     }
                                 } else {
                                          puts $fileid "    (add ($argi))"
                                 }
                             } else {
                                     if {$i == 1} {
                                         if {[llength [lindex $args 5]] == 1} {
                                             puts $fileid "   ((add ($argi)))))"
                                         } else {
                                                  puts $fileid "    (add ($argi)))))"
                                         }
                                     } else {
                                             puts $fileid "    (add ($argi)))))"
                                     }
                             }
                     }
                 }
             }
   }
   close $fileid
}













