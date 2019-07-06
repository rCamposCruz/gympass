require 'spec_helper'

RSpec.describe Piloto do
	context "when it receives a valid name" do
		before :all do
			@p = Piloto.new("teste")
		end

		it "is valid" do
			expect(@p.valid?).to eq(true)
		end

		context "when it receives lap data" do
			before :all do
				@p.load_lap(1, "1:01.002", "20,002")
				@p.load_lap(2, "1:00.000", "20,001")
			end

			it "has the right number of laps" do
				expect(@p.laps.size).to eq(2)
			end

			it "knows its best lap" do
				expect(@p.best_lap.to_s).to eq("[2, \"1:00.000\"]")
			end

			it "knows its total time" do
				expect(@p.total_time).to eq("2:01.002")
			end

			it "knows its average speed" do
				expect(@p.avg_speed).to eq(20.0015)
			end
		end
	end

	context "when it receives an empty name" do
		before :all do
			@p = Piloto.new("")
		end

		it "is invalid" do
			expect(@p.valid?).to eq(false)
		end
	end
end
