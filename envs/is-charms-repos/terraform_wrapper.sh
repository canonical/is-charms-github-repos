#!/bin/bash

# if remote doesn't exist, git create it
for repo in $(./hcl2json terraform.tfvars | jq -r '.repo_names[]')
do
  if ! grep -q "feature/template-files" <( https_proxy=http://squid.internal:3128 git ls-remote https://git@github.com/${GITHUB_OWNER}/${repo}.git )
  then
    echo "branch feature/template-files not found in repo ${repo}"
    echo "creating..."
    https_proxy=http://squid.internal:3128 git clone https://${GITHUB_TOKEN}@github.com/${GITHUB_OWNER}/${repo}.git
    cd ${repo}
    git checkout -b feature/template-files
    https_proxy=http://squid.internal:3128 git push --set-upstream origin feature/template-files
    cd ../
    rm -rf ${repo}
  fi
done

# plan and send to MM
https_proxy=http://squid.internal:3128 NO_PROXY=radosgw.ps5.canonical.com /snap/terraform/547/terraform plan -compact-warnings -no-color | tee plan_output

awk '/Terraform/,0' plan_output >> summary_plan

echo -n '{"text": ' > json_escaped
jq -RMs '.' summary_plan >> json_escaped
echo -n '}' >> json_escaped

if [ ! -z "${MM_API}" ]
then
  curl -i -X POST https://chat.canonical.com/hooks/${MM_API} --data-urlencode "payload=$(cat json_escaped)"
fi

rm -f plan_output
rm -f summary_plan
rm -f json_escaped

# apply
https_proxy=http://squid.internal:3128 NO_PROXY=radosgw.ps5.canonical.com /snap/terraform/547/terraform apply
