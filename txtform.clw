   PROGRAM

   INCLUDE('Equates.CLW')
   INCLUDE('TplEqu.CLW')
   INCLUDE('Keycodes.CLW')
   INCLUDE('Errors.CLW')
   INCLUDE('ABASCII.INC'),ONCE
   INCLUDE('ABBROWSE.INC'),ONCE
   INCLUDE('ABDROPS.INC'),ONCE
   INCLUDE('ABEIP.INC'),ONCE
   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABPOPUP.INC'),ONCE
   INCLUDE('ABQUERY.INC'),ONCE
   INCLUDE('ABREPORT.INC'),ONCE
   INCLUDE('ABRESIZE.INC'),ONCE
   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABUSERCONTROL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE
   INCLUDE('ABWMFPAR.INC'),ONCE
   INCLUDE('CSIDLFOLDER.INC'),ONCE
   INCLUDE('CLARUNEXT.INC'),ONCE
   INCLUDE('SPECIALFOLDER.INC'),ONCE
   INCLUDE('ABBREAK.INC'),ONCE
   INCLUDE('ABCPTHD.INC'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE
   INCLUDE('ABGRID.INC'),ONCE
   INCLUDE('ABPRNAME.INC'),ONCE
   INCLUDE('ABPRTARG.INC'),ONCE
   INCLUDE('ABPRXML.INC'),ONCE
   INCLUDE('ABQEIP.INC'),ONCE
   INCLUDE('ABRPATMG.INC'),ONCE
   INCLUDE('ABRPPSEL.INC'),ONCE
   INCLUDE('ABRULE.INC'),ONCE
   INCLUDE('ABVCRFRM.INC'),ONCE
   INCLUDE('CFILTBASE.INC'),ONCE
   INCLUDE('CFILTERLIST.INC'),ONCE
   INCLUDE('CWSYNCHC.INC'),ONCE
   INCLUDE('MDISYNC.INC'),ONCE
   INCLUDE('QPROCESS.INC'),ONCE
   INCLUDE('RTFCTL.INC'),ONCE
   INCLUDE('TRIGGER.INC'),ONCE
   INCLUDE('WINEXT.INC'),ONCE
fi EQUATE (1)
nf EQUATE (2)
ju EQUATE (3)
nj EQUATE (4)
br EQUATE (5)
ls EQUATE (6)
rm EQUATE (7)
lm EQUATE (8)
ti EQUATE (9)
sp EQUATE (10)
bp EQUATE (11)
pc EQUATE (12)
ta EQUATE (13)
ce EQUATE (14)
ul EQUATE (15)
bf EQUATE (16)
he EQUATE (17)
fo EQUATE (18)
pl EQUATE (19)
vm EQUATE (20)
ac EQUATE (21)
inc EQUATE (22)
da EQUATE (23)
dn EQUATE (24)
ke EQUATE (25)
ne EQUATE (26)
pd EQUATE (27)
pi EQUATE (28)
qu EQUATE (29)
qd EQUATE (30)
unknown EQUATE (100)

   MAP
     MODULE('txtform001.clw')
       FormatText(*STRING,LONG)
     END
     MODULE('txtform002.clw')
       FormatInit(*STRING, LONG)
     END
     MODULE('txtform003.clw')
       min(LONG,LONG)LONG
       max(LONG,LONG)LONG
       skipbl(*STRING, *LONG)
       getval(*STRING,*BYTE,*LONG,*LONG)
       docommand(*STRING)
       textout(*STRING)
       setparm(*LONG,*LONG,BYTE,LONG,LONG,LONG)
       getcmd(*STRING)BYTE
       spread(*STRING,LONG,LONG,LONG)
       putword(*STRING)
       fwidth(*STRING)LONG
       flength(*STRING)LONG
       space(LONG)
       puthead
       putfoot
       getword(*STRING,LONG,*STRING,*LONG) 
       dobreak
       scopy(*STRING,LONG,*STRING,LONG)
       doskip(LONG)
       doput(*STRING)
       writetextbuffer(STRING)
       leadbl(*STRING)
       docenter(*STRING)
       getstrn(*STRING,*STRING,*LONG)
       checkvar(*STRING)
     END
     MODULE('txtform004.clw')
       TestFormat
     END
     MODULE('txtfo_SF.CLW')
       CheckOpen(FILE File,<BYTE OverrideCreate>,<BYTE OverrideOpenMode>)
       ReportPreview(QUEUE PrintPreviewQueue)
       Preview:JumpToPage(LONG Input:CurrentPage, LONG Input:TotalPages),LONG
       Preview:SelectDisplay(*LONG Input:PagesAcross, *LONG Input:PagesDown)
       StandardWarning(LONG WarningID),LONG,PROC
       StandardWarning(LONG WarningID,STRING WarningText1),LONG,PROC
       StandardWarning(LONG WarningID,STRING WarningText1,STRING WarningText2),LONG,PROC
       SetupStringStops(STRING ProcessLowLimit,STRING ProcessHighLimit,LONG InputStringSize,<LONG ListType>)
       NextStringStop,STRING
       SetupRealStops(REAL InputLowLimit,REAL InputHighLimit)
       NextRealStop,REAL
       INIRestoreWindow(STRING ProcedureName,STRING INIFileName)
       INISaveWindow(STRING ProcedureName,STRING INIFileName)
       RISaveError
     END
     MODULE('txtfo_RU.CLW')
     END
     MODULE('txtfo_RD.CLW')
     END
   END

G:cmd                BYTE,STATIC
G:blank              BYTE,STATIC
G:plus               BYTE,STATIC
G:minus              BYTE,STATIC
G:CR                 BYTE,STATIC
G:LF                 BYTE,STATIC
G:hardspace          BYTE,STATIC
G:backspace          BYTE,STATIC
G:newline            BYTE,STATIC
G:endstr             BYTE,STATIC
G:huge               LONG,STATIC
G:pagewidth          LONG,STATIC
G:pagelength         LONG,STATIC
G:lineno             LONG,STATIC
G:bottom             LONG,STATIC
G:maxstr             LONG,STATIC
G:fill               BYTE,STATIC
G:justify            BYTE,STATIC
G:lsval              LONG,STATIC
G:inval              LONG,STATIC
G:rmval              LONG,STATIC
G:tival              LONG,STATIC
G:ceval              LONG,STATIC
G:outp               LONG,STATIC
G:outw               LONG,STATIC
G:outwds             LONG,STATIC
G:dir                BYTE,STATIC
G:TextBufferLng      LONG,STATIC
G:TextBuffer         &STRING,STATIC
G:BufPtr             LONG,STATIC
G:inbuf              STRING(4000),STATIC
G:outbuf             STRING(4000),STATIC
TxtFormQ             QUEUE,PRE()
VariableStr            STRING(30)
ReplaceStr             STRING(100)
                     END

SaveErrorCode        LONG
SaveError            CSTRING(255)
SaveFileErrorCode    LONG
SaveFileError        CSTRING(255)
GlobalRequest        LONG(0),EXTERNAL,DLL(dll_mode),THREAD
GlobalResponse       LONG(0),EXTERNAL,DLL(dll_mode),THREAD
VCRRequest           LONG(0),EXTERNAL,DLL(dll_mode),THREAD
!region File Declaration
!endregion

Sort:Name            STRING(ScrollSort:Name)                
Sort:Name:Array      STRING(3),DIM(100),OVER(Sort:Name)
Sort:Alpha           STRING(ScrollSort:Alpha)
Sort:Alpha:Array     STRING(2),DIM(100),OVER(Sort:Alpha)


  CODE
  TestFormat
!---------------------------------------------------------------------------
