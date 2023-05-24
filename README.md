# Export Secrets to CSV

This GitHub Action exports secrets to a CSV file.

## Disclaimer

This action is not officially supported by GitHub. It is a personal project that I created to help me export secrets from GitHub to a CSV file which contains possibly sensitive information. Make sure to store the CSV file in a secure location and delete it when no longer needed. 

*Use this action at your own risk.*

## Inputs

- `secrets-prefix` (required): The prefix for the secrets ending with an underscore. For example, `SECRETS_`.
- `repository` (optional): The repository name. Defaults to the current repository.
- `secrets-type` (optional): The type of secrets. Allowed values are `org`, `repo`, or `env`. Defaults to `org`.
- `environment-name` (optional): The environment name. Required for `secrets-type=env`.

## Usage

Create a workflow (eg: `.github/workflows/export-secrets.yml` see [Creating a Workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file)) in any repository that you would like to export secrets from following the examples below. Add the secrets you would like to export as environment variables in the workflow file as shown in the examples below.

The workflow will export the secrets to a CSV file and upload it as an artifact.

### Example 1: Export Organization Secrets

> Note: Don't forget to add the organization secrets to the repository where the action is used before running the action.

```yaml
jobs:
  export-secrets-org:
    name: Export Secrets (org)
    runs-on: windows-latest
    steps:
      - name: Export Secrets to CSV (org)
        uses: martins-vds/export-secrets-action@v1
        env:
          SECRETS_ORG_SECRET1: ${{ secrets.ORG_SECRET1 }}
          SECRETS_ORG_SECRET2: ${{ secrets.ORG_SECRET2 }}
        with:
          repository: ${{ github.repository }}
          secrets-prefix: 'SECRETS_'
          secrets-type: 'org'
```

### Example 2: Export Repository Secrets

```yaml
jobs:
  export-secrets-repo:
    name: Export Secrets (repo)
    runs-on: windows-latest
    steps:
      - name: Export Secrets to CSV (repo)
        uses: martins-vds/export-secrets-action@v1
        env:
          SECRETS_REPO_SECRET1: ${{ secrets.REPO_SECRET1 }}
          SECRETS_REPO_SECRET2: ${{ secrets.REPO_SECRET2 }}    
        with:
          repository: ${{ github.repository }}
          secrets-prefix: 'SECRETS_'
          secrets-type: 'repo'
```

### Example 3: Export Environment Secrets

```yaml
jobs:
    export-secrets-env:
      name: Export Secrets (env)
      runs-on: windows-latest
      environment: 'production'
      steps:
        - name: Export Secrets to CSV (env)
          uses: martins-vds/export-secrets-action@v1    
          env:
            SECRETS_ENVIRONMENT_SECRET1: ${{ secrets.ENVIRONMENT_SECRET1 }}
            SECRETS_ENVIRONMENT_SECRET2: ${{ secrets.ENVIRONMENT_SECRET2 }}
          with:
            repository: ${{ github.repository }}
            secrets-prefix: 'SECRETS_'
            secrets-type: 'env'
            environment-name: 'production'
```

### Example 4: Complete Workflow

```yaml
name: Export Secrets to Artifact

on:
  workflow_dispatch:

env:
  PREFIX_SECRETS: 'SECRETS_'

jobs:
    export-secrets-org:
      name: Export Secrets (org)
      runs-on: windows-latest
      steps:
        - name: Export Secrets to CSV (org)
          uses: martins-vds/export-secrets-action@v1
          env:
            SECRETS_ORG_SECRET1: ${{ secrets.ORG_SECRET1 }}
            SECRETS_ORG_SECRET2: ${{ secrets.ORG_SECRET2 }}
          with:
            repository: ${{ github.repository }}
            secrets-prefix: 'SECRETS_'
            secrets-type: 'org'
    export-secrets-repo:
      name: Export Secrets (repo)
      runs-on: windows-latest
      steps:
        - name: Export Secrets to CSV (repo)
          uses: martins-vds/export-secrets-action@v1
          env:
            SECRETS_REPO_SECRET1: ${{ secrets.REPO_SECRET1 }}
            SECRETS_REPO_SECRET2: ${{ secrets.REPO_SECRET2 }}    
          with:
            repository: ${{ github.repository }}
            secrets-prefix: 'SECRETS_'
            secrets-type: 'repo'
    export-secrets-env:
      name: Export Secrets (env)
      runs-on: windows-latest
      environment: 'production'
      steps:
        - name: Export Secrets to CSV (env)
          uses: martins-vds/export-secrets-action@v1    
          env:
            SECRETS_ENVIRONMENT_SECRET1: ${{ secrets.ENVIRONMENT_SECRET1 }}
            SECRETS_ENVIRONMENT_SECRET2: ${{ secrets.ENVIRONMENT_SECRET2 }}
          with:
            repository: ${{ github.repository }}
            secrets-prefix: 'SECRETS_'
            secrets-type: 'env'
            environment-name: 'production'
            
```

## License

The scripts and documentation in this project are released under the [MIT License](LICENSE).
