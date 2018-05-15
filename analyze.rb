#!/usr/bin/env ruby

require 'csv'

data = CSV.parse(IO.read('data.csv'), headers: true)

puts "Headers: "
data.headers.each_with_index do |header, index|
  puts "#{index}. #{header}"
end
puts "-----"
print "Column to Analyze: "
colIdx = gets.chomp.to_i
puts "-----"

totals = {}

data.each do |row|
  row.each do |col, value|
    totals[col] = {} if totals[col].nil?
    value ||= '' # prevent nil NoMethod error
    value.split(/[\s,\/]/).each do |value|
      value = '[blank]' if value.empty?
      value = value.strip.downcase
      totals[col][value] = totals[col][value].to_i + 1
    end
  end
end

totals[totals.keys[colIdx]].sort_by{ |response, count| -count }.first(20).each do |resp, count|
  puts "#{resp} (#{count})"
end
