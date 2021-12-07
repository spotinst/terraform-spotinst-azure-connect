locals {
  cmd = "${path.module}/scripts/spot-account-azure"
  account_id = lookup(data.external.account.result,"account_id","Fail")
}

resource "random_string" "value" {
  length = 24
  special = false
}