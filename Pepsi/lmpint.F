
C **********************************************************************

      REAL FUNCTION LMPINT(PEXTI,I)

C...This is the MINUIT routine PINTF.
CC        CALCULATES THE INTERNAL PARAMETER VALUE LMPINT CORRESPONDING
CC        TO THE EXTERNAL VALUE PEXTI FOR PARAMETER I.
CC
      COMMON
     1/LMMINE/ ERP(30)  ,ERN(30)
     2/LMPARI/ X(15)    ,XT(15)   ,DIRIN(15) ,MAXINT     ,NPAR
     3/LMPARE/ U(30)              ,WERR(30)  ,MAXEXT     ,NU
     4/LMLIMI/ ALIM(30) ,BLIM(30) ,LCODE(30) ,LCORSP(30) ,LIMSET
     5/LMVARI/ V(15,15)
     7/LMFIX / IPFIX(15),XS(15)   ,XTS(15)   ,DIRINS(15) ,NPFIX
     7/LMFIX2/ GRDS(15) ,G2S(15)  ,GSTEPS(15),ABERFS(15)
     C/LMCASC/ Y(16)    ,JH       ,JL
     F/LMDERI/ GIN(30)  ,GRD(15)  ,G2(15)    ,GSTEP(15)  ,ABERF(15)
     G/LMSIMV/ P(15,16) ,PSTAR(15),PSTST(15) ,PBAR(15)   ,PRHO(15)
     J/LMVART/ VT(15,15)
      COMMON
     6/LMUNIT/ ISYSRD   ,ISYSWR   ,ISYSPU
     8/LMTITL/ TITLE(13),DATE(2)  ,ISW(7)    ,NBLOCK
     9/LMCONV/ EPSI     ,APSI     ,VTEST     ,NSTEPQ     ,NFCN ,NFCNMX
     A/LMCARD/ CWORD    ,CWORD2   ,CWORD3    ,WORD7(7)
     B/LMMINI/ AMIN     ,UP       ,NEWMIN    ,ITAUR      ,SIGMA,EPSMAC
      COMMON /LPFLAG/ LST3
      INTEGER LST3
      SAVE /LPFLAG/

      DATA BIG, SMALL / 1.570796326795 , -1.570796326795 /
      IGO = LCODE(I)
      GO TO (100,200,300,400),IGO
C--       IGO = 1  MEANS NO LIMITS
  100 LMPINT = PEXTI
      GO TO 800
  200 CONTINUE
  300 CONTINUE
C--       IGO = 4  MEANS THERE ARE TWO LIMITS
  400 ALIMI = ALIM(I)
      BLIMI = BLIM(I)
      IF (PEXTI-ALIMI)  440,500,460
  440 A = SMALL
  450 LMPINT = A
      PEXTI = ALIMI + 0.5* (BLIMI-ALIMI) *(SIN(A) +1.0)
      LIMSET=1
      IF(LST3.GE.1) WRITE (ISYSWR,241)  I
      GO TO 800
  460 IF (BLIMI-PEXTI)  470,520,480
  470 A = BIG
      GO TO 450
  480 YY=2.0*(PEXTI-ALIMI)/(BLIMI-ALIMI) - 1.0
      LMPINT = ATAN(YY/SQRT(1.0- YY**2) )
      GO TO 800
  500 LMPINT = SMALL
      GO TO 800
  520 LMPINT = BIG
  800 RETURN
  241 FORMAT(' WARNING - VARIABLE',I3,' HAS BEEN BROUGHT BACK IN',
     +'SIDE LIMITS BY LMPINT.')
      END
