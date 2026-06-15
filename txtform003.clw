

                     MEMBER('txtform.clw')                 ! This is a MEMBER module

min                  PROCEDURE (x,y)                       ! Declare Procedure
  CODE                                                     ! Begin processed code
IF X < Y
  RETURN(X)
ELSE
  RETURN(Y)
END
max                  PROCEDURE (x,y)                       ! Declare Procedure
  CODE                                                     ! Begin processed code
IF x < y
  RETURN(Y)
ELSE
  RETURN(X)
END
skipbl               PROCEDURE (buf, i)                    ! Declare Procedure
  CODE                                                     ! Begin processed code
LOOP WHILE(buf[i] = CHR(G:blank))
  i += 1
END
getval               PROCEDURE (buf, argtype, arg, i)      ! Declare Procedure
work                 STRING(5)                             !
n                    LONG                                  !
  CODE                                                     ! Begin processed code
  skipbl(buf, i)

  argtype = buf[i]
  IF (argtype = CHR(G:plus)) OR (argtype = CHR(G:minus)); i =+ 1.

  n = 1
  work = '';
  skipbl(buf,i)
  LOOP
    IF buf[i] = CHR(G:blank) OR buf[i] = CHR(G:newline) OR buf[i] = CHR(G:endstr); BREAK.

    work[n] = buf[i]
    n += 1
    i += 1
  END

  IF ~NUMERIC(work)
    arg = 0
  ELSE
    arg = work
  END
