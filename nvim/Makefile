PHONY: clean dataclnup stateclnup

clean: dataclnup stateclnup

dataclnup:
	@printf "%-25s" "Cleanup nvim data..."
	@rm -rf ${XDG_DATA_HOME}/nvim
	@printf "%s\n" "OK" 

stateclnup:
	@printf "%-25s" "Cleanup nvim state..."
	@rm -rf ${XDG_STATE_HOME}/nvim
	@printf "%s\n" "OK" 

