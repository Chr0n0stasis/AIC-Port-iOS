// テキスト:名前
GREETING	L -10

IF 'GFB[ALCHEMY_RECIPE]==0' {
    STOP_LETTERBOX
    HKDS	n CT #<%>
    MSG n_00
    MSG n_01
    MSG n_02
    SEEK_END
}

ALCHEMY alchemy_cutin/f_city_ixia
