INCLUDE Irvine32.inc

.DATA
    ;-----------Welcome & Exit Message-----------
    welcomeMessage BYTE "+-----Welcome to PREMIER ATM SYSTEM!-----+", 0  
    exitMessage BYTE "+-----Thanks for using PREMIER ATM SYSTEM, have a nice day!-----+", 0

    ;-----------Variable for GetCardNum------------
    promptCard1 BYTE "Enter first 8-digit credit card number: ", 0
    promptCard2 BYTE "Enter second 8-digit credit card number: ", 0
    userCardInput1 DWORD ?
    userCardInput2 DWORD ?
    validCardInput1 DWORD 11112222
    validCardInput2 DWORD 33334444
    validCCMessage BYTE ">>> Valid Credit Card!", 0
    invalidCCMessage BYTE ">>> Invalid Credit Card!", 0

    ;-----------Variable for GetPinNum------------
    promptPin BYTE "Enter your PIN Number: ", 0
    userPinInput DWORD ?
    validPinInput DWORD 718111
    validPinMessage BYTE ">>> Valid PIN Number!", 0
    invalidPinMessage BYTE ">>> Invalid PIN Number!", 0

    ;------------Main Menu-------------
    mainMenuOptions BYTE ">>> Access Granted! Please enjoy using our system!", 0Dh, 0Ah
                    BYTE "+---------Main Menu---------+", 0Dh, 0Ah
                    BYTE "1. Deposit", 0Dh, 0Ah                     ;0Dh means carriage return
                    BYTE "2. Withdraw", 0Dh, 0Ah                   ;0Ah means linefeed
                    BYTE "3. Check Balance", 0Dh, 0Ah  
                    BYTE "4. Currency Conversion", 0Dh, 0Ah
                    BYTE "5. Future Value Calculation", 0Dh, 0Ah
                    BYTE "6. Rewards", 0Dh, 0Ah
                    BYTE "7. Exit", 0Dh, 0Ah, 0                   ;0 means null terminator, marking the end of the string 

    ;------------Handle Main Menu Choice----------
    mainMenuMessage BYTE "Enter your choice(1-7): ", 0
    mainMenuChoice DWORD ?

    ;-------------Withdrawal---------------
    withdrawTitle BYTE "+---------Money Withdrawal---------+", 0
    promptWithdrawalAmount BYTE "Enter withdrawal amount: ", 0
    notSufficientBalance BYTE ">>> Insufficient balance amount! Please Enter again", 0
    confirmWithdraw BYTE "Confirm Withdrawal (Y/N)? ", 0
    invalidWithdrawMessage BYTE ">>> Invalid withdrawal amount. Please enter a positive value.", 0

    ;--------Future Value Calculation------
    futureValueCalTitle BYTE "+---------Future Value Calculator---------+", 0
    promptDeposit     BYTE "Enter yearly regular deposit (RM): ", 0
    promptRate        BYTE "Enter annual interest rate (%) [1% / 2% ...] : ", 0
    promptYears       BYTE "Enter number of years: ", 0
    resultMsg         BYTE ">>> Future Value: RM ", 0
    overflowMessage   BYTE ">>> Overflow Error! Result too large.", 0

    deposit           DWORD ?         ; Yearly deposit (P)
    interestRate      DWORD ?         ; Interest rate (as a whole number, e.g., 5 for 5%)
    years             DWORD ?         ; Number of years (n)
    futureValue       DWORD 0         ; Final accumulated amount (FV) in sen
    oneHundred        DWORD 100       ; Scaling factor for percentage calculations
    oneThousand       DWORD 1000      ; More precise scaling factor for division

    ;-------------Error Message-------------
    errorMessage BYTE ">>> Invalid option, Please try again!", 0

    ;-------------Balance-------------
    checkBalanceTitle BYTE "+---------Check Balance---------+", 0
    balanceMessage BYTE ">>> Your current account balance are: RM", 0
    balance DWORD 12345678 

    ;-------------Continue?-------------
    continueMessage BYTE "Do you want to continue(y/n)?: ", 0
    continueOption BYTE ?

    ;-------------Print Receipt?-------------
    printRequestMessage BYTE "Do you want to print receipt(y/n)?: ", 0
    printOption BYTE ?

    ;-------------Receipt-------------
    receiptHeader BYTE "+--------------------------+", 0Dh, 0Ah
                 BYTE "   PREMIER ATM RECEIPT", 0Dh, 0Ah
                 BYTE "+--------------------------+", 0

    receiptDeposit BYTE "Money Deposited: RM", 0
    DepositTotal DWORD 0

    receiptWithdraw BYTE "Money Withdrawed: RM", 0
    WithdrawTotal DWORD 0

    receiptBalance BYTE "Balance: RM", 0

    receiptFooter BYTE "+--------------------------+", 0

    ;-------------Reperform Any Function?-------------
    redoMessage BYTE "Do you want to perform any other functions(y/n)?: ", 0
    redoOption BYTE ?

    ;-------------Deposit-------------
    depositTitle BYTE "+---------Money Deposit---------+", 0
    getDeposit BYTE "Enter amount to deposit: ", 0
    confirmDeposit BYTE "Confirm deposit (Y/N)? ", 0
    invalidDepositMessage BYTE ">>> Invalid deposit amount. Please enter a positive value.", 0
    depositAmount DWORD 0         ; Stores deposit amount entered by user

    ;-------------Currency-------------
    currecnyTitle BYTE "+---------Currency Conversion---------+", 0
    ; Currency Selection
    currencyMenu BYTE "Select Currency:", 0
    option1 BYTE "1 - USD", 0
    option2 BYTE "2 - EUR", 0
    option3 BYTE "3 - GBP", 0
    option4 BYTE "4 - JPY", 0
    option5 BYTE "5 - AUD", 0
    option6 BYTE "6 - CAD", 0
    option7 BYTE "7 - CHF", 0
    
    promptCurrency BYTE "Enter your choice (1-7): ", 0
    selectedCurrency DWORD ?

    ; Withdrawal Amount
    promptAmount BYTE "Enter withdrawal amount: ", 0
    withdrawalAmount DWORD ?
    
    ; Exchange Rates (Relative to Local Currency)
    rateUSD REAL4 1.0
    rateEUR REAL4 0.92
    rateGBP REAL4 0.78
    rateJPY REAL4 110.5
    rateAUD REAL4 1.45
    rateCAD REAL4 1.35
    rateCHF REAL4 0.92

    finalAmount REAL4 ?

    ;-------------Reward-------------
    rewardTitle BYTE "+---------Reward Points---------+", 0
    rewardRate DWORD 5
    conversionFactor DWORD 10
    rewardPoints DWORD 0
    rewardPointsMessage BYTE "Reward Points: ", 0
    points BYTE " points", 0

    ;-------------Reward Menu-------------
    rewardMenu BYTE  "+---------Reward Menu---------+", 0Dh, 0Ah
                    BYTE "1. Redeem Points", 0Dh, 0Ah                     ;0Dh means carriage return
                    BYTE "2. Estimate Future Points", 0Dh, 0Ah                   ;0Ah means linefeed
                    BYTE "3. Back", 0Dh, 0Ah 
                    BYTE "4. Exit", 0Dh, 0Ah, 0       
    rewardMenuMsg BYTE "Enter your choice(1-4): ", 0
    rewardMenuChoice DWORD ?

    ;-------------Reward Points Menu-------------
    redeemPointsMenu BYTE  "+---------Redeem Points---------+", 0Dh, 0Ah
                    BYTE "1. Point to Money (10 points needed)", 0Dh, 0Ah                     ;0Dh means carriage return
                    BYTE "2. Voucher Code (30 points needed)", 0Dh, 0Ah                   ;0Ah means linefeed
                    BYTE "3. Back", 0Dh, 0Ah                   
                    BYTE "4. Exit", 0Dh, 0Ah, 0 
    redeemPointsMsg BYTE "Enter your choice(1-4): ", 0
    redeemPointChoice DWORD ?
    confirmRedeemMoney BYTE "Confirm redeeming points for money (Y/N)? ", 0
    moneyRedeemSuccess BYTE ">>> Points redeemed successfully! Money credited to your account.", 0
    moneyRedeemMsg BYTE ">>> Money redeemed: RM", 0
    rewardPointsDeducted BYTE ">>> Points deducted: ", 0
    moneyRedeemAmount DWORD 0
    extraPointMsg1 BYTE ">>> Extra ", 0
    extraPointMsg2 BYTE " points has be returned.", 0

    ;-------------PointToMoney-------------
    PointToMoneyMsg BYTE "How many points do you want to redeem?: ", 0
    PointToMoneyAmount DWORD ?
    leftoverPoints DWORD 0
    insufficientRewardPoint BYTE ">>> Insufficient reward point. Please try again.", 0

    ;-------------Voucher Code-------------
    voucherCodeMenu BYTE  "+---------Voucher Code---------+", 0Dh, 0Ah
                    BYTE "1. BACX2033 (Discount 30%)", 0Dh, 0Ah                     ;0Dh means carriage return
                    BYTE "2. BADX3033 (Discount 30%)", 0Dh, 0Ah                   ;0Ah means linefeed
                    BYTE "3. BAJG1020 (CashBack RM10)", 0Dh, 0Ah       
                    BYTE "4. Back", 0Dh, 0Ah
                    BYTE "5. Exit", 0Dh, 0Ah, 0 

    voucherCodeMsg BYTE "Enter your choice(1-5): ", 0
    voucherCodeChoice DWORD ?
    voucherRedeemSuccess BYTE ">>> Voucher code redeemed successfully!", 0
    voucherCode1 BYTE ">>> Voucher code: BACX2033 (Discount 30%)", 0
    voucherCode2 BYTE ">>> Voucher code: BADX3033 (Discount 30%)", 0
    voucherCode3 BYTE ">>> Voucher code: BAJG1020 (CashBack RM10)", 0
    confirmVoucher BYTE "Confirm voucher code (Y/N)? ", 0

    ;-------------Points Estimation-------------
    futureEstimateTitle   BYTE "+---------Future Reward Estimator---------+", 0
    promptMonthlyDeposit  BYTE "Enter estimated monthly deposit (RM): ", 0
    promptMonths          BYTE "Enter number of months: ", 0
    estimatedPointsMsg             BYTE ">>> Estimated reward points after that period: ", 0

    monthlyDeposit        DWORD ?
    numberOfMonths        DWORD ?
    estimatedPoints       DWORD ?


