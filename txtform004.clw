

                     MEMBER('txtform.clw')                 ! This is a MEMBER module

TestFormat           PROCEDURE                             ! Declare Procedure
TestBuffer           STRING(2000)                          !
TestCmd              STRING(30)                            !
TestStr              STRING(500)                           !
CodingDate           LONG                                  !
RunDate              LONG                                  !
Donation             DECIMAL(7,2)                          !
MyName               STRING(30)                            !
  CODE                                                     ! Begin processed code
OMIT ('!Instructions')

Install the dll into a program where the TestFormat procedure
has been included as 'external'.

call the procedure TestFormat and it should display some formatted text
using the message comand
!Instructions
  CodingDate = DATE(8,12,1999)
  FormatInit(TestBuffer, 3000)

  TestCmd = '.lm 10'
  FormatText(TestCmd, 10)
  TestCmd = '.rm 60'
  FormatText(TestCmd, 10)

  TestCmd = '.ti 10'
  FormatText(TestCmd, 10)
  TestStr = 'This is a test of the Text Format module,'
  FormatText(TestStr, 500)

  TestStr = 'that was described in a book called Software Tools in Pascal,'
  FormatText(TestStr, 500)

  TestStr = 'written by Kernighan and Plaugher.'
  FormatText(TestStr, 500)

  TestStr = 'They were Bell Labs software engineers on UNIX software.'
  FormatText(TestStr, 500)

  TestStr = 'Text Format is a design from roff. Its more sophisticated '
  FormatText(TestStr, 500)

  TestStr = 'successors were nroff, troff, and ditroff.'
  FormatText(TestStr, 500)

  TestCmd = '.lm 20'
  FormatText(TestCmd, 10)
  TestCmd = '.rm 50'
  FormatText(TestCmd, 10)
  TestCmd = '.nj'
  FormatText(TestCmd, 10)
  TestCmd = '.sp 1'
  FormatText(TestCmd, 10)

  TestStr = 'It was coded in Clarion by Michael J. Kuhn on ' &|
             FORMAT(CodingDate, @D1)                         &|
            ' using the Pascal code from the book that he saved from a project in' &|
            ' the early 1980''s.'
  FormatText(TestStr, 500)

  TestCmd = '.sp 1'
  FormatText(TestCmd, 10)

  TestCmd = '.rm 60'
  FormatText(TestCmd, 10)
  TestCmd = '.ti 10'
  FormatText(TestCmd, 10)
  TestStr = 'But wait there''s more. . .'
  FormatText(TestStr, 500)
  
  TestCmd = '.lm 5'
  FormatText(TestCmd, 10)
  TestCmd = '.rm 40'
  FormatText(TestCmd, 10)
  
  TestCmd = '.sp 1'
  FormatText(TestCmd, 10)
 
  RunDate = Today()
  MyName = 'Michael Kuhn'
  Donation = 999.99

  TestCmd = '.qu ' & 'RunDate ' & '"' & CLIP(LEFT(FORMAT(RunDate,@D4))) & '"'
  FormatText(TestCmd, 200)
  TestCmd = '.qu ' & 'Name ' & '"' & CLIP(MyName) & '"'
  FormatText(TestCmd, 200)
  TestCmd = '.qu ' & 'Money ' & CLIP(LEFT(FORMAT(Donation,@N$-14.2)))
  FormatText(TestCmd, 200)

  TestStr = 'You have run this on <RunDate>, I hope you find the functions useful. ' &|
            ' If so you might consider sending <Name> a check. A thousand seems too much but ' &|
            ' <Money> would work and it''s less.'
  FormatText(TestStr, 500)
  TestCmd = '.br'     ! some command cause a break if last line does not go then YOU NEED a manual break
 
  FormatText(TestCmd, 10)
  message(TestBuffer)

! NOTE .ju (justify) does not show using the "message" command because message
!      must compress out extraneous blanks.
!      write the text to a file and it should be justified to right margin
