from checkov.common.models.enums import CheckCategories, CheckResult
from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck


class StoragePublicAccessDisabled(BaseResourceCheck):
    def __init__(self):
        super().__init__(
            name="Azure Storage public network access is disabled",
            id="CUSTOM_AZURE_001",
            categories=(CheckCategories.NETWORKING,),
            supported_resources=("azurerm_storage_account",),
        )

    def scan_resource_conf(self, conf):
        values = conf.get("public_network_access_enabled", [True])
        return CheckResult.PASSED if values and values[0] is False else CheckResult.FAILED


check = StoragePublicAccessDisabled()