.CODE

;----------Functions Prototype----------
PrintWelcome PROTO
GetCCNum PROTO
GetPinNum PROTO
CheckBalance PROTO
ContinueRequest PROTO
PrintReceiptOption PROTO
FutureValueCalculator PROTO
DepositMoney PROTO 
DisplayMainMenu PROTO
RePerformFunction PROTO
QuitProgram PROTO

;----------Main----------
MAIN PROC
    call PrintWelcome
    call GetCardNum
    call GetPinNum
    call DisplayMainMenu

    EXIT         
MAIN ENDP

;----------Functions----------
;----------Print Welcome Message----------
PrintWelcome PROC
    mov edx, OFFSET welcomeMessage  ; Load address of welcome message into EDX
    call WriteString                ; Print the message
    call Crlf
    call Crlf
    ret
PrintWelcome ENDP

;----------Get Credit Card Number----------
GetCardNum PROC

    mov edx, OFFSET promptCard1
    call WriteString
    call ReadInt                    ; Read credit card number
    mov userCardInput1, eax          ; Store credit card number from eax to variable

    mov edx, OFFSET promptCard2
    call WriteString
    call readInt
    mov userCardInput2, eax

    mov eax, userCardInput1
    mov ebx, validCardInput1
    cmp eax, ebx         ; Compare user credit card number with valid credit card number
    jne InvalidCard                    ; Jump to 'isValidCC' label if equal
   
    mov eax, userCardInput2
    mov ebx, validCardInput2
    cmp eax, ebx 
    jne InvalidCard

    mov edx, OFFSET validCCMessage
    call writeString
    call Crlf
    call Crlf
    ret
                
