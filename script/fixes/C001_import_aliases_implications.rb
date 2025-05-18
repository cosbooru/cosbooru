#!/usr/bin/env ruby

require_relative "base"

require "json"

# Import aliases and implications
with_confirmation do
  implications = JSON.parse(File.read("implications.json"))
  puts "#{implications.size} implications"
  implications.each do |impl|
    TagImplication.approve!(antecedent_name: impl["antecedent_name"], consequent_name: impl["consequent_name"], approver: User.system)
  end

  aliases = JSON.parse(File.read("aliases.json"))
  puts "#{aliases.size} aliases"
  aliases.each do |impl|
    TagAlias.approve!(antecedent_name: impl["antecedent_name"], consequent_name: impl["consequent_name"], approver: User.system)
  end
end
