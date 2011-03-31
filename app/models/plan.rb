class Plan
  include Mongoid::Document
  embedded_in :user, :inverse_of => :plan

  field :type
  field :limit
  attr_accessible :type, :limit
end
