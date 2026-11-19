// I guess you need this feature:
MSG n_<<<EOF
This is a text that 
<s><m joy>does not exist<m0> 
in the localization</s> directory.
*
The part enclosed by 
<C1>\"\\\<\\\<\\\<EOF\"<C0> to <C1>\"EOF;\"<C0> is 
sent from evt.EV to NelMSG.

EOF;
WAIT 20

_variable=TX_BOARD
TX_BOARD <<<EOF
You can also use EOF 
in \"$_variable\". 
EOF;
WAIT 40
