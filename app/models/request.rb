class Request
  include Mongoid::Document
  embedded_in :user, :inverse_of => :requests

  field :query
  field :location
  field :response
  field :date
  attr_accessible :query, :location, :response, :date
end