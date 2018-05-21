#!/usr/bin/env ruby

require 'csv'

data = CSV.parse(IO.read('data.csv'), headers: true)

# TODO: just print all of them
puts "Headers: "
data.headers.each_with_index do |header, index|
  puts "#{index}. #{header}"
end
puts "-----"
print "Column to Analyze: "
colIdx = gets.chomp.to_i
puts "-----"

responses = {} # Word Frequency Maps
counts = [] # Correlations between # of words responded and values

data.each do |row|
  counts.push [row[1]&.split(/[\s,\/]/)&.length.to_i, row[9] || "None"]
  row.each do |col, value|
    responses[col] = {} if responses[col].nil?
    value ||= '' # prevent nil NoMethod error
    value.split(/[\s,\/]/).each do |value|
      value = '[blank]' if value.empty?
      value = value.strip.downcase
      responses[col][value] = responses[col][value].to_i + 1
    end
  end
end

responses[responses.keys[colIdx]].sort_by{ |response, count| -count }.first(20).each do |resp, count|
  puts "#{resp} (#{count})"
end

File.write("counts.csv", counts.map(&:to_csv).join)
