OVERLAY=manifest/overlays

.PHONY: deploy-prd deploy-dev
deploy-prd deploy-dev: $(OVERLAY)/production $(OVERLAY)/development
$(OVERLAY)/production $(OVERLAY)/development: $(OVERLAY)/%: FORCE
	./script/apply.sh $*

FORCE: # dummy target
