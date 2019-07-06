require "spec_helper"

RSpec.describe Gympass do
  it "has a version number" do
    expect(Gympass::VERSION).not_to be nil
  end

	context "when it receives a single valid data_line" do
		before :all do
			@gb = Processor.new("23:49:08.277      038 – F.MASSA                           1     1:02.852                        44,275")
		end

		it "has a Piloto" do
						expect(@gb.pilotos.compact.size).to eq(1)
			expect(@gb.pilotos[38].valid?).to eq(true)
		end

		it "creates a leaderboard" do
						expect(@gb.leaderboard.to_s).to eq("[[1, \"038\", \"F.MASSA\", 1, \"1:02.852\"]]")
		end

		it "knows the best laps" do
						expect(@gb.best_laps.to_s).to eq("[[\"F.MASSA\", \"LAP: 1\", \"1:02.852\"]]")
		end

		it "knows average speeds" do
						expect(@gb.avg_speeds.to_s).to eq("[[\"F.MASSA\", 44.275]]")
		end

		it "can access a pilot through its name" do
						expect(@gb.get_piloto("F.MASSA").to_s).to eq("[\"F.MASSA\", \"TOTAL TIME: 1:02.852\", \"MEDIAN SPEED: 44.275\"]")
		end
	end
end
