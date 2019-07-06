require "gympass"

file = ARGV[0]
action = ARGV[1]

lines = ""
count = 0

File.open(file).each do |line|
	if line != "" && count != 0 then
		lines = "#{lines};#{line}"
	end
	count = count + 1
end

puts lines

p = Processor.new(lines)

if action == nil then
	puts p.leaderboard
elsif action == "bestlaps" then
	puts p.best_laps
elsif action == "avgspeeds" then
	puts p.avg_speeds
end
