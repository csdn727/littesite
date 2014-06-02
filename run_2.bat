cd site/ebin
erl -name site@localhost -setcookie abc -pa . -pz ../src -s site start -s observer start -noshell
