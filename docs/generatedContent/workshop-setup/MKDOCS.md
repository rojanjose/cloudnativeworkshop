# MkDocs

## Installation

1. Go to the [Installation](https://www.mkdocs.org/#installation) instructions for MkDocs,

```console
alias python=python3
python --version
alias pip=pip3
pip --version   
pip install --upgrade pip
pip install mkdocs
mkdocs --version
```

1. To install `Material for MkDocs` go to the [Getting Started](https://squidfunk.github.io/mkdocs-material/getting-started/) instructions,

```console
pip install mkdocs-material
```

1. In the repository root directory, add a new `~/README.md` file, this is the landing page for the Github repository different from the MkDocs landing page. MkDocs assumes its root to be the `docs` folder.

```console
vi README.md
```

## Migration

1. Get repository,

```console
ORG=<github_org>
REPO=<repository>

git clone https://github.com/$ORG/$REPO.git
cd $REPO
```

1. When converting an existing repository from Gitbook, rename `workshop` to `docs`,

```console
mv workshop docs
```

1. For a repository without Gitbook support, create a new directory `docs`,

```console
mkdir docs
```

1. When converting from Gitbook, edit `.gitbook.yaml` and change `workshop` to `docs` references,

```console
sed -i "" 's/workshop/docs/' .gitbook.yaml
```

1. **Skip this step for repositories with a `docs/README.md` file present!** If no file `docs/README.md` exists, add one. The `docs/README.md` is the landing page for the MkDocs documentation,

```console
cat > docs/README.md <<EOF
# $REPO

## About

EOF
```

1. Create a new file `.github/workflows/ci.yml` to configure a Github action,

```console
mkdir -p .github/workflows
wget -O .github/workflows/ci.yml https://raw.githubusercontent.com/IBM/workshop-setup/master/.github/workflows/ci.yml
```

1. In the root folder of your project, create a new file `~/mkdocs.yml` and add the following content to the new file,

```console
cat > mkdocs.yml <<EOF
# Project information
site_name: <SITE_NAME>
site_url: https://ibm.github.io/<REPO_NAME>
site_author: IBM Developer

# Repository
repo_name: <REPO_NAME>
repo_url: https://github.com/ibm/<REPO_NAME>
edit_uri: edit/master/docs

# Navigation
nav:
  - Welcome:
    - About the workshop: README.md
  - Workshop:
    - Lab 1: lab1.md
    - Lab 2: lab2.md
  - References:
    - Additional resources: references/RESOURCES.md
    - Contributors: references/CONTRIBUTORS.md

## DO NOT CHANGE BELOW THIS LINE

# Copyright
copyright: Copyright &copy; 2020 IBM Developer

# Theme
theme:
  name: material
  font:
    text: IBM Plex Sans
    code: IBM Plex Mono
  icon:
    logo: material/library
  features:
    - navigation.tabs
    #- navigation.instant
  palette:
    scheme: default
    primary: blue
    accent: blue

# Plugins
plugins:
  - search

# Customization
extra:
  social:
    - icon: fontawesome/brands/github
      link: https://github.com/ibm
    - icon: fontawesome/brands/twitter
      link: https://twitter.com/ibmdeveloper
    - icon: fontawesome/brands/linkedin
      link: https://www.linkedin.com/company/ibm/
    - icon: fontawesome/brands/youtube
      link: https://www.youtube.com/user/developerworks
    - icon: fontawesome/brands/dev
      link: https://dev.to/ibmdeveloper

# Extensions
markdown_extensions:
  - abbr
  - admonition
  - attr_list
  - def_list
  - footnotes
  - meta
  - toc:
      permalink: true
  - pymdownx.arithmatex:
      generic: true
  - pymdownx.betterem:
      smart_enable: all
  - pymdownx.caret
  - pymdownx.critic
  - pymdownx.details
  - pymdownx.emoji:
      emoji_index: !!python/name:materialx.emoji.twemoji
      emoji_generator: !!python/name:materialx.emoji.to_svg
  - pymdownx.highlight
  - pymdownx.inlinehilite
  - pymdownx.keys
  - pymdownx.mark
  - pymdownx.smartsymbols
  - pymdownx.snippets:
      check_paths: true
  - pymdownx.superfences:
      custom_fences:
        - name: mermaid
          class: mermaid
          format: !!python/name:pymdownx.superfences.fence_code_format
  - pymdownx.tabbed
  - pymdownx.tasklist:
      custom_checkbox: true
  - pymdownx.tilde
EOF
```

1. Edit the above file `mkdocs.yml`, change:
    * `<SITE_NAME>`
    * `<REPO_NAME>`
    * when converting from Gitbook: copy the navigation links from `workshop/SUMMARY.md` to the `Navigation` section and copy-edit the links for the navigation,

```console
sed -i "" "s/<SITE_NAME>/$REPO/" mkdocs.yml
sed -i "" "s/<REPO_NAME>/$REPO/" mkdocs.yml
```

1. The above navigation example includes two example items, you need to add the files `docs/lab1.md` and `docs/lab2.md` to enable the examples,

```console
echo '# Lab One' > docs/lab1.md
echo '# Lab Two' > docs/lab2.md
```

1. But for existing content, you need to overwrite the navigation.
1. If your repository has an existing Gitbook, you can copy the navigation in the `docs/SUMMARY.md` file, to the `# Navigation nav:` section in `mkdocs.yml`,

1. Add a file `.gitignore` with the following exceptions,

```console
echo "\n# MkDocs\nsite/\n" >> .gitignore
```

1. Add a new file `~/markdownlint.json` with the following rule,

```console
cat > markdownlint.json <<EOF
{
    "line-length": false
}
EOF
```

1. Add a new file `.markdownlintignore`, when converting from Gitbook, add the following exceptions,

```console
cat > .markdownlintignore <<EOF
workshop/SUMMARY.md
workshop/README.md
EOF
```

1. When migrating from `Gitbook`, if a `.travis.yml` file already exists, replace reference to `workshop` by `docs`,

```console
sed -i "" 's/workshop/docs/' .travis.yml
```

1. Add a new file `.travis.yml`,

```console
cat > .travis.yml <<EOF
---
language: node_js
node_js: 10

before_script:
  - npm install markdownlint-cli
script:
  - markdownlint -c .markdownlint.json docs
EOF
```

1. If you don't have a LICENSE file yet, download the `LICENSE` file,

```console
wget -O LICENSE https://raw.githubusercontent.com/IBM/workshop-setup/master/LICENSE
```

1. Test the docs locally with the command `mkdocs serve`,
1. Review the `WARNING` output, fix where necessary,
1. Create a new repository in Github,
1. Initialize the local repository, add all files, commit, add the remote, and push changes,

```console
echo "# test1" >> README.md
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/remkohdev/test1.git
git push -u origin main
```

1. Github pages use a branch called `gh-pages`, this branch is automatically created if it does not exist by the Github action that is defined in the `.github/workflows/ci.yml`,

1. Github also needs to resolve the domain name and URI to the repository, and point it to the correct branch of the Github page for the repo. To configure this, in your repo, go to Settings, scroll down to `GitHub Pages` section and from the `Source` dropdown, select the branch `gh-pages`, accept the default `/root` and click `Save`.

1. Your MkDocs branch should now be live. Whenever you push changes to your main branch, the Github action to deploy MkDocs will be triggered again,

1. Add an update to your README.md,

```console
vi README.md
```

1. Push changes,

```console
git add .
git commit -m "second commit"
git push
```

1. Check your actions at `https://github.com/<ORG>/<REPO>/actions`.

## Export to PDF

There are several plugins to export mkdocs to PDF,

* [mkdocs-pdf-export](https://github.com/zhaoterryy/mkdocs-pdf-export-plugin),
* [MkPdf](https://comwes.github.io/mkpdfs-mkdocs-plugin/),

1. Install the plugin,
1. Enable the plugin by adding the plugin line to the plugins list in `mkdocs.yml`, to use the `pdf-export` plugin, add,

```console
plugins:
  - pdf-export:
      verbose: true
      media_type: print
      enabled_if_env: ENABLE_PDF_EXPORT
      combined: true
```

1. Run `mkdocs build`, which will create a `pdf` directory with the combined PDF, e.g. to run `pdf-export`,

```console
ENABLE_PDF_EXPORT=1 mkdocs build
```
