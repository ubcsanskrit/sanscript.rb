# frozen_string_literal: true
require "ice_nine"

module Sanscript
  # A set of helpful refinements for duplication and deep freezing.
  module Refinements
    refine Object do
      def deep_dup
        dup
      rescue TypeError
        self
      end

      def deep_freeze
        IceNine.deep_freeze(self)
      end
    end

    refine NilClass do
      def deep_dup
        self
      end
    end

    refine FalseClass do
      def deep_dup
        self
      end
    end

    refine TrueClass do
      def deep_dup
        self
      end
    end

    refine Symbol do
      def deep_dup
        self
      end
    end

    refine Numeric do
      def deep_dup
        self
      end
    end

    # Necessary to re-override Numeric
    require "bigdecimal"
    refine BigDecimal do
      def deep_dup
        dup
      end
    end

    refine String do
      def w_split
        split(/\s/)
      end
    end

    refine Array do
      def deep_dup
        map { |value| value.deep_dup } # rubocop:disable Style/SymbolProc
      end
    end

    refine Hash do
      def deep_dup
        hash = dup
        each_pair do |key, value|
          if ::String === key # rubocop:disable Style/CaseEquality
            hash[key] = value.deep_dup
          else
            hash.delete(key)
            hash[key.deep_dup] = value.deep_dup
          end
        end
        hash
      end
    end

    refine Set do
      def deep_dup
        set_a = to_a
        set_a.map! do |val|
          next val if ::String === val # rubocop:disable Style/CaseEquality
          val.deep_dup
        end
        self.class[set_a]
      end
    end
  end
end
