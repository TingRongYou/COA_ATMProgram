INCLUDE Irvine32.inc

.DATA
    welcomeMessage BYTE "+-----Welcome to PREMIER ATM SYSTEM!-----+", 0  

    ;Variable for getCCNum
    promptCard BYTE "Enter an 8-digit credit card number: ", 0
    userCardInput DWORD ?
    validCardInput DWORD 05100111
    validCCMessage BYTE ">>> Valid Credit Card!", 0
    invalidCCMessage BYTE ">>> Invalid Credit Card!", 0

    ;Variable for getPinNum
    promptPIN BYTE "Enter your PIN Number: ", 0
    userPinInput DWORD ?
    validPinInput DWORD 718111
    validPinMessage BYTE ">>> Valid PIN Number!", 0
    invalidPinMessage BYTE ">>> Invalid PIN Number!", 0

    ;Balance
    balanceMessage BYTE "Your account balance are: RM", 0
    balance DWORD 12345678 

    ;ContinueRequest
    continueMessage BYTE "Do you want to continue(y/n): ", 0
    continueOption BYTE ?

    ;PrintReceiptOption
    printRequestMessage BYTE "Do you want to print receipt(y/n): ", 0
    printOption BYTE ?
    
    

.CODE

;----------Functions Prototype----------

PrintWelcome PROTO
GetCCNum PROTO
GetPinNum PROTO
CheckBalance PROTO
ContinueRequest PROTO
PrintReceiptOption PROTO

;----------Main----------

MAIN PROC

    call PrintReceiptOption
    call ContinueRequest

    call PrintWelcome
    call GetCCNum
    call GetPinNum
    call CheckBalance

    call ExitProcess         
MAIN ENDP

;----------Functions----------

PrintWelcome PROC
    mov edx, OFFSET welcomeMessage  ; Load address of welcome message into EDX
    call WriteString                ; Print the message
    call Crlf
    call Crlf
    ret
PrintWelcome ENDP

GetCCNum PROC
creditCardLoop:
    mov edx, OFFSET promptCard
    call WriteString

    call ReadInt                    ; Read credit card number
    mov userCardInput, eax          ; Store credit card number from eax to variable

    cmp eax, validCardInput         ; Compare user credit card number with valid credit card number
    je isValidCC                    ; Jump to 'isValidCC' label if equal

    mov edx, OFFSET invalidCCMessage
    call writeString
    call Crlf
    call Crlf
    jmp creditCardLoop              ; Loop again if credit card number entered is invalid

isValidCC: 
    mov edx, OFFSET validCCMessage
    call writeString
    call Crlf
    call Crlf
    ret
GetCCNum ENDP

GetPinNum PROC
pinLoop:
    mov edx, OFFSET promptPin
    call WriteString

    call ReadInt
    mov userPinInput, eax

    cmp eax, validPinInput
    je isValidPin                   ;jump to 'isValidPin' label if equal

    mov edx, OFFSET invalidPinMessage
    call writeString
    call Crlf
    call Crlf
    jmp pinLoop

isValidPin: 
    mov edx, OFFSET validPinMessage
    call writeString
    call Crlf
    call Crlf
    ret
GetPinNum ENDP

CheckBalance PROC
    mov edx, OFFSET balanceMessage
    call writeString
    mov eax, balance
    call writeDec
    ret
CheckBalance ENDP

ContinueRequest PROC
    mov edx, OFFSET continueMessage
    call writeString

    call readChar
    mov continueOption, al

    call writeChar
    call Crlf

    ret
ContinueRequest ENDP

PrintReceiptOption PROC
    mov edx, OFFSET printRequestMessage
    call writeString

    call readChar
    mov printOption, al

    call writeChar
    call Crlf

    ret
PrintReceiptOption ENDP

END MAIN