InvalidCard: 
    mov edx, OFFSET invalidCCMessage
    call writeString
    call Crlf
    call Crlf
    jmp GetCardNum  ; Loop again if credit card number entered is invalid
    
GetCardNum ENDP

;----------Get Credit Card Pin Number----------
GetPinNum PROC
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
    jmp getPinNum

isValidPin: 
    mov edx, OFFSET validPinMessage
    call writeString
    call Crlf
    call Crlf
    ret
GetPinNum ENDP

;----------Display Main Menu-----------
DisplayMainMenu PROC
    call Clrscr
    mov edx, OFFSET mainMenuOptions
    call writeString
    call HandleMainMenu
    ret
DisplayMainMenu ENDP

HandleMainMenu PROC
    ; Display main menu message
    mov edx, OFFSET mainMenuMessage
    call WriteString

    ; Read user input
    call ReadInt
    mov mainMenuChoice, eax

    ; Handle valid options
    cmp mainMenuChoice, 1
    je DepositMoney

    cmp mainMenuChoice, 2
    je WithdrawMoney
    
    cmp mainMenuChoice, 3
    je CheckBalance

    cmp mainMenuChoice, 4
    je CurrencyConversion

    cmp mainMenuChoice, 5
    je FutureValueCalculator

    cmp mainMenuChoice, 6
    je Reward

    cmp mainMenuChoice, 7
    je QuitProgram

; Invalid input - display error and return to menu
InvalidInput:
    mov edx, OFFSET errorMessage
    call WriteString
    call Crlf
    call Crlf
    jmp HandleMainMenu   ; Loop back to re-display the menu

    ret
HandleMainMenu ENDP


;----------Deposit----------
DepositMoney PROC
    call Clrscr

    mov edx, OFFSET depositTitle
    call WriteString

    call Crlf
    call CheckBalance

depositLoop:
    call Crlf
    mov edx, OFFSET getDeposit
    call WriteString

    call ReadInt
    mov ecx, 100
    mul ecx                ; EAX = withdrawal * 100 (in cents)
    mov depositAmount, eax

    cmp eax, 0
    jle invalidDeposit  ; If deposit is <= 0, prompt again

makeConfirmationDeposit:
    mov edx, OFFSET confirmDeposit
    call WriteString

    ; Read user input (confirmation)
    call ReadChar
    or al, 32                 ; Convert to lowercase (handles 'Y' and 'y')
    call WriteChar            ; Echo the character

    cmp al, 'y'
    je updateBalance          ; If 'y', proceed to update balance

    call Crlf

    cmp al, 'n'
    je NotConfirmDeposit            ; If 'n', return to deposit loop

    ; Invalid input, re-prompt
    mov edx, OFFSET errorMessage
    call WriteString
    jmp makeConfirmationDeposit

invalidDeposit:
    mov edx, OFFSET invalidDepositMessage
    call WriteString
    call Crlf
    jmp depositLoop

updateBalance:
    ; === Step 1: Separate RM and cent portion ===
    mov eax, balance         ; Load current balance (in cents)

    ; === Step 2: Add deposit amount (whole RM only) ===
    add eax, depositAmount   ; Add deposit amount (RM only)

    ; Store the updated balance
    mov balance, eax

    call Crlf
    call Crlf

        ; Convert depositAmount (in cents) to RM using EAX
    mov eax, depositAmount     ; Load deposit amount (in cents)
    mov ecx, 100
    xor edx, edx               ; Clear upper part for division
    div ecx                    ; EAX = RM part, EDX = remaining cents

    ; Add RM value to depositTotal
    add depositTotal, eax      ; Update depositTotal (in RM)

    ; === Calculate Reward Points ===
    ; rewardPoints = (depositTotal * rewardRate) / conversionFactor

    mov eax, depositTotal       ; EAX = deposit RM
    mul rewardRate        ; EAX = deposit RM * rewardRate
    div conversionFactor        ; EAX = reward points
    mov rewardPoints, eax       ; Store reward points

    ; === Step 4: Display updated balance message ===
    mov edx, OFFSET balanceMessage
    call WriteString

    mov eax, balance
    mov ecx, 100
    xor edx, edx
    div ecx                ; EAX = integer part (RM), EDX = cents

    ; Print integer part (RM)
    call WriteDec

    ; Print decimal point and cents
    mov al, '.'
    call WriteChar
    mov eax, edx
    cmp eax, 9
    jg printCents
    mov al, '0'
    call WriteChar

