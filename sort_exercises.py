from collections import Counter
from itertools import chain
import json


TRACKS = json.loads(open('_data/tracks.json').read())
ALL_EXERCISES = json.loads(open('_data/all_exercises.json').read())


implementations = Counter({x: 0
                           for x in ALL_EXERCISES})

for t in TRACKS:
    problems = json.loads(open('_data/{}.json'.format(t)).read())['problems']
    implementations.update(problems)

print(json.dumps([k for k, _ in implementations.most_common()]))
