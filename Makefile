.PHONY: deploy-prd
deploy-prd: overlays/production
overlays/production: overlays/%: FORCE
	@if [[ $$(kubectl config current-context | grep "$*") ]]; then \
	    kustomize build overlays/$* | kubectl apply -f -; \
	else \
	    echo "Switch context for $*"; \
	fi

.PHONY: deploy-dev
deploy-dev: overlays/development
overlays/development: overlays/%: FORCE
	@if [[ $$(kubectl config current-context | grep "$*") ]]; then \
	    kustomize build overlays/$* | kubectl apply -f -; \
	else \
	    echo "Switch context for $*"; \
	fi

FORCE: # dummy target
