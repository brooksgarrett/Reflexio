class Site
  include Mongoid::Document
  field :org, type: String
  field :url, type: String
  field :last_updated, type: DateTime
  field :state, type: String
  field :timestamp, type: DateTime
  field :status, type: String, default: 'In Progress'
  field :result, type: String
  field :screenshot, type: String
  field :response_code, type: Integer
  field :response_time, type: Float

end
