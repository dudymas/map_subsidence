module GisDataHelper
    def self.get_features
        Subsidence.all.map { |s| self.get_feature_from_subsidence s }
    end

    def self.convert_csv_file gis_csv_file
        csv = CSV.new(gis_csv_file.read, :headers => true, :header_converters => :symbol)
        gis_records = csv.to_a.map &:to_hash
        self.convert_records gis_records.reject &:empty?
    end

    def self.convert_records gis_records
        gis_records.map do |gis_record|
            subsidence = Subsidence.new
            subsidence.latitude = gis_record[:lat]
            subsidence.longitude = gis_record[:long]
            subsidence
        end
    end

    def self.get_feature_from_subsidence subsidence
        {
            type: "Feature",
            geometry: {
                type: "Point",
                coordinates: [subsidence.longitude, subsidence.latitude, 0]
            }
        }
    end

    def self.get_data
        {
            type: "FeatureCollection",
            features: self.get_features
        }.to_json
    end
end
