class Plan
  include Mongoid::Document
  referenced_in :user

  field :type
end
