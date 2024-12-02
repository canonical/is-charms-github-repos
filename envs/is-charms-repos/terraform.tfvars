repositories = [
  {
    id                    = "bind-operator",
    template_repo_enabled = true
  },
  { id = "content-cache-k8s-operator" },
  # {id="create-pull-request"},
  {
    id                    = "digest-squid-auth-helper",
    template_repo_enabled = true
  },
  { id = "discourse-k8s-operator" },
  {
    id                    = "element-web-operator",
    template_repo_enabled = true
  },
  {
    id       = "flask-k8s-operator",
    archived = true
  },
  { id = "flask-multipass-saml-groups" },
  {
    id                    = "gateway-api-integrator-operator",
    template_repo_enabled = true
  },
  { id = ".github" },
  { id = "github-actions-exporter-operator" },
  {
    id = "github-runner-operator",
    required_status_checks = [
      "unit-tests / Required Test Status Checks",
      "unit-tests-github-runner-manager / Required Test Status Checks",
      "Integration test with juju 3.1 / Required Integration Test Status Checks",
      "Required E2E Test Status Checks"
    ]
  },
  { id = "github-runner-image-builder-operator" },
  {
    id       = "gunicorn-k8s-operator",
    archived = true
  },
  {
    id = "github-runner-manager",
    archived = true
    required_status_checks = [
      "unit-tests / Required Test Status Checks",
    ]
  },
  {
    id                    = "github-runner-webhook-router",
    template_repo_enabled = true
  },
  {
    id                    = "haproxy-operator",
    template_repo_enabled = true
  },
  {
    id = "httprequest-lego-provider",
    required_status_checks = [
      "unit-tests / Required Test Status Checks",
    ]
  },
  { id = "indico-operator" },
  { id = "irc-bridge-operator" },
  # {id="is-charms-contributing-guide"},
  {
    id                     = "jenkins-agent-deb",
    required_status_checks = []
  },
  { id = "jenkins-agent-k8s-operator" },
  {
    id                    = "jenkins-agent-operator",
    template_repo_enabled = true
  },
  { id = "jenkins-k8s-operator" },
  {
    id                    = "matrix-plugins-lib",
    template_repo_enabled = true
  },
  { id = "mattermost-k8s-operator" },
  {
    id                    = "maubot-operator",
    template_repo_enabled = true
  },
  { id = "netbox" },
  { id = "nginx-ingress-integrator-operator" },
  {
    id       = "openldap-k8s-operator",
    archived = true
  },
  # {id="operator-workflows"},
  {
    id                    = "penpot-operator",
    template_repo_enabled = true
  },
  {
    id = "repo-policy-compliance",
    required_status_checks = [
      "charm-integration-test / Required Integration Test Status Checks",
      "tests",
    ]
  },
  { id = "pollen-operator" },
  { id = "saml-integrator-operator" },
  # {id="setup-devstack-swift"},
  {
    id                    = "smtp-integrator-operator",
    template_repo_enabled = true
  },
  {
    id                    = "smtp-relay-operator",
    template_repo_enabled = true
  },
  #{id="spring-boot-sample-apps"},
  { id = "synapse-operator" },
  {
    id                    = "tmate-ssh-server-operator",
    template_repo_enabled = true
  },
  # {id="upload-charm-docs"},
  {
    id                    = "ubuntu-repository-metadata-operator",
    template_repo_enabled = true
  },
  {
    id                    = "wazuh-dashboard-operator",
    template_repo_enabled = false,
    required_status_checks = [
      "unit-tests / Required Test Status Checks",
      "Integration Test / Required Integration Test Status Checks",
      "Integration Test on Juju3 / Required Integration Test Status Checks",
    ]
  },
  {
    id                    = "wazuh-indexer-operator",
    template_repo_enabled = false,
    required_status_checks = [
      "Integration test charm",
    ]
  },
  {
    id                    = "wazuh-server-operator",
    template_repo_enabled = true
  },
  {
    id = "wordpress-k8s-operator",
    required_status_checks = [
      "Integration Test / Required Integration Test Status Checks",
      "unit-tests / Required Test Status Checks",
    ]
  },
  {
    id                    = "content-cache-backends-config-operator",
    template_repo_enabled = true
    required_status_checks = [
      "unit-tests / Required Test Status Checks",
    ]
  },
  {
    id                     = "paas-charm",
    required_status_checks = []
  }
]
