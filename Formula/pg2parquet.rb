class Pg2parquet < Formula
  desc "Export PostgreSQL table or query into Parquet file"
  homepage "https://github.com/exyi/pg2parquet"
  license "Apache-2.0"
  head "https://github.com/exyi/pg2parquet.git", revision: "da1f8e53786fa816d9374e7bab18e5a6a0926186"

  depends_on "rust" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    cd "cli" do
      ENV["RUSTFLAGS"] = "-C target-cpu=native"
      system "cargo", "install", *std_cargo_args
      bin.install "target/release/pg2parquet" => "pg2parquet"
    end
  end

  test do
    assert_match "Usage: pg2parquet", shell_output("#{bin}/pg2parquet -h")
  end
end
