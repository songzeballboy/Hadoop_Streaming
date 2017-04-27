#coding=utf-8

import sys
reload(sys)
sys.setdefaultencoding('utf-8')

def PrintOUT(OneBatch):
    ret = 0

    OneBatch_Length = len(OneBatch)

    if OneBatch_Length < 1:
		return

    for i in range(OneBatch_Length):
        ret += OneBatch[i][1]
    
    print OneBatch[0][0] + "\t" + str(ret)

def main():
	last_id = ""
	OneBatch = []
	for line in sys.stdin:
		try:
			fields = line.replace('\n','').split("\t")
			if len(fields) < 2:
				continue
			cur_id = fields[0]
			cur_val = int(fields[1])

			if cur_id != last_id and last_id != "":
				PrintOUT(OneBatch)

				last_id = cur_id
				OneBatch = []
				OneBatch.append((cur_id,cur_val))
			else:
				OneBatch.append((cur_id,cur_val))
				last_id = cur_id

		except Exception,ex:
			continue
	PrintOUT(OneBatch)
	return

if __name__ == '__main__':
	main()
