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

;------------Main Menu----------------
mainMenuOptions Byte "1.Deposit" ,0Dh, 0Ah,                     ;0Dh means carriage return
                     "2. Withdraw", 0Dh, 0Ah,                   ;0Ah means linefeed
                     "3. Check Balance", 0Dh, 0Ah,  
                     "4. Currency Conversion", 0Dh, 0Ah,
                     "5. Future Value Calculation", 0Dh, 0Ah,
                     "6. Rewards Points", 0Dh, 0Ah,
                     "7. Exit", 0Dh, 0Ah,
                     "Enter your choice: ", 0                   ;0 means null terminator, marking the end of the string 


;-------------Withdrawal---------------
promptWithdrawalAmount BYTE "Enter withdrawal amount: ", 0
notSufficientBalance BYTE "Insufficient balance amount.", 0

;---------------Balance----------------
currentBalance DWORD 10000; ;Example pf Initial Balance
showBalanceMessage BYTE "CurrentBalance: RM ", 0

;--------Future Value Calculation------
promptYealyDeposit BYTE "Enter regular yearly deposit: ",0
promptAnnualInterestRate BYTE "Enter annual interest rate (%): ", 0
promptNumYears BYTE "Enter number of years: ", 0
futureValueMessage BYTE "Future Value: RM ", 0

;------------Reward Points--------------
rewardPoints DWORD 0    ;Example of initial reward points
rewardPointsMessage BYTE "Reward Points: ", 0

;-------------Error Message-------------
errorMessage BYTE "Invalid option . Please try again .", 0

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
FutureValueCalculator PROTO

;----------Main----------

MAIN PROC
    
    call 

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

FutureValueCalculator PROC
    ; 1. Prompt for regular deposit
    mov edx, OFFSET promptYearlyDeposit         ; Load the address of the prompt message into EDX.
    call WriteString                            ; Display the prompt message.
    call ReadInt                                ; Read the yearly deposit amount from the user and store it in EAX.
    mov ebx, eax                                ; Move the yearly deposit amount from EAX to EBX (P).

    ; 2. Prompt for interest rate
    mov edx, OFFSET promptAnnualInterestRate    ; Load the address of the prompt message into EDX.
    call WriteString                            ; Display the prompt message.
    call ReadInt                                ; Read the annual interest rate from the user and store it in EAX.
    mov ecx, eax                                ; Move the interest rate from EAX to ECX (r).

    ; 3. Prompt for number of years
    mov edx, OFFSET promptNumYears              ; Load the address of the prompt message into EDX.
    call WriteString                            ; Display the prompt message.
    call ReadInt                                ; Read the number of years from the user and store it in EAX.
    mov edi, eax                                ; Move the number of years from EAX to EDI (n).

    ; 4. ---Future Value = P * (((1 + r)^n - 1) / r)---
    ;---P = yearly deposit, r = yearly interest rate (decimal), n = number of years---

    ; Convert r to decimal (r / 100)
    mov eax, ecx    ; Move the interest rate (r) into EAX.
    mov edx, 0      ; Clear EDX for division.
    mov esi, 100    ; Load 100 into ESI (for percentage calculation)  
    div esi         ; EAX = r / 100. (=0) 
    add eax, 100    ; Convert to (1 + r)   (EAX = 0 + 100 = 100) which means 1.00) --> Remainder store in EDX (100 + 7 = 107)
    mov ecx, eax    ; Store (1 + r) in ECX. (ECX = 100)

    ; Calculate (1 + r)^n
    mov eax, 100    ; Start with 100 (representing 1.00).
    mov ebp, edi    ; Move n (number of years) to EBP as the loop counter.  --> Use ebp to keep the original n 

powerLoop:
    mul ecx         ; Multiply the current result in EAX by (1 + r) (EAX = EAX * (1 + r)). (since cannot floating point number) (if r = 7 , then ecx = 107)
                    ; Multiply 100 for (107 *100) means when the index is 1  --> First loop (get the same thing)
    div esi         ; Divide the result by 100 (EAX = EAX / 100).  (Maintain correct scale)
    dec ebp         ; Decrease loop counter.    
    jnz powerLoop   ; If not equal to 0, continue looping.

    ; Subtract 1
    sub eax, 100    ; Subtract 100 from the result (EAX = (1 + r)^n - 1).

    ; Divide by r (handling division by zero)
    cmp ecx, 0          ; Check if r is zero.
    je divisionByZero   ; If r is zero, jump to the divisionByZero handler.
    mov edx, 0          ; Clear EDX before division.
    div ecx             ; Divide the result by r (EAX = ((1 + r)^n - 1) / r).

    jmp continueCalc    ; Jump to continueCalc to proceed with the next calculation.

divisionByZero:
    mov eax, 0          ; If r is zero, set EAX to 0.

continueCalc:
    ; Multiply by P
    mul ebx             ; Multiply the result by P (EAX = P * (((1 + r)^n - 1) / r)).

    ; --- Display Result ---
    mov edx, OFFSET futureValueMessage  ; Load the address of the output message into EDX.
    call WriteString                    ; Display the output message.
    call WriteDec                       ; Display the calculated future value (stored in EAX).
    call Crlf                           ; Print a newline character.

    ret                                 ; Return from the procedure.
FutureValueCalculator ENDP

END MAIN