printCents:
    call WriteDec

NotConfirmDeposit:
    ; Continue with next operation
    call ContinueRequest

ValidateContinueInput:
    ; Handle 'Y' or 'y'
    mov al, byte ptr [continueOption] ; Load continueOption into AL
    or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
    cmp al, 'y'
    je depositLoop                     ; If 'y' (or 'Y'), go to depositLoop

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je PrintReceiptRequest              ; If 'n' (or 'N'), go to PrintReceiptRequest

    ; Invalid input, prompt again
    mov edx, OFFSET errorMessage     ; Load invalid input message
    call WriteString                    ; Display invalid input message
    jmp NotConfirmDeposit               ; Loop back and prompt again

PrintReceiptRequest:
    call PrintReceiptOption

ValidatePrintReceiptInput:
    ; Handle 'Y' or 'y' for receipt
    mov al, byte ptr [PrintOption] ; Load PrintReceiptOption into AL
    or al, 32
    cmp al, 'y'
    je PrintDepositReceipt
    
    ; Handle 'N' or 'n' for skipping receipt
    mov al, byte ptr [PrintOption] ; Load PrintReceiptOption into AL
    or al, 32
    cmp al, 'n'
    je ChooseAnotherFunction

    ; Invalid input, prompt again
    mov edx, OFFSET errorMessage     ; Load invalid input message
    call WriteString                    ; Display invalid input message
    jmp PrintReceiptRequest               ; Loop back and prompt again

PrintDepositReceipt:
    call ClrScr              ; Clear the screen for a fresh receipt 

    call Crlf

    ; Print receipt header
    mov edx, OFFSET receiptHeader
    call WriteString

    call Crlf

    ; Indicate deposit
    mov edx, OFFSET receiptDeposit
    call WriteString

    ; Display deposit amount
    mov eax, depositTotal
    call WriteDec

    call Crlf

    ; Print current balance label
    mov edx, OFFSET receiptBalance
    call WriteString

    ; Display current balance (in RM.cents format)
    mov eax, balance
    mov ebx, 100
    xor edx, edx
    div ebx                  ; EAX = RM, EDX = cents

    ; Display RM portion
    call WriteDec

    ; Display decimal point
    mov al, '.'
    call WriteChar

    ; Ensure two-digit cents display (e.g., 05 instead of 5)
    cmp edx, 10
    jge printDepositCents
    mov al, '0'
    call WriteChar

printDepositCents:
    mov eax, edx
    call WriteDec
    call Crlf
    mov edx, OFFSET receiptFooter
    call WriteString
    call Crlf                ; New line after balance

    mov depositTotal, 0

ChooseAnotherFunction:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

ValidateAnotherFuncInput:
   ; Invalid input, prompt again
    mov edx, OFFSET errorMessage     ; Load invalid input message
    call WriteString                    ; Display invalid input message
    jmp ChooseAnotherFunction               ; Loop back and prompt again

    ret
DepositMoney ENDP

;----------Withdraw----------
WithdrawMoney PROC
    call Clrscr

    mov edx, OFFSET withdrawTitle
    call WriteString

    call Crlf

    call CheckBalance


CheckAndWithdraw:
    call Crlf
    ; Prompt user for withdrawal amount
    mov edx, OFFSET promptWithdrawalAmount
    call WriteString

    ; Read the withdrawal amount (in RM)
    call ReadInt
    mov ebx, eax           ; Store withdrawal amount in EBX

    cmp eax, 0
    jl invalidWithdrawal

makeConfirmationWithdrawal:
    mov edx, OFFSET confirmWithdraw
    call WriteString

    ; Read user input (confirmation)
    call ReadChar
    or al, 32                 ; Convert to lowercase (handles 'Y' and 'y')
    call WriteChar            ; Echo the character

    cmp al, 'y'
    je UpdateBalance          ; If 'y', proceed to update balance

    call Crlf

    cmp al, 'n'
    je CheckAndWithdraw            ; If 'n', return to deposit loop

    ; Invalid input, re-prompt
    mov edx, OFFSET errorMessage
    call WriteString
    jmp makeConfirmationWithdrawal

invalidWithdrawal:
    mov edx, OFFSET invalidWithdrawMessage
    call WriteString
    call Crlf
    jmp CheckAndWithdraw

UpdateBalance:
    add withdrawTotal, eax

    ; Convert withdrawal to cents (multiply by 100)
    mov eax, ebx
    mov ecx, 100
    mul ecx                ; EAX = withdrawal * 100 (in cents)

    ; Check if withdrawal exceeds balance
    cmp eax, balance
    jg InsufficientFunds   ; If withdrawal > balance, jump to error message

    ; Subtract withdrawal from balance
    sub balance, eax

    call Crlf
    call Crlf

    ; Display updated balance
    mov edx, OFFSET balanceMessage
    call WriteString

    mov eax, balance
    mov ecx, 100
    xor edx, edx
    div ecx                ; EAX = integer part (RM), EDX = cents

    ; Print integer part (RM)
    call WriteDec

    ; Print decimal point and cents
    mov al, '.'
    call WriteChar
    mov eax, edx
    cmp eax, 9
    jg printCents
    mov al, '0'
    call WriteChar

