

                     MEMBER('txtform.clw')                 ! This is a MEMBER module

FormatText           PROCEDURE (TextIn,TextInSize)         ! Declare Procedure
TextLng              LONG                                  !
n                    LONG                                  !
  CODE                                                     ! Begin processed code
  TextLng = TextInSize
  LOOP WHILE( (TextIn[TextLng] = CHR(G:blank) OR TextIn[TextLng] = '') AND TextLng > 0)
    TextLng -= 1
  END

  II# = 1
  LOOP WHILE(II# <= TextLng)

    G:inbuf = ''
    n = 1
    LOOP
      IF TextIn[II#] = CHR(G:CR) AND TextIn[II#+1] = CHR(G:LF); II# += 2; BREAK.

      G:inbuf[n] = TextIn[II#]
      if n <= 4000-2; n += 1.     ! ***** check for buffer overflow
      II# += 1

      IF II# > TextLng; BREAK.
    END

    G:inbuf[n]   = CHR(G:newline)
    G:inbuf[n+1] = CHR(G:endstr)

    IF G:inbuf[1] = CHR(G:cmd)
      docommand(G:inbuf)
    ELSE
      textout(G:inbuf)
    END

  END

OMIT('!Notes')

  The heirarchy of processing generally is. . .

     docommand
        getcmd
        getval
        setparam


     textout

       .nf   put

       .fi   getword
             putword
        .ju    spread
             break
               put
                 writebuffer
             skip

  with the routines (min,max,width,length,skipbl,leadbl,scopy)
  being used as required
!Notes

