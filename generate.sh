#! /bin/bash

output_dir=$1
source_name=$2

function replace_lower() {
    echo "${1//\{LOWER_NAME\}/$lower_name}"
}

function replace_upper() {
    echo "${1//\{UPPER_NAME\}/$upper_name}"
}

function replace_cap() {
    echo "${1//\{CAP_NAME\}/$cap_name}"
}

function create_gitignore() {
    cp .gitignore "$output_dir"/
}

function create_dockerfile() {
    replace_lower "$(< Dockerfile.tpl)" > "$output_dir"/Dockerfile
}

function create_license() {
    cp LICENSE "$output_dir"/
}

function create_load_libs_script() {
    cp load_libs.sh "$output_dir"/load_libs.sh
    chmod +x "$output_dir"/load_libs.sh
}

function create_readme() {
    local template
    template=$(< README.md.tpl)

    lower=$(replace_lower "$template")
    replace_upper "$lower" > "$output_dir"/README.md
}

function create_requirements() {
    cp requirements.txt "$output_dir"/
}

function create_run_script() {
    replace_lower "$(< run.sh.tpl)" > "$output_dir"/run.sh
    chmod +x "$output_dir"/run.sh
}

function create_test_script() {
    replace_lower "$(< test.sh.tpl)" > "$output_dir"/test.sh
    chmod +x "$output_dir"/test.sh
}

function create_content_extractor() {
    replace_cap "$(< src/content_extractor.py.tpl)" \
    > "$output_dir"/src/"$lower_name"_content_extractor.py
}

function create_link_collector() {
    replace_cap "$(< src/link_collector.py.tpl)" \
    > "$output_dir"/src/"$lower_name"_link_collector.py
}

function create_news() {
    local template
    template=$(< src/news.py.tpl)

    lower=$(replace_lower "$template")
    replace_cap "$lower" > "$output_dir"/src/"$lower_name"_news.py
}

function create_news_test() {
    local template
    template=$(< src/test_news.py.tpl)

    lower=$(replace_lower "$template")
    replace_cap "$lower" > "$output_dir"/src/test_"$lower_name"_news.py
}

function create_article_model() {
    cp src/model/article.py "$output_dir"/src/model/
}

function create_content_model() {
    cp src/model/content.py "$output_dir"/src/model/
}

function create_link_model() {
    cp src/model/link.py "$output_dir"/src/model/
}

function create_news_extractor() {
    cp src/extractor/news_extractor.py \
    "$output_dir"/src/extractor/
}

function run() {
    if [[ -z "$output_dir" ]] || [[ -z "$source_name" ]]; then
        echo "output_dir source_name"
        exit 1
    fi

    lower_name=${source_name,,}
    cap_name=${lower_name^}
    upper_name=${lower_name^^}

    mkdir -p "$output_dir"
    mkdir -p "$output_dir"/src/model
    mkdir -p "$output_dir"/src/extractor

    create_gitignore
    create_dockerfile
    create_license
    create_load_libs_script

    create_readme
    create_requirements

    create_run_script
    create_test_script

    create_content_extractor
    create_link_collector
    create_news
    create_news_test

    create_article_model
    create_content_model
    create_link_model

    create_news_extractor
}

run 