printCents:
    call WriteDec

NotConfirmWithdraw:
    call ContinueRequest

ValidateContinueInput:
    ; Handle 'Y' or 'y'
    mov al, byte ptr [continueOption] ; Load continueOption into AL
    or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
    cmp al, 'y'
    je CheckAndWithdraw                 ; If 'y' (or 'Y'), go to CheckAndWithdraw

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je PrintReceiptRequest              ; If 'n' (or 'N'), go to PrintReceiptRequest

    ; Invalid input, prompt again
    mov edx, OFFSET errorMessage     ; Load invalid input message
    call WriteString                    ; Display invalid input message
    jmp NotConfirmWithdraw               ; Loop back and prompt again

PrintReceiptRequest:
    call PrintReceiptOption    ; Display the receipt prompt

    ; Handle 'Y' or 'y' for receipt
    mov al, byte ptr [PrintOption] ; Load PrintReceiptOption into AL
    or al, 32
    cmp al, 'y'
    je PrintWithdrawalReceipt
    
    ; Handle 'N' or 'n' for skipping receipt
    mov al, byte ptr [PrintOption] ; Load PrintReceiptOption into AL
    or al, 32
    cmp al, 'n'
    je ChooseAnotherFunction

    ; Invalid input, prompt again
    mov edx, OFFSET errorMessage     ; Load invalid input message
    call WriteString                    ; Display invalid input message
    jmp PrintReceiptRequest               ; Loop back and prompt 

PrintWithdrawalReceipt:
    call ClrScr              ; Clear the screen for a fresh receipt view

    ; Print receipt header
    mov edx, OFFSET receiptHeader
    call WriteString

    call Crlf

    ; Indicate deposit
    mov edx, OFFSET receiptWithdraw
    call WriteString

    ; Display deposit amount
    mov eax, WithdrawTotal
    call WriteDec

    call Crlf

    ; Print current balance label
    mov edx, OFFSET receiptBalance
    call WriteString

    ; Display current balance (in RM.cents format)
    mov eax, balance
    mov ebx, 100
    xor edx, edx
    div ebx                  ; EAX = RM, EDX = cents

    ; Display RM portion
    call WriteDec

    ; Display decimal point
    mov al, '.'
    call WriteChar

    ; Ensure two-digit cents display (e.g., 05 instead of 5)
    cmp edx, 10
    jge printWithdrawalCents
    mov al, '0'
    call WriteChar

printWithdrawalCents:
    mov eax, edx
    call WriteDec
    call Crlf
    mov edx, OFFSET receiptFooter
    call WriteString
    call Crlf                ; New line after balance

    mov withdrawTotal, 0

ChooseAnotherFunction:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

    ; Invalid input, prompt again
    mov edx, OFFSET errorMessage     ; Load invalid input message
    call WriteString                    ; Display invalid input message
    jmp ChooseAnotherFunction               ; Loop back and prompt again

InsufficientFunds:
    mov edx, OFFSET notSufficientBalance
    call WriteString
    call Crlf
    call Crlf
    jmp CheckAndWithdraw

WithdrawMoney ENDP

;----------Check Balance----------
CheckBalance PROC

    mov eax, mainMenuChoice
    cmp eax, 3
    jne SkipCheckBalance

    call ClrScr

    mov edx, OFFSET checkBalanceTitle
    call writeString

    call Crlf

SkipCheckBalance:
    mov edx, OFFSET balanceMessage
    call writeString
        ; Print integer part (balance / 100)

    mov eax, balance
    mov ebx, 100
    xor edx, edx       ; Clear edx for division
    div ebx            ; EAX = balance / 100, EDX = balance % 100

    call WriteDec      ; Print whole number (RM part)

    ; Print decimal point
    mov al, '.'
    call WriteChar

    ; Print the decimal part (EDX contains cents)
    mov eax, edx
    cmp eax, 9         ; Ensure two-digit display (e.g., 05 instead of 5)
    jg printCents
    mov al, '0'        ; Print leading zero for values < 10
    call WriteChar

printCents:
    call WriteDec      ; Print cents

    call Crlf

    cmp mainMenuChoice, 3 
    je RequestReperform

    cmp mainMenuChoice, 3
    jne ExitCheckBalance

    cmp mainMenuChoice, 1
    jne ExitCheckBalance

RequestReperform:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

ExitCheckBalance:
    ret
CheckBalance ENDP

;----------Currency Conversion----------
CurrencyConversion PROC
    call ChooseCurrency
    call GetWithdrawalAmount
    call ConvertCurrency
    call DisplayFinalAmount
CurrencyConversion ENDP

ChooseCurrency PROC
    call ClrScr
    mov edx, OFFSET currecnyTitle
    call WriteString
    call Crlf
    call Crlf
    mov edx, OFFSET currencyMenu
    call WriteString
    call Crlf

    mov edx, OFFSET option1
    call WriteString
    call Crlf

    mov edx, OFFSET option2
    call WriteString
    call Crlf

    mov edx, OFFSET option3
    call WriteString
    call Crlf

    mov edx, OFFSET option4
    call WriteString
    call Crlf

    mov edx, OFFSET option5
    call WriteString
    call Crlf

    mov edx, OFFSET option6
    call WriteString
    call Crlf

    mov edx, OFFSET option7
    call WriteString
    call Crlf

    mov edx, OFFSET promptCurrency
    call WriteString
    call ReadInt
    mov selectedCurrency, eax

    ret
