# Manage translations
## Crowdin platform

We used Crowdin as a collaborative platform to manage translations.

# Platform link

https://crowdin.com/project/gc-wizard

To translate, click your language and follow instructions.

# Tools
To integrate, several ways : 
Recommended way is [crowdin CLI](https://support.crowdin.com/cli-tool/)

You can use intelliJ or AndroidStuido plugin too.

Our own scripts on API are deprecated.


## Setup
Follow [instructions](https://support.crowdin.com/cli-tool/) to install.

Then init using [sample](external_helpers/crowdin/crowdin.yml). Just change API key

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
