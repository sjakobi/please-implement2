curl 'https://api.github.com/users/exercism/repos?per_page=100' | jq '[.[] | .name]'  | grep \"x[^-] | cut -d'"' -f 2
