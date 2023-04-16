class Pg2parquet < Formula
  desc "Export PostgreSQL table or query into Parquet file"
  homepage "https://github.com/exyi/pg2parquet"
  license "Apache-2.0"
  head "https://github.com/exyi/pg2parquet.git", revision: "745323955adc80240ba154756f3e0d1b533f834c"

  depends_on "rust" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    cd "cli" do
      ENV["RUSTFLAGS"] = "-C target-cpu=native"
      system "cargo", "update", "-p", "geo-types", "--precise", "0.7.8"
      system "cargo", "install", *std_cargo_args
      bin.install "target/release/pg2parquet" => "pg2parquet"
    end
  end

  test do
    assert_match "Usage: pg2parquet", shell_output("#{bin}/pg2parquet -h")
  end
end
