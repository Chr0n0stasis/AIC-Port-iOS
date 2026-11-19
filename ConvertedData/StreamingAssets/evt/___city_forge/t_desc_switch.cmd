

MSG	n_00 


MSG	fd_01 

PIC_FILL #9 DARK
PIC_FADEIN #9 50
WAIT 60
#< smith >
#PTCST_PREFIX _nosnd 1 
HKDS	fd CCRCT '@CRB'
HKDS	n CCLCB '@CLB'
//暗転
MSG	fd_10 


MSG	n_12 


MSG	fd_13 


MTL SND quest_tracking
MSG	n_13 

WAIT 30
PIC_FADEOUT #9 50

WAIT 50
HKDS	fd RT #<$_focusto>
HKDS	n CCLT #<Noel>
#< smith >
#PTCST_PREFIX _nosnd 0

// 暗転開け
MSG	fd_20 
