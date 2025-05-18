#!/usr/bin/env ruby

require_relative "base"

require "json"

# Import aliases and implications
with_confirmation do
  system_user = User.system

  which = ENV.fetch("WHICH", "user")

  if which == "implications"
    implications = JSON.parse(File.read("implications.json"))
    implications.each_with_index  do |impl, idx|
      puts "[#{idx} / #{implications.size}] imply #{impl["antecedent_name"]} -> #{impl["consequent_name"]}"
      TagImplication.approve!(antecedent_name: impl["antecedent_name"], consequent_name: impl["consequent_name"], approver: system_user)
    end
  elsif which == "aliases"
    aliases = JSON.parse(File.read("aliases.json"))
    aliases.each_with_index  do |a, idx|
      puts "[#{idx} / #{aliases.size}] alias #{a["antecedent_name"]} -> #{a["consequent_name"]}"
      TagAlias.approve!(antecedent_name: a["antecedent_name"], consequent_name: a["consequent_name"], approver: system_user)
    end
  end
end
