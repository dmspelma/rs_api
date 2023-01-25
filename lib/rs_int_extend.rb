# frozen_string_literal:true

require 'active_support'
require 'active_support/core_ext/numeric/conversions'

# Useful functions extending Integer class
class Integer
  def delimited
    self.to_s(:delimited) # rubocop:disable Style/RedundantSelf
  end
end
