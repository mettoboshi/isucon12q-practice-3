.PHONY: initialize

initialize:
	sudo ./bin/mitamae local --log-level=debug mitamae/roles/initialize.rb

configure-mysql:
	sudo ./bin/mitamae local --log-level=debug mitamae/cookbooks/mysql/default.rb

pre-bench:
	sudo ./bin/mitamae local --log-level=debug mitamae/cookbooks/pre_bench/default.rb

post-bench:
	sudo ./bin/mitamae local --log-level=debug mitamae/cookbooks/post_bench/default.rb