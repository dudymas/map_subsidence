require 'csv'

class GisDataController < ApplicationController
    def get
        geojson_text = GisDataHelper.get_data
        render text: geojson_text
    end

    def new
    end

    def upload
    end

    def create
        gis_upload = params[:gis_data][:csv]
        if gis_upload
            subsidences = GisDataHelper.convert_csv_file gis_upload
            subsidences.each &:save
            redirect_to gis_data_path
        else
            @subsidence = Subsidence.new(gis_data_params)

            @subsidence.save
            redirect_to @subsidence
        end
    end

    def get_subsidence
    end

    def subsidence_url subsidence
        'gis_data?subsidence='+subsidence.id.to_s
    end

    private
    def gis_data_params
        params.require(:gis_data).permit(:latitude, :longitude)
    end
end
