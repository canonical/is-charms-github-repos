/!\ This repository is archived and has been replaced by https://github.com/canonical/platform-engineering-repos/ /!\

# GitHub repo templator

A terraform set of environments and modules to set up an initial repository as a template repo and create repositories
that clone from said repo to benefit from the templates.

## Usage

Create a personal access token on GitHub

- export GITHUB_TOKEN # set to the token created
- export GITHUB_OWNER # set to your account name
- export MM_API # if you want to send notifications to an MM channel

```shell
cd envs/is-charms-template-repo
# adjust terraform.tfvars
terraform init && terraform plan && terraform apply
cd envs/is-charms-repos
# adjust terraform.tfvars
terraform init
./terraform_wrapper.sh # handles GH feature/ branch and optional messaging to MM
```

Note the wrapper is needed to accomodate the flow of Github, where feature branches are expected to be ephemeral.
In case you have merged the changes for your files that are managed via terraform, the state cannot be queried (files will be 404), hence we detect whether we have a branch or not - if it's missing, we are recreating the branch via git push. Upon recreating, terraform will be able to pick the branch and check for file changes.
