# Create _data/ directory if not already there
mkdir -p _data

# Get the list of all language repos and write it to _data/tracks.json
curl https://api.github.com/users/exercism/repos?per_page=100 \
	| jq '[.[]
		| .name
		| select(startswith("x")
			and (startswith("x-") | not)
			and . != "xproofs")]' \
	> _data/tracks.json

# For each language track, get the the config.json and write it to _data as
# <repo_name>.json
for track in (cat _data/tracks.json | cut -s -d'"' -f 2)
	curl https://raw.githubusercontent.com/exercism/$track/master/config.json \
	> _data/$track.json
end

# Get the list of all exercises and write it to _data/all_exercises.json
curl https://api.github.com/repos/exercism/x-common/contents \
	| jq '[.[]
		| .name
		| select(endswith(".yml"))
		| rtrimstr(".yml")]' \
	> _data/all_exercises.json

# Sort all exercises by number of existing implementations (descending) and
# write those to _data/all_exercise_by_number_of_implementations.json
python sort_exercises.py > _data/all_exercises_by_number_of_implementations.json
