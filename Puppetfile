#!/usr/bin/env ruby
#^syntax detection

forge "http://forge.puppetlabs.com"

# use dependencies defined in Modulefile
# modulefile



mod 'puppetlabs/stdlib'
mod 'saz/vim'
mod 'jfryman/nginx'

# Roles/Profiles Pattern. See http://blog.hsatac.net/2014/04/roles-and-profiles-pattern-in-puppet/
mod 'example/role', :path => './role'
mod 'example/profile', :path => './profile'
mod 'example/common', :path => './private/common'
mod 'example/users', :path => './private/users'
