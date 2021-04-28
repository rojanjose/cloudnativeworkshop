#!/bin/bash

clean_tempClones(){
    rm -rf tempClones
}

clean_generatedContent(){
    rm -rf docs/generatedContent/*
    rm generatedContentDocs.yml
}

do_the_thing(){
    
    for repoPath in `yq r agenda.yaml --printMode p "repos.*"`; do

        repo=`yq r agenda.yaml --printMode v "$repoPath.url"`
        BRANCH=`yq r agenda.yaml --printMode v "$repoPath.branch"`
        if [[ -z $BRANCH ]]; then
            BRANCH="master"
        fi

        echo ""
        echo "Cloning $repo..."
        workshopName=$(basename "$repo")
    	git clone --quiet "$repo" tempClones/"$workshopName"

        cd tempClones/"$workshopName"
        echo "Checking out branch $BRANCH..."
        git checkout --quiet $BRANCH
        cd ../..

        MKDOCS_YAML="tempClones/"$workshopName"/mkdocs.yml"
        DOCS_ROOT="."
        if [ -f $MKDOCS_YAML ]; then
            DOCS_ROOT=`yq r tempClones/"$workshopName"/mkdocs.yml docs_dir`
            if [[ -z $DOCS_ROOT ]]; then
                DOCS_ROOT="docs"
            fi
        else
            echo "Not Material MKDocs."
        fi

        echo "Using document/workshop root: $DOCS_ROOT"

        CLONED_REPO_ROOT=tempClones/"$workshopName"
        WORKSHOP_PATH="$CLONED_REPO_ROOT"/"$DOCS_ROOT"

        echo "Cleaning up any .git files from cloned repo"
        rm -rf "$CLONED_REPO_ROOT"/.git*

        GENERATED_CONTENT_PATH=docs/generatedContent/"$workshopName"
        echo "Copying over content to $GENERATED_CONTENT_PATH"
        echo "Workshop Path: $WORKSHOP_PATH"
        if [[ -d $WORKSHOP_PATH ]]; then
            cp -a $WORKSHOP_PATH $GENERATED_CONTENT_PATH
        else
            cp -a $CLONED_REPO_ROOT $GENERATED_CONTENT_PATH
        fi

        GENERATED_CONTENT_LINKS="generatedContentDocs.yml"
        echo "Generating links in $GENERATED_CONTENT_LINKS"

        printf "###############################\n" >> $GENERATED_CONTENT_LINKS
        printf "##  SUMMARY.md for $workshopName\n" >> $GENERATED_CONTENT_LINKS
        printf "################################\n\n" >> $GENERATED_CONTENT_LINKS
        printf "# Home page for repo \n" >> $GENERATED_CONTENT_LINKS
        printf "# [$workshopName](generatedContent/$workshopName/README.md)\n\n" >> $GENERATED_CONTENT_LINKS

	    #SUMMARY_MD="$GENERATED_CONTENT_PATH"/SUMMARY.md
        #if [[ -f $SUMMARY_MD ]]; then
        #    sed "s/\[\(.*\)\](\(.*\))/\[\1\](generatedContent\/$workshopName\/\2)/" $SUMMARY_MD >> $GENERATED_CONTENT_LINKS
        #fi

        if [ -f $MKDOCS_YAML ]; then
            NAV_ROOT=`yq r "$MKDOCS_YAML" nav`
            printf "nav \n $NAV_ROOT" >> $GENERATED_CONTENT_LINKS
        fi

        printf "\n\n" >> $GENERATED_CONTENT_LINKS
        
    done

    echo "This content is generated! Do not edit directly! Please run aggregate-labs.sh to repopulate with latest content from agenda.txt!" > docs/generatedContent/README.md

}

main(){
    pushd "$(dirname "$0")" > /dev/null || exit 1
    command -v yq >/dev/null 2>&1 || { echo >&2 "This script requires yq (version 3.x) but it's not installed.  Aborting."; exit 1; }
    if [[ -d tempClones ]]; then
        clean_tempClones
    fi

    mkdir -p tempClones docs/generatedContent
    clean_generatedContent
    printf "# This file contains all the MKDOCS navigation from the generated content. Still need to prefix the path with the right (\"generatedContent\") path so you can copy and paste this into parent mkdocs.yml\n\n" >> generatedContentDocs.yml
    do_the_thing
    clean_tempClones
    popd > /dev/null || exit 1
}

main