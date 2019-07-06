class Piloto
	attr_accessor :laps, :name

	def initialize(name)
		@name = name
		@laps = []
		@avg_speeds = []
	end

	def to_s
		[@name, "TOTAL TIME: #{total_time}", "MEDIAN SPEED: #{avg_speed}"].to_s
	end

	def valid?
		@name.size > 0
	end

	def load_lap(lap_n, lap_time, avg_speed)
		@laps << [lap_n, lap_time]
		@avg_speeds << avg_speed
	end

	def avg_speed()
		soma = 0

		@avg_speeds.each do |as|
			soma = as.gsub(",", ".").to_f + soma
		end

		soma / @laps.size
	end

	def best_lap()
		ranking = {}

		@laps.each do |l|
			ranking.store(l[1], l[0])
		end

		ranking.sort.first.reverse
	end

	def total_time
		total_time = [0, 0, 0]

		@laps.each do |l|
			min = l[1].split(":")[0].to_i
			sec = l[1].split(":")[1].split(".")[0].to_i
			mil = l[1].split(":")[1].split(".")[1].to_i

			total_time[0] = total_time[0] + min
			total_time[1] = total_time[1] + sec
			total_time[2] = total_time[2] + mil
		end

		total_time[1] = total_time[2] / 1000 + total_time[1]
		total_time[0] = total_time[1] / 100 + total_time[0]
		total_time[1] = total_time[1] % 100
		total_time[2] = total_time[2] % 1000

		"#{total_time[0]}:#{total_time[1] / 10 == 0 ? '0' : ''}#{total_time[1]}.#{total_time[2] < 100 ? '0' : ''}#{total_time[2] < 10 ? '0' : ''}#{total_time[2]}"
	end
end
