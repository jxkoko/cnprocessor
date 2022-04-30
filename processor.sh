#!/bin/bash
cat src.txt | grep -E "^((\+|\-).*XXXXXX|\+\+\+ b)" | sed -e "s/\(.*\)\(XXXXXX[1-9A-Z_]*\)\(.*\)/\2/g" -e "s/\+\+\+ b //g" | awk '
    BEGIN{
        path = "init"
    }
    {
        if($1 !~ "XXXXXX.*"){
            path = $0
        }
        else{
            $0 = $0  " "  path
            print $0
        }
    }
' | sort | uniq | sed -e "/^\//d" | awk '
    BEGIN{
        custom = "init"
    }
    {
        if($1 != custom){
            custom = $1
            print custom
        }
        print $2
    }
' > out.txt
