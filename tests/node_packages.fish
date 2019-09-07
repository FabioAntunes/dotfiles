################################################
# tests if global node modules were installed  #
################################################
set -l packages eslint stylelint tern prettier eslint-config-prettier eslint-plugin-react stylelint-config-recommended

npm ls -g --depth=0 --parseable > temp_npm.txt

for package in $packages
  @test "package $package is installed" (grep -q $package temp_npm.txt ) $status -eq 0
end


rm temp_npm.txt