docommand            PROCEDURE (buf)                       ! Declare Procedure
cmd                  BYTE                                  !
cmdval               LONG                                  !
argtype              BYTE                                  !
spval                LONG                                  !
x                    LONG                                  !
VarStr               STRING(200)                           !
RepStr               STRING(200)                           !
  CODE                                                     ! Begin processed code
 cmd = getcmd(buf)

 x = 4
 IF cmd <> unknown; getval(buf, argtype, cmdval, x).

 CASE cmd
   OF sp
     space(max(cmdval,1))
   OF br
     dobreak
   OF fi
     dobreak
     G:fill = TRUE
   OF nf
     dobreak
     G:fill = FALSE
   OF ju
     dobreak
     G:justify = TRUE
   OF nj
     dobreak
     G:justify = FALSE
   OF ls
     setparm(G:lsval, cmdval, argtype, 1, 1, G:huge)
   OF rm
     setparm(G:rmval, cmdval, argtype, G:pagewidth, G:inval+G:tival+1, G:huge)
   OF lm
     dobreak
     setparm(G:inval, cmdval, argtype, 0, 0, G:rmval-1)
   OF ce
     dobreak
     setparm(G:ceval, cmdval, argtype, 1, 0, G:huge)
   OF ti
     dobreak
     setparm(G:tival, cmdval, argtype, 0, -G:huge, G:rmval)
   OF qu
     x = 4
     getstrn(buf, VarStr, x)
     getstrn(buf, RepStr, x)

     TxtFormQ:VariableStr = CLIP(LOWER(VarStr))
     GET(TxtFormQ, +TxtFormQ:VariableStr)
     IF ERRORCODE() = 30
       TxtFormQ:VariableStr = CLIP(LOWER(VarStr))
       TxtFormQ:ReplaceStr  = CLIP(RepStr)
       ADD(TxtFormQ, +TxtFormQ:VariableStr)
     END

    OF qd
      TxtFormQNbr# = RECORDS(TxtFormQ)
      LOOP II# = 1 to TxtFormQNbr#
        GET(TxtFormQ, II#)

        G:inbuf = '(' & CLIP(TxtFormQ:VariableStr) & ':' & CLIP(TxtFormQ:ReplaceStr) & ')'
        LNG# = LEN(CLIP(G:Inbuf))
        G:inbuf[LNG#+1] = CHR(G:newline)
        G:inbuf[LNG#+2] = CHR(G:endstr)
        textout(G:inbuf)
      END
 END

textout              PROCEDURE (inbuf)                     ! Declare Procedure
wordbuf              STRING(400)                           !
i                    LONG                                  !
  CODE                                                     ! Begin processed code
  IF (inbuf[1] = CHR(G:blank)) OR (inbuf[1] = CHR(G:newline)); leadbl(inbuf).

  IF RECORDS(TxtFormQ) > 0
    checkvar(inbuf)                  ! check for variable substitution
  END

  IF G:ceval > 0
    docenter(inbuf)
    doput(inbuf)
    G:ceval -= 1
  ELSIF inbuf[1] = CHR(G:newline)
      doput(inbuf)                  !blank line
  ELSIF ~G:fill
      doput(inbuf)                  !unfilled text
  ELSE
      i = 1
      LOOP UNTIL(i = 0)
        getword(inbuf, i, wordbuf, i)
        IF i > 0; putword(wordbuf).
      END
  END
setparm              PROCEDURE (param,theval,argtype,defval,minval,maxval) ! Declare Procedure
  CODE                                                     ! Begin processed code
  IF argtype = G:newline
    param = defval
  ELSIF argtype = G:plus
    param += theval
  ELSIF argtype = G:minus
    param -= theval
  ELSE
     param = theval
  END

  param = min(param, maxval)
  param = max(param, minval)

 
getcmd               PROCEDURE (buf)                       ! Declare Procedure
cmdval               BYTE                                  !
cmd                  STRING(2)                             !
  CODE                                                     ! Begin processed code
  cmd = LOWER(buf[2 : 3])
  CASE cmd
    OF 'fi'
      cmdval = fi
    OF 'nf'
      cmdval = nf
    OF 'ju'
      cmdval = ju
    OF 'nj'
      cmdval = nj
    OF 'br'
      cmdval = br
    OF 'ls'
      cmdval = ls
    OF 'rm'
      cmdval = rm
    OF 'lm'
      cmdval = lm
    OF 'ti'
      cmdval = ti
    OF 'sp'
      cmdval = sp
    OF 'bp'
      cmdval = bp
    OF 'pc'
      cmdval = pc
    OF 'ta'
      cmdval = ta
    OF 'ce'
      cmdval = ce
    OF 'ul'
      cmdval = ul
    OF 'bf'
      cmdval = bf
    OF 'he'
      cmdval = he
    OF 'fo'
      cmdval = fo
    OF 'pl'
      cmdval = pl
    OF 'vm'
      cmdval = vm
    OF 'ac'
      cmdval = ac
    OF 'in'
      cmdval = inc
    OF 'da'
      cmdval = da
    OF 'dn'
      cmdval = dn
    OF 'ke'
      cmdval = ke
    OF 'ne'
      cmdval = ne
    OF 'pd'
      cmdval = pd
    OF 'pi'
      cmdval = pi
    OF 'qu'
      cmdval = qu
    OF 'qd'
      cmdval = qd
    ELSE
      cmdval = unknown
  END
  RETURN(cmdval)

spread               PROCEDURE (buf,outp,nextra,outwds)    ! Declare Procedure
i                    LONG                                  !
j                    LONG                                  !
nb                   LONG                                  !
nholes               LONG                                  !
  CODE                                                     ! Begin processed code
  IF (nextra > 0) AND (outwds > 1)
    G:dir = 1 - G:dir                 !reverse direction
    nholes = outwds -1
    i = outp - 1
    j = min(G:maxstr-2, i+nextra)     !room for newline and endstr

    LOOP WHILE(i < j)
      buf[j] = buf[i]

      IF buf[i] = CHR(G:blank)
        IF G:dir = 0
          nb = (nextra - 1) / nholes + 1
        ELSE
          nb = nextra / nholes
        END

        nextra = nextra - nb
        nholes = nholes -1

        LOOP WHILE(nb > 0)
          j -= 1
          buf[j] = CHR(G:blank)
          nb -= 1
        END
      END

      i -= 1
      j -= 1
    END
  END

putword              PROCEDURE (wordbuf)                   ! Declare Procedure
last                 LONG                                  !
llval                LONG                                  !
nextra               LONG                                  !
w                    LONG                                  !
  CODE                                                     ! Begin processed code
  w = fwidth(wordbuf)
  last = flength(wordbuf) + G:outp + 1   !new end of outbuf
  llval = G:rmval - G:tival - G:inval

  IF (G:outp > 0) AND ((G:outw+w > llval) OR (last >= G:maxstr))
    last = last - G:outp           !remember end of wordbuf

    IF G:justify
      nextra = llval - G:outw + 1
      IF (nextra > 0) AND (G:outwds > 1)
        spread(G:outbuf, G:outp, nextra, G:outwds)
        G:outp = G:outp + nextra
      END
    END

    dobreak          ! flush previous line
  END

  scopy(wordbuf, 1, G:outbuf, G:outp+1)

  G:outp = last
  G:outbuf[G:outp] = CHR(G:blank)     !blank between words
  G:outw   = G:outw + w + 1           !1 for blank
  G:outwds = G:outwds + 1

fwidth               PROCEDURE (buf)                       ! Declare Procedure
i                    LONG                                  !
w                    LONG                                  !
  CODE                                                     ! Begin processed code
  w = 0
  i = 1

  LOOP WHILE(buf[i] <> CHR(G:endstr))
    IF buf[i] = CHR(G:backspace)
      w -= 1
    ELSIF buf[i] = CHR(G:newline)
    ELSE
      w += 1
    END

    i += 1
  END

  RETURN(w)


flength              PROCEDURE (buf)                       ! Declare Procedure
n                    LONG                                  !
  CODE                                                     ! Begin processed code
  n = 1
  LOOP WHILE(buf[n] <> CHR(G:endstr))
    n += 1
  END
  RETURN(n-1)
space                PROCEDURE (n)                         ! Declare Procedure
  CODE                                                     ! Begin processed code
  dobreak
  IF G:lineno <= G:bottom
    IF G:lineno <= 0; puthead.

    doskip(min(n, G:bottom+1-G:lineno))
    G:lineno += n

    IF G:lineno > G:bottom; putfoot.
  END
puthead              PROCEDURE                             ! Declare Procedure
  CODE                                                     ! Begin processed code
  RETURN
putfoot              PROCEDURE                             ! Declare Procedure
  CODE                                                     ! Begin processed code
  RETURN
getword              PROCEDURE (buf,i,bufout,ptr)          ! Declare Procedure
j                    LONG                                  !
  CODE                                                     ! Begin processed code
  LOOP WHILE(buf[i] = CHR(G:blank) OR buf[i] = CHR(G:newline))
    i += 1
  END
  j += 1

  LOOP WHILE (buf[i] <> CHR(G:endstr) AND buf[i] <> CHR(G:blank) AND buf[i] <> CHR(G:newline))
    bufout[j] = buf[i]
    i += 1
    j += 1
  END

  bufout[j] = CHR(G:endstr)
  IF buf[i] = CHR(G:endstr)
    ptr = 0
  ELSE
    ptr = i
  END
dobreak              PROCEDURE                             ! Declare Procedure
  CODE                                                     ! Begin processed code
  IF G:outp > 0
    G:outbuf[G:outp]   = CHR(G:newline)
    G:outbuf[G:outp+1] = CHR(G:endstr)
    doput(G:outbuf)
  END
  G:outp   = 0
  G:outw   = 0
  G:outwds = 0
scopy                PROCEDURE (str,i,dest,j)              ! Declare Procedure
  CODE                                                     ! Begin processed code
  LOOP WHILE(str[i] <> CHR(G:endstr))
    dest[j] = str[i]
    i += 1
    j += 1
  END
  dest[j] = CHR(G:endstr)
doskip               PROCEDURE (n)                         ! Declare Procedure
x                    LONG                                  !
  CODE                                                     ! Begin processed code
  LOOP x = 1 to n
    WriteTextBuffer(CHR(G:CR))
    WriteTextBuffer(CHR(G:LF))
  END
doput                PROCEDURE (buf)                       ! Declare Procedure
n                    LONG                                  !
x                    LONG                                  !
  CODE                                                     ! Begin processed code
  LOOP x = 1 TO (G:inval+G:tival)
    WriteTextBuffer(CHR(G:blank))
  END

  n = 1
  LOOP WHILE(buf[n] <> CHR(G:endstr))

    IF buf[n] = CHR(G:newline)
      WriteTextBuffer(CHR(G:CR))
      WriteTextBuffer(CHR(G:LF))
    ELSIF buf[n] = CHR(G:hardspace)
      WriteTextBuffer(CHR(G:blank))
    ELSE
      WriteTextBuffer(buf[n])
    END

    n += 1
  END

  G:tival = 0
  doskip(min(G:lsval-1, G:bottom-G:lineno))
  G:lineno += G:lsval
  IF G:lineno > G:bottom; putfoot.




writetextbuffer      PROCEDURE (strchr)                    ! Declare Procedure
  CODE                                                     ! Begin processed code
 IF G:BufPtr < G:TextBufferLng
   G:BufPtr += 1
   G:TextBuffer[G:BufPtr] = strchr
 END
leadbl               PROCEDURE (buf)                       ! Declare Procedure
i                    LONG                                  !
j                    LONG                                  !
  CODE                                                     ! Begin processed code
  dobreak
  i = 1

  LOOP WHILE(buf[i] = CHR(G:blank))
    i += 1
  END

  if buf[i] <> CHR(G:newline); G:tival = G:tival + i - 1.

  LOOP j = i to (flength(buf)+1)
    buf[j-i+1] = buf[j]
  END
docenter             PROCEDURE (buf)                       ! Declare Procedure
  CODE                                                     ! Begin processed code
 G:tival = max((G:rmval+G:tival-fwidth(buf)) / 2, 0)
getstrn              PROCEDURE (buf, arg, i)               ! Declare Procedure
argtype              STRING(1)                             !
quoted               BYTE                                  !
work                 STRING(200)                           !
n                    LONG                                  !
  CODE                                                     ! Begin processed code
  skipbl(buf, i)
  quoted = False

  argtype = buf[i]
  IF (argtype = '"'); i += 1; quoted = TRUE.

  n = 1
  work = '';
  skipbl(buf,i)
  LOOP
    argtype = buf[i]
    IF (argtype = '"' AND quoted) OR (buf[i] = CHR(G:Blank) AND ~quoted) |
                      OR buf[i] = CHR(G:newline) OR buf[i] = CHR(G:endstr); BREAK.

    work[n] = buf[i]
    n += 1
    i += 1
  END

  LOOP NN# = 1 to n-1
    arg[NN#] = work[NN#]
  END

checkvar             PROCEDURE (buf)                       ! Declare Procedure
wbuf                 STRING(4000)                          !
i                    LONG                                  !
j                    LONG                                  !
x                    LONG                                  !
repLng               LONG                                  !
varFound             BYTE                                  !
varStr               STRING(50)                            !
  CODE                                                     ! Begin processed code
 varFound = False
 i = 1
 j = 1
 LOOP WHILE(buf[i] <> CHR(G:endstr))
    IF buf[i] = '<<'
      x = INSTRING('>', buf, 1, i)

      IF ((x-1) - (i+1)) > 50; x = 0.        ! variable string too big

      IF x <> 0
         VarStr = buf[i+1 : x-1]
        TxtFormQ:VariableStr = CLIP(LOWER(VarStr))
        GET(TxtFormQ, +TxtFormQ:VariableStr)
        IF ERRORCODE() = 30
          wbuf[j] = buf[i]
          i += 1
          j += 1
        ELSE
          varFound = True
          i = x + 1
          repLng = LEN(CLIP(TxtFormQ:ReplaceStr))
          LOOP N# = 1 to repLng
            wbuf[j] = TxtFormQ:ReplaceStr[N#]
            j  += 1
          END
        END  ! ERROCODE() = 30
      ELSE ! closing '>' not found
        wbuf[j] = buf[i]
        i += 1
        j += 1
      END
    ELSE ! no opening '<' found
      wbuf[j] = buf[i]
      i += 1
      j += 1
    END
 END
 IF varFound
   wbuf[j] = CHR(G:endstr)
   scopy(wbuf, 1, buf, 1)
 END


