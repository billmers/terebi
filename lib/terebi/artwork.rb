module Terebi

  class Artwork
    def initialize(config_path)
      load_config(config_path)
    end

    def load_config(path)
      config = YAML.load_file(path)["itunes_search"]

      ap config
      a = OpenStruct.new(config)
      ap a.default_show
      ap a.overrides.first["show"]



    end
  end

end
