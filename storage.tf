resource "azurerm_storage_account" "mainSA" {
  name                     = lower("${var.suffix}${var.saName}")
  resource_group_name      = azurerm_resource_group.mainRG.name
  location                 = azurerm_resource_group.mainRG.location
  account_kind             = var.saKind
  account_tier             = var.saTier
  account_replication_type = var.saReplicationType

  tags = var.tags
}

resource "azurerm_storage_share" "mainFileShare" {
  name                 = lower("${var.suffix}${var.fsName}")
  storage_account_name = azurerm_storage_account.mainSA.name

  quota = var.fsQuota
}
