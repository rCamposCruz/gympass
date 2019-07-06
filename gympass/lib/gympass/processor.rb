require_relative "piloto"

class Processor
	attr_accessor :pilotos

	def initialize(txt)
		@pilotos = []

		txt.split(";").each do |line|
			carrega_dado(line)
		end
	end

	def carrega_dado(line)
		real_time, p_number, trash, p_name, lap_n, 
		lap_time, median_velocity = line.strip.split(" ")

		p_number = p_number.to_i

		p = get_piloto(p_number)

		if p == nil then
			p = Piloto.new(p_name)
			@pilotos[p_number] = p

			if @nomes == nil then
				@nomes = {p_name => p_number}
			else
				@nomes.store(p_name, p_number)
			end
		end

		p.load_lap(lap_n, lap_time, median_velocity)
	end

	def get_piloto(name)
		if @nomes != nil then
			return @pilotos[@nomes[name]]
		end

		nil
	end

	def leaderboard()
		leaderboard = {}

		@pilotos.compact.each do |p|
			leaderboard.store(p.total_time.gsub(":", "").to_i, p)
		end
	
		output = []
		count = 1

		leaderboard.sort.each do |time, p|
			n = @nomes[p.name]
			output << [count, "#{n < 100 ? '0' : ''}#{n < 10 ? '0' : ''}#{n}", p.name, p.laps.size, p.total_time]
		end

		output
	end

	def best_laps()
		output = []

		@pilotos.compact.each do |p|
			output << [p.name, "LAP: #{p.best_lap[0]}", p.best_lap[1]]
		end

		output
	end

	def avg_speeds()
		output = []

		@pilotos.compact.each do |p|
			output << [p.name, p.avg_speed]
		end

		output
	end
end
