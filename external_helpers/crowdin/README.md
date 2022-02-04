# Manage translations
## Crowdin platform

We used Crowdin as a collaborative platform to manage translations.

# Platform link

https://crowdin.com/project/gc-wizard

To translate, click your language and follow instructions.

# Tools
To integrate, several ways : 
Recommended way is [crowdin CLI](https://support.crowdin.com/cli-tool/)

## Setup
Follow [instructions](https://support.crowdin.com/cli-tool/) to install.

Copy [sample](external_helpers/crowdin/crowdin.yml) into project root directory and set your personal API key.

Our project_id is 445424.

```shell
> crowdin init
`````

## Commands

#### Download source
```shell
> crowdin download source
`````

#### Upload sources
```shell
> crowdin upload 
`````

#### Download translations
```shell
> crowdin download
`````

#### Upload translations
```shell
> crowdin upload translations
`````

#### List project files
```shell
> crowdin list project
`````

#### status
```shell
> crowdin status
`````
