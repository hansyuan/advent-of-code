#!/usr/local/bin/python3.7
# I wrote this to sanity check my haskell code because d3.hs was way too slow.
# Delimit, Count

fi = open("input", 'r')
contents = fi.readlines()
fi.close()

import re

# print(contents[1])
data = [re.match(r"#(?P<id>\d+) @ (?P<left>\d+),(?P<top>\d+): (?P<width>\d+)x(?P<height>\d+)",
    c).groupdict() for c in contents]

for d in data:
    for k in d:
        d[k] = int(d[k])
# print(data)
# from IPython import embed; embed()
# processed = [{k: int(v)} for d in data for k, v in d.items()]
# print (processed)

processed = data

grid = [[0 for _ in range (1000)] for _ in range (1000)]

for p in processed:
    # print(p)
    for y in range(p['top'], p['top'] + p['height']):
        for x in range (p['left'], p['left'] + p['width']):
            grid[x][y] += 1

count = 0
for li in grid:
    for el in li:
        if el > 1:
            count += 1
print (count)

# positions = [(x,y) for x in range(0,1000) for y in range(0,1000)]
# counted = 0

# i = 0
# for (x, y) in positions :
#     print (i)
#     i += 1
#     seen = False
#
#     for config in processed:
#         print("\t", config['id'])
#         if config['left'] <= x and x < config['left'] + config['width']  and\
#             config['top'] <= y and y < config['top'] + config['height']:
#
#             if not seen:
#                 print("\tSet Seen.")
#                 seen = True
#
#             if seen:
#                 counted += 1
#                 print("\tDuplicate")
#                 break
#
# print (counted)
