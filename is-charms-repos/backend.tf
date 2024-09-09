terraform {
  backend "s3" {
    # These are defined in backend.tfvars so they can be referenced when
    # setting up the bucket as well.
    # bucket      = SOME_VALUE
    # region      = SOME_VALUE
    key = "state"
    endpoints = {
      s3 = "https://radosgw.ps5.canonical.com"
    }
    skip_region_validation = true
    # The following need to be defined at run time per the README.md
    # access_key  = AWS_ACCESS_KEY_ID env variable
    # secret_key  = AWS_SECRET_ACCESS_KEY env variable

    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    use_path_style              = true
  }
}
