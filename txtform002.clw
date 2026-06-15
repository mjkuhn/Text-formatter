

                     MEMBER('txtform.clw')                 ! This is a MEMBER module

FormatInit           PROCEDURE (BufferAddress, BufferLng)  ! Declare Procedure
  CODE                                                     ! Begin processed code
OMIT ('!Comments')

  Software Tools in Pascal
  Kernighan & Plaugher  (1980's?)

  Text Formatter Chapter

  This design was the precursor to Unix utilites "roff", "nroff", "troff", "ditroff"

  These are the basic formatting commands that were outlined in the Chapter on Text Formatting

 .sp - space N number of lines
 .br - force output buffer to clear
 .fi - fill on, add words to output buffer
 .nf - fill off, send each input line to output buffer
 .ju - justify text to right margin
 .nj - no justify, ragged right margin
 .ls - set line spacing
 .lm - set left margin
 .rm - set right margin
 .ti - temporary indent

  These commands are not and will not be implemented they were in my Pascal
  program but are not needed here.

 .bp - break page
 .pl - page length
 .pc - send printer commands to control special features
 .vm - vertical margins
 .ta - set tab stops and skip to tab
 .ac - set alignment character - align character on the tab stop
 .bf - boldface
 .ul - underline
 .da/dn - alphabetic date and numeric date
 .ke - reserves specified number of blank lines
 .ne - insures block of text is kept on the same page
 .in - include the specified file
 .pd - paragraph skip and indentation
 .pi - set the character per inch

  This is an addition in order to substitutedatabase data
  into the text strings.

  .qu adds a variable name and data to a queue
      When the text is parsed if a <nnnnn> is found then the value "nnnnn" is 
      used to search the queue. If match found then corresponding data is substituted.

  Notes

  Michael J Kuhn 8-10-99   mike@kuhns.org

  My requirements for Clarion were simple, I just need to format some text in a buffer
  and print it. Basically a simple letter writer or in my case a Court Document.

  This was a rush job and future requirements and sophistication were not considered.

  I simply took the original source code that I had in Pascal and duplicated it in
  Clarion. I did not convert my "upgrades" to the text formatter, although I did include
  the dot commands in getcmd routine only as reminder to myself.

  "do" was prefixed to some procedure names because of keyword conflicts.
!Comments

 FREE(TxtFormQ)                ! Clear the variable replace queue

 G:TextBuffer    &= BufferAddress
 G:BufPtr        = 0
 G:TextBufferLng = BufferLng

 G:blank = VAL(' ')
 G:cmd   = VAL('.')
 G:plus  = VAL('+')
 G:minus = VAL('-')
 G:CR    = VAL('<13>')
 G:LF    = VAL('<10>')

 G:newline   = 04h
 G:endstr    = 05h
 G:hardspace = 5Ch
 G:backspace = 00h

 G:huge      = 999999
 G:maxstr    = 1000
 G:pagewidth = 90
 G:pagelength= 66

 G:dir     = 0
 G:fill    = TRUE
 G:justify = TRUE

 G:lsval = 1
 G:inval = 0
 G:tival = 0
 G:ceval = 0
 G:rmval = G:pagewidth

 G:bottom = G:pagelength
 G:lineno = 0

 G:outp   = 0
 G:outw   = 0
 G:outwds = 0

