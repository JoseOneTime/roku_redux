'**********************************************************
'**  Video Player Example Application - General Dialogs 
'**  November 2009
'**  Copyright (c) 2009 Roku Inc. All Rights Reserved.
'**********************************************************

'******************************************************
'Show basic message dialog without buttons
'Dialog remains up until caller releases the returned object
'******************************************************

Function ShowPleaseWait(title As Dynamic, text As Dynamic) As Object
    if not isStr(title) title = ""
    if not isStr(text) text = ""

    port = CreateObject("roMessagePort")
    dialog = invalid

    'the OneLineDialog renders a single line of text better
    'than the MessageDialog.
    if text = ""
        dialog = CreateObject("roOneLineDialog")
    else
        dialog = CreateObject("roMessageDialog")
        dialog.SetText(text)
    endif

    dialog.SetMessagePort(port)

    dialog.SetTitle(title)
    dialog.ShowBusyAnimation()
    dialog.Show()
    return dialog
End Function

'******************************************************
'Retrieve text for connection failed
'******************************************************

Function GetConnectionFailedText() as String
    return "We were unable to connect to the service.  Please try again in a few minutes."
End Function

'******************************************************
'Show connection error dialog
'
'Parameter: retry true/false - offer retry option
'Return 0 = retry, 1 = back
'******************************************************

Function ShowConnectionFailedRetry() as Dynamic
    Dbg("Connection Failed Retry")
    title = "Can't connect to video service"
    text  = GetConnectionFailedText()
    return ShowDialog2Buttons(title, text, "Try again", "Back")
End Function

'******************************************************
'Show Amazon connection error dialog with only an OK button
'******************************************************

Sub ShowConnectionFailed()
    Dbg("Connection Failed")
    title = "Can't connect to video service"
    text = GetConnectionFailedText()
    ShowErrorDialog(text, title)
End Sub

'******************************************************
'Show error dialog with OK button
'******************************************************

Sub ShowErrorDialog(text As Dynamic, title=invalid as Dynamic)
    if not isStr(text) text = "Unspecified error"
    if not isStr(title) title = ""
    ShowDialog1Button(title, text, "Done")
End Sub

'******************************************************
'Show 1 button dialog
'Return: nothing
'******************************************************

Sub ShowDialog1Button(title As Dynamic, text As Dynamic, but1 As String)
    if not isStr(title) title = ""
    if not isStr(text) text = ""

    Dbg("DIALOG1: ", title + " - " + text)

    port = CreateObject("roMessagePort")
    dialog = CreateObject("roMessageDialog")
    dialog.SetMessagePort(port)

    dialog.SetTitle(title)
    dialog.SetText(text)
    dialog.AddButton(0, but1)
    dialog.Show()

    while true
        dlgMsg = wait(0, dialog.GetMessagePort())

        if type(dlgMsg) = "roMessageDialogEvent"
            if dlgMsg.isScreenClosed()
                print "Screen closed"
                return
            else if dlgMsg.isButtonPressed()
                print "Button pressed: "; dlgMsg.GetIndex(); " " dlgMsg.GetData()
                return
            endif
        endif
    end while
End Sub

'******************************************************
'Show 2 button dialog
'Return: 0=first button or screen closed, 1=second button
'******************************************************

Function ShowDialog2Buttons(title As Dynamic, text As Dynamic, but1 As String, but2 As String) As Integer
    if not isStr(title) title = ""
    if not isStr(text) text = ""

    Dbg("DIALOG2: ", title + " - " + text)

    port = CreateObject("roMessagePort")
    dialog = CreateObject("roMessageDialog")
    dialog.SetMessagePort(port)

    dialog.SetTitle(title)
    dialog.SetText(text)
    dialog.AddButton(0, but1)
    dialog.AddButton(1, but2)
    dialog.Show()

    while true
        dlgMsg = wait(0, dialog.GetMessagePort())

        if type(dlgMsg) = "roMessageDialogEvent"
            if dlgMsg.isScreenClosed()
                print "Screen closed"
                dialog = invalid
                return 0
            else if dlgMsg.isButtonPressed()
                print "Button pressed: "; dlgMsg.GetIndex(); " " dlgMsg.GetData()
                dialog = invalid
                return dlgMsg.GetIndex()
            endif
        endif
    end while
End Function
