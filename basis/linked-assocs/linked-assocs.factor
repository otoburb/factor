! Copyright (C) 2008 Slava Pestov, James Cash.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors assocs arrays kernel deques dlists sequences hashtables fry ;
IN: linked-assocs

TUPLE: linked-assoc assoc dlist ;

: <linked-hash> ( -- assoc )
    0 <hashtable> <dlist> linked-assoc boa ;

M: linked-assoc assoc-size assoc>> assoc-size ;

M: linked-assoc at* assoc>> at* tuck [ obj>> ] when swap ;

<PRIVATE
: add-to-dlist ( value key lassoc -- node )
    [ swap 2array ] dip dlist>> push-back* ;

: remove-from-dlist ( key dlist -- )
    swap '[ _ = ] delete-node-if ;
PRIVATE>

M: linked-assoc set-at
    [ add-to-dlist ] 2keep
    assoc>> set-at ;

M: linked-assoc delete-at
    [ [ assoc>> ] [ dlist>> ] bi [ at ] dip '[ _ delete-node ] when* ]
    [ assoc>> delete-at ]
    2bi ;

: dlist>seq ( dlist -- seq )
    [ ] pusher [ dlist-each ] dip ;

M: linked-assoc >alist
    dlist>> dlist>seq ;

INSTANCE: linked-assoc assoc
