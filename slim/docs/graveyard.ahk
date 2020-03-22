
; ; Left hand numpad (Needs to be at the bottom)
; NumpadToggle := false
; CapsLock & BackSpace:: 
;   if(!NumpadToggle) 
;     ToolTip, NUMPAD MODE, 0, 0
;   Else 
;     ToolTip
  
;   NumpadToggle := !NumpadToggle
; return

; #If (NumpadToggle) ; if this variable has the value "true"
;   space::Numpad0
;   ,::Numpad1
;   .::Numpad2
;   /::Numpad3
;   k::Numpad4
;   l::Numpad5
;   ;::Numpad6
;   i::Numpad7
;   o::Numpad8
;   p::Numpad9

;   =::+
;   ]::*
;   [::/
; return

; ; --|