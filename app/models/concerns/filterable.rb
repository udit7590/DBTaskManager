require 'active_support/concern'

# TODO: WIP
module Filterable
  extend ActiveSupport::Concern

  included do
    def self.filter_by(filter_name, param_type, data_type, defn)
      register_filter(filter_name, param_type, data_type)
      scope :"filter_by_#{filter_name}", defn
    end

    def self.register_filter(filter_name, param_type, data_type)
      @filters ||= {}.with_indifferent_access
      @filters[filter_name] = { param_type: param_type, data_type: data_type }
    end

    def self.registered_filters_params
      params        = []
      range_params  = []
      @filters.each do |filter, options|
        next unless respond_to?("filter_by_#{filter}")

        case options[:param_type].to_sym
        when :range
          range_params << "#{filter_start}"
          range_params << "#{filter_end}"
        else
          params << filter
        end
      end
      { simple: params, range: range_params }
    end

    scope :filter, -> (params) do
      filtered_records = self
      filtered_params = params.slice(*registered_filters_params[:simple])
      ranged_params   = params.slice(*registered_filters_params[:range])
      filtered_params.each do |filter, value|
        case filter.to_s
        filtered_records.send("filter_by_#{filter}", value)
      end
    end
  end
end
