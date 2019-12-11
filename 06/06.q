// Use parent vector
// See Iverson 'A Programming Language' or Apter 'Treetable: a case-study in q'

d:`$")"vs/:read0`input.txt
t:(!). reverse flip d
t[`COM]:`COM

(+/) -1+(#:')t scan/: key t

paths:t scan/: t`YOU`SAN
meet:first(inter/)paths
(+/)paths?\:meet

