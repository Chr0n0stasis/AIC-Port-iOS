GREETING	R 20
#MS_ ostrea '@#[%::40]'
WAIT 15
HKDS	s CLT #<ostrea>
IF 'GFC[OST3]==0||TRUE' {
    MSG s_00
    GFC_SET OST3 |=1
} ELSE {
    MSG s_01

}