ChooseCurrency ENDP

GetWithdrawalAmount PROC
    mov edx, OFFSET promptAmount
    call WriteString
    call ReadInt
    mov withdrawalAmount, eax
    ret
GetWithdrawalAmount ENDP

ConvertCurrency PROC
    finit  ; Initialize floating-point operations

    mov eax, withdrawalAmount
    push eax
    fild DWORD PTR [esp]  ; Load integer amount as float
    pop eax

    cmp selectedCurrency, 1
    je convertUSD
    cmp selectedCurrency, 2
    je convertEUR
    cmp selectedCurrency, 3
    je convertGBP
    cmp selectedCurrency, 4
    je convertJPY
    cmp selectedCurrency, 5
    je convertAUD
    cmp selectedCurrency, 6
    je convertCAD
    cmp selectedCurrency, 7
    je convertCHF

convertUSD:
    fmul rateUSD
    jmp storeResult

convertEUR:
    fmul rateEUR
    jmp storeResult

convertGBP:
    fmul rateGBP
    jmp storeResult

convertJPY:
    fmul rateJPY
    jmp storeResult

convertAUD:
    fmul rateAUD
    jmp storeResult

convertCAD:
    fmul rateCAD
    jmp storeResult

convertCHF:
    fmul rateCHF

storeResult:
    fstp finalAmount  ; Store the final converted amount
    ret
ConvertCurrency ENDP

DisplayFinalAmount PROC
    mov edx, OFFSET finalAmount
    call WriteFloat  ; Display converted amount
    call Crlf
    ret
DisplayFinalAmount ENDP

;----------Future Value Calculation----------
FutureValueCalculator PROC

    call ClrScr

    mov edx, OFFSET futureValueCalTitle
    call WriteString

    call Crlf
    call Crlf

    ; Get Deposit Amount (in RM)
    mov edx, OFFSET promptDeposit
    call WriteString
    call ReadInt        ; Integer because deposit money is only 
    mov deposit, eax    ; Store deposit (in RM)

    ; Get Interest Rate (as a whole number percentage)
    mov edx, OFFSET promptRate
    call WriteString
    call ReadInt
    mov interestRate, eax    ; Store interest rate

    ; Get Number of Years
    mov edx, OFFSET promptYears
    call WriteString
    call ReadInt
    mov years, eax    ; Store number of years

    ; Convert deposit to sen (1 RM = 100 sen)
    mov eax, deposit
    imul eax, oneHundred    ; Convert deposit to sen --> Signed Multiplication (Avoid Overflow)
    mov deposit, eax        ; Store the deposit in sen

    ; Initialize Future Value in sen (starting with 0)
    mov futureValue, 0

    ; Loop to compute FV using corrected compound interest formula
    mov ecx, years    ; Set the loop counter to the number of years

first_year:
    ; First Year - Only add deposit (No Interest Applied)
    mov eax, deposit
    add futureValue, eax
    loop after_first_year  ; Skip interest calculation for the first year --> The loop instruction decrements ecx by 1.

after_first_year: ; No interest calculation at here

calc_loop:
    cmp ecx, 0
    je display_result ; Exit loop if years == 0

    ; Step 1: Apply interest BEFORE adding deposit
    mov eax, futureValue
    mov edx, 0            
    imul eax, interestRate    ; Multiply FV by interestRate
    mov edx, 0               
    idiv oneHundred          ; Divide by 100 for proper scaling --> Signed Division (Avoid Overflow)

    ; Step 2: Add computed interest to FV
    add futureValue, eax

    ; Step 3: Add deposit (new yearly deposit in sen)
    mov eax, deposit
    add futureValue, eax

    ; Check for overflow before continuing
    jnc continueLoop    ;jump if no carry
    mov edx, OFFSET overflowMessage
    call WriteString
    jmp endProgram

continueLoop:
    loop calc_loop    ; Decrement the year counter and repeat the loop

display_result:
    ; --- Display Future Value in RM and Sen ---
    call Crlf
    mov edx, OFFSET resultMsg
    call WriteString

    ; Convert future value from sen to RM and sen
    mov eax, futureValue
    mov edx, 0
    div oneHundred    ; EAX = RM, EDX = sen

    ; Display RM part
    call WriteDec
    mov al, '.'    ; Print decimal point
    call WriteChar

    ; Display Sen part (ensure two digits)
    mov eax, edx    ; Move sen to EAX (remainder store in edx)
    cmp eax, 10    ; If less than 10, add leading zero) (5sen become .05)
    jae print_sen   ;(>= 10, proceed to print_sen)
    mov al, '0'     ; add trailing zero
    call WriteChar

print_sen:
    call WriteDec

    call ContinueRequest

    ; Handle 'Y' or 'y'
    mov al, byte ptr [continueOption] ; Load continueOption into AL
    or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
    cmp al, 'y'
    je FutureValueCalculator                 ; If 'y' (or 'Y'), go to CheckAndWithdraw

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je ChooseAnotherFunction              ; If 'n' (or 'N'), go to PrintReceiptRequest

ChooseAnotherFunction:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

endProgram:
    exit

FutureValueCalculator ENDP

;----------Reward Points----------
Reward PROC

    call ClrScr

