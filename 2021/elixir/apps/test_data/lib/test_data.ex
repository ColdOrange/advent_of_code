defmodule TestData do
  @test_data_dir Path.join(File.cwd!(), "../../../test_data")

  def get(day, part) do
    Path.join([@test_data_dir, day, part <> ".yaml"])
    |> YamlElixir.read_all_from_file()
    |> case do
      {:ok, data} -> data
      {:error, error} -> raise ~s("Read test data "#{day}/#{part}.yaml" failed: #{error.message}")
    end
  end
end
