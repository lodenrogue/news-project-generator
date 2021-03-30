#! /bin/bash

output_dir=$1
source_name=$2

function replace_lower() {
    echo "${1//\{LOWER_NAME\}/$lower_name}"
}

function replace_cap() {
    echo "${1//\{CAP_NAME\}/$cap_name}"
}

function create_content_extractor() {
    replace_cap "$(< src/content_extractor.py.tpl)" \
    > "$output_dir"/"$lower_name"/"$lower_name"_content_extractor.py
}

function create_link_collector() {
    replace_cap "$(< src/link_collector.py.tpl)" \
    > "$output_dir"/"$lower_name"/"$lower_name"_link_collector.py
}

function create_news() {
    local template
    template=$(< src/news.py.tpl)

    lower=$(replace_lower "$template")
    replace_cap "$lower" > "$output_dir"/"$lower_name"/"$lower_name"_news.py
}

function run() {
    if [[ -z "$output_dir" ]] || [[ -z "$source_name" ]]; then
        echo "output_dir source_name"
        exit 1
    fi

    lower_name=${source_name,,}
    cap_name=${lower_name^}

    mkdir -p "$output_dir"/"$lower_name"

    create_content_extractor
    create_link_collector
    create_news
}

run 