RewardMenuLoop:

    mov edx, OFFSET rewardTitle
    call writeString

    call Crlf

    mov edx, OFFSET rewardPointsMessage
    call writeString

    mov eax, rewardPoints
    call writeDec

    mov edx, OFFSET points
    call writeString

    call Crlf
    call Crlf

    mov edx, OFFSET rewardMenu
    call writeString

    mov edx, OFFSET rewardMenuMsg
    call writeString

    call readInt

    mov rewardMenuChoice, eax

    cmp rewardMenuChoice, 1
    je RedeemPoints

    cmp rewardMenuChoice, 2
    je EstimateFutureRewards

    cmp rewardMenuChoice, 3
    je DisplayMainMenu

    cmp rewardMenuChoice, 4
    je QuitProgram

InvalidInput:
    mov edx, OFFSET errorMessage
    call WriteString
    call Crlf
    call Crlf
    jmp RewardMenuLoop   ; Loop back to re-display the menu

    call Crlf

RequestReperform:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

    ret
Reward ENDP

RedeemPoints PROC

    call ClrScr

RedeemMenuLoop:
    mov edx, OFFSET redeemPointsMenu
    call writeString

    mov edx, OFFSET redeemPointsMsg
    call writeString

    call ReadInt
    mov redeemPointChoice, eax

    cmp redeemPointChoice, 1 
    je pointToMoney

    cmp redeemPointChoice, 2
    je redeemVoucherCode

    cmp redeemPointChoice, 3
    je Reward

    cmp redeemPointChoice, 4
    je QuitProgram

InvalidRedeemPointChoice:
    mov edx, OFFSET errorMessage
    call WriteString
    call Crlf
    call Crlf
    jmp RedeemMenuLoop   ; Loop back to re-display the menu

pointToMoney:

    call Crlf

getRedeemPointsLoop:
    mov edx, OFFSET pointToMoneyMsg
    call writeString

    call ReadInt
    mov pointToMoneyAmount, eax

    mov eax, rewardPoints

    cmp pointToMoneyAmount, eax
    jbe makeConfirmationRedeemMoney

    mov edx, OFFSET insufficientRewardPoint
    call writeString
    call Crlf
    call Crlf
    jmp getRedeemPointsLoop

makeConfirmationRedeemMoney:
    mov edx, OFFSET confirmRedeemMoney
    call WriteString

    ; Read user input (confirmation)
    call ReadChar
    or al, 32                 ; Convert to lowercase (handles 'Y' and 'y')
    call WriteChar            ; Echo the character

    cmp al, 'y'
    je DeductRewardPoints          ; If 'y', proceed to update balance

    call Crlf

    cmp al, 'n'
    je NotConfirmRedeemMoney           ; If 'n', return to deposit loop

    ; Invalid input, re-prompt
    mov edx, OFFSET errorMessage
    call WriteString
    jmp makeConfirmationRedeemMoney

DeductRewardPoints:
    mov eax, pointToMoneyAmount
    mov ecx, 10
    xor edx, edx
    div ecx                ; EAX = pointToCash / 10, EDX = pointToCash % 10
    mov moneyRedeemAmount, eax
    mov leftoverPoints, edx 
    mov ecx, 100
    mul ecx
    add balance, eax

    mov eax, rewardPoints
    add eax, leftoverPoints
    mov rewardPoints, eax

    mov eax, rewardPoints
    add eax, edx
    mov rewardPoints, eax

    mov eax, rewardPoints
    sub eax, pointToMoneyAmount
    mov rewardPoints, eax

    call Crlf

    mov edx, OFFSET moneyRedeemSuccess
    call writeString

    call Crlf

    mov edx, OFFSET moneyRedeemMsg
    call writeString
    mov eax, moneyRedeemAmount
    call writeDec
    call Crlf
    mov edx, OFFSET rewardPointsDeducted
    call writeString
    mov eax, pointToMoneyAmount
    sub eax, leftoverPoints
    call writeDec
    mov edx, OFFSET points
    call writeString

    call Crlf

    mov edx, OFFSET extraPointMsg1
    call writeString
    mov eax, leftoverPoints
    call writeDec
    mov edx, OFFSET extraPointMsg2
    call writeString

    jmp NotConfirmRedeemMoney

NotConfirmRedeemMoney:
	call ContinueRequest

	; Handle 'Y' or 'y'
	mov al, byte ptr [continueOption] ; Load continueOption into AL
	or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
	cmp al, 'y'
	je getRedeemPointsLoop                 ; If 'y' (or 'Y'), go to CheckAndWithdraw

	; Handle 'N' or 'n'
	cmp al, 'n'
	je requestReperform              ; If 'n' (or 'N'), go to PrintReceiptRequest

redeemVoucherCode:

	call ClrScr

voucherMenuCodeLoop:
	mov edx, OFFSET voucherCodeMenu
    call writeString

getVoucherCodeChoice:
    mov edx, OFFSET voucherCodeMsg
    call writeString

    call ReadInt
    mov voucherCodeChoice, eax

    cmp voucherCodeChoice, 1
    je redeemVoucher

    cmp voucherCodeChoice, 2
    je redeemVoucher

    cmp voucherCodeChoice, 3
    je redeemVoucher

    cmp voucherCodeChoice, 4
    je RedeemPoints

    cmp voucherCodeChoice, 5
    je QuitProgram

