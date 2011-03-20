class Plan
  include Mongoid::Document
  embedded_in :user, :inverse_of => :plan

  field :type
end
