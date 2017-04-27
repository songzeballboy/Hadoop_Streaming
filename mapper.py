#coding=utf-8

import sys
import json

reload(sys)
sys.setdefaultencoding('utf-8')

def main():
    for line in sys.stdin:
        try:
            ary = line.strip().decode("utf-8", "ignore").split("\t")
            
            cur_id = ary[0]
            cur_val = ary[1]

            print("%s\t%s" % (cur_id,cur_val))
            
        except Exception,ex:
            print("print : %s" % ex)
            continue
    return

if __name__ == '__main__':
    main()