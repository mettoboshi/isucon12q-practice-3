ENV['DEBIAN_FRONTEND'] = 'noninteractive'
include_recipe '../cookbooks/percona/default.rb'
include_recipe '../cookbooks/alp/default.rb'
include_recipe '../cookbooks/skeema/default.rb'