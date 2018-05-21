#!/usr/bin/env ruby

require 'csv'

data = CSV.parse(IO.read('data.csv'), headers: true)

responses = {} # Word Frequency Maps
counts = [] # Correlations between # of words responded and values

def wordcount(str)
  str&.split(/[\s,\/]/)&.length.to_i
end

data.each do |row|
  counts.push [wordcount(row[1]), wordcount(row[7]), row[9] || "None"]
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

for i in 0..10 do
  puts "-----------------"
  puts "[#{i}] #{data.headers[i]}"
  puts "-----------------"
  vals = responses[responses.keys[i]].sort_by{ |response, count| -count }
  vals.first(10).each do |resp, count|
    puts "#{resp} (#{count})"
  end
end

File.write("counts.csv", counts.map(&:to_csv).join)
