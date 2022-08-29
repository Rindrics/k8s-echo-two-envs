INFRA=tffile/environment/local_infra
OVERLAY=manifest/overlays

# local infra
## plan
.PHONY: infra-prd-plan
infra-prd-plan: $(INFRA)
	./script/plan_infra.sh local_infra production

.PHONY: infra-dev-plan
infra-dev-plan: $(INFRA)
	./script/plan_infra.sh local_infra development

## apply
.PHONY: infra-prd-apply
infra-prd-apply: $(INFRA)
	./script/apply_infra.sh local_infra production

.PHONY: infra-dev-apply
infra-dev-apply: $(INFRA)
	./script/apply_infra.sh local_infra development

## destroy
.PHONY: infra-prd-destroy
infra-prd-destroy: $(INFRA)
	./script/destroy_infra.sh local_infra production

.PHONY: infra-dev-destroy
infra-dev-destroy: $(INFRA)
	./script/destroy_infra.sh local_infra development

# app
## plan
.PHONY: app-prd-plan
app-prd-plan: $(OVERLAY)/production
	./script/plan.sh app production

.PHONY: app-dev-plan
app-dev-plan: $(OVERLAY)/development
	./script/plan.sh app development

## apply
.PHONY: app-prd-apply
app-prd-apply: $(OVERLAY)/production
	./script/apply.sh app production

.PHONY: app-dev-apply
app-dev-apply: $(OVERLAY)/development
	./script/apply.sh app development

## destroy
.PHONY: app-prd-destroy
app-prd-destroy: $(OVERLAY)/production
	./script/destroy.sh app production

.PHONY: app-dev-destroy
app-dev-destroy: $(OVERLAY)/development
	./script/destroy.sh app development