InvalidVoucherCodeChoce:
    mov edx, OFFSET errorMessage
    call WriteString
    call Crlf
    call Crlf
    jmp voucherMenuCodeLoop   ; Loop back to re-display the menu

redeemVoucher:

makeConfirmationRedeemVoucher:
    mov edx, OFFSET confirmVoucher
    call WriteString

    ; Read user input (confirmation)
    call ReadChar
    or al, 32                 ; Convert to lowercase (handles 'Y' and 'y')
    call WriteChar            ; Echo the character

    cmp al, 'y'
    je updateRewardPoints          ; If 'y', proceed to update balance

    call Crlf

    cmp al, 'n'
    je NotConfirmVoucher            ; If 'n', return to deposit loop

    ; Invalid input, re-prompt
    mov edx, OFFSET errorMessage
    call WriteString
    jmp makeConfirmationRedeemVoucher

UpdateRewardPoints:
    mov eax, rewardPoints
    cmp eax, 30
    jb notEnoughPoints

	mov eax, rewardPoints
    sub eax, 30
    mov rewardPoints, eax

    call Crlf

    mov edx, OFFSET voucherRedeemSuccess
    call writeString

    call Crlf

    cmp voucherCodeChoice, 1
    je printVoucher1Code

    cmp voucherCodeChoice, 2
    je printVoucher2Code

    cmp voucherCodeChoice, 3
    je printVoucher3Code

    jmp NotConfirmVoucher

printVoucher1Code:
    mov edx, OFFSET voucherCode1
    call writeString
    jmp NotConfirmVoucher

printVoucher2Code:
    mov edx, OFFSET voucherCode2
    call writeString
    jmp NotConfirmVoucher

printVoucher3Code:
    mov edx, OFFSET voucherCode3
    call writeString
    jmp NotConfirmVoucher

NotConfirmVoucher:
	call ContinueRequest

	; Handle 'Y' or 'y'
	mov al, byte ptr [continueOption] ; Load continueOption into AL
	or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
	cmp al, 'y'
	je getVoucherCodeChoice                 ; If 'y' (or 'Y'), go to CheckAndWithdraw

	; Handle 'N' or 'n'
	cmp al, 'n'
	je requestReperform              ; If 'n' (or 'N'), go to PrintReceiptRequest

notEnoughPoints:
	mov edx, OFFSET insufficientRewardPoint
	call writeString
	call Crlf
	call Crlf
	jmp voucherMenuCodeLoop

RequestReperform:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

    ret

RedeemPoints ENDP

EstimateFutureRewards PROC
    call ClrScr

    mov edx, OFFSET futureEstimateTitle
    call WriteString
    call Crlf

    ; Prompt for Monthly Deposit
    mov edx, OFFSET promptMonthlyDeposit
    call WriteString
    call ReadInt
    mov monthlyDeposit, eax     ; Store user's monthly deposit

    ; Prompt for Number of Months
    mov edx, OFFSET promptMonths
    call WriteString
    call ReadInt
    mov numberOfMonths, eax     ; Store number of months

    ; Calculate: monthlyDeposit / 10
    mov eax, monthlyDeposit
    mov ebx, 10
    xor edx, edx
    div ebx                     ; EAX = reward points per month

    ; Multiply by numberOfMonths
    mov ebx, numberOfMonths
    mul ebx                     ; EAX = estimated future reward points

    mov estimatedPoints, eax    ; Store in variable

    ; Display result
    mov edx, OFFSET estimatedPointsMsg
    call WriteString
    mov eax, estimatedPoints
    call WriteDec
    mov edx, OFFSET points
    call WriteString

    call ContinueRequest

    ; Handle 'Y' or 'y'
    mov al, byte ptr [continueOption] ; Load continueOption into AL
    or al, 32                          ; Convert 'Y' to 'y' (if uppercase)
    cmp al, 'y'
    je EstimateFutureRewards                 ; If 'y' (or 'Y'), go to CheckAndWithdraw

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je ChooseAnotherFunction              ; If 'n' (or 'N'), go to PrintReceiptRequest

ChooseAnotherFunction:
    call RePerformFunction

    ; Handle 'Y' or 'y' to go back to main menu
    mov al, byte ptr [redoOption] ; Load redoOption into AL
    or al, 32
    cmp al, 'y'
    je DisplayMainMenu

    ; Handle 'N' or 'n'
    cmp al, 'n'
    je QuitProgram              ; If 'n' (or 'N'), go to PrintReceiptRequest

    ret
EstimateFutureRewards ENDP


QuitProgram PROC
    call ClrScr
    mov edx, OFFSET exitMessage
    call WriteString
    call Crlf
    call Crlf
    call ExitProcess
    ret
QuitProgram ENDP

;----------Redo Process----------
ContinueRequest PROC
    call Crlf
    call Crlf
    mov edx, OFFSET continueMessage
    call writeString

    call readChar
    mov continueOption, al

    call writeChar
    call Crlf

    ret
ContinueRequest ENDP

PrintReceiptOption PROC
    call Crlf
    mov edx, OFFSET printRequestMessage
    call writeString

    call readChar
    mov printOption, al

    call writeChar
    call Crlf

    ret
PrintReceiptOption ENDP

RePerformFunction PROC
    call Crlf
    mov edx, OFFSET redoMessage
    call writeString

    call readChar
    mov redoOption, al

    call writeChar
    call Crlf
    call Crlf

    ret
RePerformFunction ENDP

END MAIN

