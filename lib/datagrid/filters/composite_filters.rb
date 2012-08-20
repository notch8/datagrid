module Datagrid
  module Filters
    module CompositeFilters

      def self.included(base)
        base.extend         ClassMethods
        base.class_eval do

        end
        base.send :include, InstanceMethods
      end # self.included

      module ClassMethods


        def date_range_filters(field, from_options = {}, to_options = {})
          filter(from_options[:name] || :"from_#{field.to_s.tr('.', '_')}", :date, from_options) do |date|
            self.scoped(:conditions => ["#{field} >= ?", date])
          end
          filter(to_options[:name] || :"to_#{field.to_s.tr('.', '_')}", :date, to_options) do |date|
            self.scoped(:conditions => ["#{field} <= ?", date])
          end
        end

        def integer_range_filters(field, from_options = {}, to_options = {})
          filter(from_options[:name] || :"from_#{field.to_s.tr('.', '_')}", :integer, from_options) do |value|
            self.scoped(:conditions => "#{field} >= #{value}")
          end
          filter(to_options[:name] || :"to_#{field.to_s.tr('.', '_')}", :integer, to_options) do |value|
            self.scoped(:conditions => "#{field} <= #{value}")
          end
        end
      end # ClassMethods

      module InstanceMethods

      end # InstanceMethods

    end
  end
end
