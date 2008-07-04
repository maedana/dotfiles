import rlcompleter, readline
readline.parse_and_bind('tab: complete')

import inspect
import string
igd = inspect.getdoc
igs = inspect.getsource
igf = inspect.getfile
igsl = inspect.getsourcelines

def getsourcewithline(object):
  lines, lnum = igsl(object)
  lineswithlnum = []
  for l in lines:
    linewithlnum = str(lnum) + ' ' + l
    lineswithlnum.append(linewithlnum)
    lnum += 1
  return string.join(lineswithlnum, '')
igswl = getsourcewithline
