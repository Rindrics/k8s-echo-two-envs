OVERLAY=manifest/overlays

.PHONY: plan-local-prd plan-local-dev
plan-local-prd plan-local-dev: $(OVERLAY)/production $(OVERLAY)/development
$(OVERLAY)/production $(OVERLAY)/development: $(OVERLAY)/%: FORCE
	./script/plan.sh $*

.PHONY: deploy-local-prd deploy-local-dev
deploy-local-prd deploy-local-dev: $(OVERLAY)/production $(OVERLAY)/development
$(OVERLAY)/production $(OVERLAY)/development: $(OVERLAY)/%: FORCE
	./script/apply.sh $*

.PHONY: destroy-local-prd destroy-local-dev
destroy-local-prd destroy-local-dev: $(OVERLAY)/production $(OVERLAY)/development
$(OVERLAY)/production $(OVERLAY)/development: $(OVERLAY)/%: FORCE
	./script/destroy.sh $*

FORCE: # dummy target
