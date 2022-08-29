OVERLAY=manifest/overlays

.PHONY: deploy-local-prd deploy-local-dev
deploy-local-prd deploy-local-dev: $(OVERLAY)/production $(OVERLAY)/development
$(OVERLAY)/production $(OVERLAY)/development: $(OVERLAY)/%: FORCE
	./script/apply.sh $*

FORCE: # dummy target
